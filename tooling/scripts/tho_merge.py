#!/usr/bin/env python3
"""Merge THO's published content into what Chapter 2C gives us, additively.

Why this exists
---------------

We publish CodeSystems and ValueSets at THO's own canonical URLs. A canonical
URL is an identifier: publishing at one means "this is that artifact", not
"this is our version of that artifact". So anything THO carries that our output
leaves out is not an omission from a draft -- it is content deleted from the
artifact that URL names.

Comparing the two on 2026-09-17 found 4,855 concept definitions in that
position, plus 1,061 designations and 1,438 concept properties. The cause is
the text policy's rule that a definition is never invented from a display,
which is right about inventing and wrong about discarding: Chapter 2C simply
does not carry definitions, and dropping THO's because the chapter is silent
destroys text somebody wrote.

The stance, agreed 2026-09-17: **where THO has content and Chapter 2C has no
opinion, THO's content survives.** Where both have something and they disagree,
the chapter wins -- this guide publishes the chapter -- and the disagreement is
recorded rather than buried.

What this module does not do
----------------------------

It never creates an artifact. Twenty-one tables have a THO CodeSystem and no
resource in this guide, because ADR-0008 classified them as concept-domain-only
or sent them for a decision. Publishing nothing at a canonical destroys
nothing; THO's artifact stands untouched. Those are reported and left alone.

It never merges a value set's enumerated codes into an "all codes" include, or
the other way round. Those two composes mean different things, and splicing
concepts across the difference would change what the value set says rather than
complete it.

Observations
------------

Everything the merge notices goes into an `Observations` collector as one
record per instance, under four kinds:

  fill         THO had it, the chapter did not, we kept THO's.
  discrepancy  Both had it and they differ. The chapter's value was used.
  addition     The chapter had it and THO does not. Ours is new content.
  omission     THO publishes something this guide does not, and the merge is
               not entitled to invent it.

`fill` records are the only kind that make no difference to the version, since
after a fill the element matches THO exactly. The other three are changes.
"""

import json
import re
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
THO_DIR = PROJECT_ROOT / "tho-r5"

# Values a chapter field can hold that mean "nobody has written this yet".
# Treating these as absent is what lets the merge fill them; treating them as
# content would publish the placeholder over THO's real text. Table 0001 is
# the only one in the corpus today, whose description reads `tbd` against
# THO's two full sentences.
# `none` is deliberately NOT in this set. Seven THO concepts have the display
# `None` and the definition `None` -- table 0063's `NON`, table 0251's `N` and
# five more -- where "None" is the answer, not the absence of one.
PLACEHOLDER_TEXT = {"", "tbd", "t.b.d.", "-", "--", "n/a",
                    # Chapter 2C's own markers for "there is no object here",
                    # which table 0560 carries in a code system block that
                    # nonetheless has five codes under it. THO reproduces the
                    # last of these as the definition of all five 0560 codes.
                    "noobject", "nodescription", "no definition"}


def normalize(value):
    """Collapse whitespace so trivial layout differences are not differences.

    Chapter 2C and THO disagree on runs of spaces in 358 of 396 descriptions
    and in a good many definitions, always because one of them wrapped a line
    where the other did not. That is not a change to the artifact and must not
    cost a version number.
    """
    if value is None:
        return ""
    return re.sub(r"\s+", " ", str(value)).strip()


def is_absent(value):
    """Whether a chapter value counts as "the chapter has no opinion"."""
    return normalize(value).lower() in PLACEHOLDER_TEXT


def words(value):
    """The words in a string, lowercased, with punctuation discarded."""
    return re.findall(r"[0-9a-z]+", (value or "").lower())


def is_editorial(ours, theirs):
    """Whether two texts say the same thing and differ only in punctuation.

    If the two contain exactly the same words in the same order, whatever
    moved was punctuation or spacing, and no reader learns anything different
    from one than from the other.

    This is reported, not acted on. Every description difference is a change
    for versioning purposes; this only says what kind of difference it was.
    """
    return bool(words(ours)) and words(ours) == words(theirs)


