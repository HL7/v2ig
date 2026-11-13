#!/usr/bin/env python3
"""Run the vocabulary IG preprocessing chain in the one order that works.

Seven scripts have to run before the IG Publisher, and the order matters
because they pass files to each other. That order lived in a note in
JOURNAL.md for four sessions and picked up a new constraint each time. This
script is that note, made executable.

The ordering is not asserted here as a list somebody has to keep correct by
hand. Each step declares what it PRODUCES and what it CONSUMES, and
`check_order()` verifies that every step's inputs are produced by an earlier
step. A step inserted in the wrong place fails that check immediately, with a
message naming the input that would not exist yet -- rather than at the far end
of a seventeen-minute build, or worse, silently, by reading last run's file.

Usage:

    python3 tooling/scripts/build_vocab_ig.py            # the whole chain
    python3 tooling/scripts/build_vocab_ig.py --list     # show it, run nothing
    python3 tooling/scripts/build_vocab_ig.py --from render_table_ledger
    python3 tooling/scripts/build_vocab_ig.py --only generate_table_index
    python3 tooling/scripts/build_vocab_ig.py --publish  # then the IG Publisher

`--from` is for resuming after a step failed and you have fixed it: it skips
the steps that already succeeded. It trusts you that their outputs are still
good, so do not use it after changing something early in the chain.
"""

import argparse
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
SCRIPT_DIR = Path(__file__).resolve().parent

# The IG Publisher invocation, matching the one in JOURNAL.md. Only used with
# --publish. It needs Ruby on PATH because the publisher shells out to Jekyll.
PUBLISHER_JAR = PROJECT_ROOT / "input-cache" / "publisher.jar"
IG_INI = PROJECT_ROOT / "vocab-ig" / "ig.ini"
IG_OUTPUT = PROJECT_ROOT / "vocab-ig" / "output"
IG_SNAPSHOT = PROJECT_ROOT / "vocab-ig" / "output-snapshot"
IG_TEMP = PROJECT_ROOT / "vocab-ig" / "temp"
JAVA = Path("/home/claude/jdk/bin/java")
GEM_HOME = "/home/claude/.gems"
RUBY_BIN = "/home/claude/ruby/arm64/bin"

# The publisher's maximum heap, in gigabytes. Used both for -Xmx and for the
# memory check that runs before the build starts; see run_publisher() for why
# it is 12 and check_publisher_memory() for why the check exists.
PUBLISHER_HEAP_GB = 12


# --------------------------------------------------------------------------
# The chain
# --------------------------------------------------------------------------
#
# `produces` and `consumes` are logical names for the artefacts that pass
# between steps, not file paths. They are deliberately coarse: the point is to
# pin the ORDER, and a finer-grained graph would need updating every time a
# script gained a field.
#
# Steps with no `consumes` read only the corpus on disk (v291-extracted,
# tho-r5, UTG), which nothing in this chain writes.

STEPS = [
    {
        "name": "generate_concept_domains",
        "produces": {"concept-domains", "divergences"},
        "consumes": set(),
        "why": "Reads the extracted corpus and the THO snapshot. Nothing in "
               "the chain writes its inputs, so it can go first.",
    },
    {
        "name": "write_utg_xml",
        "produces": {"resources", "write-report", "fill-report"},
        "consumes": set(),
        "why": "Writes the CodeSystem/ValueSet resources and the two reports "
               "every later page is built from.",
    },
    {
        "name": "render_tho_merge_page",
        "produces": {"page-tho-merge"},
        "consumes": {"fill-report"},
        "why": "The per-class view of the merge.",
    },
    {
        "name": "render_table_ledger",
        "produces": {"page-table-ledger"},
        "consumes": {"fill-report", "write-report"},
        "why": "The per-table view of the same merge. Must precede the table "
               "index, which reads this page's anchors.",
    },
    {
        "name": "generate_table_index",
        "produces": {"page-table-index"},
        "consumes": {"write-report", "concept-domains", "page-table-ledger"},
        "why": "Reads table-ledger.md via load_ledger_anchors() to link into "
               "it, so the ledger has to exist first. This is the edge most "
               "likely to be got wrong.",
    },
    {
        "name": "render_review_pages",
        "produces": {"page-open-items", "page-evidence"},
        "consumes": {"divergences", "write-report"},
        "why": "Builds open-items and evidence from the divergence log and "
               "the writer report.",
    },
    {
        "name": "stage_vocab_ig",
        "produces": {"staged-ig"},
        "consumes": {"resources", "concept-domains"},
        "why": "Copies resources into vocab-ig/input and self-checks the "
               "counts on index.md. Last, so index.md counts what is really "
               "there.",
    },
]


