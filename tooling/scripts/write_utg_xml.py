#!/usr/bin/env python3
"""Write the Chapter 2C vocabulary out as UTG-style CodeSystem and ValueSet XML.

This is the writer the whole vocabulary workstream has been building towards.
Everything upstream of it -- extraction, the text policy, the pipeline
comparison, the escalation register -- exists to make the corpus in
`v291-extracted/vocabulary/` trustworthy. This turns that corpus into resources
shaped like the ones already in UTG's `input/sourceOfTruth/v2/`.

What it will and will not do
----------------------------

It emits a resource only when the chapter says clearly enough what the resource
should be. Everything else is written to a report with the reason, rather than
guessed at. That follows the rule the rest of this workstream runs on: nothing
is normalized quietly, and a table nobody has decided about is visible rather
than invented.

Errors in the published chapter are reproduced, not corrected, except where a
recorded ADR-0008 decision says otherwise. Reproducing is reversible; the
reproduce-vs-correct question is still with V2 Management, and correcting first
would prejudge it.

How a table is classified
-------------------------

  code-system-and-value-set
      The chapter's code system is this table's own THO canonical, and there
      are codes to put in it. The ordinary case -- most of the corpus.

  value-set-only
      The code system belongs to somebody else: UCUM, LOINC, SNOMED, ISO 3166,
      a v3 code system, or another v2 table. We must not author a CodeSystem at
      a canonical we do not own, so only the ValueSet is written and its
      `compose` names the real system. This is ADR-0008 D8 and D11 generalised.

      Two of these are worth knowing about because they look like defects and
      are not. Table 0962 resolves to `http://hl7.org/fhir/device-status`,
      which is a FHIR canonical rather than a THO one -- a known outlier that
      TSMG has already discussed, not something to raise again. Table 0227
      (MVX) resolves through `NamingSystem/MVX` to
      `http://hl7.org/fhir/sid/mvx`; THO deliberately has no CodeSystem for
      MVX and should not have one, so a ValueSet over the external system is
      the correct and complete output.

  concept-domain-only
      The table declares a domain and no code system. Concept domains do not
      need a ValueSet -- a binding to a domain is expressed with an extension
      on the binding rather than a bound value set -- so nothing is written.
      Also covers the two tables whose code system is the `noObject`
      placeholder (D11: 0560 and 0910).

  nothing-to-write
      The chapter declares the table and no terminology of any kind.

  needs-decision
      Something about the table cannot be settled mechanically. Reported with
      the specific obstacle so it can be answered once and re-run.

  suppressed-by-ruling
      A committee has ruled that this guide should not publish the table at
      all. Nothing is written, and the ruling travels with the entry. See
      `RULED_SUPPRESSIONS` below -- this is the only route that produces no
      artifact for a table the chapter does publish content for.

  superseded-by-ruling
      A committee has ruled that the correct value set for this table is one
      published elsewhere, but THO already publishes a v2 artifact that
      cannot simply be withdrawn. The artifact is kept, marked `retired`, and
      its description is prefixed with a pointer to the correct value set.
      See `RULED_SUPERSESSIONS` below.

Metadata inherited from UTG
---------------------------

Where UTG already publishes a file for a table, `version`, `date` and the
work-group extension are read from it rather than regenerated. We are editing
their resources for most of the corpus, and churning metadata we have no
opinion about would bury the changes that matter. Concept element ids are
preserved the same way -- UTG numbers them from a counter that runs across the
whole repository, so a fresh numbering would collide.

What THO contributes
--------------------

We publish at THO's canonicals, so THO's own content is merged in additively:
anything it carries that Chapter 2C is silent about survives into our output
rather than being dropped. `tho_merge` does the merging and records every fill,
every disagreement and every artifact THO has that we do not; `v291-fhir/
tho-fill-report.json` is the result.

Version numbers follow from the same comparison. An artifact that ends up
matching THO keeps THO's version; one that differs on an element the TSMG
versioning policy counts increments its major version; one THO does not publish
starts at 1.0.0. `tho_versioning_policy` holds the policy's element table and
does the arithmetic, so nothing is hand-applied.

Usage:
    python3 tooling/scripts/write_utg_xml.py
    python3 tooling/scripts/write_utg_xml.py --dry-run
    python3 tooling/scripts/write_utg_xml.py --table 0001 --table 0003
    python3 tooling/scripts/write_utg_xml.py --utg-repo /workspace/UTG
"""

import argparse
import json
import re
import sys
from collections import Counter, defaultdict, namedtuple
from pathlib import Path
from xml.etree import ElementTree

sys.path.insert(0, str(Path(__file__).resolve().parent))
import tho_merge  # noqa: E402
import tho_versioning_policy as versioning  # noqa: E402
from utg_xml import Node, render_document  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"

# Sections of Chapter 2C that are not tables and do not belong in this IG at
# all. This is not a suppression: a suppression withholds a table's artifacts
# and reports the absence, because somebody looking for the artifact deserves
# to know why it is missing. 9999 has no artifacts to withhold and nobody is
# looking for them -- it is a documentation placeholder that occupies a table
# number, carrying the literal strings `noObject` and `noDescription` where a
# code system and description belong.
#
# Excluded at the corpus boundary rather than filtered in each renderer. The
# table reached the published IG three times over -- the table index, the
# ledger, and the open-items register -- because every page that walks the
# corpus had to remember to skip it, and a page added later would not.
#
# V2 Management, 2026-10-15: "Do not put 9999 in this IG at all." Nothing in
# the V2.9.1 standard binds to it: a scan of every `tableBinding` in the
# extracted segments and data types found 1,187 bound fields across 731
# distinct tables and no reference to 9999. The same scan finds 7 bindings to
# withdrawn table 0010 and 1 to 0188, so it does detect bindings to dead
# tables where they exist.
EXCLUDED_SECTIONS = {
    "9999": "A documentation placeholder, not a table. V2 Management ruled "
            "on 2026-10-15 that it does not belong in this IG. Nothing in "
            "the V2.9.1 standard binds to it.",
}
THO_DIR = PROJECT_ROOT / "tho-r5"
DEFAULT_UTG_REPO = PROJECT_ROOT / "UTG"
OUTPUT_DIR = PROJECT_ROOT / "v291-fhir" / "utg"
REPORT_PATH = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"
FILL_REPORT_PATH = PROJECT_ROOT / "v291-fhir" / "tho-fill-report.json"

UTG_V2_SUBPATH = Path("input") / "sourceOfTruth" / "v2"

CS_CANONICAL = "http://terminology.hl7.org/CodeSystem/v2-{table}"
VS_CANONICAL = "http://terminology.hl7.org/ValueSet/v2-{table}"

# Defaults for the publication metadata Chapter 2C does not carry. These are
# UTG's own values, read off their existing files; they are Batch A questions
# that have not been answered, and every one of them is a single edit here.
#
# DEFAULT_VERSION is emphatically NOT a claim that every resource is at 1.0.0.
# Version is inherited per resource from the existing UTG file, and UTG's own
# corpus is not uniform -- it carries 3.0.0, 4.0.0 and 5.0.0. The default is
# reached only by a resource UTG does not yet have, and every resource that
# reaches it is listed in the write report under `usedDefaultVersion` so the
# fallback is never silent.
#
# 1.0.0 is the user's answer (2026-08-25) to what a genuinely new CodeSystem or
# ValueSet should start at. It replaces a 3.0.0 placeholder that had been chosen
# only to match the neighbours. A first publication of a resource nobody has
# published before is a first version, whatever its neighbours happen to carry.
DEFAULT_VERSION = "1.0.0"
DEFAULT_DATE = "2019-12-01"
DEFAULT_STATUS = "active"
DEFAULT_EXPERIMENTAL = "false"
PUBLISHER = "Health Level Seven International"
CONTACT_URL = "http://hl7.org"
CONTACT_EMAIL = "hq@HL7.org"
COPYRIGHT = (
    "This material derives from the HL7 Terminology (THO). THO is copyright "
    "©1989+ Health Level Seven International and is made available under "
    "the CC0 designation. For more licensing information see: "
    "https://terminology.hl7.org/license.html"
)

# The concept property definitions UTG declares, reproduced verbatim. A
# property is only declared in an output file if some concept in it uses the
# property.
PROPERTY_DEFINITIONS = {
    "status": {
        "uri": "http://hl7.org/fhir/concept-properties#status",
        "description": "A code that indicates the status of the concept",
        "type": "code",
    },
    "v2-concComment": {
        "uri": "http://terminology.hl7.org/CodeSystem/utg-concept-properties"
               "#v2-concComment",
        "description": "V2 Concept Comment",
        "type": "string",
    },
}

# Chapter 2C's status column against the FHIR concept status codes.
#
# These values land in `concept.property` under the code `status`, which is the
# standard FHIR concept property
# `http://hl7.org/fhir/concept-properties#status`. Its value set is active /
# experimental / deprecated / retired, and nothing else is a legal value.
# Blank, D and R map onto it unambiguously.
#
# `N` maps to `active`, as a technical correction. The chapter's legend says
# `N` means "new in this release", which is not a status: it decays, because
# nothing updates it after the release that first printed it, and it is not a
# value the property we write it into can take. This guide already publishes
# `active` for 205 concepts where THO still says `N` and the 2.9.1 chapter no
# longer flags anything, so mapping our own 65 the same way makes the treatment
# consistent rather than introducing a second one.
#
# `B` is deliberately NOT mapped. "Backwards-compatible use only" has no FHIR
# equivalent either, and V2 Management is to review the 5 concepts carrying it
# (3 tables in the chapter, 4 concepts reaching the output) case by case. So we
# knowingly continue to emit 4 values the property's value set does not
# contain. Inventing a mapping would prejudge the review. The question is
# registered as `esc-status-n-b-undefined` in `vocabulary_escalations.py`.
STATUS_MAP = {
    "": "active",
    "D": "deprecated",
    "R": "retired",
    "N": "active",
    "B": "B",
}

# Steward initials in Chapter 2C against HL7 work group codes. A steward naming
# two groups, such as "InM/PA", is attributed to the first. An unrecognised
# steward means no extension is written and the table is reported, because a
# wrong work group is worse than an absent one.
WORK_GROUP_MAP = {
    "OO": "oo",
    "FM": "fm",
    "PA": "pa",
    "INM": "inm",
    "SD": "sd",
    "STRUCDOC": "sd",
    "VOCAB": "vocab",
    "VOCABULARY": "vocab",
    "MM": "mnm",
}

# Chapter 2C writes some code system references as a link to a rendered page
# rather than as a canonical URL -- `.../CodeSystem-v3-ActCode.html`. A page URL
# is not a code system identifier and must never reach a `compose`.
PAGE_URL_RE = re.compile(r"^https?://\S+\.html$", re.IGNORECASE)

# The two halves of a filter-shaped Content Logical Definition. Four tables use
# this shape: 0719, 0954, 0957 and 0961. The `Exclude` half is optional, and
# where it appears it always names the same concept the `is-a` filter is rooted
# at -- the standard way of saying "the descendants, but not the abstract
# concept itself". THO writes exactly this pair; see `ValueSet/v3-WorkScheduleODH`.
CLD_INCLUDE_IS_A_RE = re.compile(
    r"Include\s+codes\s+from\s+(?P<system>\S+)\s+where\s+concept\s+is-a\s+(?P<value>\S+)",
    re.IGNORECASE,
)
CLD_EXCLUDE_CODE_RE = re.compile(
    r"Exclude\s+codes\s+where\s+code\s*=\s*(?P<value>\S+)",
    re.IGNORECASE,
)

# The marker Chapter 2C leaves where a table has no real code system. It
# appears in exactly two sections, 0560 and 0910, which is most of the argument
# for treating both as concept domain only (ADR-0008 D11).
PLACEHOLDER_SYMBOLIC_NAME = "noObject"

# The OID arc HL7 registers v2 code systems under. Chapter 2C sometimes gives a
# code system by OID and no URI; an OID under this arc is a v2 code system by
# construction, which is enough to place it without an index lookup.
V2_OID_ARC = "2.16.840.1.113883.18."