class Observations:
    """Everything the merge noticed, one record per instance.

    Records are appended in the order they are found, which is table order,
    then element order within a resource. That makes the JSON report stable
    between runs, so a diff of the report is a diff of the findings.
    """

    def __init__(self):
        self.records = []

    def _add(self, kind, **fields):
        record = {"kind": kind}
        record.update(fields)
        self.records.append(record)

    def fill(self, **fields):
        """THO had it, the chapter did not, we kept THO's."""
        self._add("fill", **fields)

    def discrepancy(self, **fields):
        """Both had it and they differ; the chapter's value was used."""
        self._add("discrepancy", **fields)

    def addition(self, **fields):
        """The chapter has it and THO does not."""
        self._add("addition", **fields)

    def omission(self, **fields):
        """THO publishes something this guide does not."""
        self._add("omission", **fields)

    def for_table(self, table):
        return [r for r in self.records if r.get("table") == table]


class ThoSnapshot:
    """The local THO package, indexed for lookup by table number and by URL.

    Loading is lazy per resource: the snapshot holds 2,000-odd files and a
    single run touches perhaps 850 of them, so parsing on demand and caching
    is both faster and simpler than a bulk load.
    """

    def __init__(self, root=THO_DIR):
        self.root = Path(root)
        self.available = self.root.is_dir()
        self._code_systems = {}
        self._value_sets_by_url = None
        self.package = {}
        package_path = self.root / "package.json"
        if package_path.is_file():
            try:
                self.package = json.loads(package_path.read_text(encoding="utf-8"))
            except json.JSONDecodeError:
                self.package = {}

    def provenance(self):
        """What to put at the top of a report so the numbers can be repeated."""
        return {
            "package": self.package.get("name"),
            "version": self.package.get("version"),
            "date": self.package.get("date"),
            "path": str(self.root),
        }

    def code_system(self, table):
        """THO's CodeSystem for a v2 table number, or None."""
        if not self.available:
            return None
        if table not in self._code_systems:
            path = self.root / f"CodeSystem-v2-{table}.json"
            self._code_systems[table] = _read_json(path)
        return self._code_systems[table]

    def _index_value_sets(self):
        self._value_sets_by_url = {}
        if not self.available:
            return
        for path in sorted(self.root.glob("ValueSet-v2-*.json")):
            resource = _read_json(path)
            if resource and resource.get("url"):
                self._value_sets_by_url[resource["url"]] = resource

    def value_set(self, url):
        """THO's ValueSet at a canonical URL, or None.

        Looked up by URL rather than by table number because four tables are
        published at a `v2-notAllCodes-NNNN` canonical, and the URL is the
        identifier that decides which artifact we are editing.
        """
        if self._value_sets_by_url is None:
            self._index_value_sets()
        return self._value_sets_by_url.get(url)

    def code_system_tables(self):
        """Every v2 table number THO publishes a CodeSystem for."""
        if not self.available:
            return set()
        tables = set()
        for path in self.root.glob("CodeSystem-v2-*.json"):
            match = re.fullmatch(r"CodeSystem-v2-(\d{4})\.json", path.name)
            if match:
                tables.add(match.group(1))
        return tables

    def value_set_urls(self):
        """Every v2 ValueSet canonical THO publishes."""
        if self._value_sets_by_url is None:
            self._index_value_sets()
        return set(self._value_sets_by_url)


def _read_json(path):
    if not path.is_file():
        return None
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, UnicodeDecodeError):
        return None


# --------------------------------------------------------------------------
# Concepts
# --------------------------------------------------------------------------
#
# A concept is carried through the merge as a plain dict rather than as an XML
# node, so that merging is done on values and the XML is built once at the end
# from a settled answer. The shape:
#
#   code          the code, and the key the merge joins on
#   display       string or None
#   definition    string or None
#   designations  list of THO designation objects, passed through untouched
#   properties    list of (code, value_key, value) triples, in emit order
#   elementId     the `id` attribute, inherited where one exists
#   origin        "chapter", "tho" or "both"


def property_triples(concept):
    """Read a THO concept's properties as (code, value_key, value) triples."""
    triples = []
    for prop in concept.get("property") or []:
        code = prop.get("code")
        if not code:
            continue
        for key, value in prop.items():
            if key.startswith("value"):
                triples.append((code, key, value))
                break
    return triples


