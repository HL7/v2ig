This page exists so that a reviewer can tell the difference between a defect in
the pipeline and a defect we already know about. **Read it before filing
anything.**

### Broken links out of `conceptdomains`

The narrative carried by `CodeSystem/conceptdomains` links to v3 code system
pages — `CodeSystem-v3-ActClass.html`, `CodeSystem-v3-RoleClass.html` and
others — that are **not part of this guide**, so those links do not resolve.
There are **191 of them**, and they are the largest block of errors in the QA
report that genuinely belongs to this guide; almost everything else there
traces back to the unreachable terminology server.

They are a packaging artifact, not a content defect: the concepts and their
properties are correct. The open question is whether this guide declares a
dependency on the v3 code systems or points the links at the artifacts already
published on `terminology.hl7.org`, and that decision has not been taken.

### Fourteen tables with nothing written

These are blocked on a decision, not on work:

`0399` `0458` `0459` `0467` `0821` `0822` `0823` `0824` `0827` `0828` `0895`
`0953` `0956` `0963`

Each is recorded with its evidence on the [per-table
ledger](table-ledger.html). **0459 is a hard stop**: the chapter gives its code
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

### Terminology server errors

`tx.fhir.org` is unreachable from the build host and the build runs with
`-tx n/a`. Terminology-validation errors and warnings that trace back to a
missing terminology server are expected and are not findings.