# --------------------------------------------------------------------------
# Tentative overrides                                                 ADR-0011
# --------------------------------------------------------------------------
#
# Deviations from what Chapter 2C says that are *provisional*: a named
# committee has been asked the question and has not answered it yet.
#
# This is neither of the two mechanisms already here. It is not the ADR-0010
# evidence gate, which is permanent and is written as a general condition
# rather than a table number. It is not the escalation register either, which
# records a defect in prose and changes no output. It is the narrow case where
# the guide deviates deliberately while a ruling is pending, and has to say so.
#
# An override belongs here only when all three of these hold:
#
#   * the chapter's own content is contradicted by other evidence,
#   * a register item in `vocabulary_escalations.py` puts the question to a
#     committee, and
#   * the entry is deleted the moment the committee answers -- if it agrees,
#     the deviation becomes corrected source data or a general ADR-0010 rule
#     and an ADR records it; if it disagrees, deleting the entry restores the
#     chapter's reading and changes nothing else.
#
# The second of those is the invariant the mechanism refuses to run without.
# An override that names no register item is not tentative; it is an
# unrecorded decision. `test_write_utg_xml.py` imports the register and checks
# that every `register_item` below is really one of its ids.
#
# The number of entries is this guide's un-ruled-deviation debt.
# `tentative_override_summary` computes it on every run and `main` writes it
# into the report, so a page can show it and it cannot quietly grow.
#
# The shape follows `MANUAL_CORRECTIONS` in `vocabulary_text_policy.py`: keyed,
# rationale-bearing, enumerable.
#
#   gate             the classification gate this entry overrides, so that an
#                    entry written for one gate can never skip another
#   chapter_says     what the published chapter says, and what the writer
#                    would do if left alone
#   guide_publishes  what this guide does instead
#   register_item    the id of the register item that asks the question
#   evidence         why the reviewer believes the chapter is wrong here
TentativeOverride = namedtuple(
    "TentativeOverride",
    "gate chapter_says guide_publishes register_item evidence")

TENTATIVE_OVERRIDES = {
    "0292": TentativeOverride(
        gate="concept-domain-only",
        chapter_says="The table is flagged `Concept Domain Only: yes`, which "
                     "stops classification at that gate, so nothing is "
                     "written for the table at all.",
        guide_publishes="The table is treated as a real one whose code system "
                        "belongs to the CDC. The concept-domain-only gate is "
                        "skipped and classification carries on, which reaches "
                        "the table's own OID and resolves it through THO.",
        register_item="esc-0292-cdo-contradiction",
        evidence=(
            "The chapter's own table-metadata grid for 0292 names the code "
            "system -- Full Name \"Vaccines Administered Code System\" -- and "
            "prints its canonical, http://hl7.org/fhir/sid/cvx, in the same "
            "section that declares the table domain-only.",
            "THO publishes a live ValueSet/v2-0292 composing from that same "
            "URI.",
            "THO's NamingSystem/CVX registers this table's own OID, "
            "2.16.840.1.113883.12.292, against that URI.",
            "Sibling table 0227 (MVX) is the same shape -- an external code "
            "system reached through a NamingSystem on the table's own OID -- "
            "is flagged `Concept Domain Only: no`, and is published.",
            "None of the 14 tables typed `External` routes to "
            "code-system-and-value-set, so reading this one as external is "
            "the ordinary treatment rather than a new one.",
        ),
    ),
}


# --------------------------------------------------------------------------
# Suppressions by ruling
# --------------------------------------------------------------------------
#
# Tables a committee has ruled this guide should not publish. The mirror image
# of a tentative override: that mechanism deviates from the chapter *while
# waiting* for an answer and names the open question, this one deviates
# *because* an answer arrived and names the ruling.
#
# They must stay separate. `TENTATIVE_OVERRIDES` carries the guide's un-ruled
# deviation debt, and a test requires every entry there to name an *open*
# register item. Filing a settled ruling in that table would both break the
# invariant and misreport a decision as a pending question.
#
# An entry belongs here only when all three hold:
#
#   * a body with the authority has ruled that this guide should not publish
#     the table,
#   * the register item carrying that ruling has a `resolution` -- the
#     suppression is not this project's judgement and must not look like one,
#   * the absence is reported rather than silent, so a reader who expects the
#     artifact finds out why it is missing.
#
# The second is the invariant, enforced by a test, and it is the reverse of
# the tentative-override one: that table's items must be open, this table's
# must be answered.
#
# Suppression is reversible by deleting the entry. Nothing else in the writer
# knows about these tables, so the chapter's reading is restored intact.
#
#   ruling         what was decided, in the words of the decision
#   register_item  the id of the register item carrying the resolution
#   consequence    what stops being published, stated concretely enough that
#                  a reader can tell what is now absent
Suppression = namedtuple("Suppression", "ruling register_item consequence")

RULED_SUPPRESSIONS = {
    "0078": Suppression(
        ruling="ValueSet/v2-0078 already exists under a different URL, "
               "ValueSet/v3-ObservationInterpretation. That value set is "
               "allowed to serve and no new one is created. This is noted in "
               "the ledger.",
        register_item="esc-0078-alias-of-v3",
        consequence="ValueSet/v2-0078 is not written. It would have been a "
                    "first publication at 1.0.0 -- THO has nothing at that "
                    "canonical -- carrying a compose byte-identical to "
                    "v3-ObservationInterpretation's and the OID "
                    "2.16.840.1.113883.1.11.78, which that value set already "
                    "holds. Not writing it resolves the one-OID-on-two-"
                    "artifacts conflict by removing the second artifact.",
    ),
    "0411": Suppression(
        ruling="Table 0411 should be concept domain only, so no CodeSystem "
               "and no ValueSet.",
        register_item="esc-0411-concept-domain-only",
        consequence="Neither CodeSystem/v2-0411 nor ValueSet/v2-0411 is "
                    "written. Both would have been first publications -- THO "
                    "has nothing for this table -- and the CodeSystem was "
                    "one of only two canonicals this guide minted anywhere "
                    "in the corpus. The two codes the chapter lists, NDBS "
                    "and CG, are no longer published as concepts. The "
                    "table's concept domain is unaffected and continues to "
                    "be published in CodeSystem/conceptdomains.",
    ),
    "0954": Suppression(
        ruling="This guide should not create a value set for table 0954. One "
               "already exists and is correct: THO's "
               "ValueSet/v3-WorkScheduleODH.",
        register_item="esc-0954-0957-duplicate-of-v3",
        consequence="ValueSet/v2-0954 is not written. It would have been a "
                    "first publication at 1.0.0 carrying the OID "
                    "2.16.840.1.113883.1.11.20561, which THO's "
                    "v3-WorkScheduleODH already holds -- and it would have "
                    "disagreed with that value set, because the chapter's "
                    "content logical definition omits the <i>exclude "
                    "_WorkSchedule</i> clause THO's carries. Not writing it "
                    "removes both the duplicate identifier and the "
                    "divergence.",
    ),
    "0957": Suppression(
        ruling="The same as 0954: a correct value set already exists, THO's "
               "ValueSet/v3-employmentStatusODH, and this guide should use "
               "it rather than create a second one.",
        register_item="esc-0954-0957-duplicate-of-v3",
        consequence="ValueSet/v2-0957 is not written. It would have been a "
                    "first publication at 1.0.0 carrying the OID "
                    "2.16.840.1.113883.1.11.20562, which THO's "
                    "v3-employmentStatusODH already holds, over a compose "
                    "structurally identical to that value set's -- the same "
                    "is-a filter and the same exclude. It was a duplicate in "
                    "every respect but its canonical.",
    ),
    "0960": Suppression(
        ruling="This guide should not create a value set for table 0960. "
               "Chapter 2C names the correct one, FHIR core's "
               "ValueSet/data-absent-reason, and that is correct.",
        register_item="esc-0960-duplicate-of-fhir-core",
        consequence="ValueSet/v2-0960 is not written. It would have been a "
                    "first publication at 1.0.0 composing over "
                    "CodeSystem/data-absent-reason -- the same code system "
                    "the FHIR core value set draws on -- at a v2 canonical "
                    "the chapter does not ask for. The chapter's own Value "
                    "Set URI field gives "
                    "http://hl7.org/fhir/ValueSet/data-absent-reason, so not "
                    "writing a second one follows what the chapter says "
                    "rather than departing from it.",
    ),
    "0567": Suppression(
        ruling="Tables 0567 and 0568 should never have been created. Their "
               "value sets will be retired by a separate Jira ticket against "
               "THO, not by this IG, which is to do nothing with them.",
        register_item="esc-0567-0568-deprecation",
        consequence="ValueSet/v2-0567 is not written. The guide had been "
                    "publishing it at 4.0.0 against THO's 3.0.0, an "
                    "increment earned only by adding display text to the "
                    "four UCUM codes THO leaves bare.",
    ),
    "0568": Suppression(
        ruling="Tables 0567 and 0568 should never have been created. Their "
               "value sets will be retired by a separate Jira ticket against "
               "THO, not by this IG, which is to do nothing with them.",
        register_item="esc-0567-0568-deprecation",
        consequence="ValueSet/v2-0568 is not written. The guide had been "
                    "publishing it at 4.0.0 against THO's 3.0.0, an "
                    "increment earned only by adding display text to the "
                    "three UCUM codes THO leaves bare.",
    ),
}


# --------------------------------------------------------------------------
# Reclassifications by ruling
# --------------------------------------------------------------------------
#
# Tables a committee has ruled the chapter classifies wrongly, where the
# correct classification is stated rather than derived.
#
# The third of the ruling-driven mechanisms, and the distinctions matter:
#
#   TENTATIVE_OVERRIDES   deviate from the chapter *while awaiting* a ruling;
#                         must name an OPEN register item (ADR-0011)
#   RULED_SUPPRESSIONS    withhold a table *because of* a ruling; must name an
#                         ANSWERED register item (ADR-0013)
#   RULED_RECLASSIFICATIONS  publish a table the chapter says not to, or
#                         differently from what it says, because of a ruling
#
# This one cannot be folded into either. A suppression removes output and
# needs nothing but a table number. A reclassification *adds* output, so it
# has to say what to publish and over which code system -- and that cannot
# come from the chapter, because the chapter being wrong is the premise.
#
# An entry belongs here only when all four hold:
#
#   * a body with the authority has ruled the chapter's classification wrong,
#   * the register item carrying that ruling has a `resolution`,
#   * the replacement classification is stated in the ruling or follows
#     directly from it, and
#   * `system_url` names a code system identity that THO recognises, OR the
#     entry records why it does not and what that costs.
#
# "Recognises" is the part that is easy to get wrong, and this mechanism got
# it wrong first time round. A canonical under
# `http://terminology.hl7.org/CodeSystem/` does NOT have to have a CodeSystem
# resource behind it. THO mints endorsed URIs for code systems whose content
# belongs to somebody else and registers them as NamingSystems with a
# `responsible` party, publishing no content at all -- its own
# `external_code_systems.html` lists them. Tables 0350, 0351, 0456 and 0895
# are all NUBC systems of exactly that kind.
#
# So the test for a resolvable `system_url` is "THO publishes a CodeSystem at
# it OR registers it as an external code system", not "THO publishes a
# CodeSystem at it". Applying the narrow test flagged four value sets as
# unexpandable that are nothing of the sort.
#
#   action         the classification to use instead of the chapter's
#   system_url     the code system the value set composes over
#   unresolved     None when `system_url` is published and resolvable; a
#                  sentence saying what is wrong with it when it is not
#   ruling         what was decided, in the words of the decision
#   register_item  the id of the register item carrying the resolution
#   rationale      why the chapter's classification is wrong, with evidence
Reclassification = namedtuple(
    "Reclassification",
    "action system_url unresolved ruling register_item rationale")

NUBC_OCCURRENCE_RULING = (
    "Tables 0350 and 0351 are not concept domain only. The value sets exist "
    "in THO, which makes them v2 content and fair game for revision in this "
    "IG, and the fix is to their content logical definitions."
)