def check_order(steps=STEPS):
    """Verify every step's inputs are produced by a step that runs earlier.

    Returns a list of complaints, empty when the order is sound. This is what
    turns the ordering from a convention into something the script enforces.
    """
    problems = []
    available = set()
    for position, step in enumerate(steps, 1):
        missing = step["consumes"] - available
        if missing:
            problems.append(
                f"step {position} ({step['name']}) needs "
                f"{', '.join(sorted(missing))}, which no earlier step produces"
            )
        available |= step["produces"]
    return problems


def script_path(name):
    """The file a step runs."""
    return SCRIPT_DIR / f"{name}.py"


def run_step(step, position, total):
    """Run one step, streaming its output. Returns its elapsed seconds.

    Raises SystemExit if the step fails, because every later step reads what
    this one writes -- carrying on would build pages from a stale file and the
    result would look fine.
    """
    path = script_path(step["name"])
    print(f"\n[{position}/{total}] {step['name']}", flush=True)
    print(f"        {step['why']}", flush=True)

    started = time.monotonic()
    result = subprocess.run([sys.executable, str(path)], cwd=PROJECT_ROOT)
    elapsed = time.monotonic() - started

    if result.returncode != 0:
        print(f"\nFAILED: {step['name']} exited {result.returncode} after "
              f"{elapsed:.1f}s.", file=sys.stderr)
        print(f"Fix it, then resume with:\n"
              f"  python3 tooling/scripts/build_vocab_ig.py "
              f"--from {step['name']}", file=sys.stderr)
        raise SystemExit(result.returncode)

    print(f"        done in {elapsed:.1f}s", flush=True)
    return elapsed


