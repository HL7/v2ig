# Chapter 2C field mapping — What the chapter publishes about each table, and how much of it reaches the FHIR resources

Chapter 2C publishes far more about each code table than a
CodeSystem and a ValueSet have room for. This document sets out, field by
field, what reaches the generated resources and what does not — so that
the information being dropped is dropped on purpose.

The question that prompted it was a narrow one: the Code System
Identification block has a Full Name field, and nothing in the output
appears to carry it. That turned out to be true, and to be one of
twenty-four such fields. Two of them carry a value on all 799 tables.

This is the systematic version of what ADR-0008 calls Batch C
— container-level metadata — which has been open since the ADR was
written and lists four of these questions individually. Rather than answer them
one at a time, the whole surface is laid out here with counts attached, so the
ones worth spending effort on are visible next to the ones that are not.

Nothing here is a proposal. A field recorded as not carried is a
question, not a defect: some of these have no sensible FHIR home, and some
describe the chapter rather than the terminology. The purpose is to make the
choice explicit.

## What is not carried

| Field | Tables | Block | Why it goes nowhere |
|---|---|---|---|
| Description | 799 | Table metadata | A description of the table, on all 799 tables, going nowhere. It is not a duplicate of the code system or value set description — it describes the table as a whole, and it is present on the 355 tables that have no code system block at all and therefore no other description of any kind. For a concept-domain-only table this is the only prose the chapter offers beyond the domain definition. |
| Type | 799 | Table metadata | User, HL7 and the other table types. This is a real classification with consequences — a User table is site-extensible and an HL7 table is not — and it is the kind of thing an implementer needs. FHIR has no standard place for it, so it would need a concept property or an extension. |
| Concept Domain Name | 796 | Concept Domain | Not a name but a sequence label — the values are DOM: 1, DOM: 2 and so on. The usable name is SymbolicName. Nothing is lost by dropping it unless the numbering means something to somebody. |
| where used | 779 | Table metadata | The message fields the table is bound to — PID-8 and so on — on 779 tables. This is the link between the vocabulary and the rest of the standard, and it is the single richest piece of information in the chapter that reaches nothing. It arguably belongs on the binding rather than on the value set, which is why it has no natural home in a terminology-only IG. Worth deciding deliberately rather than by omission. |
| HL7 Version Introduced | 607 | Table metadata | The release the table was introduced in, on 607 tables. A different fact from the code system version block's field of the same name, and dropped for the same reason: no property has been defined for it. D18 covers both. |
| SymbolicName | 593 | Table metadata | The table's own symbolic name, distinct from the code system's and the value set's. Populated on 593 tables and read by nothing. |
| Realm | 439 | Binding Information | On 439 tables, almost all of them representative. FHIR has ValueSet.jurisdiction, which is the obvious candidate, but “representative” is not a jurisdiction — it is a statement about the status of the binding, closer to an HL7 realm concept than to a country code. Recorded as an open Batch C question in ADR-0008 and still open. |
| Full Name | 437 | Code System Identification Information | The field this document was commissioned over. Carries a value on 437 of the 444 tables that declare a code system, and is read by nothing. There is no obvious FHIR home: title is already taken by SymbolicName, and the two are not the same string — Full Name is a human-readable label of the form <Table Name> Code System. It is also the field with the known copy-paste defects: 412 of 444 follow the pattern and the exceptions include names carried over from a different table. Because nothing reads it, those defects never reach the output — which is a reason the field is low-risk, not a reason it is worthless. |
| Full Name | 432 | Value Set Identification Information | The Value Set counterpart of the Code System Full Name, on 432 tables, and read by nothing for the same reason: title already holds SymbolicName. |
| URI | 429 | Value Set Identification Information | Read by nothing, and it should be. The writer constructs ValueSet.url from the table number as …/ValueSet/v2-NNNN. For 412 of 429 tables that is character-for-character what the chapter prints, which is why this was invisible until the mapping was written out. For 17 tables it is not, and for four of those the chapter, THO and UTG all agree on a canonical we are not using. See the findings section. |
| Version | 426 | Code System Version | The chapter's own version number for the code system. CodeSystem.version is taken from the existing UTG resource instead, and where UTG has none, from a default. The two are on different schemes — the chapter counts 1, 2, 3; THO uses semantic versions — so they cannot simply be substituted, but nobody has reconciled them either. |
| HL7 Version Introduced | 422 | Code System Version | ADR-0008 D18 already ruled on this one: it is provenance about the concept and belongs in a property, never in CodeSystem.version. The ruling has not been implemented, so the information is currently dropped. This is the clearest actionable gap in the document — the decision exists, only the property does not. |
| Effective Date | 416 | Code System Version | In DD.MM.YYYY form. CodeSystem.date comes from UTG, where 414 of 416 resources carry the same 2019-12-01 — the date of a bulk load, not a date anyone chose. The chapter has the better information here and it is the one being thrown away. |
| URL | 4 | Code System Identification Information | A variant spelling of URI that nothing reads. Four tables (0821, 0823, 0955, 0958), eight rows between them, use URL as the key where every other table uses URI. The writer looks up URI only, so these are invisible to it. Two of the four tables are resolved anyway by their OID; two are blocked for other reasons. Worth fixing at source so the chapter uses one key, and worth reading both keys here in the meantime. |
| THO URL | 3 | Value Set Identification Information | Three tables (0821, 0822, 0823) carry an hl7.org/permalink address under this key. A permalink is not a canonical and could not be used as one, but it does point at the intended value set, which is more than those three tables otherwise give us — all three are currently blocked. |
| Full Name | 3 | Table metadata | Three tables carry it at table level as well. |
| URI | 2 | Table metadata | Two tables. |
| UTG Name | 1 | Code System Identification Information | One table, 0083, carries an extra key naming the UTG resource (v2 Outlier Type). Nothing else in the corpus has it. Almost certainly an editing artefact rather than a field. |
| Comments | 1 | Code System Identification Information | One table, 0719: replaces 2.16.840.1.113883.18.389. That is a substantive statement about supersession and it reaches nothing. A single instance, but the kind of information that is expensive to recover once lost. |
| Comments | 1 | Value Set Identification Information | Two tables. 0719's says replaces 2.16.840.1.113883.21.406 — supersession again, and again dropped. 0821's is empty. |
| UTG Name | 1 | Value Set Identification Information | Table 0083 only, as with the code system block. |
| UTG Title | 1 | Value Set Identification Information | Table 0083 only. |
| Version Info | 1 | Table metadata | One table. |
| Code System OID | 1 | Table metadata | One table carries a Code System OID in its table metadata block rather than in its code system block. An editing slip, but it means one table's code system OID is invisible to the writer. |