RULED_RECLASSIFICATIONS = {
    "0350": Reclassification(
        action="value-set-only",
        system_url="http://terminology.hl7.org/CodeSystem/v2-0350",
        unresolved=None,
        ruling=NUBC_OCCURRENCE_RULING,
        register_item="esc-0350-0351-not-domain-only",
        rationale=(
            "THO's own CodeSystem/v2-tables types this table "
            "`Externally defined` and records a code system OID, a value set "
            "OID and a CLD flag for it -- none of which a concept-domain-only "
            "table has.",
            "THO publishes ValueSet/v2-0350 as an active resource, so the "
            "value set is established v2 content rather than something this "
            "guide would be creating.",
            "The chapter's own table description names the National Uniform "
            "Billing Committee and prints the code system OID "
            "2.16.840.1.113883.6.301.7, which contradicts the "
            "concept-domain-only flag in the same section.",
        ),
    ),
    "0895": Reclassification(
        action="value-set-only",
        system_url="https://www.cms.gov/Medicare/"
                   "Medicare-Fee-for-Service-Payment/HospitalAcqCond/Coding",
        unresolved=None,
        ruling="THO's ValueSet/v2-0895 is wrong about the system URL. The "
               "correct one is the CMS Present on Admission coding page, "
               "which THO's external code systems page carries with the v2 "
               "code system URL as an additional identifier and the same "
               "OID Chapter 2C gives. This IG fixes the THO artifact. No "
               "CodeSystem is created, because THO's record is correct.",
        register_item="esc-0895-wrong-system-url",
        rationale=(
            "THO publishes NamingSystem/presentOnAdmission with the "
            "preferred URI "
            "https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/"
            "HospitalAcqCond/Coding and lists "
            "http://terminology.hl7.org/CodeSystem/v2-0895 among its other "
            "identifiers, commented \"The v2 table of present on admission "
            "indicators\".",
            "Both that NamingSystem and Chapter 2C carry the same OID, "
            "2.16.840.1.113883.6.301.11, so the two are demonstrably the "
            "same code system under two names.",
            "THO publishes CodeSystem/presentOnAdmission at the CMS URL, "
            "content complete with five concepts -- Y, N, U, W and 1 -- so "
            "the value set composes over real content rather than an "
            "unresolvable pointer.",
            "THO's own ValueSet/POAIndicators composes over the CMS URL, "
            "not over v2-0895, which is THO contradicting its own "
            "ValueSet/v2-0895.",
            "A second NamingSystem, NamingSystem/v2-0895, registers the "
            "same OID against the v2 canonical and is what the OID index "
            "resolves to -- it sorts after presentOnAdmission and "
            "overwrites it. That is why this has to be stated rather than "
            "derived.",
        ),
    ),
    "0351": Reclassification(
        action="value-set-only",
        system_url="http://terminology.hl7.org/CodeSystem/v2-0351",
        unresolved=None,
        ruling=NUBC_OCCURRENCE_RULING,
        register_item="esc-0350-0351-not-domain-only",
        rationale=(
            "THO's CodeSystem/v2-tables types this table "
            "`Externally defined` with a code system OID, a value set OID "
            "and a CLD flag.",
            "THO publishes ValueSet/v2-0351 as an active resource.",
            "The chapter's table description names the NUBC and prints the "
            "code system OID 2.16.840.1.113883.6.301.8.",
        ),
    ),
}


# --------------------------------------------------------------------------
# Supersessions by ruling
# --------------------------------------------------------------------------
#
# Tables where a committee has ruled that the correct value set is one
# published elsewhere, and THO already publishes a v2 artifact that cannot
# simply stop existing.
#
# The fourth ruling-driven mechanism, and the one the other three cannot
# express:
#
#   RULED_SUPPRESSIONS       the artifact is never created. Right when this
#                            guide would be minting something new -- 0954,
#                            0957, 0960 -- because not creating it leaves
#                            nothing behind.
#   RULED_RECLASSIFICATIONS  the chapter's classification is wrong and the
#                            correct one is stated. Changes *what* is
#                            published, not its standing.
#   RULED_SUPERSESSIONS      the artifact already exists in THO and is
#                            superseded. Suppressing it would not unpublish
#                            it; it would only stop this guide from saying
#                            anything about it, leaving a live artifact in
#                            the field with nothing pointing at its
#                            replacement.
#
# That last distinction is the whole reason for a fourth table. Suppression
# and supersession look alike -- both say "do not use this" -- but they act
# on opposite situations. Suppression is available only before first
# publication. Once THO publishes an artifact, the strongest available act
# is to retire it and say where to go instead, and both halves matter: a
# retired value set with no pointer tells an implementer they are wrong
# without telling them what is right.
#
# An entry belongs here only when all four hold:
#
#   * a body with the authority has ruled that another value set is the
#     correct one,
#   * the register item carrying that ruling has a `resolution`,
#   * THO already publishes the v2 artifact, so suppression is not available,
#     and
#   * `replacement_url` is version-less, so the pointer keeps resolving as
#     THO publishes new versions.
#
# The last is a requirement rather than a style note. A ruling citing
# `terminology.hl7.org/7.4.0/en/ValueSet-v3-Foo.html` names the right value
# set through a link that rots at the next release; the canonical does not.
#
#   replacement_url    the canonical of the value set that supersedes this
#                      one -- version-less, by invariant
#   replacement_name   how to refer to it in the prose of the note
#   ruling             what was decided, in the words of the decision
#   register_item      the id of the register item carrying the resolution
#   rationale          why this table's own value set is not the one to use
Supersession = namedtuple(
    "Supersession",
    "replacement_url replacement_name ruling register_item rationale")

ODH_SUPERSESSION_RULING = (
    "The v3 code system URI is the correct one and the v3 resource should "
    "be used for the value set as well. The v2 value set has to be kept "
    "because it already exists in THO, but it is to be retired and its "
    "description is to say, at the top, that the v3 value set is the "
    "correct one, with a link that keeps resolving in future versions of "
    "THO."
)

RULED_SUPERSESSIONS = {
    "0719": Supersession(
        replacement_url="http://terminology.hl7.org/ValueSet/"
                        "v3-ActInformationSensitivityPolicy",
        replacement_name="v3-ActInformationSensitivityPolicy",
        ruling="The correct value set for table 0719 is THO's "
               "ValueSet/v3-ActInformationSensitivityPolicy. The only thing "
               "to do with the v2 value set is update its text to point at "
               "the v3 one.",
        register_item="esc-0719-superseded-by-v3",
        rationale=(
            "Chapter 2C's own Value Set URI field for 0719 names "
            "v3-ActInformationSensitivityPolicy, not a v2 canonical.",
            "THO already publishes ValueSet/v2-0719 with status `retired`, "
            "so the supersession is THO's existing position rather than a "
            "new one. This guide had been republishing it as `active`.",
            "The OID on the retired artifact, 2.16.840.1.113883.1.11.20428, "
            "is also on THO's v3-InformationSensitivityPolicy. An "
            "identifier on a published artifact cannot be changed, so this "
            "is a fact to record rather than a defect to repair.",
        ),
    ),
    "0952": Supersession(
        replacement_url="http://terminology.hl7.org/ValueSet/"
                        "v3-Confidentiality",
        replacement_name="v3-Confidentiality",
        ruling=ODH_SUPERSESSION_RULING,
        register_item="esc-0952-0959-superseded-by-v3",
        rationale=(
            "Chapter 2C prints a *ValueSet* page URL, "
            "http://terminology.hl7.org/ValueSet-v2-0952.html, in the Code "
            "System URI field -- a value set where a code system belongs. "
            "The writer recovers by falling back to the code system OID "
            "2.16.840.1.113883.5.25, which resolves to v3-Confidentiality, "
            "so the output is right despite the input being wrong.",
            "The value set OID the chapter gives, "
            "2.16.840.1.113883.1.11.10228, is the identifier on THO's "
            "v3-Confidentiality.",
            "THO publishes ValueSet/v2-0952 as active at 3.0.0, so it "
            "cannot be withheld -- only retired and pointed away from.",
        ),
    ),
    "0959": Supersession(
        replacement_url="http://terminology.hl7.org/ValueSet/"
                        "v3-WorkClassificationODH",
        replacement_name="v3-WorkClassificationODH",
        ruling=ODH_SUPERSESSION_RULING,
        register_item="esc-0952-0959-superseded-by-v3",
        rationale=(
            "The value set OID the chapter gives, "
            "2.16.840.1.113883.1.11.20560, is the identifier on THO's "
            "v3-WorkClassificationODH.",
            "THO publishes ValueSet/v2-0959 as active at 3.0.0, so it "
            "cannot be withheld -- only retired and pointed away from.",
            "Unlike 0952, this table's Code System URI field is a proper "
            "code system page link. The duplication is the only defect "
            "here.",
        ),
    ),
}

# The note prefixed to a superseded value set's description. Markdown, because
# the IG Publisher renders these as markdown -- the same mechanism the 0133
# emphasis ruling uses. The link is written out as a markdown link so it is
# clickable wherever the description is rendered.
SUPERSESSION_NOTE = (
    "**This value set has been retired. The correct value set to use is "
    "[{name}]({url}).**"
)


def ruled_supersession(table):
    """The supersession ruling for this table, or None."""
    return RULED_SUPERSESSIONS.get(table)


def supersession_note(supersession):
    """The markdown note prefixed to a superseded value set's description."""
    return SUPERSESSION_NOTE.format(name=supersession.replacement_name,
                                    url=supersession.replacement_url)


def supersession_summary():
    """What this guide retires and points elsewhere, on somebody's ruling."""
    return {
        "count": len(RULED_SUPERSESSIONS),
        "tables": sorted(RULED_SUPERSESSIONS),
        "registerItems": sorted(
            {s.register_item for s in RULED_SUPERSESSIONS.values()}),
        "replacements": {table: s.replacement_url
                         for table, s in sorted(RULED_SUPERSESSIONS.items())},
    }


def ruled_reclassification(table):
    """The reclassification ruling for this table, or None."""
    return RULED_RECLASSIFICATIONS.get(table)


def reclassification_summary(report):
    """What this guide publishes against the chapter's classification.

    `unresolved` is the part worth surfacing: a reclassification whose code
    system nothing publishes produces a value set that cannot expand, and
    that is a known cost of the ruling rather than a defect to discover
    later.
    """
    applied = [entry for entry in report
               if entry.get("ruledReclassification")]
    return {
        "count": len(RULED_RECLASSIFICATIONS),
        "tables": sorted(RULED_RECLASSIFICATIONS),
        "registerItems": sorted(
            {r.register_item for r in RULED_RECLASSIFICATIONS.values()}),
        "unresolvedSystems": sorted(
            table for table, r in RULED_RECLASSIFICATIONS.items()
            if r.unresolved),
        "appliedThisRun": sorted(entry["table"] for entry in applied),
    }


def ruled_suppression(table):
    """The ruling suppressing this table, or None."""
    return RULED_SUPPRESSIONS.get(table)


def suppression_report(table, suppression):
    """The entry written for a suppressed table.

    It carries the ruling rather than just the fact of suppression, because
    the report is what downstream pages read: a table that is simply absent
    from the output and present in the chapter is indistinguishable from a
    pipeline bug.
    """
    return {
        "table": table,
        "action": "suppressed-by-ruling",
        "reason": suppression.ruling,
        "registerItem": suppression.register_item,
        "consequence": suppression.consequence,
        "written": [],
    }


def suppression_summary():
    """What this guide withholds on somebody else's authority, computed."""
    return {
        "count": len(RULED_SUPPRESSIONS),
        "tables": sorted(RULED_SUPPRESSIONS),
        "registerItems": sorted(
            {s.register_item for s in RULED_SUPPRESSIONS.values()}),
    }


def tentative_override(table, gate):
    """The tentative override for this table at this gate, or None.

    The gate is part of the match so that an entry written to override one
    gate cannot silently skip a different one.
    """
    override = TENTATIVE_OVERRIDES.get(table)
    if override is None or override.gate != gate:
        return None
    return override


def override_report(table, override):
    """The `tentativeOverride` block stamped into a table's report entry.

    The register item is the point of it: a reader of the report can follow
    the id straight to the question that is waiting for an answer.
    """
    return {
        "table": table,
        "gate": override.gate,
        "registerItem": override.register_item,
        "chapterSays": override.chapter_says,
        "guidePublishes": override.guide_publishes,
        "evidence": list(override.evidence),
    }


def tentative_override_summary(report):
    """This guide's un-ruled-deviation debt, computed on every run.

    `count` is the number of entries in the table, which is the debt itself --
    every one of them is a deviation nobody has ruled on. `appliedThisRun` is
    the subset that actually fired, which differs from `tables` only when the
    run was filtered to particular tables with `--table`.
    """
    applied = [entry["tentativeOverride"] for entry in report
               if entry.get("tentativeOverride")]
    return {
        "count": len(TENTATIVE_OVERRIDES),
        "tables": sorted(TENTATIVE_OVERRIDES),
        "registerItems": sorted(
            {o.register_item for o in TENTATIVE_OVERRIDES.values()}),
        "appliedThisRun": sorted(block["table"] for block in applied),
    }


def code_system_directories():
    """Directories to read code system definitions from, lowest authority first.

    THO is the main source. The FHIR core package is added because a handful of
    tables name a code system FHIR owns rather than THO -- table 0962's Device
    Status is `http://hl7.org/fhir/device-status` -- and without it those OIDs
    look unresolvable when they are merely defined somewhere else.
    """
    directories = []
    package_cache = Path.home() / ".fhir" / "packages"
    if package_cache.is_dir():
        for package in sorted(package_cache.glob("hl7.fhir.r5.core#*/package")):
            directories.append(package)
    if THO_DIR.is_dir():
        directories.append(THO_DIR)
    return directories


