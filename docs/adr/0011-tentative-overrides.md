# ADR-0011: Tentative Overrides — Deviating from the Chapter While a Ruling Is Pending

## Status

Proposed

## Date

2026-09-19

## Context

The governing rule for this load is fidelity to Chapter 2C: where the chapter is
wrong, the defect is recorded and escalated rather than silently repaired. Two
mechanisms serve that rule today, and between them they leave a gap.

The first is the **escalation register** (`tooling/scripts/vocabulary_escalations.py`).
It is where a defect is written down and put in front of a committee. It is prose:
an `id`, a `tables` list, a `body`, an `ask`, and a `who`. Nothing in the pipeline
reads it. Registering a defect changes no output.

The second is the **evidence gate** of ADR-0010. Where the chapter's own content is
self-defeating and the correct reading is derivable from evidence, the writer
overrides it — the `noObject` placeholder handling at `write_utg_xml.py:580-599` is
the worked example. ADR-0010 is emphatic that the override must be expressed as a
general condition rather than a table number, and its reasoning is good:

> Special-case the table number. Rejected. `if table == "0560"` records the
> conclusion and throws away the reasoning.

So the pipeline can do two things: publish what the chapter says and register a
complaint, or override the chapter permanently on derivable evidence. It cannot do
the thing table 0292 needs.

**Table 0292 is the case that does not fit.** The chapter flags it
`Concept Domain Only: yes`, so the pipeline writes nothing for it. Four independent
signals say that flag is wrong and it is a real table whose code system belongs to
the CDC — including the chapter's own table-metadata grid, which names the code
system and prints its canonical in the same section that declares the table
domain-only. The reviewer's instruction is to treat it tentatively as a real table,
with the final answer coming from TSMG or V2 Management, and for the guide to make
that visible.

Neither existing mechanism does this. The register alone changes no output, so the
guide would keep publishing nothing while claiming the table is real. The ADR-0010
gate is permanent and carries no notion of a pending ruling; an override recorded
that way is indistinguishable from a settled decision, and nothing would make it
expire or resurface.

The tension with ADR-0010 is real and should not be waved away. Its argument is
that a table number in the code is a conclusion with the reasoning thrown away.
That argument has force precisely when the override *is* derivable from a general
rule — then the rule is the honest expression of it, and it catches the next table
with the same defect. It has much less force here. What is being asserted for 0292
is not a rule. It is a specific, provisional judgement about one table, made by
named people, awaiting a named committee's answer. The table number is not an
impoverished stand-in for a rule; it is the actual scope of the claim. Writing it
as a general condition would be the dishonest option, because it would imply a
generality nobody has established.

## Decision

Add a **tentative override** mechanism, distinct from the ADR-0010 evidence gate
and explicitly scoped to deviations that are awaiting a committee ruling.

1. A keyed table in the writer, on the model of `MANUAL_CORRECTIONS` in
   `vocabulary_text_policy.py` — which already demonstrates the shape: keyed,
   rationale-bearing, enumerable. Each entry carries the table number, what the
   chapter says, what this guide does instead, the id of the register item that
   asks the question, and the evidence.

2. It is consulted in `classify()` **before** the gate it overrides, and it stamps
   a `tentativeOverride` block into that table's entry in the write report, naming
   the register item.

3. **Every entry must name a register item, and that item must exist.** An override
   with no pending ask is not tentative; it is an unrecorded decision, and the
   mechanism must refuse it. This is the invariant that keeps the register and the
   pipeline honest about each other, and it is enforced by a test.

4. The count of un-ruled deviations is computed on every run and surfaced in the
   guide, so it cannot drift out of sight. A tentative override that nobody has
   answered is a debt, and debts should be visible.

5. When a ruling arrives the entry is deleted. If the ruling agrees, the deviation
   becomes either the plain reading of corrected source data or a permanent
   ADR-0010-style rule, and an ADR records it. If it disagrees, deleting the entry
   restores the chapter's reading with no other change.

The mechanism is for deviations awaiting a ruling. It is **not** a general licence
to special-case a table. An override that is derivable from evidence belongs in a
general condition under ADR-0010; an override nobody has asked a question about
does not belong in the pipeline at all.

## Alternatives considered

**Keep publishing the chapter's reading and rely on the register.** Faithful, and
it needs no new code. Rejected because the reviewer's judgement is that 0292 is a
real table, and a guide that agrees with that in prose while publishing nothing at
the canonical is less honest than one that publishes and flags. It also gives the
committee nothing concrete to rule on — a ruling is easier against a shape you can
look at.

**Express 0292 as a general condition under ADR-0010.** The condition would be
something like *"a table flagged concept-domain-only whose table-metadata grid
nonetheless names a code system and prints its canonical."* Tempting, and it would
sit inside the existing mechanism. Rejected for now because it fits exactly three
tables (0227, 0292, 9999), of which one is a placeholder section and one is already
routed correctly for other reasons — a "general" rule with one real member is a
table number wearing a disguise. If the committee rules for 0292 and the same shape
turns up again, promoting it to a general condition is the right move then.

**Mark it `needs-decision`.** This is the pipeline's existing "we did not decide"
state and it produces no artifact. It means *we cannot proceed*, not *we proceeded
against the chapter deliberately*, so it cannot express a tentative override.
Rejected.

**Carry the override in the extraction data rather than the writer** — edit 0292's
`Concept Domain Only` in `v291-extracted/vocabulary/0292.json`. Rejected outright:
the extraction is a faithful record of what the chapter says, and editing it would
destroy the evidence that the chapter says something different from what we publish.

## Consequences

The pipeline gains a third, narrow way to deviate, and with it the obligation to
keep the count visible. The risk is that "tentative" becomes permanent by neglect —
which is why the count is computed and published rather than held in a file
somebody has to open.

ADR-0010's rule stands unchanged for evidence-derivable overrides. This ADR does not
relax it; it carves out the case ADR-0010 did not address, where the deviation is
provisional and its scope genuinely is one table.

If V2 Management rules that the chapter's `Concept Domain Only` flag is
authoritative for 0292, the change is deleting one entry.

## Related

- ADR-0008 — Batch A, the external-code-system rule that makes 0292 `value-set-only`
- ADR-0009 — additive merge with THO
- ADR-0010 — the evidence gate, and the argument against special-casing table numbers
- `esc-0292-cdo-contradiction` — the register item this override must name
