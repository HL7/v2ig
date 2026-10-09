# ADR-0013: Suppression by Ruling — Withholding a Table a Committee Said Not to Publish

## Status

Accepted

## Date

2026-10-08

## Context

On 2026-09-23 V2 Management ruled that tables 0567 *Weight Units* and 0568
*Volume Units* should never have been created, that their value sets will be
retired by a separate Jira ticket raised against THO rather than by this
project, and that **this IG is to do nothing with them**.

"Do nothing" turned out not to describe what the guide was doing. It was
publishing both value sets, and publishing them *incremented* — ours at 4.0.0
against THO's 3.0.0. The increment was earned honestly by the versioning
policy: THO lists the UCUM codes bare, this guide adds display text
(`[lb_av]` → "Pound", `l` → "Liter"), and `compose.include` changing is a
versionable change. So the guide was minting a new version of two artifacts a
committee had just said it should leave alone, and would have gone on doing so
every time the chapter was re-read.

The register's prose alone could not fix this. Recording a resolution in
`vocabulary_escalations.py` changes no output — that is explicitly true of the
register by design, and ADR-0011 says so. Something in the pipeline had to
stop writing the files.

**None of the three existing mechanisms fits.**

The **ADR-0010 evidence gate** overrides the chapter where the correct reading
is derivable from evidence, and ADR-0010 is emphatic that it must be expressed
as a general condition rather than a table number. There is no general
condition here to find. The reason these two tables are withheld is not a
property of their content that a rule could detect — their content is
unremarkable, and is byte-identical to tables 0929 and 0930 which the guide
continues to publish. The reason is that a committee said so.

The **ADR-0011 tentative override** is the closest fit and is the wrong one,
in a way worth stating precisely because the two mechanisms will sit next to
each other. A tentative override deviates from the chapter **while waiting**
for an answer, and ADR-0011 makes it an enforced invariant that every entry
names a register item that is still **open**; the count of entries is
published as the guide's un-ruled-deviation debt. A suppression is the mirror
image: it deviates **because** an answer arrived. Filing one in
`TENTATIVE_OVERRIDES` would break that invariant and, worse, would report a
settled decision as an outstanding question — inflating the debt figure with
something that is not a debt.

**`needs-decision`** means *we cannot proceed*. These tables are not blocked;
they are decided. Using it would file a ruling as a failure, and the fifteen
genuine `needs-decision` tables are a worklist that this would pollute.

## Decision

Add **`RULED_SUPPRESSIONS`** to `write_utg_xml.py`: a keyed table of tables a
committee has ruled this guide should not publish, consulted before
classification, producing the new action `suppressed-by-ruling`.

1. **Keyed by table number, carrying the ruling.** Each entry holds the
   ruling in the words of the decision, the id of the register item that
   records it, and the concrete consequence — what stops being published.

2. **Every entry must name a register item that has a `resolution`.** This is
   the invariant, and it is the exact reverse of ADR-0011's: that mechanism's
   items must be open, this one's must be answered. A suppression resting on
   an open item would be this project deciding not to publish something and
   dressing it as somebody else's ruling. Enforced by a test.

3. **Consulted before `classify()`, not after.** A suppressed table is one
   nobody wants an opinion about. Classifying it and discarding the result
   would run the THO merge across it and file observations against a table
   the guide is not publishing, which would then surface in the ledger and
   the fill report as findings about an artifact that does not exist.

4. **The absence is reported, never silent.** The table keeps an entry in the
   write report carrying the ruling, and the run prints what it withheld. A
   table that simply vanished from the output while remaining in the chapter
   is indistinguishable from a pipeline failure.

5. **Stale artifacts are pruned.** The writer deletes exactly the paths a
   suppressed table would have written, because nothing else prunes that
   directory — `stage_vocab_ig.py` mirrors whatever it finds. A file left
   behind is a file published in the IG, and the ruling would have had no
   effect on the output it was about. The prune is narrow by path rather than
   a sweep, because under `--table` the rest of the directory is still
   current.

6. **The two mechanisms are disjoint**, enforced by a test. A table cannot be
   both awaiting a ruling and governed by one.

Reversal is deleting the entry: nothing else in the writer knows about these
tables, so the chapter's reading is restored intact.

## Alternatives considered

**Edit the extraction so the tables carry no content.** Rejected on the same
grounds ADR-0011 rejected it for 0292: the extraction is a faithful record of
what the chapter says, and editing it would destroy the evidence that the
chapter publishes something this guide does not.

**Publish them unchanged at THO's 3.0.0** — drop the added display text so
nothing increments. This was genuinely tempting, because it satisfies "we
won't touch them" quite literally and keeps the guide's coverage of the
chapter complete. Rejected because it is not what was ruled: the instruction
was that the IG should do nothing with them, and continuing to publish two
value sets is doing something. It would also require a special case in the
display-filling path, which is a general rule applied to the whole corpus —
a worse place to carve an exception than a suppression table.

**Suppress via the register alone and accept the drift.** Rejected. The whole
defect the ruling addressed was the guide acting on tables it had been told to
leave; a resolution that changes no output leaves that intact.

## Consequences

The guide now publishes two fewer value sets, and `valueSet: incremented`
falls from 22 to 20. Both numbers appear in authored prose in the briefings
and are covered by `test_render_v2mgmt_briefing.py`, which compares them
against the build.

The pipeline gains a fourth way to deviate from the chapter, which is one
more than is comfortable. The mitigation is that each is narrow and each is
enforced: the evidence gate must be a general condition, a tentative override
must name an open question, a suppression must name an answered one.

A reader of the chapter will find two tables with no corresponding artifact in
this guide. That is why the report entry carries the ruling rather than only
the fact of suppression — the question "where did 0567 go?" has to be
answerable from the guide's own output.

**The ruling's other half is not implemented and is not this project's to
implement.** Retiring `ValueSet/v2-0567` and `v2-0568` in THO goes via a
separate Jira ticket. Nothing here tracks whether that ticket was raised.

## Related

- ADR-0010 — the evidence gate, and the argument against special-casing table numbers
- ADR-0011 — tentative overrides, the mechanism this one mirrors
- `esc-0567-0568-deprecation` — the register item carrying the ruling
- `esc-0929-0930-enumerated-subset` — the half of the original ask the ruling did not reach, re-asked against the live replacement tables