def load_oid_index():
    """Map OIDs to canonical URLs, using THO as the authority.

    Chapter 2C often gives a code system by OID and no URI, or gives a link to
    a rendered page where a canonical belongs. Either way the OID is the
    reliable identifier, and this is what turns one into the other -- the same
    lookup that settled table 0227 in ADR-0008 D8 and four more in D11.

    Two kinds of source, in order of authority. A NamingSystem exists precisely
    to say which identifiers name the same system, so it wins. But most OIDs
    are recorded on the CodeSystem itself instead -- v3 ActMood and v3
    ObservationInterpretation both carry theirs that way and have no
    NamingSystem -- so CodeSystem identifiers are read as well, and fill the
    gaps the NamingSystems leave.

    Returns:
        A dict of OID string to canonical URL. Empty if no source directory is
        present, in which case OID-only tables fall through to the report
        rather than being resolved wrongly.
    """
    index = {}

    for directory in code_system_directories():
        for path in sorted(directory.glob("CodeSystem-*.json")):
            try:
                resource = json.loads(path.read_text(encoding="utf-8"))
            except (json.JSONDecodeError, UnicodeDecodeError):
                continue
            url = resource.get("url")
            if not url:
                continue
            identifiers = resource.get("identifier") or []
            if isinstance(identifiers, dict):      # R4 spelled this 0..1
                identifiers = [identifiers]
            for identifier in identifiers:
                value = identifier.get("value") or ""
                if value.startswith("urn:oid:"):
                    index[value[len("urn:oid:"):]] = url

    if not THO_DIR.is_dir():
        return index

    # NamingSystems are loaded last and overwrite, because they outrank a
    # CodeSystem's own identifier list when the two disagree.
    for path in sorted(THO_DIR.glob("NamingSystem-*.json")):
        try:
            resource = json.loads(path.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, UnicodeDecodeError):
            continue
        oids = []
        uris = []
        for identifier in resource.get("uniqueId", []):
            if identifier.get("type") == "oid" and identifier.get("value"):
                oids.append(identifier["value"])
            elif identifier.get("type") == "uri" and identifier.get("value"):
                uris.append(identifier["value"])
        if not oids or not uris:
            continue
        # A NamingSystem can list several URIs; the preferred one wins, and
        # failing that the first, which is THO's own ordering.
        preferred = next(
            (i["value"] for i in resource.get("uniqueId", [])
             if i.get("type") == "uri" and i.get("preferred")),
            uris[0],
        )
        for oid in oids:
            index[oid] = preferred
    return index


class UtgRepo:
    """Metadata read from an existing UTG checkout.

    Everything here is optional. Without a checkout the writer still produces
    complete resources; it just uses defaults for the publication metadata and
    numbers concept ids from scratch.
    """

    def __init__(self, root=None):
        self.available = False
        self.code_systems = {}   # table number -> parsed metadata
        self.value_sets = {}
        self.collisions = []     # (table, file name) pairs, reported not resolved
        self.next_concept_id = 100
        if root is None:
            return
        v2_dir = Path(root) / UTG_V2_SUBPATH
        if not v2_dir.is_dir():
            return
        self.available = True
        self._load_code_systems(v2_dir / "codeSystems")
        self._load_value_sets(v2_dir / "valueSets")

    @staticmethod
    def _table_number(path):
        """Pull the table number out of a `cs-v2-0001.xml` style filename.

        A few of UTG's value set files carry something between the prefix and
        the number -- `vs-v2-notAllCodes-0291.xml`. The table number is the
        four digits at the end either way, and matching on anything else meant
        those files were invisible, so their tables inherited no version, no
        date and no concept element ids.
        """
        match = re.fullmatch(r"(?:cs|vs)-v2-(?:.*-)?(\d{4})\.xml", path.name)
        return match.group(1) if match else None

    @staticmethod
    def _value_of(parent, tag):
        """Read the `value` attribute of a direct child element, or None."""
        child = parent.find(f"{{http://hl7.org/fhir}}{tag}")
        return child.get("value") if child is not None else None

    def _load_code_systems(self, directory):
        if not directory.is_dir():
            return
        highest = self.next_concept_id - 1
        for path in sorted(directory.glob("cs-v2-*.xml")):
            table = self._table_number(path)
            if table is None:
                continue
            try:
                root = ElementTree.parse(path).getroot()
            except ElementTree.ParseError:
                continue

            concept_ids = {}
            for concept in root.iter("{http://hl7.org/fhir}concept"):
                code = self._value_of(concept, "code")
                element_id = concept.get("id")
                if code is not None and element_id is not None:
                    concept_ids.setdefault(code, element_id)
                    if element_id.isdigit():
                        highest = max(highest, int(element_id))

            work_group = None
            for extension in root.findall("{http://hl7.org/fhir}extension"):
                if extension.get("url", "").endswith("structuredefinition-wg"):
                    work_group = self._value_of(extension, "valueCode")

            self.code_systems[table] = {
                "version": self._value_of(root, "version"),
                "date": self._value_of(root, "date"),
                "workGroup": work_group,
                "conceptIds": concept_ids,
                # `CodeSystem.valueSet` means "the value set containing the
                # entire code system", so a code system whose value set omits
                # a code must not carry it. UTG leaves it off exactly twice --
                # 0291 and 0834, the two notAllCodes tables that have a code
                # system -- and 414 of 416 carry it. Mirroring that is safer
                # than re-deriving the rule.
                "hasValueSetElement":
                    self._value_of(root, "valueSet") is not None,
            }
        self.next_concept_id = highest + 1

    def _load_value_sets(self, directory):
        if not directory.is_dir():
            return
        for path in sorted(directory.glob("vs-v2-*.xml")):
            table = self._table_number(path)
            if table is None:
                continue
            try:
                root = ElementTree.parse(path).getroot()
            except ElementTree.ParseError:
                continue
            if table in self.value_sets:
                # Two UTG files claiming one table would make the inherited
                # metadata depend on directory order. There are none today;
                # this exists so that a new one is noticed rather than
                # silently winning.
                self.collisions.append((table, path.name))
                continue
            self.value_sets[table] = {
                "version": self._value_of(root, "version"),
                "date": self._value_of(root, "date"),
                # UTG's own file name and canonical, kept so the output can
                # overwrite the right file at the right URL rather than at one
                # derived from the table number.
                "fileName": path.name,
                "url": self._value_of(root, "url"),
                "resourceId": self._value_of(root, "id"),
            }

    def allocate_concept_id(self):
        """Hand out the next unused concept element id."""
        element_id = self.next_concept_id
        self.next_concept_id += 1
        return str(element_id)


def load_published_value_set_urls():
    """Index the ValueSet canonicals THO already publishes, by table number.

    A canonical URL is an identifier and nothing more. Where one already exists
    for a table, it is the URL, and this project must use it rather than
    construct its own -- even where the existing one looks like it means
    something. Four tables have a canonical of the form
    `.../ValueSet/v2-notAllCodes-NNNN`; that string is not a statement about
    the value set's contents that we are entitled to reproduce or to ignore, it
    is simply the identifier THO issued.

    Read from the `url` element rather than from the file name, because the two
    disagree: UTG's file for table 0834 is `vs-v2-0834.xml` and declares the
    canonical `.../v2-notAllCodes-0834`.

    Returns:
        A dict of table number to canonical URL. Tables THO does not publish
        are absent, and the writer constructs a canonical for those.
    """
    index = {}
    pattern = re.compile(
        r"^http://terminology\.hl7\.org/ValueSet/v2-(?:.*-)?(\d{4})$")

    for path in sorted(THO_DIR.glob("ValueSet-*.json")):
        try:
            url = json.loads(path.read_text()).get("url") or ""
        except (json.JSONDecodeError, OSError):
            continue
        match = pattern.match(url)
        if match:
            index[match.group(1)] = url

    return index


def value_set_identity(table, published_urls=None, utg=None):
    """Decide the canonical, resource id and file name for a table's ValueSet.

    Three things have to agree, and all three follow from the canonical:

      * `ValueSet.url` is whatever THO already publishes, or a constructed
        `.../ValueSet/v2-NNNN` where THO publishes nothing.
      * `ValueSet.id` is the last segment of that canonical, which is how every
        UTG resource is built.
      * the file name mirrors UTG's own, so that copying the output tree over
        UTG's overwrites the right file instead of adding a second one. UTG is
        not internally consistent here -- three of the four odd tables are
        filed under their canonical and the fourth under its table number --
        so its file name is read rather than derived.
    """
    url = (published_urls or {}).get(table) or VS_CANONICAL.format(table=table)
    resource_id = url.rsplit("/", 1)[-1]

    inherited = (utg.value_sets.get(table, {}) if utg else {})
    file_name = inherited.get("fileName") or f"vs-{resource_id}.xml"

    return {"url": url, "id": resource_id, "file": f"valueSets/{file_name}"}


def pascal_case(symbolic_name):
    """Turn a symbolic name into the computer-friendly `name` FHIR wants.

    Word breaks are the punctuation in the name; the first letter of each piece
    is capitalised and nothing else is touched, so internal capitals survive.
    `hl7VS-administrativeSex` becomes `Hl7VSAdministrativeSex`, which is what
    UTG's own files carry.
    """
    pieces = re.split(r"[^A-Za-z0-9]+", symbolic_name or "")
    return "".join(p[0].upper() + p[1:] for p in pieces if p)


def work_group_code(steward):
    """Map a Chapter 2C steward to an HL7 work group code, or None."""
    if not steward:
        return None
    first = steward.split("/")[0].strip().upper()
    return WORK_GROUP_MAP.get(first)


def is_placeholder(code_system):
    """Is this the `noObject` marker rather than a real code system?"""
    return (code_system.get("SymbolicName") or "").strip() == PLACEHOLDER_SYMBOLIC_NAME


def is_page_url(url):
    """Is this a link to a rendered HTML page rather than a canonical URL?"""
    return bool(url) and bool(PAGE_URL_RE.match(url))


def parse_logical_definition(text):
    """Read a Content Logical Definition into the compose it describes.

    Returns one of:
        {"kind": "all-codes"}       include the whole system
        {"kind": "enumerated"}      include the codes the table itself lists
        {"kind": "filter", ...}     include a subtree of another system
        None                        not a shape we build; the table is reported

    The filter shape is copied from THO rather than invented. 1,423 of THO's
    1,432 filtered ValueSets use `concept is-a` and nothing else, and the three
    subtrees Chapter 2C asks for already exist there --
    `ValueSet/v3-WorkScheduleODH`, `ValueSet/v3-employmentStatusODH` and
    `ValueSet/device-kind` -- so the pattern is not in doubt.
    """
    text = (text or "").strip()
    if text.lower() in ("all codes", ""):
        return {"kind": "all-codes"}
    if text.lower() == "enumerated per table content":
        return {"kind": "enumerated"}

    include = CLD_INCLUDE_IS_A_RE.search(text)
    if not include:
        return None
    exclude = CLD_EXCLUDE_CODE_RE.search(text)
    return {
        "kind": "filter",
        # The filter clause carries a real canonical even where the table's own
        # code system block carries a page link, so it is the better source.
        "system": include.group("system"),
        "isA": include.group("value"),
        "excludeRoot": exclude.group("value") if exclude else None,
    }


def declares_concept_domain_only(record):
    """Does the chapter flag this table `Concept Domain Only: yes`?"""
    domain = record.get("conceptDomain") or {}
    return (domain.get("Concept Domain Only") or "").strip().lower() == "yes"


def classify(record, oid_index, snapshot=None):
    """Decide what, if anything, to write for one table.

    This is `classify_chapter_reading` with ADR-0011's tentative overrides
    applied on top. Where an override fires, the returned plan carries a
    `tentativeOverride` block naming the register item that asks the question,
    so the deviation travels with the classification rather than having to be
    reconstructed later.

    Returns:
        A dict with `action` and `reason`, plus whatever the chosen action
        needs -- typically `systemUrl`, the canonical of the code system the
        table's codes actually belong to.
    """
    table = record["tableNumber"]

    # A ruling that the chapter's classification is wrong replaces it
    # outright. Checked before the tentative overrides because a settled
    # answer outranks a pending question, and before the chapter reading
    # because that reading is what was ruled wrong.
    reclassification = ruled_reclassification(table)
    if reclassification is not None:
        plan = {
            "action": reclassification.action,
            "reason": reclassification.ruling,
            "systemUrl": reclassification.system_url,
            "resolvedBy": f"committee ruling, "
                          f"{reclassification.register_item}",
            # The chapter declares no value set block for these tables --
            # that absence is part of what was ruled wrong -- so the write
            # has to be authorised here or the reclassification does nothing.
            "hasValueSet": True,
            "ruledReclassification": {
                "table": table,
                "registerItem": reclassification.register_item,
                "ruling": reclassification.ruling,
                "rationale": list(reclassification.rationale),
                "unresolvedSystem": reclassification.unresolved,
            },
        }
        return plan

    override = tentative_override(table, "concept-domain-only")
    plan = classify_chapter_reading(
        record, oid_index, snapshot,
        skip_concept_domain_only=override is not None)
    # Stamped only where the gate would really have fired. An entry for a
    # table the chapter does not actually flag has overridden nothing, and
    # claiming a deviation we did not make would be worse than making none.
    if override is not None and declares_concept_domain_only(record):
        plan["tentativeOverride"] = override_report(table, override)
    return plan


