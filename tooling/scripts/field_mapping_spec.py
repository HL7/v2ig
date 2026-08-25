#!/usr/bin/env python3
"""What every Chapter 2C table field maps to in the generated FHIR resources.

This is the authored half of the field-mapping document. It says, for each
field Chapter 2C publishes about a code table, where that information ends up
-- or that it ends up nowhere. `render_field_mapping.py` joins it to the corpus
to produce the document itself.

The mapping is authored rather than derived because "where should this field
go" is an editorial judgement, and because a derived mapping could only ever
report what the code happens to do today. The value of writing it down is
precisely that it can disagree with the code: a field recorded here as
`NOT_USED` is a question waiting for an answer, not a description of correct
behaviour.

The four statuses, and what each one means for a reader deciding whether
information is being lost:

  CARRIED      The value reaches a FHIR element and can be read back out. No
               information is lost.

  TRANSFORMED  The value reaches the output in a changed form -- recoded,
               reformatted, or merged with something else. Usually fine, but
               the transformation is worth knowing about because it is not
               always reversible.

  USED         The value is read, and it changes what gets generated, but the
               value itself does not appear anywhere in the output. If Chapter
               2C were regenerated from our resources, this information would
               be gone.

  NOT_USED     Nothing reads the field. The information exists in the chapter
               and does not exist in the resources.

`USED` and `NOT_USED` together are the loss list, and the point of the
document is to let somebody decide, field by field, whether that loss matters.
"""

CARRIED = "carried"
TRANSFORMED = "transformed"
USED = "used"
NOT_USED = "not-used"

STATUS_LABEL = {
    CARRIED: "Carried",
    TRANSFORMED: "Transformed",
    USED: "Used, not carried",
    NOT_USED: "Not used",
}

STATUS_BLURB = {
    CARRIED: "Reaches a FHIR element unchanged, and can be read back out.",
    TRANSFORMED: "Reaches the output in a changed form. Not always reversible.",
    USED: "Read, and it changes what is generated, but the value itself does "
          "not appear in any resource.",
    NOT_USED: "Nothing reads it. The information is in the chapter and not in "
              "the resources.",
}

# Ordered worst-first, because the reader of this document is looking for what
# is missing rather than for what works.
STATUS_ORDER = [NOT_USED, USED, TRANSFORMED, CARRIED]


# --------------------------------------------------------------------------
# The blocks Chapter 2C publishes about a table
# --------------------------------------------------------------------------
#
# Each block in the chapter is a small key/value grid under the table's
# heading. `key` is the key in the extracted JSON; `feeds` names the resource
# the block is supposed to produce, which is what makes "not used" meaningful
# -- a Code System field that reaches no CodeSystem is a different kind of gap
# from one that has no obvious home anywhere.