# Status letters that are not values of the FHIR concept-status property, and
# what this guide publishes instead. `N` ("new in some past release") is not a
# status and decays; V2 Management has ruled it a technical correction, and the
# ruling is about the letter, not about which side of the merge it arrived on.
# `B` is deliberately absent: it is deferred for case-by-case review, so the
# four concepts carrying it keep it. See `esc-status-n-b-undefined`.
INHERITED_STATUS_CORRECTIONS = {"N": "active"}


def correct_inherited_status(triples, observe, table, code):
    """Apply the status ruling to a property taken wholesale from THO.

    A concept the chapter does not carry arrives from THO with THO's own
    properties. Where that includes a status letter this guide has ruled on,
    the ruling applies here too -- publishing `active` for the chapter's `N`
    and `N` for THO's would put two readings of the same letter in one file.

    The change is recorded, not absorbed: it is a place where this guide
    departs from THO, which is exactly what the merge report is for.
    """
    corrected = []
    for prop in triples:
        name, key, value = prop
        replacement = (INHERITED_STATUS_CORRECTIONS.get(value)
                       if name == "status" else None)
        if replacement is None:
            corrected.append(prop)
            continue
        observe.discrepancy(element="concept.property:status", table=table,
                            resource="CodeSystem", code=code,
                            ours=replacement, tho=value, editorial=False,
                            reason="The published letter is not a value of the "
                                   "FHIR concept status property.")
        corrected.append((name, key, replacement))
    return corrected


def row_from_tho(concept, observe=None, table=None):
    """Turn a THO concept into a merge row, keeping everything it carries."""
    triples = property_triples(concept)
    if observe is not None:
        triples = correct_inherited_status(triples, observe, table,
                                           concept.get("code"))
    return {
        "code": concept.get("code"),
        "display": concept.get("display"),
        "definition": concept.get("definition"),
        "designations": list(concept.get("designation") or []),
        "properties": triples,
        "elementId": concept.get("id"),
        "origin": "tho",
    }


def _merge_properties(ours, theirs, observe, context):
    """Union two property lists, the chapter winning a direct disagreement.

    Ordering follows the chapter's properties first, then THO's that the
    chapter does not carry, so that a reader comparing our file to THO's sees
    the chapter's contribution at the top of each concept.
    """
    merged = list(ours)
    ours_by_code = {code: (key, value) for code, key, value in ours}
    theirs_by_code = {code: (key, value) for code, key, value in theirs}

    for code, key, value in theirs:
        if code not in ours_by_code:
            merged.append((code, key, value))
            observe.fill(element="concept.property", property=code,
                         value=value, **context)
            continue
        our_key, our_value = ours_by_code[code]
        if normalize(our_value) != normalize(value) or our_key != key:
            observe.discrepancy(element="concept.property", property=code,
                                ours=our_value, tho=value, **context)

    for code, _key, value in ours:
        if code not in theirs_by_code:
            observe.addition(element="concept.property", property=code,
                             value=value, **context)
    return merged


def merge_concept(chapter_row, tho_concept, observe, context):
    """Merge one code's chapter row with THO's concept for the same code."""
    merged = dict(chapter_row)
    merged["origin"] = "both"

    for element in ("display", "definition"):
        ours = chapter_row.get(element)
        theirs = tho_concept.get(element)
        # Both sides are tested with `is_absent` rather than against None. A
        # chapter row carries "" for a column the chapter does not fill, and
        # THO writes its own placeholders -- all five of table 0560's concepts
        # are defined as "no definition". Testing for None instead reported
        # 266 empty strings as content this guide contributes.
        if is_absent(ours) and is_absent(theirs):
            continue
        if is_absent(theirs):
            observe.addition(element=f"concept.{element}", value=ours,
                             **context)
            continue
        if is_absent(ours):
            merged[element] = theirs
            observe.fill(element=f"concept.{element}", value=theirs, **context)
        elif normalize(ours) != normalize(theirs):
            observe.discrepancy(element=f"concept.{element}", ours=ours,
                                tho=theirs, **context)

    designations = tho_concept.get("designation") or []
    if designations:
        # The chapter has no way to express a translation, so every one of
        # these is a fill; there is no disagreement to have.
        merged["designations"] = list(designations)
        observe.fill(element="concept.designation",
                     languages=sorted({d.get("language") for d in designations
                                       if d.get("language")}),
                     count=len(designations), **context)

    merged["properties"] = _merge_properties(
        chapter_row.get("properties") or [],
        property_triples(tho_concept),
        observe, context)

    if chapter_row.get("elementId") is None and tho_concept.get("id"):
        merged["elementId"] = tho_concept["id"]
    return merged