## Concept Domain

_Feeds `CodeSystem/conceptdomains` · 796 tables_

Every table declares a concept domain, whether or not it also has a code system. The domain is the abstract idea the table is about; the code system is one way of expressing it. These fields feed the single shared conceptdomains CodeSystem, which this project extends rather than replaces (ADR-0008 D1).

| Field | Tables | Status | Where it goes | Notes |
|---|---|---|---|---|
| Concept Domain Name | 796 | Not used | — | Not a name but a sequence label — the values are DOM: 1, DOM: 2 and so on. The usable name is SymbolicName. Nothing is lost by dropping it unless the numbering means something to somebody. |
| SymbolicName | 794 | Carried | conceptdomains: concept.code, concept.display | Used verbatim as the concept code, including where it contains characters unusual in a code. Fidelity wins and the irregular ones are reported rather than normalized. |
| Description | 796 | Transformed | conceptdomains: concept.definition | Carried only where THO does not already publish the domain. Where it does, THO's definition is kept and the chapter's is discarded (ADR-0008 D1). That affects 5 domains where the two genuinely differ; for 577 others the two texts are identical, so nothing turns on it. Where one domain is declared by several tables with different wordings, the first in document order wins. |
| Concept Domain Only | 796 | Used, not carried | decides whether any CodeSystem or ValueSet is written | The single most consequential field in the corpus: yes on 360 tables, and every one of those produces no CodeSystem and no ValueSet. The flag itself is not recorded anywhere in the output, so nothing in the published resources says why a table has no terminology. |

## Code System Identification Information

