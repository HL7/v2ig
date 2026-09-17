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
from collections import Counter, defaultdict
from pathlib import Path
from xml.etree import ElementTree

sys.path.insert(0, str(Path(__file__).resolve().parent))
import tho_merge  # noqa: E402
import tho_versioning_policy as versioning  # noqa: E402
from utg_xml import Node, render_document  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
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

# Chapter 2C's status column against the FHIR concept status codes. Blank, D
# and R have unambiguous FHIR equivalents. N and B do not, and UTG passes both
# through as themselves, so we do the same rather than inventing a meaning.
STATUS_MAP = {
    "": "active",
    "D": "deprecated",
    "R": "retired",
    "N": "N",
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


def classify(record, oid_index, snapshot=None):
    """Decide what, if anything, to write for one table.

    Returns:
        A dict with `action` and `reason`, plus whatever the chosen action
        needs -- typically `systemUrl`, the canonical of the code system the
        table's codes actually belong to.
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

    if (domain.get("Concept Domain Only") or "").strip().lower() == "yes":
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
                        name, title, description):
    """Add the publication metadata every UTG v2 resource carries, in order.

    CodeSystem and ValueSet share this whole block and put it in the same
    place, so it is built once. Element order matters: FHIR XML is ordered, and
    a resource whose elements are shuffled will not validate.
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
    root.add_value("status", DEFAULT_STATUS)
    root.add_value("experimental", DEFAULT_EXPERIMENTAL)
    root.add_value("date", date)
    root.add_value("publisher", PUBLISHER)
    contact = root.add(Node("contact"))
    for system, value in (("url", CONTACT_URL), ("email", CONTACT_EMAIL)):
        telecom = contact.add(Node("telecom"))
        telecom.add_value("system", system)
        telecom.add_value("value", value)
    root.add_value("description", description)


def chapter_concept_row(entry, element_id):
    """Turn a row of the chapter's coded content into a merge row.

    The row shape is the one `tho_merge` joins on; see that module for the
    field list. Building rows first and XML afterwards is what lets THO's
    content be merged in on values rather than spliced into a node tree.
    """
    properties = []
    comment = (entry.get("comment") or "").strip()
    if comment:
        properties.append(("v2-concComment", "valueString", comment))

    raw_status = (entry.get("status") or "").strip()
    status = STATUS_MAP.get(raw_status, raw_status)
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
    chapter_rows = [
        chapter_concept_row(entry, known_ids.get(entry.get("value")))
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
        plan = classify(record, oid_index, snapshot)
        entry = {
            "table": table,
            "name": record.get("tableName", ""),
            "action": plan["action"],
            "reason": plan["reason"],
            "written": [],
        }
        for key in ("systemUrl", "resolvedBy", "published", "candidates"):
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
            document = render_document(render_code_system(resolved))
            path = f"codeSystems/cs-v2-{table}.xml"
            files[path] = document
            entry["written"].append(path)

        if plan["action"] in ("code-system-and-value-set", "value-set-only"):
            if not plan.get("hasValueSet"):
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
    for relative, document in files.items():
        path = output_dir / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(document, encoding="utf-8", newline="\n")

    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_PATH.write_text(
        json.dumps({"counts": dict(actions), "tables": report},
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