def run_publisher():
    """Run the IG Publisher over the staged tree.

    Separate from the chain above because it is Java rather than Python, takes
    about seventeen minutes, and is silent for roughly thirteen of them during
    "Run Template" -- that silence is normal and is not a hang.
    """
    if not PUBLISHER_JAR.exists():
        print(f"No publisher at {PUBLISHER_JAR}", file=sys.stderr)
        raise SystemExit(1)

    env = dict(os.environ)
    env["GEM_HOME"] = GEM_HOME
    env["GEM_PATH"] = GEM_HOME
    env["PATH"] = f"{GEM_HOME}/bin:{RUBY_BIN}:{env.get('PATH', '')}"

    # -Xss16m is a SEATBELT now, not the fix it once was. Keep it anyway.
    #
    # It was added because the publisher generated a "previous version
    # comparison" page per published THO release, and 7.5.0's page is
    # malformed: every row emits `<a href="...">Text</td>` with no closing
    # `</a>`, 4,306 times. Its XhtmlParser treats each unclosed anchor as
    # another nesting level, hit ~4,300 frames deep, and overflowed the
    # default 1MB stack in "Checking Output HTML" -- the very last step,
    # after a complete and correct IG had been written.
    #
    # Those pages are no longer generated at all. vocabulary.xml now sets
    # the version-comparison parameter to n/a, which suppresses them; the
    # reasoning is written out there and the full diagnosis is in readiness
    # item A1. That removed the malformed page along with ~7,300 broken
    # links, ~280MB of output and most of two hours of runtime.
    #
    # The flag stays because it costs nothing on the main thread and the
    # suppression is one parameter away from being lost. If a future change
    # re-enables comparison pages, this is what keeps the failure to a slow
    # build rather than a crash at minute 18. If something DOES overflow the
    # stack again, the fix is not a bigger number -- find which page is
    # malformed and report it upstream.
    #
    # -Xmx12g is a separate story. At 8g the run died with OutOfMemoryError in
    # ValidationPresenter.genQAHtml, so the heap was raised -- and the 12g run
    # peaked at ~7GB during the link check, above the old ceiling, so that OOM
    # was a real shortage. Keep 12g: it is what lets everything up to the QA
    # page finish.
    #
    # It does NOT make the QA page work, and no larger number will. At 12g the
    # same method instead threw
    #
    #   java.lang.NegativeArraySizeException: -1360072342
    #     at java.lang.String.encodeUTF8_UTF16 <- getBytes <- stringToFile
    #     at ValidationPresenter.genQAHtml(ValidationPresenter.java:916)
    #
    # genQAHtml builds the entire QA page as one Java String and then calls
    # getBytes(UTF-8). The encoder sizes its array at up to 3 bytes per char,
    # and that multiply overflowed a signed int: read unsigned, -1360072342 is
    # 2,934,894,954 bytes, 787MB past Integer.MAX_VALUE. A Java array cannot be
    # longer than Integer.MAX_VALUE, so this is a hard ceiling in upstream
    # code, not a tuning problem. 32g would throw the identical exception.
    #
    # The crash leaves a ZERO-BYTE qa.html behind, because stringToFile creates
    # the file before the encode throws. Anything testing exists() will read
    # that as a successful build; test_render_v2mgmt_briefing.py fails loudly
    # on it rather than skipping. Readiness item A1 has the full diagnosis and
    # what to try next -- all of it about shrinking the page, none of it flags.
    command = [str(JAVA), f"-Xmx{PUBLISHER_HEAP_GB}g", "-Xss16m", "-jar", str(PUBLISHER_JAR),
               "-ig", str(IG_INI), "-no-sushi"]

    print("\n" + "=" * 70)
    print("IG Publisher — ~17 minutes, silent for ~13 during \"Run Template\".")
    print("That silence is expected. Check liveness in another shell with:")
    print("  ps -eo pid,etime,comm,args | awk '$3==\"java\"'")
    print("=" * 70, flush=True)

    started = time.monotonic()
    result = subprocess.run(command, cwd=PROJECT_ROOT, env=env)
    elapsed = time.monotonic() - started

    if result.returncode != 0:
        print(f"\nPublisher exited {result.returncode} after {elapsed / 60:.1f} "
              "min.", file=sys.stderr)
        raise SystemExit(result.returncode)
    print(f"\nPublisher finished in {elapsed / 60:.1f} min.")


def read_available_memory_bytes(meminfo=Path("/proc/meminfo"),
                                cgroup=Path("/sys/fs/cgroup")):
    """Return how many bytes this process could still allocate, or None.

    Two limits apply and the smaller one wins:

    - the kernel's MemAvailable in /proc/meminfo, which is the whole
      machine (or VM) the container runs on;
    - the container's own cgroup limit, memory.max minus memory.current.
      memory.max is the word "max" when the cgroup has no limit, and then
      only the first figure counts.

    Returns None if neither can be read (not Linux, unusual mount), so the
    caller can choose to carry on rather than block a build on a guess.
    """
    limits = []

    try:
        for line in meminfo.read_text().splitlines():
            if line.startswith("MemAvailable:"):
                # The line looks like "MemAvailable:     703512 kB".
                kilobytes = int(line.split()[1])
                limits.append(kilobytes * 1024)
                break
    except (OSError, ValueError, IndexError):
        pass

    try:
        cgroup_max = (cgroup / "memory.max").read_text().strip()
        if cgroup_max != "max":
            cgroup_current = int((cgroup / "memory.current").read_text())
            limits.append(int(cgroup_max) - cgroup_current)
    except (OSError, ValueError):
        pass

    if not limits:
        return None
    return min(limits)