_Feeds `CodeSystem/v2-NNNN` · 437 tables_

The identity of the code system the table's codes belong to. Where the table owns that code system, these fields become a CodeSystem resource. Where the code system belongs to somebody else — UCUM, SNOMED, a v3 code system, another v2 table — no CodeSystem is written at all, and everything in this block except the identifier has nowhere to go. That second case is set out separately below.

| Field | Tables | Status | Where it goes | Notes |
|---|---|---|---|---|
| Code System OID | 437 | Carried | CodeSystem.identifier[0].value as urn:oid:… | Also the fallback identifier when the chapter prints no usable canonical URL, which resolved seven tables by itself. Omitted from the resource where the value is blank or a bare hyphen. |
| SymbolicName | 437 | Transformed | CodeSystem.name (PascalCase), CodeSystem.title (verbatim) | One source field feeding two elements, which is how UTG does it. name is a computed form and title the original, so nothing is lost. The same field doubles as the noObject placeholder marker that identifies a table with no real code system. |
| Description | 437 | Carried | CodeSystem.description | Carried in full. Unlike the Value Set descriptions, these are not truncated — they run past 500 characters and end cleanly, which is the evidence that the truncation is a cap on one field rather than a general limit. |
| Full Name | 437 | Not used | — | The field this document was commissioned over. Carries a value on 437 of the 444 tables that declare a code system, and is read by nothing. There is no obvious FHIR home: title is already taken by SymbolicName, and the two are not the same string — Full Name is a human-readable label of the form <Table Name> Code System. It is also the field with the known copy-paste defects: 412 of 444 follow the pattern and the exceptions include names carried over from a different table. Because nothing reads it, those defects never reach the output — which is a reason the field is low-risk, not a reason it is worthless. |
| URI | 423 | Used, not carried | CodeSystem.url, or the system named in ValueSet.compose.include.system | Decides the single most important thing about a table: whether we own the code system or somebody else does. Where the URI is the table's own THO canonical it becomes CodeSystem.url and is carried; where it names an external system, no CodeSystem is written and the URI appears only inside the value set's compose. Page URLs ending .html are discarded and the OID used instead. |
| URL | 4 | Not used | — | A variant spelling of URI that nothing reads. Four tables (0821, 0823, 0955, 0958), eight rows between them, use URL as the key where every other table uses URI. The writer looks up URI only, so these are invisible to it. Two of the four tables are resolved anyway by their OID; two are blocked for other reasons. Worth fixing at source so the chapter uses one key, and worth reading both keys here in the meantime. |
| UTG Name | 1 | Not used | — | One table, 0083, carries an extra key naming the UTG resource (v2 Outlier Type). Nothing else in the corpus has it. Almost certainly an editing artefact rather than a field. |
| Comments | 1 | Not used | — | One table, 0719: replaces 2.16.840.1.113883.18.389. That is a substantive statement about supersession and it reaches nothing. A single instance, but the kind of information that is expensive to recover once lost. |

## Code System Version

_Feeds `nothing at present` · 426 tables_

This whole block is unread. The chapter states a version, an effective date and the HL7 release the code system was introduced in, and none of the three reaches any resource. Resource version and date are inherited from the existing UTG file instead, which is a deliberate choice — but it means the chapter's own version information is discarded rather than reconciled. This is the largest single block of unused information in the corpus.

| Field | Tables | Status | Where it goes | Notes |
|---|---|---|---|---|
| Version | 426 | Not used | — | The chapter's own version number for the code system. CodeSystem.version is taken from the existing UTG resource instead, and where UTG has none, from a default. The two are on different schemes — the chapter counts 1, 2, 3; THO uses semantic versions — so they cannot simply be substituted, but nobody has reconciled them either. |
| Effective Date | 416 | Not used | — | In DD.MM.YYYY form. CodeSystem.date comes from UTG, where 414 of 416 resources carry the same 2019-12-01 — the date of a bulk load, not a date anyone chose. The chapter has the better information here and it is the one being thrown away. |
| HL7 Version Introduced | 422 | Not used | — | ADR-0008 D18 already ruled on this one: it is provenance about the concept and belongs in a property, never in CodeSystem.version. The ruling has not been implemented, so the information is currently dropped. This is the clearest actionable gap in the document — the decision exists, only the property does not. |