def merge_concepts(chapter_rows, tho_resource, observe, table):
    """Merge the chapter's concepts with THO's, additively.

    Order: the chapter's codes in the chapter's order, then the codes only THO
    has, in THO's order. Keeping the chapter's order first means the file still
    reads like the chapter it is generated from, and appending rather than
    interleaving keeps the added codes visible as a block instead of scattering
    them through a diff.

    Returns the merged rows.
    """
    tho_concepts = (tho_resource or {}).get("concept") or []
    theirs_by_code = {c.get("code"): c for c in tho_concepts if c.get("code")}
    ours_by_code = {r.get("code") for r in chapter_rows}

    merged = []
    for row in chapter_rows:
        context = {"table": table, "resource": "CodeSystem",
                   "code": row.get("code")}
        counterpart = theirs_by_code.get(row.get("code"))
        if counterpart is None:
            observe.addition(element="concept", value=row.get("display"),
                             **context)
            merged.append(dict(row, origin="chapter"))
        else:
            merged.append(merge_concept(row, counterpart, observe, context))

    for concept in tho_concepts:
        code = concept.get("code")
        if code in ours_by_code:
            continue
        observe.fill(element="concept", table=table, resource="CodeSystem",
                     code=code, value=concept.get("display"))
        merged.append(row_from_tho(concept, observe, table))
    return merged


# --------------------------------------------------------------------------
# Resource-level fields
# --------------------------------------------------------------------------

# The CodeSystem fields the merge is allowed to take from THO. The rest are
# either ours by construction (`purpose`, built from the table number and
# name), fixed house values (`publisher`, `copyright`), or identity (`url`,
# `identifier`) where taking THO's would mean publishing a different artifact.
FILLABLE_CODE_SYSTEM_FIELDS = ("description", "name", "title")
FILLABLE_VALUE_SET_FIELDS = ("description", "name", "title")

# Fields compared for a difference but never filled: a difference here is a
# discrepancy to report and a version to bump, not something to overwrite.
COMPARED_CODE_SYSTEM_FIELDS = (
    "name", "title", "status", "experimental", "description", "purpose",
    "caseSensitive", "hierarchyMeaning", "compositional", "content",
)
COMPARED_VALUE_SET_FIELDS = (
    "name", "title", "status", "experimental", "description",
)


# The publication toolchain that produced Chapter 2C cut value set
# descriptions at roughly 250 characters, mid-word. Where THO carries the same
# description and it continues past the point ours stops, THO holds the words
# the chapter lost -- so this is not the chapter and THO disagreeing, it is the
# chapter being incomplete, and the additive rule already says THO's content
# survives where the chapter has no opinion. A cut sentence has no opinion
# about the words after the cut.
#
# Scoped to `description` deliberately. The defect is a length cap on that
# field. A name or title that happens to be a prefix of THO's is a genuine
# disagreement -- "Vaccines Administered" against "Vaccines Administered Code
# Set" is the chapter saying something different, not something truncated --
# and the chapter wins those.
RECOVERABLE_FIELDS = ("description",)


def is_truncated_prefix(ours, theirs):
    """Whether our text is THO's text cut off mid-sentence.

    Two conditions, both needed. Ours must be a proper prefix of theirs once
    whitespace is folded, so there is no question of the two saying different
    things. And ours must not end in terminal punctuation, because a prefix
    that stops at a completed sentence is THO having *added* a sentence, which
    is a different situation entirely -- `ValueSet/v2-0719` is that case, where
    THO appended a note recording its own error, and the chapter's text is
    complete without it.
    """
    ours, theirs = normalize(ours), normalize(theirs)
    if not ours or not theirs or ours == theirs:
        return False
    return theirs.startswith(ours) and ours[-1] not in '.!?)"\u201d'