def classify_chapter_reading(record, oid_index, snapshot=None,
                             skip_concept_domain_only=False):
    """Classify one table on what Chapter 2C itself says.

    `skip_concept_domain_only` is ADR-0011's hook: with it set, the
    concept-domain-only gate is passed over and classification continues as
    though the chapter had not flagged the table. Nothing else about the
    reading changes, so what the table routes to is still worked out from the
    chapter's content and THO's index rather than asserted.
    """
    table = record["tableNumber"]
    own_system = CS_CANONICAL.format(table=table)
    domain = record.get("conceptDomain") or {}
    systems = record.get("codeSystems") or []
    value_sets = record.get("valueSets") or []
    codes = record.get("codedContent") or []

    if not domain and not systems and not codes:
        return {"action": "nothing-to-write",
                "reason": "The chapter declares the table but no concept "
                          "domain, code system or codes."}

    if (not skip_concept_domain_only
            and (domain.get("Concept Domain Only") or "").strip().lower()
            == "yes"):
        return {"action": "concept-domain-only",
                "reason": "Declared concept domain only. A binding to a "
                          "domain needs no value set."}

    if systems and all(is_placeholder(s) for s in systems):
        # The placeholder usually means exactly what it says. Table 0560 is
        # the exception, and it is an exception on evidence rather than by
        # name: the chapter lists five codes underneath the placeholder, gives
        # the value set's OID, and THO publishes a code system carrying those
        # same five codes at this table's own canonical. Three independent
        # signals that the placeholder is a defect in the chapter rather than
        # a statement that the table has no code system. See ADR-0010.
        #
        # Table 0910 has the same placeholder, no codes and no THO code
        # system, so it stays where it was.
        if codes and snapshot is not None and snapshot.code_system(table):
            return {"action": "code-system-and-value-set",
                    "reason": "The code system block is the noObject "
                              "placeholder, but the chapter lists codes under "
                              "it and THO publishes a code system at this "
                              "table's own canonical, so the placeholder is a "
                              "defect in the chapter rather than an absent "
                              "code system.",
                    "systemUrl": own_system,
                    "resolvedBy": "THO publishes a CodeSystem at the table's "
                                  "own canonical and the chapter lists codes",
                    "placeholderOverridden": True,
                    "hasValueSet": bool(value_sets)}
        return {"action": "concept-domain-only",
                "reason": "The code system block is the noObject placeholder, "
                          "so there is no code system (ADR-0008)."}

    if not systems:
        # Table 0227 (MVX) is the whole of this case. The chapter declares a
        # value set and no code system block at all -- but the table's own OID
        # is registered in THO as a NamingSystem for the real, external code
        # system. That is ADR-0008 D8, and the lookup generalises: a table with
        # no code system whose OID names one is a value set over that system.
        table_oid = ((record.get("tableMetadata") or {})
                     .get("Table OID") or "").strip()
        if table_oid in oid_index:
            return {"action": "value-set-only",
                    "reason": "The chapter declares no code system, but the "
                              "table's own OID is registered in THO as a "
                              "NamingSystem for an external one.",
                    "systemUrl": oid_index[table_oid],
                    "resolvedBy": f"THO NamingSystem for table OID {table_oid}",
                    "hasValueSet": bool(value_sets)}
        return {"action": "needs-decision",
                "reason": "A value set is declared but no code system, so "
                          "there is nothing to compose over."}

    if len(systems) > 1:
        return {"action": "needs-decision",
                "reason": f"The table declares {len(systems)} code systems; "
                          "which one the value set draws from is not stated.",
                "candidates": [s.get("URI") or s.get("Code System OID")
                               for s in systems]}

    system = systems[0]
    declared_uri = (system.get("URI") or "").strip()
    oid = (system.get("Code System OID") or "").strip()

    # Seven tables print a link to a rendered page where a canonical URL
    # belongs. A page URL cannot identify a code system in a compose, so it is
    # discarded -- but every one of those tables also prints the OID, and the
    # OID is a perfectly good identifier. Falling back to it resolves them all
    # without anybody having to decide anything.
    page_url = None
    if is_page_url(declared_uri):
        page_url = declared_uri
        declared_uri = ""

    if declared_uri:
        system_url = declared_uri
        resolved_by = "published URI"
    elif oid and oid in oid_index:
        system_url = oid_index[oid]
        resolved_by = f"THO resolves OID {oid}"
    elif oid.startswith(V2_OID_ARC):
        # The HL7 v2 code system arc. An OID here is a v2 code system by
        # construction, so even though nothing in THO indexes it, we know whose
        # it is. Tables 0001 and 0460 reach us this way.
        system_url = own_system
        resolved_by = f"OID {oid} is in the HL7 v2 code system arc"
    elif oid and oid not in ("", "-"):
        return {"action": "needs-decision",
                "reason": f"The code system is given only as OID {oid}, which "
                          "nothing in THO or FHIR core resolves to a canonical "
                          "URL.",
                "published": page_url or oid}
    else:
        # No URI and no usable OID. The chapter simply did not print the
        # canonical for its own table; UTG publishes one, so we do too.
        system_url = own_system
        resolved_by = "table's own canonical (the chapter printed neither)"

    common = {"systemUrl": system_url,
              "resolvedBy": resolved_by,
              "hasValueSet": bool(value_sets)}
    if page_url:
        common["published"] = page_url
        common["note"] = ("The chapter printed a link to a rendered page, "
                          f"{page_url}, where a canonical URL belongs. The OID "
                          "beside it resolved instead.")

    if system_url == own_system:
        if not codes:
            return {"action": "needs-decision",
                    "reason": "The table owns its code system but publishes "
                              "no codes, so a complete CodeSystem cannot be "
                              "built."}
        return {"action": "code-system-and-value-set",
                "reason": "The code system is this table's own canonical.",
                **common}

    return {"action": "value-set-only",
            "reason": "The code system belongs to another authority, so only "
                      "the value set is ours to author.",
            **common}


def add_common_metadata(root, *, resource_id, url, oid, version, date,
                        name, title, description, status=None):
    """Add the publication metadata every UTG v2 resource carries, in order.

    CodeSystem and ValueSet share this whole block and put it in the same
    place, so it is built once. Element order matters: FHIR XML is ordered, and
    a resource whose elements are shuffled will not validate.

    `status` defaults to DEFAULT_STATUS, which is what every artifact carries
    unless a ruling says otherwise. It is a parameter rather than a constant
    only so `RULED_SUPERSESSIONS` can retire a value set; nothing else passes
    it, and nothing else should without a ruling behind it.
    """
    root.add_value("id", resource_id)
    root.add_value("url", url)
    if oid and oid not in ("", "-"):
        identifier = root.add(Node("identifier"))
        identifier.add_value("system", "urn:ietf:rfc:3986")
        identifier.add_value("value", f"urn:oid:{oid}")
    root.add_value("version", version)
    root.add_value("name", name)
    root.add_value("title", title)
    root.add_value("status", status or DEFAULT_STATUS)
    root.add_value("experimental", DEFAULT_EXPERIMENTAL)
    root.add_value("date", date)
    root.add_value("publisher", PUBLISHER)
    contact = root.add(Node("contact"))
    for system, value in (("url", CONTACT_URL), ("email", CONTACT_EMAIL)):
        telecom = contact.add(Node("telecom"))
        telecom.add_value("system", system)
        telecom.add_value("value", value)
    root.add_value("description", description)


def chapter_concept_row(entry, element_id, unknown_statuses=None):
    """Turn a row of the chapter's coded content into a merge row.

    The row shape is the one `tho_merge` joins on; see that module for the
    field list. Building rows first and XML afterwards is what lets THO's
    content be merged in on values rather than spliced into a node tree.

    Args:
        entry: one row of the chapter's coded content.
        element_id: the concept element id to reuse, or None to allocate one
            later.
        unknown_statuses: a list to append anomalies to, or None to not
            collect them. A status letter `STATUS_MAP` does not know is
            written out as it stands -- the same treatment `B` gets, and the
            same fidelity rule the rest of the writer follows -- but it is
            recorded here so that it reaches the write report. Chapter 2C's
            complete observed set is blank, D, N, B and R, so nothing in the
            current corpus takes this path; a future chapter adding a letter
            would otherwise put an unmapped value into the FHIR `status`
            property with nothing saying so. The module reports unexpected
            input rather than raising on it -- an unresolvable OID becomes
            `needs-decision`, an unmapped steward becomes a note, an
            undeclared property becomes `unknownProperties` -- and this
            follows that convention.
    """
    properties = []
    comment = (entry.get("comment") or "").strip()
    if comment:
        properties.append(("v2-concComment", "valueString", comment))

    raw_status = (entry.get("status") or "").strip()
    if raw_status in STATUS_MAP:
        status = STATUS_MAP[raw_status]
    else:
        status = raw_status
        if unknown_statuses is not None:
            unknown_statuses.append({"code": entry.get("value"),
                                     "status": raw_status})
    if status:
        properties.append(("status", "valueCode", status))

    return {
        "code": entry.get("value"),
        "display": entry.get("displayName"),
        "definition": entry.get("definition"),
        "designations": [],
        "properties": properties,
        "elementId": element_id,
        "origin": "chapter",
    }


def xml_value(value):
    """Render a property value as FHIR XML spells it.

    Python's `True` is `"True"`, and FHIR's is `"true"`. Every other type is
    its own string.
    """
    if isinstance(value, bool):
        return "true" if value else "false"
    return value


def build_concept(row):
    """Build one `<concept>` from a merged concept row.

    Element order is the one FHIR fixes for `CodeSystem.concept`: code,
    display, definition, designation, property.
    """
    concept = Node("concept", id=row.get("elementId"))
    concept.add_value("code", row.get("code"))
    concept.add_value("display", row.get("display"))
    concept.add_value("definition", row.get("definition"))

    for designation in row.get("designations") or []:
        node = concept.add(Node("designation"))
        node.add_value("language", designation.get("language"))
        use = designation.get("use") or {}
        if use:
            use_node = node.add(Node("use"))
            use_node.add_value("system", use.get("system"))
            use_node.add_value("code", use.get("code"))
        node.add_value("value", designation.get("value"))

    for code, value_key, value in row.get("properties") or []:
        prop = concept.add(Node("property"))
        prop.add_value("code", code)
        prop.add_value(value_key, xml_value(value))
    return concept


def property_declarations(used_codes, tho_resource):
    """The `<property>` declarations a file needs for the codes it uses.

    A declaration is taken from THO's own resource wherever THO has one, so
    that a property we inherited is described exactly as THO describes it, and
    from our own transcription of UTG's wording otherwise.

    Order follows THO's declaration order, then our fixed order for anything
    left, so that adding an inherited property does not reshuffle the ones
    already there.

    Returns:
        A ``(declarations, unknown)`` pair. `declarations` are dicts ready to
        write; `unknown` are property codes nobody defines, which are reported
        rather than written, because an undeclared property is invalid FHIR.
    """
    from_tho = {}
    for declaration in (tho_resource or {}).get("property") or []:
        if declaration.get("code"):
            from_tho[declaration["code"]] = declaration

    ordered = [code for code in from_tho if code in used_codes]
    ordered += [code for code in ("status", "v2-concComment")
                if code in used_codes and code not in ordered]
    ordered += [code for code in sorted(used_codes) if code not in ordered]

    declarations = []
    unknown = []
    for code in ordered:
        if code in from_tho:
            declaration = from_tho[code]
            declarations.append({
                "code": code,
                "uri": declaration.get("uri"),
                "description": declaration.get("description"),
                "type": declaration.get("type"),
            })
        elif code in PROPERTY_DEFINITIONS:
            declarations.append({"code": code, **PROPERTY_DEFINITIONS[code]})
        else:
            unknown.append(code)
    return declarations, unknown