## Value Set Identification Information

_Feeds `ValueSet/v2-NNNN` · 438 tables_

The identity of the value set, and the rule for what it contains. Most of this block is carried. The exception matters: the canonical URL the chapter prints is not read, and the writer constructs one from the table number instead. For 412 of 429 tables those are the same string, which is why it went unnoticed.

| Field | Tables | Status | Where it goes | Notes |
|---|---|---|---|---|
| Value Set OID | 438 | Carried | ValueSet.identifier[0].value as urn:oid:… | Carried unchanged, on the same rule as the code system OID. |
| SymbolicName | 437 | Transformed | ValueSet.name (PascalCase), ValueSet.title (verbatim) | Same two-element treatment as the code system's. |
| Description | 438 | Carried | ValueSet.description | Carried verbatim — including for the 16 tables whose description is truncated mid-word at the source. This is the one published defect that reaches the generated resources. THO carries the same truncation on 15 of the 16, so it is not something this project introduced. Listed in full in the escalation register. |
| Full Name | 432 | Not used | — | The Value Set counterpart of the Code System Full Name, on 432 tables, and read by nothing for the same reason: title already holds SymbolicName. |
| URI | 429 | Not used | — | Read by nothing, and it should be. The writer constructs ValueSet.url from the table number as …/ValueSet/v2-NNNN. For 412 of 429 tables that is character-for-character what the chapter prints, which is why this was invisible until the mapping was written out. For 17 tables it is not, and for four of those the chapter, THO and UTG all agree on a canonical we are not using. See the findings section. |
| Content Logical Definition | 438 | Used, not carried | the shape of ValueSet.compose | all codes composes the whole code system; enumerated per table content lists the table's rows; an Include … where concept is-a X clause becomes a filter. The rule survives in the compose, but the sentence the chapter wrote does not, and anything the writer cannot parse sends the table to the blocked list rather than being recorded. |
| THO URL | 3 | Not used | — | Three tables (0821, 0822, 0823) carry an hl7.org/permalink address under this key. A permalink is not a canonical and could not be used as one, but it does point at the intended value set, which is more than those three tables otherwise give us — all three are currently blocked. |
| Comments | 1 | Not used | — | Two tables. 0719's says replaces 2.16.840.1.113883.21.406 — supersession again, and again dropped. 0821's is empty. |
| UTG Name | 1 | Not used | — | Table 0083 only, as with the code system block. |
| UTG Title | 1 | Not used | — | Table 0083 only. |

## Binding Information

_Feeds `nothing at present` · 439 tables_

One field, on 439 tables, and nothing reads it. ADR-0008 lists “whether Binding Information (realm) is represented at all” as an open Batch C question; this is that question with a count attached.

| Field | Tables | Status | Where it goes | Notes |
|---|---|---|---|---|
| Realm | 439 | Not used | — | On 439 tables, almost all of them representative. FHIR has ValueSet.jurisdiction, which is the obvious candidate, but “representative” is not a jurisdiction — it is a statement about the status of the binding, closer to an HL7 realm concept than to a country code. Recorded as an open Batch C question in ADR-0008 and still open. |

## Table metadata

_Feeds `resource id, work group` · 799 tables_

The chapter's own description of the table as a table, rather than of the terminology it carries. Two fields are read. The rest — including the table's own description, its type, and every field it is used in — are not.