def merge_fields(fields, tho_resource, fillable, observe, context):
    """Fill absent resource-level fields from THO and report the rest.

    Args:
        fields: Our field values, as a dict. Mutated copy is returned.
        tho_resource: THO's resource as parsed JSON, or None.
        fillable: The field names THO is allowed to supply.
        observe: The Observations collector.
        context: Keys added to every observation -- table and resource.

    Returns:
        The merged field dict.
    """
    merged = dict(fields)
    if not tho_resource:
        return merged
    for name in fillable:
        theirs = tho_resource.get(name)
        if theirs is None:
            continue
        if is_absent(merged.get(name)) and not is_absent(theirs):
            merged[name] = theirs
            observe.fill(element=name, value=theirs, **context)
        elif (name in RECOVERABLE_FIELDS
              and is_truncated_prefix(merged.get(name), theirs)):
            observe.fill(element=name, value=theirs,
                         reason="The chapter's text stops mid-sentence and "
                                "THO's continues it, so THO holds the words "
                                "the chapter lost.",
                         **context)
            merged[name] = theirs
    return merged


def merge_identifier(our_oid, tho_resource, observe, context):
    """Settle which OID to publish, and say what the policy makes of it.

    Identifiers are the one thing the versioning policy puts outside the
    version system: adding one is an ordinary increment, but changing or
    removing one requires a **new artifact at a new canonical**. So this is
    the comparison most worth getting right, and until now nothing was making
    it at all.

    The additive rule applies as everywhere else -- if THO has an OID and the
    chapter gives none, THO's stands, which is also what keeps us from
    silently removing an identifier.

    **Where both give one and they differ, THO's is published, not the
    chapter's.** This is the one place the "chapter wins" rule does not reach,
    and deliberately so: an identifier is identity rather than content. The
    canonical URL is THO's, and the policy says a published identifier cannot
    be changed at all -- so writing the chapter's OID at THO's canonical would
    not be publishing the chapter faithfully, it would be asserting that this
    is a different artifact. Both conflicts are registered for adjudication
    (`esc-oid-conflicts`), and neither is a version question.

    Returns:
        An ``(oid, changed)`` pair.
    """
    ours = normalize(our_oid)
    if ours in ("", "-"):
        ours = None

    theirs = (tho_resource or {}).get("identifier") or []
    if isinstance(theirs, dict):            # R4 spelled this 0..1
        theirs = [theirs]
    theirs = [i.get("value", "")[len("urn:oid:"):] for i in theirs
              if (i.get("value") or "").startswith("urn:oid:")]

    if not tho_resource or not theirs:
        if ours and tho_resource:
            observe.addition(element="identifier", value=ours, **context)
            return ours, ["identifier.added"]
        return ours, []

    if ours is None:
        observe.fill(element="identifier", value=theirs[0], **context)
        return theirs[0], []

    if ours not in theirs:
        observe.discrepancy(element="identifier", ours=ours, tho=theirs[0],
                            published="tho", **context)
        return theirs[0], []
    return ours, []


def changed_fields(fields, tho_resource, compared, observe, context):
    """Which compared fields differ from THO, reporting each difference.

    Every difference counts as a change, whatever its size. A description
    that gained a comma increments the major version exactly as a reworded
    one does.

    Whether a difference is punctuation-only is still recorded, marked
    `editorial` on the discrepancy. It no longer decides anything -- it is
    there so a reader can see that an increment rests on a comma, which is
    worth knowing even though it does not change the outcome.

    Returns:
        The names of the fields that differ, ignoring whitespace throughout.
    """
    changed = []
    if not tho_resource:
        return changed
    for name in compared:
        ours = fields.get(name)
        theirs = tho_resource.get(name)
        if isinstance(theirs, bool):
            theirs = "true" if theirs else "false"
        if normalize(ours) == normalize(theirs):
            continue
        if theirs is None:
            changed.append(name)
            observe.addition(element=name, value=ours, **context)
            continue
        changed.append(name)
        observe.discrepancy(element=name, ours=ours, tho=theirs,
                            editorial=is_editorial(ours, theirs), **context)
    return changed


