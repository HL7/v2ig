# ADR-0015: Canonical by Ruling — Publishing a Value Set at a Name the Table Number Does Not Imply

## Status

Accepted

## Date

2026-11-05

## Context

Every ValueSet this guide writes publishes at a canonical URL, and until now
that URL was never a choice. `value_set_identity` settles it in two steps:
use whatever THO already publishes for the table, and where THO publishes
nothing, construct `http://terminology.hl7.org/ValueSet/v2-NNNN` from the
table number.

The constructed form is a fallback, not a decision. It exists because a
resource must have a canonical and no better name was available. For the
overwhelming majority of the corpus it is also the right name — a v2 table's
value set published at a v2 canonical — and nothing here changes that.

**Table 0820 is where the fallback produced a poor name.** The table is
*Gender Harmony Concepts*; it enumerates three LOINC codes covering gender
identity, sexual orientation and personal pronouns. THO publishes nothing for
it: no `ValueSet/v2-0820`, and nothing anywhere in the 7.3.0 snapshot carrying
its value set OID `2.16.840.1.113883.21.480`. So the guide was minting a first
publication, and minting it at `ValueSet/v2-0820` purely because 0820 is the
table number.

On 2026-11-05 V2 Management ruled that the value set should be created with no
code system — the codes are LOINC's — and published at
`http://terminology.hl7.org/ValueSet/gender-harmony-attributes`, carrying
Chapter 2C's OID.

This is not a reclassification. `RULED_RECLASSIFICATIONS` already says *what*
to publish and over which code system, and 0820 needs an entry there too: the
chapter's classification is fine, but the ruling has to authorise the write.
What no existing mechanism could express is *where the artifact lives*.

## Decision

Add `RULED_CANONICALS`, keyed by table number, holding the canonical a
committee has set for a table's ValueSet, the register item carrying the
resolution, and the canonical it replaces.

`value_set_identity` consults it, and the resource id and file name follow
from the canonical exactly as they already do — so all three stay consistent
without a second place to keep them in step.

### The constraint that makes this safe

**A ruled canonical applies only where THO publishes nothing for the table.**
If THO already publishes the table's value set, THO's canonical wins and the
ruled one is ignored.

This is the whole guard. The mechanism exists to improve a name this guide
invented; letting it move a canonical THO has already published would fork a
live artifact — two URLs, one body of content, and an implementer with no way
to know which is current. Moving a published canonical is not a naming
decision at all. It is a supersession, and ADR-0014 already covers it:
retire what exists and point at the replacement.

So the two mechanisms partition cleanly by whether THO has published:

| THO publishes the v2 artifact | The ruling says | Mechanism |
|---|---|---|
| No | publish it somewhere better | `RULED_CANONICALS` (this ADR) |
| Yes | use something else instead | `RULED_SUPERSESSIONS` (ADR-0014) |

### Pruning

Moving a canonical renames the file. The file written under the old name is
not overwritten — it is simply no longer written — and nothing else cleans
the output directory, because `stage_vocab_ig` mirrors whatever is in it. Left
alone, the IG would publish the same three codes at two canonicals, one of
them the name the ruling rejected.

So the writer deletes the file at the replaced canonical, the same way the
suppression prune does, and says so on stdout. `replaces` exists for this as
much as for the record.

## Consequences

**0820 publishes at `ValueSet/gender-harmony-attributes`** with Chapter 2C's
OID `2.16.840.1.113883.21.480` and its three LOINC codes, and
`vs-v2-0820.xml` is gone. No CodeSystem: the codes are LOINC's.

**The guide now publishes two value sets whose canonical is not derivable from
their table number**, counting THO's own `v2-notAllCodes-NNNN` forms it
inherits. A reader of the ledger needs to be told why, which is what the
register item is for.

**The mechanism should stay small.** It is reversible — delete the entry and
the derived canonical returns — but each entry is a name somebody has to
know is special. If it grows beyond a handful of tables, the right response
is probably a naming convention rather than more entries.

**The `replaces` field will go stale in a useful way.** Once a ruled canonical
has been published for a release, the old file no longer exists to prune and
the field is purely historical. That is fine; it is the record of what moved.
It should not be deleted, because it is the only place the move is written
down in the code.