def resolve_version(resource_type, snapshot, tho_resource, inherited, changed):
    """Decide the version to publish, and say why.

    With no THO snapshot to compare against the writer keeps its old
    behaviour and inherits the version from the UTG checkout -- that is the
    path the unit tests take, and it keeps the builders usable without a
    2,000-file package on disk. With a snapshot, the version follows from the
    TSMG policy and the comparison.
    """
    if snapshot is None:
        return {
            "version": inherited.get("version") or DEFAULT_VERSION,
            "reason": "Inherited from the UTG checkout; no THO snapshot to "
                      "compare against.",
            "incremented": False,
            "triggers": [],
            "judgement": [],
            "newArtifact": [],
        }
    baseline = tho_resource.get("version") if tho_resource else None
    return versioning.next_version(resource_type, baseline, changed)


def plan_code_system(record, plan, utg, published_urls=None, snapshot=None,
                     observe=None):
    """Settle every value the CodeSystem will carry, before any XML is built.

    This is where THO's content is merged in and the version is worked out.
    Doing it on values rather than on a node tree keeps the merge readable and
    means the XML is built once, from an answer nothing else will change.

    Returns:
        A dict of resolved values, plus a `version` record saying how the
        version was arrived at and an `unknownProperties` list.
    """
    table = record["tableNumber"]
    system = (record.get("codeSystems") or [{}])[0]
    metadata = record.get("tableMetadata") or {}
    inherited = utg.code_systems.get(table, {})
    observe = observe if observe is not None else tho_merge.Observations()
    tho = snapshot.code_system(table) if snapshot else None
    context = {"table": table, "resource": "CodeSystem"}

    symbolic_name = (system.get("SymbolicName") or "").strip()
    if is_placeholder(system):
        # `noObject` is a marker, not a name. Emptying it here is what lets the
        # merge fill name and title from THO rather than publishing the marker.
        symbolic_name = ""
    fields = {
        "name": pascal_case(symbolic_name),
        "title": symbolic_name,
        "status": DEFAULT_STATUS,
        "experimental": DEFAULT_EXPERIMENTAL,
        "description": (system.get("Description") or "").strip(),
        "purpose": f"Underlying Master Code System for V2 table {table} "
                   f"({record.get('tableName', '')})",
        "caseSensitive": "true",
        "hierarchyMeaning": "is-a",
        "compositional": "false",
        "content": "complete",
    }
    fields = tho_merge.merge_fields(
        fields, tho, tho_merge.FILLABLE_CODE_SYSTEM_FIELDS, observe, context)

    known_ids = inherited.get("conceptIds", {})
    unknown_statuses = []
    chapter_rows = [
        chapter_concept_row(entry, known_ids.get(entry.get("value")),
                            unknown_statuses)
        for entry in record.get("codedContent") or []
    ]
    rows = (tho_merge.merge_concepts(chapter_rows, tho, observe, table)
            if tho else chapter_rows)
    # Ids are handed out after the merge so that a concept inherited from THO
    # keeps THO's id rather than being given a fresh one.
    for row in rows:
        if not row.get("elementId"):
            row["elementId"] = utg.allocate_concept_id()

    used_properties = {code for row in rows
                       for code, _key, _value in row.get("properties") or []}
    declarations, unknown = property_declarations(used_properties, tho)

    oid, changed = tho_merge.merge_identifier(
        system.get("Code System OID"), tho, observe, context)
    changed += tho_merge.changed_fields(
        fields, tho, tho_merge.COMPARED_CODE_SYSTEM_FIELDS, observe, context)
    if tho and tho_merge.concepts_changed(rows, tho):
        changed.append("concept")

    # `CodeSystem.valueSet` names the value set that contains the *entire* code
    # system, so it is wrong on a code system whose value set leaves a code
    # out. Where UTG already publishes the code system, follow what it does;
    # it omits the element on exactly the two tables where the value set is not
    # all-codes. Where UTG has nothing, the value set we write is built from
    # the chapter's own content, so the element is correct.
    inherited_has_element = inherited.get("hasValueSetElement")
    if inherited_has_element is None:
        inherited_has_element = True
    value_set_url = None
    if plan.get("hasValueSet") and inherited_has_element:
        value_set_url = value_set_identity(table, published_urls, utg)["url"]

    return {
        "resourceId": f"v2-{table}",
        "url": plan["systemUrl"],
        "oid": oid,
        "workGroup": (inherited.get("workGroup")
                      or work_group_code(metadata.get("Steward"))),
        "fields": fields,
        "date": inherited.get("date") or DEFAULT_DATE,
        "valueSetUrl": value_set_url,
        "concepts": rows,
        "propertyDeclarations": declarations,
        "unknownProperties": unknown,
        "unknownStatuses": unknown_statuses,
        "version": resolve_version("CodeSystem", snapshot, tho, inherited,
                                   changed),
        "changed": changed,
    }


def render_code_system(resolved):
    """Build the CodeSystem XML from the values `plan_code_system` settled.

    Element order matters: FHIR XML is ordered, and a resource whose elements
    are shuffled will not validate.
    """
    fields = resolved["fields"]
    root = Node("CodeSystem")
    root.add_value("id", resolved["resourceId"])

    if resolved["workGroup"]:
        extension = root.add(Node(
            "extension",
            url="http://hl7.org/fhir/StructureDefinition/structuredefinition-wg",
        ))
        extension.add_value("valueCode", resolved["workGroup"])

    # `id` is added by add_common_metadata for the ValueSet, but the CodeSystem
    # puts the work group extension between id and url, so id is added above
    # and the shared helper is given the rest.
    add_common_metadata(
        root,
        resource_id=None,
        url=resolved["url"],
        oid=resolved["oid"],
        version=resolved["version"]["version"],
        date=resolved["date"],
        name=fields["name"],
        title=fields["title"],
        description=fields["description"],
    )
    root.add_value("purpose", fields["purpose"])
    root.add_value("copyright", COPYRIGHT)
    root.add_value("caseSensitive", fields["caseSensitive"])
    if resolved["valueSetUrl"]:
        root.add_value("valueSet", resolved["valueSetUrl"])
    root.add_value("hierarchyMeaning", fields["hierarchyMeaning"])
    root.add_value("compositional", fields["compositional"])
    root.add_value("versionNeeded", "false")
    root.add_value("content", fields["content"])

    for declaration in resolved["propertyDeclarations"]:
        prop = root.add(Node("property"))
        prop.add_value("code", declaration["code"])
        prop.add_value("uri", declaration["uri"])
        prop.add_value("description", declaration["description"])
        prop.add_value("type", declaration["type"])

    for row in resolved["concepts"]:
        root.add(build_concept(row))
    return root


def build_code_system(record, plan, utg, published_urls=None, snapshot=None,
                      observe=None):
    """Build the CodeSystem for a table that owns its code system."""
    return render_code_system(plan_code_system(
        record, plan, utg, published_urls, snapshot, observe))


def chapter_compose(record, plan, shape):
    """The compose the chapter asks for, as plain data.

    The chapter's Content Logical Definition says which shape it takes. `all
    codes` includes the whole system; `enumerated per table content` lists the
    table's own rows; an is-a filter names a subtree. Anything else is not
    interpreted here -- `classify` sends those tables to the report instead.
    """
    if shape["kind"] == "filter":
        compose = {
            "include": [{
                "system": shape["system"],
                "filter": [{"property": "concept", "op": "is-a",
                            "value": shape["isA"]}],
            }],
            "exclude": [],
        }
        if shape["excludeRoot"]:
            # `is-a` includes the concept it is rooted at, so excluding that
            # one code is how "the descendants only" is written.
            compose["exclude"].append({
                "system": shape["system"],
                "concept": [{"code": shape["excludeRoot"]}],
            })
        return compose

    include = {"system": plan["systemUrl"]}
    if shape["kind"] == "enumerated":
        include["concept"] = [
            {"code": entry.get("value"), "display": entry.get("displayName")}
            for entry in record.get("codedContent") or []
        ]
    return {"include": [include], "exclude": []}


def plan_value_set(record, plan, utg, published_urls=None, snapshot=None,
                   observe=None):
    """Settle every value the ValueSet will carry, before any XML is built."""
    table = record["tableNumber"]
    value_set = (record.get("valueSets") or [{}])[0]
    inherited = utg.value_sets.get(table, {})
    symbolic_name = (value_set.get("SymbolicName") or "").strip()
    identity = value_set_identity(table, published_urls, utg)
    observe = observe if observe is not None else tho_merge.Observations()
    tho = snapshot.value_set(identity["url"]) if snapshot else None
    context = {"table": table, "resource": "ValueSet"}

    fields = {
        "name": pascal_case(symbolic_name),
        "title": symbolic_name,
        "status": DEFAULT_STATUS,
        "experimental": DEFAULT_EXPERIMENTAL,
        "description": (value_set.get("Description") or "").strip(),
    }
    fields = tho_merge.merge_fields(
        fields, tho, tho_merge.FILLABLE_VALUE_SET_FIELDS, observe, context)

    # A supersession ruling, applied after the THO merge and before anything
    # is compared. Two changes, and they must happen in this order: the merge
    # fills `description` from THO where the chapter is silent, so prefixing
    # the note first would see it overwritten.
    #
    # `status` is the reason this cannot be a quieter change. It is in
    # COMPARED_VALUE_SET_FIELDS and not in FILLABLE_VALUE_SET_FIELDS -- a
    # difference against THO is reported and bumps the version, but never
    # fills. That is right everywhere else and wrong here: it is why this
    # guide was republishing THO's retired v2-0719 as active. Setting it
    # explicitly on a ruling is the only route that changes it.
    supersession = ruled_supersession(table)
    if supersession is not None:
        fields["status"] = "retired"
        note = supersession_note(supersession)
        description = fields.get("description") or ""
        if not description.startswith(note):
            fields["description"] = (
                f"{note}\n\n{description}" if description else note)

    shape = parse_logical_definition(value_set.get("Content Logical Definition"))
    compose = tho_merge.merge_compose(
        chapter_compose(record, plan, shape), tho, observe, context)

    oid, changed = tho_merge.merge_identifier(
        value_set.get("Value Set OID"), tho, observe, context)
    changed += tho_merge.changed_fields(
        fields, tho, tho_merge.COMPARED_VALUE_SET_FIELDS, observe, context)
    if tho and tho_merge.compose_changed(compose, tho):
        changed.append("compose.include")

    return {
        "resourceId": identity["id"],
        "url": identity["url"],
        "oid": oid,
        "fields": fields,
        "date": inherited.get("date") or DEFAULT_DATE,
        "compose": compose,
        "version": resolve_version("ValueSet", snapshot, tho, inherited,
                                   changed),
        "changed": changed,
    }


def render_value_set(resolved):
    """Build the ValueSet XML from the values `plan_value_set` settled."""
    fields = resolved["fields"]
    root = Node("ValueSet")
    add_common_metadata(
        root,
        resource_id=resolved["resourceId"],
        url=resolved["url"],
        oid=resolved["oid"],
        version=resolved["version"]["version"],
        date=resolved["date"],
        name=fields["name"],
        title=fields["title"],
        description=fields["description"],
        status=fields.get("status"),
    )
    root.add_value("copyright", COPYRIGHT)

    compose = root.add(Node("compose"))
    for kind in ("include", "exclude"):
        for group in resolved["compose"].get(kind) or []:
            node = compose.add(Node(kind))
            node.add_value("system", group.get("system"))
            for concept in group.get("concept") or []:
                child = node.add(Node("concept"))
                child.add_value("code", concept.get("code"))
                child.add_value("display", concept.get("display"))
            for criterion in group.get("filter") or []:
                child = node.add(Node("filter"))
                child.add_value("property", criterion.get("property"))
                child.add_value("op", criterion.get("op"))
                child.add_value("value", criterion.get("value"))
    return root


def build_value_set(record, plan, utg, published_urls=None, snapshot=None,
                    observe=None):
    """Build the ValueSet for a table, composed over `plan["systemUrl"]`."""
    return render_value_set(plan_value_set(
        record, plan, utg, published_urls, snapshot, observe))


def compose_shape(record):
    """Say whether the Content Logical Definition is one we can build.

    Returns None when it is, or the uninterpretable text when it is not.
    """
    value_sets = record.get("valueSets") or []
    if not value_sets:
        return None
    definition = (value_sets[0].get("Content Logical Definition") or "").strip()
    if parse_logical_definition(definition) is not None:
        return None
    return definition


