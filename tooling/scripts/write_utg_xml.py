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
from utg_xml import Node, render_document  # noqa: E402

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VOCAB_DIR = PROJECT_ROOT / "v291-extracted" / "vocabulary"
THO_DIR = PROJECT_ROOT / "tho-r5"
DEFAULT_UTG_REPO = PROJECT_ROOT / "UTG"
OUTPUT_DIR = PROJECT_ROOT / "v291-fhir" / "utg"
REPORT_PATH = PROJECT_ROOT / "v291-fhir" / "utg-write-report.json"

UTG_V2_SUBPATH = Path("input") / "sourceOfTruth" / "v2"

CS_CANONICAL = "http://terminology.hl7.org/CodeSystem/v2-{table}"
VS_CANONICAL = "http://terminology.hl7.org/ValueSet/v2-{table}"

# Defaults for the publication metadata Chapter 2C does not carry. These are
# UTG's own values, read off their existing files; they are Batch A questions
# that have not been answered, and every one of them is a single edit here.
DEFAULT_VERSION = "3.0.0"
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
        """Pull the table number out of a `cs-v2-0001.xml` style filename."""
        match = re.fullmatch(r"(?:cs|vs)-v2-(.+)\.xml", path.name)
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
            self.value_sets[table] = {
                "version": self._value_of(root, "version"),
                "date": self._value_of(root, "date"),
            }

    def allocate_concept_id(self):
        """Hand out the next unused concept element id."""
        element_id = self.next_concept_id
        self.next_concept_id += 1
        return str(element_id)


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


def classify(record, oid_index):
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
        return {"action": "concept-domain-only",
                "reason": "The code system block is the noObject placeholder, "
                          "so there is no code system (ADR-0008 D11)."}

    if not systems:
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


def build_concept(entry, element_id):
    """Build one `<concept>` from a row of the chapter's coded content."""
    concept = Node("concept", id=element_id)
    concept.add_value("code", entry.get("value"))
    concept.add_value("display", entry.get("displayName"))
    concept.add_value("definition", entry.get("definition"))

    comment = (entry.get("comment") or "").strip()
    if comment:
        prop = concept.add(Node("property"))
        prop.add_value("code", "v2-concComment")
        prop.add_value("valueString", comment)

    raw_status = (entry.get("status") or "").strip()
    status = STATUS_MAP.get(raw_status, raw_status)
    if status:
        prop = concept.add(Node("property"))
        prop.add_value("code", "status")
        prop.add_value("valueCode", status)
    return concept


def build_code_system(record, plan, utg):
    """Build the CodeSystem for a table that owns its code system."""
    table = record["tableNumber"]
    system = (record.get("codeSystems") or [{}])[0]
    metadata = record.get("tableMetadata") or {}
    inherited = utg.code_systems.get(table, {})

    root = Node("CodeSystem")
    root.add_value("id", f"v2-{table}")

    group = inherited.get("workGroup") or work_group_code(metadata.get("Steward"))
    if group:
        extension = root.add(Node(
            "extension",
            url="http://hl7.org/fhir/StructureDefinition/structuredefinition-wg",
        ))
        extension.add_value("valueCode", group)

    # `id` is added by add_common_metadata for the ValueSet, but the CodeSystem
    # puts the work group extension between id and url, so id is added above
    # and the shared helper is given the rest.
    symbolic_name = (system.get("SymbolicName") or "").strip()
    add_common_metadata(
        root,
        resource_id=None,
        url=plan["systemUrl"],
        oid=system.get("Code System OID"),
        version=inherited.get("version") or DEFAULT_VERSION,
        date=inherited.get("date") or DEFAULT_DATE,
        name=pascal_case(symbolic_name),
        title=symbolic_name,
        description=(system.get("Description") or "").strip(),
    )
    root.add_value(
        "purpose",
        f"Underlying Master Code System for V2 table {table} "
        f"({record.get('tableName', '')})",
    )
    root.add_value("copyright", COPYRIGHT)
    root.add_value("caseSensitive", "true")
    if plan.get("hasValueSet"):
        root.add_value("valueSet", VS_CANONICAL.format(table=table))
    root.add_value("hierarchyMeaning", "is-a")
    root.add_value("compositional", "false")
    root.add_value("versionNeeded", "false")
    root.add_value("content", "complete")

    known_ids = inherited.get("conceptIds", {})
    concepts = []
    used_properties = set()
    for entry in record.get("codedContent") or []:
        code = entry.get("value")
        element_id = known_ids.get(code) or utg.allocate_concept_id()
        concept = build_concept(entry, element_id)
        concepts.append(concept)
        for child in concept.children:
            if child.name == "property":
                used_properties.add(child.children[0].attributes["value"])

    for code in ("status", "v2-concComment"):
        if code not in used_properties:
            continue
        definition = PROPERTY_DEFINITIONS[code]
        prop = root.add(Node("property"))
        prop.add_value("code", code)
        prop.add_value("uri", definition["uri"])
        prop.add_value("description", definition["description"])
        prop.add_value("type", definition["type"])

    for concept in concepts:
        root.add(concept)
    return root


