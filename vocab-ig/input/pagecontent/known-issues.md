This page exists so that a reviewer can tell the difference between a defect in
the pipeline and a defect we already know about. **Read it before filing
anything.**

### Links out of `conceptdomains` — resolved

The narrative carried by `CodeSystem/conceptdomains` comes from THO, and THO
links to sibling v3 code systems by page filename —
`CodeSystem-v3-ActClass.html` and five others. Those resolve inside THO's own
site and nowhere else, so in this guide all **191** of them dangled.

They now point at the canonical URL of the code system they name, which the
HL7 proxy redirects to the rendered page. The rewrite is checked against the
THO package rather than assumed: a link is only changed when THO really does
publish a code system of that id at that canonical, and anything else is left
exactly as published and reported. Narrative takes no part in the merge or in
versioning, so no artifact version moved.

### Fourteen tables with nothing written

These are blocked on a decision, not on work:

`0399` `0458` `0459` `0467` `0821` `0822` `0823` `0824` `0827` `0828` `0895`
`0953` `0956` `0963`

Each is recorded with its evidence on the [per-table
ledger](table-ledger.html), and the reason the writer stopped at each one is
grouped by cause under [what needs an
answer](open-items.html). **0459 is a hard stop**: the chapter gives its code
system only as OID `2.16.840.1.113883.6.301.9`, which nothing in THO or FHIR
core resolves.

### Defects reproduced from the published chapter on purpose

The load is faithful to Chapter 2C, so the chapter's own editing defects are
present in these resources. They are **not** to be reported as pipeline bugs:

- **Sixteen truncated ValueSet descriptions**, each stopping mid-word between
  242 and 252 characters: tables 0038, 0170, 0227, 0254, 0315, 0326, 0335,
  0389, 0392, 0406, 0508, 0510, 0511, 0513, 0520 and 0544. THO carries the same
  truncation on fifteen of the sixteen. Table 0227 is the exception: THO's text
  continues 171 characters further and completes the sentence. Each affected
  table carries the item on the [per-table ledger](table-ledger.html).
- Table 0821's emptied code grid.
- Page-URL defects and missing spaces in published descriptions.
- Tables 0567 and 0568, which the chapter deprecates in prose while THO
  publishes both as live resources with no deprecation marker — and which print
  their *replacement's* canonical (`v2-0929`, `v2-0930`) as their own URI.

Whether this project may repair these as technical corrections is the open
question before V2 Management. Until it is answered, they stay.

### Five concept domains with conflicting definitions

Chapter 2C gives two different descriptions for each of these domains, and the
build emits the first in document order — which is a coin toss:

| Domain | Tables |
|---|---|
| DeviceStatus | 0682, 0962 |
| DeviceType | 0657, 0961 |
| Modality | 0259, 0604 |
| QuantityUnits | 0560, 0602 |
| VolumeUnits | 0568, 0777, 0930 |

Four of the five look resolvable on inspection — 0602, 0604 and 0777 have no
`Type`, no steward and a segment reference in the table name, so they read as
field-specific stubs rather than rival definitions. **The Device pair is the
genuinely contested one** and needs Orders & Observations.

### Version-divergence warnings

Where this guide publishes an artifact at a version THO's package does not
carry, the validator warns that a reference to that canonical has **"multiple
different potential matches"**. There is one for each artifact whose version
has moved, and the count grows with every increment. It is a consequence of
republishing at THO's canonicals rather than a defect: the artifact and its
version are both correct, and the reference resolves.

### Terminology server errors

`tx.fhir.org` is unreachable from the build host and the build runs with
`-tx n/a`. Terminology-validation errors and warnings that trace back to a
missing terminology server are expected and are not findings.