def check_publisher_memory(available_bytes, heap_gb=PUBLISHER_HEAP_GB):
    """Return an error message if the publisher cannot get its heap, else None.

    Without this check, a too-small machine fails silently: on 2026-11-12 the
    container had 1.9GB, the JVM was asked for 12g, and the kernel's OOM
    killer sent SIGKILL 1.2 minutes in -- while the publisher was still
    installing packages. The only trace was "Publisher exited -9" and an
    oom_kill count in the cgroup's memory.events. A SIGKILL leaves no Java
    stack trace and no OutOfMemoryError, so nothing pointed at memory.

    The threshold is the full -Xmx value, not the ~7GB the heap actually
    peaked at, because the JVM is entitled to grow to -Xmx and the peak
    depends on the content. A machine between the two may well succeed;
    --skip-memory-check is for trying that deliberately.

    `available_bytes` of None means the figure could not be read. That is
    not treated as a failure: the check exists to explain a known failure,
    not to block builds on machines it does not understand.
    """
    if available_bytes is None:
        return None

    needed_bytes = heap_gb * 1024 ** 3
    if available_bytes >= needed_bytes:
        return None

    available_gb = available_bytes / 1024 ** 3
    return (
        f"Not enough memory for the IG Publisher: it runs with "
        f"-Xmx{heap_gb}g, but only {available_gb:.1f}GB is available.\n"
        f"Started anyway, the kernel would kill it with SIGKILL (exit -9) "
        f"part-way through, with no Java error to say why.\n"
        f"Give the container at least {heap_gb}GB plus headroom, or re-run "
        f"with --skip-memory-check to try regardless (the heap has peaked "
        f"at ~7GB).")


def clear_stale_temp():
    """Delete vocab-ig/temp/ so the build cannot inherit a previous run's pages.

    The publisher stages every page into temp/pages/ and Jekyll copies that
    whole directory into output/. Nothing ever removes an entry that the
    current run did not produce, so temp/ is cumulative: files from
    2026-09-14 were still being copied into output/ on 2026-11-10.

    That turned a working fix into one that looked broken. Suppressing the
    version comparison stopped the pages being GENERATED -- the publisher's
    own step dropped to one millisecond -- but three comparison directories
    reappeared in output/ anyway, 18,942 files of them, copied out of temp/
    where earlier runs had left them. A reader comparing output/ against the
    parameter would conclude the parameter does nothing.

    Deleting temp/ wholesale is safe because it is derived: the publisher
    rebuilds everything it needs there on each run. It is not an optimisation
    to skip -- a cached temp/ makes the build depend on what previous runs
    happened to leave behind, which is the same class of defect as reading
    the FHIR core package out of ~/.fhir/packages (readiness A3).
    """
    if not IG_TEMP.is_dir():
        return
    file_count = sum(1 for _ in IG_TEMP.rglob("*") if _.is_file())
    print(f"Clearing {IG_TEMP} ({file_count:,} files from previous runs).")
    shutil.rmtree(IG_TEMP)


def snapshot_output():
    """Copy a just-completed build to output-snapshot/, replacing the old one.

    The publisher deletes output/ when it starts, so from that moment until it
    finishes -- about twenty minutes -- there is no readable IG, and if the run
    is interrupted there is none afterwards either. Keeping the last build that
    actually finished means that state cannot happen.

    Only ever called after the publisher exits 0, so the snapshot is always a
    build that completed. A failed build leaves the previous snapshot alone,
    which is the whole point.

    The copy goes to a scratch directory and is renamed into place, so an
    interrupted copy cannot destroy the good snapshot it was replacing.
    """
    if not IG_OUTPUT.is_dir():
        print(f"No {IG_OUTPUT} to snapshot; skipping.")
        return

    scratch = IG_SNAPSHOT.with_name(IG_SNAPSHOT.name + ".incoming")
    previous = IG_SNAPSHOT.with_name(IG_SNAPSHOT.name + ".previous")
    for leftover in (scratch, previous):
        if leftover.exists():
            shutil.rmtree(leftover)

    started = time.monotonic()
    shutil.copytree(IG_OUTPUT, scratch, symlinks=True)

    # A file saying what this is, because a directory of 16,000 HTML pages is
    # otherwise indistinguishable from the live build at a glance.
    (scratch / "SNAPSHOT.txt").write_text(
        "This is a COPY of a completed vocab-ig build, kept so that the IG is\n"
        "still readable while the publisher is running (it wipes output/ on\n"
        "startup) and after a build that fails.\n\n"
        "It is NOT the live build. The live build is vocab-ig/output/.\n\n"
        f"taken:  {time.strftime('%Y-%m-%d %H:%M:%S')}\n"
        f"commit: {current_commit()}\n"
        f"source: {IG_OUTPUT}\n",
        encoding="utf-8")

    # Rename the old one aside, move the new one in, then delete the old one.
    # At no point is there no snapshot.
    if IG_SNAPSHOT.exists():
        IG_SNAPSHOT.rename(previous)
    scratch.rename(IG_SNAPSHOT)
    if previous.exists():
        shutil.rmtree(previous)

    elapsed = time.monotonic() - started
    print(f"Snapshot updated: {IG_SNAPSHOT} ({elapsed:.1f}s). "
          "It is a copy, not the live build.")