def process(records, utg, oid_index, published_urls=None, snapshot=None,
            observe=None):
    """Classify every table and build the resources for those that qualify.

    Returns:
        A ``(files, report)`` pair. `files` maps a relative path to its
        rendered XML; `report` is the record of what was decided for every
        table, written whether or not anything was emitted.
    """
    files = {}
    report = []
    observe = observe if observe is not None else tho_merge.Observations()

    for record in records:
        table = record["tableNumber"]

        # Before classification, not after. A suppressed table is one nobody
        # wants an opinion about: classifying it first and then discarding
        # the result would run the THO merge over it and file observations
        # against a table the guide is not publishing.
        suppression = ruled_suppression(table)
        if suppression is not None:
            entry = suppression_report(table, suppression)
            entry["name"] = record.get("tableName", "")
            report.append(entry)
            continue

        plan = classify(record, oid_index, snapshot)
        entry = {
            "table": table,
            "name": record.get("tableName", ""),
            "action": plan["action"],
            "reason": plan["reason"],
            "written": [],
        }
        for key in ("systemUrl", "resolvedBy", "published", "candidates",
                    "tentativeOverride", "ruledReclassification"):
            if key in plan:
                entry[key] = plan[key]

        # Which resources fell back to DEFAULT_VERSION, tracked per resource
        # rather than per table. A table can inherit a version for its
        # CodeSystem and not for its ValueSet -- that is what happens when UTG
        # files the value set under a different name, as it does for the
        # `notAllCodes` tables -- and a per-table flag hides exactly that case.
        used_default = []

        if plan["action"] == "code-system-and-value-set":
            metadata = record.get("tableMetadata") or {}
            if not (utg.code_systems.get(table, {}).get("workGroup")
                    or work_group_code(metadata.get("Steward"))):
                entry["note"] = (
                    f"No work group extension: steward "
                    f"{metadata.get('Steward')!r} is not a work group we map."
                )
            if snapshot is None and not utg.code_systems.get(table, {}).get("version"):
                used_default.append("CodeSystem")
            resolved = plan_code_system(record, plan, utg, published_urls,
                                        snapshot, observe)
            entry["codeSystemVersion"] = resolved["version"]
            if resolved["unknownProperties"]:
                entry["unknownProperties"] = resolved["unknownProperties"]
            if resolved["unknownStatuses"]:
                entry["unknownStatuses"] = resolved["unknownStatuses"]
            document = render_document(render_code_system(resolved))
            path = f"codeSystems/cs-v2-{table}.xml"
            files[path] = document
            entry["written"].append(path)

        if plan["action"] in ("code-system-and-value-set", "value-set-only"):
            # A tentative override says the chapter is wrong about what this
            # table is. Honouring the classification but refusing to write --
            # because the chapter, being wrong in exactly the way the override
            # records, also prints no value set block -- would make the
            # override do nothing. The override authorises the write; nothing
            # else does, so no table without one changes behaviour here.
            overridden = bool(entry.get("tentativeOverride"))
            if not plan.get("hasValueSet") and not overridden:
                entry["note"] = ("The chapter declares no value set block for "
                                 "this table, so none was written.")
            else:
                unbuildable = compose_shape(record)
                if unbuildable:
                    entry["action"] = "needs-decision"
                    entry["reason"] = (
                        "The Content Logical Definition is not one of the "
                        "shapes we build -- all codes, enumerated per table "
                        "content, or an is-a filter: "
                        f"{unbuildable!r}."
                    )
                else:
                    if (snapshot is None
                            and not utg.value_sets.get(table, {}).get("version")):
                        used_default.append("ValueSet")
                    identity = value_set_identity(table, published_urls, utg)
                    if identity["url"] != VS_CANONICAL.format(table=table):
                        entry["valueSetUrl"] = identity["url"]
                        entry["valueSetUrlNote"] = (
                            "Published at THO's existing canonical rather than "
                            "one constructed from the table number.")
                    resolved = plan_value_set(record, plan, utg,
                                              published_urls, snapshot,
                                              observe)
                    entry["valueSetVersion"] = resolved["version"]

                    # A superseded value set is still written -- that is the
                    # point of the mechanism -- so the report has to say that
                    # what was written is retired, or a reader counting
                    # published value sets would count this one as live.
                    supersession = ruled_supersession(table)
                    if supersession is not None:
                        entry["action"] = "superseded-by-ruling"
                        entry["reason"] = supersession.ruling
                        entry["ruledSupersession"] = {
                            "table": table,
                            "registerItem": supersession.register_item,
                            "ruling": supersession.ruling,
                            "replacementUrl": supersession.replacement_url,
                            "replacementName": supersession.replacement_name,
                            "rationale": list(supersession.rationale),
                            "status": "retired",
                        }

                    document = render_document(render_value_set(resolved))
                    path = identity["file"]
                    files[path] = document
                    entry["written"].append(path)

        if used_default:
            entry["usedDefaultVersion"] = {
                "version": DEFAULT_VERSION,
                "resources": used_default,
            }

        report.append(entry)
    return files, report


def record_omissions(report, snapshot, observe):
    """Report THO artifacts this guide publishes nothing for.

    Publishing nothing at a canonical destroys nothing -- THO's artifact
    stands untouched -- so the merge is not entitled to invent one. But a
    reviewer needs to know where this guide is silent and THO is not, so each
    one is recorded together with the reason the writer gave for that table.

    Only meaningful on a full run; a run filtered to a few tables would report
    every other table as an omission, so `main` calls this only when it has
    processed the whole corpus.
    """
    entries = {entry["table"]: entry for entry in report}
    written_code_systems = {
        entry["table"] for entry in report
        if any(path.startswith("codeSystems/") for path in entry["written"])
    }
    written_value_sets = {
        entry.get("valueSetUrl") or VS_CANONICAL.format(table=entry["table"])
        for entry in report
        if any(path.startswith("valueSets/") for path in entry["written"])
    }

    for table in sorted(snapshot.code_system_tables() - written_code_systems):
        entry = entries.get(table, {})
        observe.omission(
            table=table, resource="CodeSystem",
            element="resource",
            url=CS_CANONICAL.format(table=table),
            action=entry.get("action", "not a Chapter 2C table"),
            reason=entry.get("reason", "The chapter has no section for it."))

    for url in sorted(snapshot.value_set_urls() - written_value_sets):
        match = re.search(r"(\d{4})$", url)
        table = match.group(1) if match else None
        entry = entries.get(table, {})
        observe.omission(
            table=table, resource="ValueSet",
            element="resource",
            url=url,
            action=entry.get("action", "not a Chapter 2C table"),
            reason=entry.get("reason", "The chapter has no section for it."))


# What each class of observation means, in words a reviewer can use. Keyed by
# the observation's kind and element; a property observation is keyed by its
# property code as well, because inheriting a comment-as-published and
# inheriting a deprecation marker are not the same finding.
#
# An unlisted combination still appears in the report -- with a title built
# from its key -- so a new kind of finding shows up rather than vanishing.
OBSERVATION_CLASSES = {
    ("fill", "concept.definition"):
        ("Concept definitions kept from THO",
         "Chapter 2C has no definition column at all, so without this every "
         "definition THO has written would be deleted from the artifact."),
    ("fill", "concept.display"):
        ("Concept displays kept from THO",
         "The chapter leaves the display blank for these codes."),
    ("fill", "concept.designation"):
        ("Translations kept from THO",
         "The chapter has no way to express a translation, so there is no "
         "disagreement to have -- only a loss to avoid."),
    ("fill", "concept"):
        ("Codes kept from THO that the chapter does not list",
         "THO publishes these codes at this canonical. Dropping them would "
         "remove codes implementers may already be sending."),
    ("fill", "compose.include.concept"):
        ("Value set members kept from THO",
         "Codes THO enumerates in the value set that the chapter's table "
         "does not."),
    ("fill", "description"):
        ("Resource descriptions kept from THO",
         "Where the chapter's description is missing or a placeholder such "
         "as 'tbd', THO's text stands."),
    ("fill", "name"):
        ("Resource names kept from THO", "The chapter supplies no name."),
    ("fill", "title"):
        ("Resource titles kept from THO", "The chapter supplies no title."),
    ("fill", "concept.property:v2-concCommentAsPub"):
        ("Comments-as-published kept from THO",
         "THO records the comment text as the chapter of the day printed it, "
         "alongside the current one. Nothing in Chapter 2C corresponds to it, "
         "so it can only be kept or lost."),
    ("fill", "concept.property:HL7usageNotes"):
        ("Usage notes kept from THO",
         "Guidance THO carries on individual concepts, with no counterpart "
         "in the chapter's grid."),
    ("fill", "concept.property:v2-table-deprecated"):
        ("Deprecation markers kept from THO",
         "The HL7 version in which a code was deprecated. The chapter's "
         "status column says that a code is deprecated but not when."),
    ("addition", "concept.display"):
        ("Displays the chapter supplies for codes THO leaves bare",
         "THO has the code with no display; the chapter names it."),
    ("addition", "concept.definition"):
        ("Definitions the chapter supplies where THO has none",
         "New content this guide contributes."),
    ("addition", "concept.property:v2-concComment"):
        ("Concept comments the chapter adds", ""),
    ("discrepancy", "concept.property:status"):
        ("Concept status where the chapter and THO disagree",
         "Most of these are codes THO still marks 'N' -- new, in some past "
         "release -- that the 2.9.1 chapter no longer flags, so ours reads "
         "'active'."),
    ("discrepancy", "concept.property:v2-concComment"):
        ("Concept comments where the chapter and THO disagree", ""),
    ("discrepancy", "name"):
        ("Resource names where the chapter and THO disagree", ""),
    ("discrepancy", "title"):
        ("Resource titles where the chapter and THO disagree", ""),
    ("discrepancy", "status"):
        ("Resource status where the chapter and THO disagree", ""),
    ("discrepancy", "concept.definition"):
        ("Definitions where the chapter and THO disagree",
         "Both carry a definition and they differ. The chapter's wins, "
         "because this guide publishes the chapter."),
    ("discrepancy", "concept.display"):
        ("Displays where the chapter and THO disagree",
         "Both carry a display and they differ beyond whitespace."),
    ("discrepancy", "description (editorial)"):
        ("Descriptions differing only in punctuation",
         "Same words in the same order; only punctuation or spacing moved. "
         "The chapter's text is published and no version is incremented, "
         "which is the versioning policy's editorial-correction carve-out "
         "applied as far as a program honestly can. Recorded so the waiver "
         "can be reversed in one place if TSMG rules otherwise."),
    ("discrepancy", "description"):
        ("Descriptions that differ in what they say",
         "The words themselves differ, so this is not an editorial "
         "correction and it does increment the version."),
    ("discrepancy", "purpose"):
        ("Purposes where the chapter and THO disagree",
         "The purpose is generated from the table number and name, so a "
         "difference here is a disagreement about the table's name."),
    ("discrepancy", "compose.include.concept.display"):
        ("Value set member displays where the chapter and THO disagree", ""),
    ("addition", "concept"):
        ("Codes the chapter lists that THO does not publish",
         "New content this guide contributes."),
    ("addition", "compose.include.concept"):
        ("Value set members the chapter lists that THO does not", ""),
    ("fill", "identifier"):
        ("Identifiers kept from THO",
         "The chapter gives no OID. Publishing without THO's would be "
         "*removing* an identifier, which the policy says needs a whole new "
         "artifact rather than a new version."),
    ("discrepancy", "identifier"):
        ("Identifiers where the chapter and THO disagree",
         "The chapter's OID is published. Under the versioning policy a "
         "changed identifier cannot be expressed as a version at all — it "
         "calls for a new artifact at a new canonical — so each of these "
         "needs resolving before publication."),
    ("addition", "hierarchyMeaning"):
        ("A hierarchy meaning the chapter states and THO omits", ""),
    ("omission", "resource"):
        ("Artifacts THO publishes that this guide does not",
         "Publishing nothing at a canonical destroys nothing -- THO's "
         "artifact stands -- so the merge does not invent one. Listed so "
         "that the silence is deliberate and visible."),
}


def observation_class(record):
    """The class key and human title for one observation."""
    element = record.get("element", "")
    if record.get("property"):
        element = f"{element}:{record['property']}"
    if record.get("editorial"):
        element = f"{element} (editorial)"
    key = (record["kind"], element)
    if key in OBSERVATION_CLASSES:
        title, why = OBSERVATION_CLASSES[key]
    elif (record["kind"], record.get("element", "")) in OBSERVATION_CLASSES:
        title, why = OBSERVATION_CLASSES[(record["kind"], record["element"])]
        if record.get("property"):
            title = f"{title} — {record['property']}"
    else:
        title, why = f"{record['kind']} in {element}", ""
    return f"{record['kind']}:{element}", title, why