BLOCKS = [
    {
        "key": "conceptDomain",
        "title": "Concept Domain",
        "feeds": "CodeSystem/conceptdomains",
        "intro":
            "Every table declares a concept domain, whether or not it also has "
            "a code system. The domain is the abstract idea the table is about; "
            "the code system is one way of expressing it. These fields feed the "
            "single shared <code>conceptdomains</code> CodeSystem, which this "
            "project extends rather than replaces (ADR-0008 D1).",
    },
    {
        "key": "codeSystems",
        "title": "Code System Identification Information",
        "feeds": "CodeSystem/v2-NNNN",
        "intro":
            "The identity of the code system the table's codes belong to. "
            "Where the table owns that code system, these fields become a "
            "CodeSystem resource. Where the code system belongs to somebody "
            "else &mdash; UCUM, SNOMED, a v3 code system, another v2 table "
            "&mdash; no CodeSystem is written at all, and everything in this "
            "block except the identifier has nowhere to go. That second case "
            "is set out separately below.",
    },
    {
        "key": "codeSystemVersions",
        "title": "Code System Version",
        "feeds": "nothing at present",
        "intro":
            "<b>This whole block is unread.</b> The chapter states a version, "
            "an effective date and the HL7 release the code system was "
            "introduced in, and none of the three reaches any resource. "
            "Resource <code>version</code> and <code>date</code> are inherited "
            "from the existing UTG file instead, which is a deliberate choice "
            "&mdash; but it means the chapter's own version information is "
            "discarded rather than reconciled. This is the largest single "
            "block of unused information in the corpus.",
    },
    {
        "key": "valueSets",
        "title": "Value Set Identification Information",
        "feeds": "ValueSet/v2-NNNN",
        "intro":
            "The identity of the value set, and the rule for what it contains. "
            "Most of this block is carried. The exception matters: the "
            "canonical URL the chapter prints is not read, and the writer "
            "constructs one from the table number instead. For 412 of 429 "
            "tables those are the same string, which is why it went unnoticed.",
    },
    {
        "key": "bindings",
        "title": "Binding Information",
        "feeds": "nothing at present",
        "intro":
            "One field, on 439 tables, and nothing reads it. ADR-0008 lists "
            "&ldquo;whether Binding Information (realm) is represented at "
            "all&rdquo; as an open Batch C question; this is that question with "
            "a count attached.",
    },
    {
        "key": "tableMetadata",
        "title": "Table metadata",
        "feeds": "resource id, work group",
        "intro":
            "The chapter's own description of the table as a table, rather than "
            "of the terminology it carries. Two fields are read. The rest "
            "&mdash; including the table's own description, its type, and every "
            "field it is used in &mdash; are not.",
    },
    {
        "key": "codedContent",
        "title": "Coded content (the rows)",
        "feeds": "CodeSystem.concept",
        "intro":
            "The codes themselves. This is the part of the chapter the whole "
            "exercise exists to carry, and all five columns reach the output. "
            "Counts here are rows rather than tables: 5,540 concepts across the "
            "corpus.",
    },
]


# --------------------------------------------------------------------------
# The mapping
# --------------------------------------------------------------------------
#
# One entry per field. `block` and `field` must match the extracted JSON
# exactly -- the renderer checks that every field in the corpus appears here,
# and reports any that do not, so this list cannot quietly fall behind the
# extraction.