def current_commit():
    """The HEAD commit, for the snapshot marker. Never fatal."""
    try:
        result = subprocess.run(["git", "rev-parse", "--short", "HEAD"],
                                cwd=PROJECT_ROOT, capture_output=True,
                                text=True, timeout=10)
        return result.stdout.strip() or "unknown"
    except Exception:
        return "unknown"


def print_chain(steps):
    """Show the order and the reason for it, without running anything."""
    print("Vocabulary IG preprocessing chain:\n")
    for position, step in enumerate(steps, 1):
        needs = ", ".join(sorted(step["consumes"])) or "the corpus on disk"
        print(f"  {position}. {step['name']}")
        print(f"     needs: {needs}")
        print(f"     {step['why']}\n")
    print("Then the IG Publisher (--publish), or run it yourself against "
          "vocab-ig/ig.ini.")


def select_steps(args):
    """Work out which steps this invocation should run."""
    names = [s["name"] for s in STEPS]

    if args.only:
        if args.only not in names:
            raise SystemExit(f"No step named {args.only!r}. "
                             f"Known: {', '.join(names)}")
        return [s for s in STEPS if s["name"] == args.only]

    if args.start_from:
        if args.start_from not in names:
            raise SystemExit(f"No step named {args.start_from!r}. "
                             f"Known: {', '.join(names)}")
        return STEPS[names.index(args.start_from):]

    return list(STEPS)


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--list", action="store_true",
                        help="show the chain and exit")
    parser.add_argument("--from", dest="start_from", metavar="STEP",
                        help="resume from this step, skipping earlier ones")
    parser.add_argument("--only", metavar="STEP",
                        help="run just this step")
    parser.add_argument("--publish", action="store_true",
                        help="also run the IG Publisher when the chain passes")
    parser.add_argument("--no-snapshot", dest="snapshot", action="store_false",
                        help="do not refresh vocab-ig/output-snapshot after a "
                             "successful publish")
    parser.add_argument("--skip-memory-check", action="store_true",
                        help="start the publisher even if available memory "
                             "is below its -Xmx heap size")
    args = parser.parse_args()

    # Always check the declared order, even for --list. A broken graph is worth
    # hearing about at the cheapest possible moment.
    problems = check_order()
    if problems:
        print("The step order is inconsistent with the declared "
              "dependencies:", file=sys.stderr)
        for problem in problems:
            print(f"  - {problem}", file=sys.stderr)
        raise SystemExit(2)

    if args.list:
        print_chain(STEPS)
        return

    if args.only and args.start_from:
        raise SystemExit("--only and --from do not go together.")

    # Check memory before the chain, not after it, so a machine that cannot
    # run the publisher is told so in a second rather than after the chain
    # and a minute of publisher start-up.
    if args.publish and not args.skip_memory_check:
        problem = check_publisher_memory(read_available_memory_bytes())
        if problem:
            print(problem, file=sys.stderr)
            raise SystemExit(3)

    steps = select_steps(args)
    missing = [s["name"] for s in steps if not script_path(s["name"]).exists()]
    if missing:
        raise SystemExit(f"Missing script(s): {', '.join(missing)}")

    if len(steps) < len(STEPS):
        print(f"Running {len(steps)} of {len(STEPS)} steps. Earlier steps' "
              "outputs are assumed current.")

    started = time.monotonic()
    for position, step in enumerate(steps, 1):
        run_step(step, position, len(steps))
    total = time.monotonic() - started

    print(f"\nChain complete in {total:.1f}s.")

    if args.publish:
        clear_stale_temp()
        run_publisher()
        if args.snapshot:
            snapshot_output()
    else:
        print("The staged tree is ready. Re-run with --publish to build the "
              "IG, or run the publisher yourself against vocab-ig/ig.ini.")


if __name__ == "__main__":
    main()