def build_value_set(record, plan, utg):
    """Build the ValueSet for a table, composed over `plan["systemUrl"]`.

    The chapter's Content Logical Definition says which shape the compose
    takes. `all codes` includes the whole system; `enumerated per table
    content` lists the table's own rows. Anything else is not interpreted here
    -- `classify` sends those tables to the report instead.
    """
    table = record["tableNumber"]
    value_set = (record.get("valueSets") or [{}])[0]
    inherited = utg.value_sets.get(table, {})
    symbolic_name = (value_set.get("SymbolicName") or "").strip()

    root = Node("ValueSet")
    add_common_metadata(
        root,
        resource_id=f"v2-{table}",
        url=VS_CANONICAL.format(table=table),
        oid=value_set.get("Value Set OID"),
        version=inherited.get("version") or DEFAULT_VERSION,
        date=inherited.get("date") or DEFAULT_DATE,
        name=pascal_case(symbolic_name),
        title=symbolic_name,
        description=(value_set.get("Description") or "").strip(),
    )
    root.add_value("copyright", COPYRIGHT)

    shape = parse_logical_definition(value_set.get("Content Logical Definition"))
    compose = root.add(Node("compose"))

    if shape["kind"] == "filter":
        include = compose.add(Node("include"))
        include.add_value("system", shape["system"])
        criterion = include.add(Node("filter"))
        criterion.add_value("property", "concept")
        criterion.add_value("op", "is-a")
        criterion.add_value("value", shape["isA"])
        if shape["excludeRoot"]:
            # `is-a` includes the concept it is rooted at, so excluding that
            # one code is how "the descendants only" is written.
            exclude = compose.add(Node("exclude"))
            exclude.add_value("system", shape["system"])
            concept = exclude.add(Node("concept"))
            concept.add_value("code", shape["excludeRoot"])
        return root

    include = compose.add(Node("include"))
    include.add_value("system", plan["systemUrl"])
    if shape["kind"] == "enumerated":
        for entry in record.get("codedContent") or []:
            concept = include.add(Node("concept"))
            concept.add_value("code", entry.get("value"))
            concept.add_value("display", entry.get("displayName"))
    return root


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


def process(records, utg, oid_index):
    """Classify every table and build the resources for those that qualify.

    Returns:
        A ``(files, report)`` pair. `files` maps a relative path to its
        rendered XML; `report` is the record of what was decided for every
        table, written whether or not anything was emitted.
    """
    files = {}
    report = []

    for record in records:
        table = record["tableNumber"]
        plan = classify(record, oid_index)
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

        if plan["action"] == "code-system-and-value-set":
            metadata = record.get("tableMetadata") or {}
            if not (utg.code_systems.get(table, {}).get("workGroup")
                    or work_group_code(metadata.get("Steward"))):
                entry["note"] = (
                    f"No work group extension: steward "
                    f"{metadata.get('Steward')!r} is not a work group we map."
                )
            document = render_document(build_code_system(record, plan, utg))
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
                    document = render_document(build_value_set(record, plan, utg))
                    path = f"valueSets/vs-v2-{table}.xml"
                    files[path] = document
                    entry["written"].append(path)

        report.append(entry)
    return files, report


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

    print(f"Tables read            : {len(records)}")
    print(f"UTG checkout           : "
          f"{'yes, ' + str(len(utg.code_systems)) + ' code systems' if utg.available else 'not found -- using defaults'}")
    print(f"THO OID index          : {len(oid_index)} OIDs")

    files, report = process(records, utg, oid_index)

    actions = Counter(entry["action"] for entry in report)
    print("\nWhat the chapter supports:")
    for action, count in sorted(actions.items(), key=lambda kv: -kv[1]):
        print(f"  {count:5d}  {action}")

    written = Counter(path.split("/")[0] for path in files)
    print("\nResources built:")
    for kind, count in sorted(written.items()):
        print(f"  {count:5d}  {kind}")

    undecided = [e for e in report if e["action"] == "needs-decision"]
    if undecided:
        print(f"\nStopped for a decision ({len(undecided)}):")
        grouped = defaultdict(list)
        for entry in undecided:
            grouped[entry["reason"]].append(entry["table"])
        for reason, tables in sorted(grouped.items(), key=lambda kv: -len(kv[1])):
            print(f"  {len(tables):3d}  {reason}")
            print(f"       {', '.join(tables)}")

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

    print(f"\nXML:    {output_dir}")
    print(f"Report: {REPORT_PATH}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