| Field | Tables | Status | Where it goes | Notes |
|---|---|---|---|---|
| Table | 799 | Carried | CodeSystem.id / ValueSet.id as v2-NNNN, and the canonical URL | The table number is the spine of the whole output: resource id, file name and canonical URL all derive from it. |
| Table OID | 798 | Used, not carried | resolves an external code system where the chapter names none | Table 0227 is the whole of this case: no code system block, but the table's own OID is registered in THO as a NamingSystem for MVX. The OID itself is not written to the resource — the identifier on the output comes from the Code System OID or Value Set OID, not from this one. |
| SymbolicName | 593 | Not used | — | The table's own symbolic name, distinct from the code system's and the value set's. Populated on 593 tables and read by nothing. |
| Description | 799 | Not used | — | A description of the table, on all 799 tables, going nowhere. It is not a duplicate of the code system or value set description — it describes the table as a whole, and it is present on the 355 tables that have no code system block at all and therefore no other description of any kind. For a concept-domain-only table this is the only prose the chapter offers beyond the domain definition. |
| Type | 799 | Not used | — | User, HL7 and the other table types. This is a real classification with consequences — a User table is site-extensible and an HL7 table is not — and it is the kind of thing an implementer needs. FHIR has no standard place for it, so it would need a concept property or an extension. |
| Steward | 581 | Transformed | structuredefinition-wg extension | Mapped through a lookup from the chapter's initials to HL7 work group codes. Two lossy points: a steward naming two groups (InM/PA) is attributed to the first, and an unrecognised steward produces no extension at all rather than a wrong one. Where UTG already records a work group, UTG's wins. |
| where used | 779 | Not used | — | The message fields the table is bound to — PID-8 and so on — on 779 tables. This is the link between the vocabulary and the rest of the standard, and it is the single richest piece of information in the chapter that reaches nothing. It arguably belongs on the binding rather than on the value set, which is why it has no natural home in a terminology-only IG. Worth deciding deliberately rather than by omission. |
| HL7 Version Introduced | 607 | Not used | — | The release the table was introduced in, on 607 tables. A different fact from the code system version block's field of the same name, and dropped for the same reason: no property has been defined for it. D18 covers both. |
| Full Name | 3 | Not used | — | Three tables carry it at table level as well. |
| URI | 2 | Not used | — | Two tables. |
| Version Info | 1 | Not used | — | One table. |
| Code System OID | 1 | Not used | — | One table carries a Code System OID in its table metadata block rather than in its code system block. An editing slip, but it means one table's code system OID is invisible to the writer. |

## Coded content (the rows)

_Feeds `CodeSystem.concept` · 415 tables_

The codes themselves. This is the part of the chapter the whole exercise exists to carry, and all five columns reach the output. Counts here are rows rather than tables: 5,540 concepts across the corpus.

| Field | Rows | Status | Where it goes | Notes |
|---|---|---|---|---|
| value | 5540 | Carried | concept.code | Also compose.include.concept.code where the value set enumerates rather than including the whole system. |
| displayName | 5407 | Carried | concept.display | And compose.include.concept.display in an enumerated value set. |
| definition | 371 | Carried | concept.definition | Omitted where the chapter gives none, which is most concepts. It is deliberately not back-filled from display, although UTG does that; the publisher warns CODESYSTEM_CONCEPT_NO_DEFINITION corpus-wide and the warning is accepted. |
| comment | 1783 | Carried | concept.property[v2-concComment].valueString | UTG's own property for this, reused rather than invented. The property is declared on the CodeSystem only where some concept in it actually uses one. |
| status | 300 | Transformed | concept.property[status].valueCode | Blank becomes active, D becomes deprecated, R becomes retired. N and B have no FHIR equivalent and are passed through as themselves, which is what UTG does; they are not valid concept status codes, so a validator may object. |

## How the mapping changes with the output class

The mapping above assumes the ordinary case: a table that owns its code
system. Most tables do not. Which fields have a destination at all depends on
which of these classes a table falls into, and the counts are lopsided —
the largest class writes almost nothing.

| Class | Tables | What it means |
|---|---|---|
| Own code system | 398 | The table owns its code system and publishes codes. A CodeSystem and a ValueSet are written, and the mapping below applies in full. |
| External code system | 24 | The codes belong to somebody else — UCUM, SNOMED, ISO 3166, a v3 code system, or another v2 table. Only a ValueSet is written. Everything in the Code System Identification block except the OID therefore has no destination for these tables, even the fields marked Carried above, because there is no CodeSystem to carry them. |
| Concept domain only | 360 | The table declares a domain and no code system. Nothing is written but a concept in the shared conceptdomains CodeSystem, so only the Concept Domain block has any destination at all. |
| Nothing declared | 3 | The chapter declares the table and no terminology of any kind. |
| Blocked | 14 | Something about the table could not be settled mechanically, so nothing is written yet and no field has a destination. |

