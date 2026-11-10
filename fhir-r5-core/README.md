# Vendored FHIR R5 core — CodeSystem definitions only

**Why this directory exists.** `load_oid_index` in
`tooling/scripts/write_utg_xml.py` turns an OID into a canonical URL, and a
handful of Chapter 2C tables name a code system that FHIR owns rather than
THO — table 0962's Device Status is `http://hl7.org/fhir/device-status`.
Without the core package those OIDs look unresolvable when they are merely
defined somewhere else, and the affected tables fall through to the
needs-decision list.

**Why it is vendored rather than read from the cache.** It used to be read
from `~/.fhir/packages`, which nothing pins and nothing records. On
2026-11-05 table 0962 moved from `needs-decision` to published between two
builds on the same day with nothing in this repository changing: the IG
Publisher had downloaded the core package mid-session, and the OID then
resolved. The output was correct both times, which is what made it
dangerous — there was no error to notice, only a different IG from the same
commit. See `esc-0962-already-in-tho` and item **A3** of
`v291-extracted/readiness-action-items.md`.

**What is here.** The 448 `CodeSystem-*.json` files from
`hl7.fhir.r5.core#5.0.0`, plus that package's `package.json` so the version
and date are recorded alongside them. Nothing else from the package is read
by this project, and the rest of it is ~90MB, so the rest is not kept.

**Scope of its authority.** Lowest. THO outranks it, and a THO NamingSystem
outranks a CodeSystem's own identifier list. 576 OIDs resolve only through
this directory, and 176 of those resolve through an identifier FHIR itself
marks `use: "old"` — so a match found here is weaker evidence than a match
found in THO, and a surprising one is worth checking by hand.

**Updating it.** Re-copy `CodeSystem-*.json` and `package.json` from a newer
`hl7.fhir.r5.core#*/package`, as its own commit with its own rebuild and
diff — never in the same pass as a ruling batch, for the same reason the THO
snapshot is bumped on its own.