FIELDS = [
    # ---- Concept Domain ----
    {
        "block": "conceptDomain",
        "field": "Concept Domain Name",
        "status": NOT_USED,
        "target": "",
        "note":
            "Not a name but a sequence label &mdash; the values are "
            "<code>DOM: 1</code>, <code>DOM: 2</code> and so on. The usable "
            "name is <code>SymbolicName</code>. Nothing is lost by dropping it "
            "unless the numbering means something to somebody.",
    },
    {
        "block": "conceptDomain",
        "field": "SymbolicName",
        "status": CARRIED,
        "target": "conceptdomains: <code>concept.code</code>, "
                  "<code>concept.display</code>",
        "note":
            "Used verbatim as the concept code, including where it contains "
            "characters unusual in a code. Fidelity wins and the irregular ones "
            "are reported rather than normalized.",
    },
    {
        "block": "conceptDomain",
        "field": "Description",
        "status": TRANSFORMED,
        "target": "conceptdomains: <code>concept.definition</code>",
        "note":
            "Carried only where THO does not already publish the domain. Where "
            "it does, <b>THO's definition is kept and the chapter's is "
            "discarded</b> (ADR-0008 D1). That affects 5 domains where the two "
            "genuinely differ; for 577 others the two texts are identical, so "
            "nothing turns on it. Where one domain is declared by several "
            "tables with different wordings, the first in document order wins.",
    },
    {
        "block": "conceptDomain",
        "field": "Concept Domain Only",
        "status": USED,
        "target": "decides whether any CodeSystem or ValueSet is written",
        "note":
            "The single most consequential field in the corpus: <code>yes</code> "
            "on 360 tables, and every one of those produces no CodeSystem and "
            "no ValueSet. The flag itself is not recorded anywhere in the "
            "output, so nothing in the published resources says why a table has "
            "no terminology.",
    },

    # ---- Code System Identification Information ----
    {
        "block": "codeSystems",
        "field": "Code System OID",
        "status": CARRIED,
        "target": "<code>CodeSystem.identifier[0].value</code> as "
                  "<code>urn:oid:&hellip;</code>",
        "note":
            "Also the fallback identifier when the chapter prints no usable "
            "canonical URL, which resolved seven tables by itself. Omitted from "
            "the resource where the value is blank or a bare hyphen.",
    },
    {
        "block": "codeSystems",
        "field": "SymbolicName",
        "status": TRANSFORMED,
        "target": "<code>CodeSystem.name</code> (PascalCase), "
                  "<code>CodeSystem.title</code> (verbatim)",
        "note":
            "One source field feeding two elements, which is how UTG does it. "
            "<code>name</code> is a computed form and <code>title</code> the "
            "original, so nothing is lost. The same field doubles as the "
            "<code>noObject</code> placeholder marker that identifies a table "
            "with no real code system.",
    },
    {
        "block": "codeSystems",
        "field": "Description",
        "status": CARRIED,
        "target": "<code>CodeSystem.description</code>",
        "note":
            "Carried in full. Unlike the Value Set descriptions, these are not "
            "truncated &mdash; they run past 500 characters and end cleanly, "
            "which is the evidence that the truncation is a cap on one field "
            "rather than a general limit.",
    },
    {
        "block": "codeSystems",
        "field": "Full Name",
        "status": NOT_USED,
        "target": "",
        "note":
            "<b>The field this document was commissioned over.</b> Carries a "
            "value on 437 of the 444 tables that declare a code system, and is "
            "read by nothing. "
            "There is no obvious FHIR home: <code>title</code> is already taken "
            "by <code>SymbolicName</code>, and the two are not the same string "
            "&mdash; Full Name is a human-readable label of the form "
            "<i>&lt;Table Name&gt; Code System</i>. It is also the field with "
            "the known copy-paste defects: 412 of 444 follow the pattern and "
            "the exceptions include names carried over from a different table. "
            "Because nothing reads it, <b>those defects never reach the "
            "output</b> &mdash; which is a reason the field is low-risk, not a "
            "reason it is worthless.",
    },
    {
        "block": "codeSystems",
        "field": "URI",
        "status": USED,
        "target": "<code>CodeSystem.url</code>, or the system named in "
                  "<code>ValueSet.compose.include.system</code>",
        "note":
            "Decides the single most important thing about a table: whether we "
            "own the code system or somebody else does. Where the URI is the "
            "table's own THO canonical it becomes <code>CodeSystem.url</code> "
            "and is carried; where it names an external system, no CodeSystem "
            "is written and the URI appears only inside the value set's "
            "compose. Page URLs ending <code>.html</code> are discarded and the "
            "OID used instead.",
    },
    {
        "block": "codeSystems",
        "field": "URL",
        "status": NOT_USED,
        "target": "",
        "note":
            "<b>A variant spelling of <code>URI</code> that nothing reads.</b> "
            "Four tables (0821, 0823, 0955, 0958), eight rows between them, use "
            "<code>URL</code> as the key where every other table uses "
            "<code>URI</code>. The writer looks up <code>URI</code> only, so "
            "these are invisible to it. Two of the four tables are resolved "
            "anyway by their OID; two are blocked for other reasons. Worth "
            "fixing at source so the chapter uses one key, and worth reading "
            "both keys here in the meantime.",
    },
    {
        "block": "codeSystems",
        "field": "UTG Name",
        "status": NOT_USED,
        "target": "",
        "note":
            "One table, 0083, carries an extra key naming the UTG resource "
            "(<code>v2 Outlier Type</code>). Nothing else in the corpus has it. "
            "Almost certainly an editing artefact rather than a field.",
    },
    {
        "block": "codeSystems",
        "field": "Comments",
        "status": NOT_USED,
        "target": "",
        "note":
            "One table, 0719: <i>replaces 2.16.840.1.113883.18.389</i>. That is "
            "a substantive statement about supersession and it reaches nothing. "
            "A single instance, but the kind of information that is expensive "
            "to recover once lost.",
    },

    # ---- Code System Version ----
    {
        "block": "codeSystemVersions",
        "field": "Version",
        "status": NOT_USED,
        "target": "",
        "note":
            "The chapter's own version number for the code system. "
            "<code>CodeSystem.version</code> is taken from the existing UTG "
            "resource instead, and where UTG has none, from a default. The two "
            "are on different schemes &mdash; the chapter counts <code>1</code>, "
            "<code>2</code>, <code>3</code>; THO uses semantic versions &mdash; "
            "so they cannot simply be substituted, but nobody has reconciled "
            "them either.",
    },
    {
        "block": "codeSystemVersions",
        "field": "Effective Date",
        "status": NOT_USED,
        "target": "",
        "note":
            "In <code>DD.MM.YYYY</code> form. <code>CodeSystem.date</code> "
            "comes from UTG, where 414 of 416 resources carry the same "
            "<code>2019-12-01</code> &mdash; the date of a bulk load, not a "
            "date anyone chose. <b>The chapter has the better information here "
            "and it is the one being thrown away.</b>",
    },
    {
        "block": "codeSystemVersions",
        "field": "HL7 Version Introduced",
        "status": NOT_USED,
        "target": "",
        "note":
            "ADR-0008 D18 already ruled on this one: it is provenance about the "
            "concept and <b>belongs in a property</b>, never in "
            "<code>CodeSystem.version</code>. The ruling has not been "
            "implemented, so the information is currently dropped. This is the "
            "clearest actionable gap in the document &mdash; the decision "
            "exists, only the property does not.",
    },

    # ---- Value Set Identification Information ----
    {
        "block": "valueSets",
        "field": "Value Set OID",
        "status": CARRIED,
        "target": "<code>ValueSet.identifier[0].value</code> as "
                  "<code>urn:oid:&hellip;</code>",
        "note": "Carried unchanged, on the same rule as the code system OID.",
    },
    {
        "block": "valueSets",
        "field": "SymbolicName",
        "status": TRANSFORMED,
        "target": "<code>ValueSet.name</code> (PascalCase), "
                  "<code>ValueSet.title</code> (verbatim)",
        "note": "Same two-element treatment as the code system's.",
    },
    {
        "block": "valueSets",
        "field": "Description",
        "status": CARRIED,
        "target": "<code>ValueSet.description</code>",
        "note":
            "Carried verbatim &mdash; including for the <b>16 tables whose "
            "description is truncated mid-word at the source</b>. This is the "
            "one published defect that reaches the generated resources. THO "
            "carries the same truncation on 15 of the 16, so it is not "
            "something this project introduced. Listed in full in the "
            "escalation register.",
    },
    {
        "block": "valueSets",
        "field": "Full Name",
        "status": NOT_USED,
        "target": "",
        "note":
            "The Value Set counterpart of the Code System Full Name, on 432 "
            "tables, and read by nothing for the same reason: "
            "<code>title</code> already holds <code>SymbolicName</code>.",
    },
    {
        "block": "valueSets",
        "field": "URI",
        "status": NOT_USED,
        "target": "",
        "note":
            "<b>Read by nothing, and that is now deliberate.</b> "
            "<code>ValueSet.url</code> is taken from THO, which already "
            "publishes a canonical for 440 of these tables, and constructed as "
            "<code>&hellip;/ValueSet/v2-NNNN</code> only where THO publishes "
            "none. A canonical is an identifier: the existing one is the "
            "answer, and the chapter's copy of it adds nothing and can be "
            "wrong. It is wrong for 14 tables &mdash; page links, permalinks "
            "and references to external value sets. "
            "The field was <i>also</i> unread before, when the canonical was "
            "always constructed, and that version of &ldquo;unread&rdquo; was a "
            "defect: it put four tables at canonicals nobody publishes. See "
            "the findings section.",
    },
    {
        "block": "valueSets",
        "field": "Content Logical Definition",
        "status": USED,
        "target": "the shape of <code>ValueSet.compose</code>",
        "note":
            "<code>all codes</code> composes the whole code system; "
            "<code>enumerated per table content</code> lists the table's rows; "
            "an <i>Include &hellip; where concept is-a X</i> clause becomes a "
            "filter. The <i>rule</i> survives in the compose, but the sentence "
            "the chapter wrote does not, and anything the writer cannot parse "
            "sends the table to the blocked list rather than being recorded.",
    },
    {
        "block": "valueSets",
        "field": "THO URL",
        "status": NOT_USED,
        "target": "",
        "note":
            "Three tables (0821, 0822, 0823) carry an "
            "<code>hl7.org/permalink</code> address under this key. A permalink "
            "is not a canonical and could not be used as one, but it does point "
            "at the intended value set, which is more than those three tables "
            "otherwise give us &mdash; all three are currently blocked.",
    },
    {
        "block": "valueSets",
        "field": "Comments",
        "status": NOT_USED,
        "target": "",
        "note":
            "Two tables. 0719's says <i>replaces "
            "2.16.840.1.113883.21.406</i> &mdash; supersession again, and "
            "again dropped. 0821's is empty.",
    },
    {
        "block": "valueSets",
        "field": "UTG Name",
        "status": NOT_USED,
        "target": "",
        "note": "Table 0083 only, as with the code system block.",
    },
    {
        "block": "valueSets",
        "field": "UTG Title",
        "status": NOT_USED,
        "target": "",
        "note": "Table 0083 only.",
    },

    # ---- Binding Information ----
    {
        "block": "bindings",
        "field": "Realm",
        "status": NOT_USED,
        "target": "",
        "note":
            "On 439 tables, almost all of them <code>representative</code>. "
            "FHIR has <code>ValueSet.jurisdiction</code>, which is the obvious "
            "candidate, but &ldquo;representative&rdquo; is not a jurisdiction "
            "&mdash; it is a statement about the <i>status</i> of the binding, "
            "closer to an HL7 realm concept than to a country code. Recorded as "
            "an open Batch C question in ADR-0008 and still open.",
    },

    # ---- Table metadata ----
    {
        "block": "tableMetadata",
        "field": "Table",
        "status": CARRIED,
        "target": "<code>CodeSystem.id</code> / <code>ValueSet.id</code> as "
                  "<code>v2-NNNN</code>, and the canonical URL",
        "note":
            "The table number is the spine of the whole output: resource id, "
            "file name and canonical URL all derive from it.",
    },
    {
        "block": "tableMetadata",
        "field": "Table OID",
        "status": USED,
        "target": "resolves an external code system where the chapter names "
                  "none",
        "note":
            "Table 0227 is the whole of this case: no code system block, but "
            "the table's own OID is registered in THO as a NamingSystem for "
            "MVX. The OID itself is not written to the resource &mdash; the "
            "identifier on the output comes from the Code System OID or Value "
            "Set OID, not from this one.",
    },
    {
        "block": "tableMetadata",
        "field": "SymbolicName",
        "status": NOT_USED,
        "target": "",
        "note":
            "The table's own symbolic name, distinct from the code system's and "
            "the value set's. Populated on 593 tables and read by nothing.",
    },
    {
        "block": "tableMetadata",
        "field": "Description",
        "status": NOT_USED,
        "target": "",
        "note":
            "<b>A description of the table, on all 799 tables, going nowhere.</b> "
            "It is not a duplicate of the code system or value set description "
            "&mdash; it describes the table as a whole, and it is present on the "
            "355 tables that have no code system block at all and therefore no "
            "other description of any kind. For a concept-domain-only table "
            "this is the only prose the chapter offers beyond the domain "
            "definition.",
    },
    {
        "block": "tableMetadata",
        "field": "Type",
        "status": NOT_USED,
        "target": "",
        "note":
            "<code>User</code>, <code>HL7</code> and the other table types. "
            "This is a real classification with consequences &mdash; a User "
            "table is site-extensible and an HL7 table is not &mdash; and it is "
            "the kind of thing an implementer needs. FHIR has no standard place "
            "for it, so it would need a concept property or an extension.",
    },
    {
        "block": "tableMetadata",
        "field": "Steward",
        "status": TRANSFORMED,
        "target": "<code>structuredefinition-wg</code> extension",
        "note":
            "Mapped through a lookup from the chapter's initials to HL7 work "
            "group codes. Two lossy points: a steward naming two groups "
            "(<code>InM/PA</code>) is attributed to the first, and an "
            "unrecognised steward produces no extension at all rather than a "
            "wrong one. Where UTG already records a work group, UTG's wins.",
    },
    {
        "block": "tableMetadata",
        "field": "where used",
        "status": NOT_USED,
        "target": "",
        "note":
            "The message fields the table is bound to &mdash; <code>PID-8</code> "
            "and so on &mdash; on 779 tables. This is the link between the "
            "vocabulary and the rest of the standard, and it is the single "
            "richest piece of information in the chapter that reaches nothing. "
            "It arguably belongs on the <i>binding</i> rather than on the value "
            "set, which is why it has no natural home in a terminology-only IG. "
            "Worth deciding deliberately rather than by omission.",
    },
    {
        "block": "tableMetadata",
        "field": "HL7 Version Introduced",
        "status": NOT_USED,
        "target": "",
        "note":
            "The release the <i>table</i> was introduced in, on 607 tables. A "
            "different fact from the code system version block's field of the "
            "same name, and dropped for the same reason: no property has been "
            "defined for it. D18 covers both.",
    },
    {
        "block": "tableMetadata",
        "field": "Full Name",
        "status": NOT_USED,
        "target": "",
        "note": "Three tables carry it at table level as well.",
    },
    {
        "block": "tableMetadata",
        "field": "URI",
        "status": NOT_USED,
        "target": "",
        "note": "Two tables.",
    },
    {
        "block": "tableMetadata",
        "field": "Version Info",
        "status": NOT_USED,
        "target": "",
        "note": "One table.",
    },
    {
        "block": "tableMetadata",
        "field": "Code System OID",
        "status": NOT_USED,
        "target": "",
        "note":
            "One table carries a Code System OID in its table metadata block "
            "rather than in its code system block. An editing slip, but it "
            "means one table's code system OID is invisible to the writer.",
    },

    # ---- Coded content ----
    {
        "block": "codedContent",
        "field": "value",
        "status": CARRIED,
        "target": "<code>concept.code</code>",
        "note":
            "Also <code>compose.include.concept.code</code> where the value set "
            "enumerates rather than including the whole system.",
    },
    {
        "block": "codedContent",
        "field": "displayName",
        "status": CARRIED,
        "target": "<code>concept.display</code>",
        "note":
            "And <code>compose.include.concept.display</code> in an enumerated "
            "value set.",
    },
    {
        "block": "codedContent",
        "field": "definition",
        "status": CARRIED,
        "target": "<code>concept.definition</code>",
        "note":
            "Omitted where the chapter gives none, which is most concepts. "
            "<b>It is deliberately not back-filled from <code>display</code></b>, "
            "although UTG does that; the publisher warns "
            "<code>CODESYSTEM_CONCEPT_NO_DEFINITION</code> corpus-wide and the "
            "warning is accepted.",
    },
    {
        "block": "codedContent",
        "field": "comment",
        "status": CARRIED,
        "target": "<code>concept.property[v2-concComment].valueString</code>",
        "note":
            "UTG's own property for this, reused rather than invented. The "
            "property is declared on the CodeSystem only where some concept in "
            "it actually uses one.",
    },
    {
        "block": "codedContent",
        "field": "status",
        "status": TRANSFORMED,
        "target": "<code>concept.property[status].valueCode</code>",
        "note":
            "Blank becomes <code>active</code>, <code>D</code> becomes "
            "<code>deprecated</code>, <code>R</code> becomes "
            "<code>retired</code>. <code>N</code> and <code>B</code> have no "
            "FHIR equivalent and are <b>passed through as themselves</b>, which "
            "is what UTG does; they are not valid concept status codes, so a "
            "validator may object.",
    },
]


# Fields that exist in the extracted JSON for bookkeeping rather than because
# Chapter 2C publishes them. Excluded from the accounting, and named here so
# the completeness check does not report them as unmapped.
EXTRACTION_ONLY = {
    ("provenance", "sourceFile"),
    ("provenance", "headingText"),
    ("sourceIssues", "issue"),
    ("sourceIssues", "wordTableIndex"),
    ("sourceIssues", "rows"),
    ("sourceIssues", "columns"),
    ("sourceIssues", "detail"),
    ("sourceIssues", "conflictingKeys"),
}