The external code system class is the one the original question
pointed at. For those 24 tables Chapter 2C still publishes a complete Code
System Identification block — OID, symbolic name, description, full name
— describing a code system somebody else owns. We write no CodeSystem for
them, correctly, so none of that block is carried, not just the Full
Name.

The natural FHIR home for “here is what we know about a code system we
do not own” is a NamingSystem, and THO already publishes
those — that is how tables like 0227 were resolved in the first place.
This project reads THO's NamingSystems and writes none of its own. So
where Chapter 2C's description of an external code system differs from THO's,
or adds something THO lacks, that difference is currently invisible. Whether it
should be reconciled, and whether any NamingSystem should be authored here, is
an open question this document does not answer.

## The concept-domain-only tables

360 tables declare a concept domain and no code system, and 3 declare
nothing at all. The mapping treats them almost entirely as a lost cause,
because every block except Concept Domain is written for a table that has
terminology. In practice the loss is much smaller than that suggests.

| Of those tables… | Count |
|---|---|
| tables | 363 |
| with a Code System block | 2 |
| with a Value Set block | 2 |
| with a Code System Version block | 0 |
| with a Binding block | 3 |
| with codes | 4 |
| coded rows | 11 |

So the picture for concept-domain-only tables is not that 360 tables
lose six blocks of content each. Nearly all of them carry the Concept Domain
block and the table metadata block and nothing else, and the Concept Domain
block is carried in full. What they lose is what every table loses: the table
metadata. That matters more here than elsewhere, because for these tables the
table-level Description is the only prose the chapter offers apart from
the domain definition itself, and it reaches nothing.

The handful of exceptions are already known and already escalated. The two
carrying a Code System block are 0560 and 0910, whose block is the
noObject placeholder. The four carrying codes are the tables that
publish example codes for a domain — conforming behaviour under the V3
requirements, and the subject of an open register item about where those
examples should live.

## Found while writing this down

Writing the mapping out surfaced something the pipeline had not reported,
which is the usual argument for doing this kind of exercise. It concerns the
Value Set URI field.

The writer never reads it. ValueSet.url is constructed from the
table number as …/ValueSet/v2-NNNN. For 412 of the 429
tables that print a URI, the constructed string and the printed string are
identical, which is why nobody noticed.