def concepts_changed(merged_rows, tho_resource):
    """Whether the merged concept list differs from THO's in any way.

    Compared as a map keyed by code rather than as an ordered list. Order is
    not information in a flat code system -- the chapter and THO order the same
    codes differently in a fair number of tables -- and treating a reshuffle as
    a change would spend a version number on nothing.

    Element ids are excluded for the same reason: `id` is FHIR plumbing that
    UTG allocates from a repository-wide counter, not content, and the policy's
    element table does not list it.
    """
    if not tho_resource:
        return True
    theirs = {c.get("code"): c for c in tho_resource.get("concept") or []}
    ours = {row.get("code"): row for row in merged_rows}
    if set(ours) != set(theirs):
        return True
    for code, row in ours.items():
        counterpart = theirs[code]
        if normalize(row.get("display")) != normalize(counterpart.get("display")):
            return True
        if normalize(row.get("definition")) != normalize(counterpart.get("definition")):
            return True
        if (row.get("designations") or []) != (counterpart.get("designation") or []):
            return True
        ours_props = {(c, normalize(v)) for c, _k, v in row.get("properties") or []}
        their_props = {(c, normalize(v)) for c, _k, v in property_triples(counterpart)}
        if ours_props != their_props:
            return True
    return False


def merge_compose(compose, tho_resource, observe, context):
    """Add codes THO enumerates that the chapter does not, and report the rest.

    Only enumerations are merged, and only against a THO include over the same
    system. An "all codes" include and an enumerated one do not mean the same
    thing, so splicing codes across that difference would change what the value
    set says rather than complete it; where the two shapes disagree the
    difference is reported and our shape stands.
    """
    if not tho_resource:
        return compose

    their_includes = (tho_resource.get("compose") or {}).get("include") or []
    for include in compose["include"]:
        if "concept" not in include:
            continue
        counterpart = next(
            (group for group in their_includes
             if group.get("system") == include["system"]
             and group.get("concept")), None)
        if counterpart is None:
            continue

        ours = {concept["code"]: concept for concept in include["concept"]}
        for concept in counterpart["concept"]:
            code = concept.get("code")
            if code not in ours:
                include["concept"].append(
                    {"code": code, "display": concept.get("display")})
                observe.fill(element="compose.include.concept", code=code,
                             value=concept.get("display"), **context)
            elif (normalize(ours[code].get("display"))
                  != normalize(concept.get("display"))):
                observe.discrepancy(element="compose.include.concept.display",
                                    code=code, ours=ours[code].get("display"),
                                    tho=concept.get("display"), **context)
        theirs = {concept.get("code") for concept in counterpart["concept"]}
        for code in ours:
            if code not in theirs:
                observe.addition(element="compose.include.concept", code=code,
                                 value=ours[code].get("display"), **context)
    return compose


def compose_changed(our_compose, tho_resource):
    """Whether our `compose` differs from THO's, as a whole.

    A compose is compared structurally rather than element by element: the
    policy lists every sub-element with the same disposition, so knowing that
    one of them moved is as much as the version calculation needs.
    """
    if not tho_resource:
        return True
    return _canonical_compose(our_compose) != _canonical_compose(
        tho_resource.get("compose") or {})


def _canonical_compose(compose):
    """A compose reduced to what it says, ignoring layout and ordering."""
    def one(group):
        return (
            group.get("system"),
            group.get("version"),
            tuple(sorted((c.get("code"), normalize(c.get("display")))
                         for c in group.get("concept") or [])),
            tuple(sorted((f.get("property"), f.get("op"), f.get("value"))
                         for f in group.get("filter") or [])),
            tuple(sorted(group.get("valueSet") or [])),
        )
    return (
        compose.get("inactive"),
        tuple(sorted(one(g) for g in compose.get("include") or [])),
        tuple(sorted(one(g) for g in compose.get("exclude") or [])),
    )