def build_fill_report(observe, snapshot, report):
    """Assemble the computable record of the merge.

    Every observation is kept individually under `records`, because the point
    of a computable report is that somebody can ask it a question we have not
    thought of. `classes` is the summary a person reads: one row per kind of
    finding, with a count and the tables it touches.
    """
    classes = {}
    for record in observe.records:
        key, title, why = observation_class(record)
        bucket = classes.setdefault(key, {
            "class": key, "kind": record["kind"],
            "element": record.get("element"), "property": record.get("property"),
            "title": title, "why": why, "count": 0, "tables": set(),
        })
        bucket["count"] += record.get("count", 1)
        if record.get("table"):
            bucket["tables"].add(record["table"])

    summary = []
    for bucket in sorted(classes.values(), key=lambda b: -b["count"]):
        tables = sorted(bucket.pop("tables"))
        bucket["tableCount"] = len(tables)
        bucket["tables"] = tables
        summary.append(bucket)

    versions = Counter()
    judgement = []
    new_artifact = []
    for entry in report:
        for which in ("codeSystemVersion", "valueSetVersion"):
            note = entry.get(which)
            if not note:
                continue
            kind = which.replace("Version", "")
            if note["version"] == versioning.INITIAL_VERSION and not note["triggers"]:
                versions[f"{kind}: first publication at 1.0.0"] += 1
            elif note["incremented"]:
                versions[f"{kind}: incremented"] += 1
            else:
                versions[f"{kind}: unchanged, THO's version kept"] += 1
            if note["judgement"]:
                judgement.append({"table": entry["table"], "resource": kind,
                                  "elements": note["judgement"],
                                  "version": note["version"]})
            if note["newArtifact"]:
                new_artifact.append({"table": entry["table"], "resource": kind,
                                     "elements": note["newArtifact"]})

    return {
        "source": snapshot.provenance(),
        "counts": {
            "observations": len(observe.records),
            "byKind": dict(Counter(r["kind"] for r in observe.records)),
            "versions": dict(versions),
        },
        "classes": summary,
        "needsJudgement": judgement,
        "cannotBeVersioned": new_artifact,
        "records": observe.records,
    }


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("--dry-run", action="store_true",
                        help="Report what would be written without writing it")
    parser.add_argument("--table", action="append", default=None,
                        metavar="NNNN",
                        help="Limit to one table; repeatable")
    parser.add_argument("--utg-repo", default=str(DEFAULT_UTG_REPO),
                        help="A UTG checkout to inherit version, date, work "
                             "group and concept element ids from")
    parser.add_argument("--output-dir", default=str(OUTPUT_DIR),
                        help="Where to write the XML tree")
    parser.add_argument("--no-tho-merge", action="store_true",
                        help="Write only what Chapter 2C says, without "
                             "merging THO's content in or computing versions "
                             "from the versioning policy")
    args = parser.parse_args()

    paths = sorted(VOCAB_DIR.glob("*.json"))
    if args.table:
        wanted = set(args.table)
        paths = [p for p in paths if p.stem in wanted]
        if not paths:
            print(f"No table matched {sorted(wanted)}", file=sys.stderr)
            return 1

    records = [json.loads(p.read_text(encoding="utf-8")) for p in paths]
    excluded = [r for r in records if r["tableNumber"] in EXCLUDED_SECTIONS]
    records = [r for r in records if r["tableNumber"] not in EXCLUDED_SECTIONS]
    for record in excluded:
        print(f"Excluded from the IG: {record['tableNumber']} "
              f"{record.get('tableName', '')} -- "
              f"{EXCLUDED_SECTIONS[record['tableNumber']]}")

    utg = UtgRepo(args.utg_repo)
    oid_index = load_oid_index()
    published_urls = load_published_value_set_urls()
    snapshot = None if args.no_tho_merge else tho_merge.ThoSnapshot()
    if snapshot is not None and not snapshot.available:
        print(f"No THO snapshot at {tho_merge.THO_DIR}; nothing to merge and "
              f"no baseline to version against.", file=sys.stderr)
        return 1
    observe = tho_merge.Observations()

    print(f"Tables read            : {len(records)}")
    print(f"UTG checkout           : "
          f"{'yes, ' + str(len(utg.code_systems)) + ' code systems' if utg.available else 'not found -- using defaults'}")
    print(f"THO OID index          : {len(oid_index)} OIDs")
    print(f"THO value set canonicals: {len(published_urls)} tables")

    if utg.collisions:
        print("\nWARNING: more than one UTG file claims the same table; the "
              "later ones were ignored:")
        for table, file_name in utg.collisions:
            print(f"  {table}  {file_name}")

    if snapshot is not None:
        print(f"THO snapshot           : "
              f"{snapshot.package.get('name')} {snapshot.package.get('version')}")

    files, report = process(records, utg, oid_index, published_urls, snapshot,
                            observe)
    if snapshot is not None and not args.table:
        record_omissions(report, snapshot, observe)

    actions = Counter(entry["action"] for entry in report)
    print("\nWhat the chapter supports:")
    for action, count in sorted(actions.items(), key=lambda kv: -kv[1]):
        print(f"  {count:5d}  {action}")

    written = Counter(path.split("/")[0] for path in files)
    print("\nResources built:")
    for kind, count in sorted(written.items()):
        print(f"  {count:5d}  {kind}")

    defaulted = [e for e in report if e.get("usedDefaultVersion")]
    if defaulted:
        print(f"\nVersion fell back to {DEFAULT_VERSION} (no UTG resource to "
              f"inherit from), {len(defaulted)}:")
        print("  " + ", ".join(e["table"] for e in defaulted))

    reclassifications = reclassification_summary(report)
    if reclassifications["count"]:
        print(f"\nPublished against the chapter's classification on a "
              f"committee ruling, {reclassifications['count']}:")
        for entry in report:
            block = entry.get("ruledReclassification")
            if block:
                print(f"  {block['table']}  -> {entry['action']}  "
                      f"({block['registerItem']})")
        if reclassifications["unresolvedSystems"]:
            print(f"  WARNING: the code system is unresolved for "
                  f"{', '.join(reclassifications['unresolvedSystems'])}. "
                  f"Those value sets cannot expand:")
            for table in reclassifications["unresolvedSystems"]:
                print(f"    {table}: "
                      f"{RULED_RECLASSIFICATIONS[table].unresolved}")

    suppressions = suppression_summary()
    if suppressions["count"]:
        print(f"\nWithheld on a committee ruling, {suppressions['count']}:")
        for entry in report:
            if entry["action"] == "suppressed-by-ruling":
                print(f"  {entry['table']}  ({entry['registerItem']})")

    supersessions = supersession_summary()
    if supersessions["count"]:
        print(f"\nRetired and pointed at a replacement on a committee "
              f"ruling, {supersessions['count']}:")
        for entry in report:
            block = entry.get("ruledSupersession")
            if block:
                print(f"  {block['table']}  -> retired, see "
                      f"{block['replacementName']}  "
                      f"({block['registerItem']})")

    overrides = tentative_override_summary(report)
    if overrides["count"]:
        print(f"\nDeviating from the chapter while a ruling is pending "
              f"(ADR-0011), {overrides['count']}:")
        for entry in report:
            block = entry.get("tentativeOverride")
            if block:
                print(f"  {block['table']}  -> {entry['action']}  "
                      f"({block['registerItem']})")
        unapplied = sorted(set(overrides["tables"])
                           - set(overrides["appliedThisRun"]))
        if unapplied:
            print(f"  not in this run: {', '.join(unapplied)}")

    unknown_statuses = [e for e in report if e.get("unknownStatuses")]
    if unknown_statuses:
        print(f"\nStatus letters the chapter uses and STATUS_MAP does not "
              f"know ({len(unknown_statuses)} tables). These were written out "
              f"as they stand, into a property whose value set does not "
              f"contain them:")
        for entry in unknown_statuses:
            for anomaly in entry["unknownStatuses"]:
                print(f"  {entry['table']}  {anomaly['code']}  "
                      f"{anomaly['status']!r}")

    undecided = [e for e in report if e["action"] == "needs-decision"]
    if undecided:
        print(f"\nStopped for a decision ({len(undecided)}):")
        grouped = defaultdict(list)
        for entry in undecided:
            grouped[entry["reason"]].append(entry["table"])
        for reason, tables in sorted(grouped.items(), key=lambda kv: -len(kv[1])):
            print(f"  {len(tables):3d}  {reason}")
            print(f"       {', '.join(tables)}")

    fill_report = None
    if snapshot is not None:
        fill_report = build_fill_report(observe, snapshot, report)
        print("\nAgainst THO "
              f"{snapshot.package.get('version')}, "
              f"{fill_report['counts']['observations']} observations:")
        for kind, count in sorted(fill_report["counts"]["byKind"].items(),
                                  key=lambda kv: -kv[1]):
            print(f"  {count:5d}  {kind}")
        print("\nThe classes behind them:")
        for bucket in fill_report["classes"]:
            print(f"  {bucket['count']:5d}  {bucket['title']} "
                  f"({bucket['tableCount']} tables)")
        print("\nVersions:")
        for label, count in sorted(fill_report["counts"]["versions"].items()):
            print(f"  {count:5d}  {label}")
        if fill_report["needsJudgement"]:
            print(f"\nIncremented on an element the policy leaves to human "
                  f"judgement ({len(fill_report['needsJudgement'])}) -- "
                  f"waivable:")
            for item in fill_report["needsJudgement"]:
                print(f"  {item['table']}  {item['resource']}  "
                      f"{', '.join(item['elements'])}")
        if fill_report["cannotBeVersioned"]:
            print(f"\nChanges the policy says cannot be expressed as a "
                  f"version ({len(fill_report['cannotBeVersioned'])}) -- "
                  f"these need a new artifact, not a new version:")
            for item in fill_report["cannotBeVersioned"]:
                print(f"  {item['table']}  {item['resource']}  "
                      f"{', '.join(item['elements'])}")

    if args.dry_run:
        print("\n(dry run — nothing written)")
        return 0

    output_dir = Path(args.output_dir)

    # A suppressed table's artifact from an earlier run has to go. Nothing
    # else prunes this directory -- `stage_vocab_ig.py` mirrors whatever is in
    # it -- so a file left behind here is a file published in the IG, and the
    # ruling would have had no effect on the output it was about.
    #
    # Only the exact paths for suppressed tables are removed. A broader sweep
    # would be wrong under `--table`, where `files` holds one table's output
    # and everything else on disk is still current.
    orphans = []
    for table in sorted(RULED_SUPPRESSIONS):
        for relative in (f"codeSystems/cs-v2-{table}.xml",
                         f"valueSets/vs-v2-{table}.xml"):
            stale = output_dir / relative
            if stale.exists():
                stale.unlink()
                print(f"Removed (withheld on a ruling): {relative}")

    for relative, document in files.items():
        path = output_dir / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(document, encoding="utf-8", newline="\n")

    # Files this run did not write and did not mean to leave. `stage_vocab_ig`
    # mirrors this directory wholesale, so an artifact for a table that has
    # since stopped routing to an artifact -- it became `needs-decision`, or
    # the chapter changed under it -- is published regardless, and nothing
    # upstream would ever mention it again.
    #
    # Reported, not deleted. A full run knows what the corpus should contain,
    # but `--table` and `--dry-run` do not, and a sweep that guessed wrong
    # would delete resources the chain still needs. The count is small enough
    # to act on by hand and loud enough not to be missed.
    if not args.table:
        expected = set(files)
        for subdirectory in ("codeSystems", "valueSets"):
            directory = output_dir / subdirectory
            if not directory.is_dir():
                continue
            for path in sorted(directory.glob("*.xml")):
                relative = f"{subdirectory}/{path.name}"
                if relative not in expected:
                    orphans.append(relative)
        if orphans:
            print(f"\nWARNING: {len(orphans)} file(s) in {output_dir} were "
                  f"not written by this run. They are still staged into the "
                  f"IG. Check whether the table stopped routing to an "
                  f"artifact, and delete them if so:")
            for relative in orphans:
                print(f"  {relative}")

    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_PATH.write_text(
        json.dumps({"counts": dict(actions),
                    "tentativeOverrides": overrides,
                    "ruledSuppressions": suppressions,
                    "ruledReclassifications": reclassifications,
                    "ruledSupersessions": supersessions,
                    "tables": report},
                   indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )

    if fill_report is not None:
        FILL_REPORT_PATH.write_text(
            json.dumps(fill_report, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8",
        )

    print(f"\nXML:    {output_dir}")
    print(f"Report: {REPORT_PATH}")
    if fill_report is not None:
        print(f"THO:    {FILL_REPORT_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