| Table | Name | Chapter prints | Published? | We generate | Published? | Status |
|---|---|---|---|---|---|---|
| 0291 | Subtype of Referenced Data | http://terminology.hl7.org/ValueSet/v2-notAllCodes-0291 | yes | http://terminology.hl7.org/ValueSet/v2-0291 | no | code-system-and-value-set |
| 0347 | State/Province | http://terminology.hl7.org/ValueSet-v2-notAllCodes-0347.html | no | http://terminology.hl7.org/ValueSet/v2-0347 | no | value-set-only |
| 0399 | Country Code | http://terminology.hl7.org/ValueSet/v2-notAllCodes-0399 | yes | http://terminology.hl7.org/ValueSet/v2-0399 | no | needs-decision |
| 0567 | Weight Units | http://terminology.hl7.org/ValueSet/v2-0929 | yes | http://terminology.hl7.org/ValueSet/v2-0567 | yes | value-set-only |
| 0568 | Volume Units | http://terminology.hl7.org/ValueSet/v2-0930 | yes | http://terminology.hl7.org/ValueSet/v2-0568 | yes | value-set-only |
| 0719 | Access Restriction Reason Code | http://terminology.hl7.org/ValueSet-v3-ActInformationSensitivityPolicy.html | no | http://terminology.hl7.org/ValueSet/v2-0719 | yes | value-set-only |
| 0824 | Recorded Sex or Gender Type | www.hl7.org/permalink/?ValueSetRecordedSexOrGenderType | no | http://terminology.hl7.org/ValueSet/v2-0824 | no | needs-decision |
| 0827 | Source Document Jurisdiction for Recorded Sex or  Gender | http://hl7.org/fhir/ValueSet/jurisdiction | no | http://terminology.hl7.org/ValueSet/v2-0827 | no | needs-decision |
| 0828 | Sex Parameter for Clinical Use | https://terminology.hl7.org/ValueSet-sex-parameter-for-clinical-use.html | no | http://terminology.hl7.org/ValueSet/v2-0828 | no | needs-decision |
| 0834 | MIME Types | http://terminology.hl7.org/ValueSet/v2-notAllCodes-0834 | yes | http://terminology.hl7.org/ValueSet/v2-0834 | no | code-system-and-value-set |
| 0953 | Security Label Handling Instructions | http://terminology.hl7.org/ValueSet-v3-SecurityControlObservationValue.html | no | http://terminology.hl7.org/ValueSet/v2-0953 | no | needs-decision |
| 0954 | Work Schedule ODH | http://terminology.hl7.org/ValueSet-v3-WorkScheduleODH.html | no | http://terminology.hl7.org/ValueSet/v2-0954 | no | value-set-only |
| 0955 | Industry | https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.7187 | no | http://terminology.hl7.org/ValueSet/v2-0955 | no | value-set-only |
| 0957 | Employment Status (ODH) | http://terminology.hl7.org/ValueSet-v3-employmentStatusODH.html | no | http://terminology.hl7.org/ValueSet/v2-0957 | no | value-set-only |
| 0958 | Occupation | https://phinvads.cdc.gov/vads/ViewValueSet.action?id=1445D71C-F37F-4504-8B6C-BA48C5A3F4CA | no | http://terminology.hl7.org/ValueSet/v2-0958 | no | value-set-only |
| 0960 | Data Absent Reason | http://hl7.org/fhir/ValueSet/data-absent-reason | no | http://terminology.hl7.org/ValueSet/v2-0960 | no | value-set-only |
| 0963 | Device Safety | http://hl7.org/fhir/ValueSet/device-safety | no | http://terminology.hl7.org/ValueSet/v2-0963 | no | needs-decision |

Most of the seventeen are already-known defect classes appearing in a field
nobody had checked — links to rendered pages where a canonical belongs,
hl7.org/permalink addresses, and references to genuinely external
value sets at FHIR or PHIN VADS canonicals. Those tables are mostly blocked
already for other reasons.


Four of them are a real divergence, and they point the same way.
Tables 0291, 0347, 0399 and 0834 print a canonical of the form
…/ValueSet/v2-notAllCodes-NNNN — THO's convention for
a value set that enumerates a subset of its code system rather than including
all of it. THO and UTG both publish exactly that canonical, and neither
publishes the v2-NNNN form we generate. So for these four,
the chapter, THO and UTG agree with each other and this project agrees with
none of them: it mints a fifth canonical that has never existed.

There is a second-order effect worth knowing about. The writer inherits
version and date from the existing UTG file by matching on the table number in
the file name, and UTG's files for three of these are named
vs-v2-notAllCodes-NNNN.xml. The match fails, so those three
inherit nothing and fall back to the default version — which means three
of the “16 resources UTG does not have” are resources UTG has all
along, under a name the parser did not recognise. Table 0347 is currently
emitted at version 1.0.0 where UTG publishes 2.0.0.


A separate pair, 0567 and 0568, print another table's value set
canonical — v2-0929 and v2-0930 respectively.
Both the printed and the generated canonical exist in THO, so this is not a
dangling reference; it is the value-set counterpart of the pattern ADR-0008 D11
found for code systems, where one table borrows another's terminology. It needs
the same treatment and has not had it.

None of this has been changed. Honouring the printed URI is not a
blanket rule — a page URL and a permalink are not canonicals, and
adopting them would be worse than ignoring them. It needs the same
classify-then-resolve treatment the Code System URI already has, and that is a
decision rather than a fix.

## Completeness check

The mapping is authored by hand and the corpus is regenerated by machine, so
they can drift. This check compares them on every run: any field that appears
in an extracted table and not in the mapping is reported here, and so is any
field in the mapping that no longer appears in the corpus.

Every field in the corpus is accounted for.

_Generated 2026-08-25 by `tooling/scripts/render_field_mapping.py` from `tooling/scripts/field_mapping_spec.py`. Edit the spec module, not this file._
