#!/usr/bin/env python3
"""Decide what version an artifact carries, from the THO versioning policy.

Source
------

Two TSMG Confluence pages, exported to PDF and read on 2026-09-17:

  THO Artifact Versioning Policy: HL7 Code Systems
      confluence.hl7.org/spaces/TSMG/pages/134947510
  THO Artifact Versioning Policy: HL7 Value Sets
      confluence.hl7.org/spaces/TSMG/pages/139669900

Both were last updated by Jessica Bota on 24 Jan 2025.

The element tables below are transcribed from those pages rather than parsed
from them. The PDFs are Confluence exports that are not checked in, so a parser
would give us a build that only works on one person's machine; and a
transcription can be read and checked against the page by anyone reviewing this
file, which a column-position heuristic cannot.

The rules, in short
-------------------

* **The version format is `n.0.0`.** Minor and patch are always zero. There is
  no such thing as a small change: every change that qualifies at all is a
  major increment.
* **A new artifact starts at `1.0.0`.**
* **An artifact that has not changed keeps the version it already has.** This
  is why the comparison has to be exact about what counts as a change -- a
  spurious difference costs a version number that implementers have to chase.
* **Identifiers are outside the version system entirely.** Changing or removing
  one requires a *new artifact* at a new canonical, not a new version. Adding
  one is an ordinary increment.

Descriptions
------------

A changed `description` is a major increment, on both CodeSystem and ValueSet,
however small the difference is. A comma, a full stop, a reworded clause and a
rewritten paragraph all cost the same single increment. There is no editorial
or improved-clarity exemption and no size threshold, which is what makes the
rule mechanical: this module never has to judge what a difference *means*, only
whether there is one.

TSMG holds this reading for both resource types. Anyone checking the tables
below against the Confluence pages should know that the Code Systems page
prints a qualification beside its `CodeSystem.description` row; that
qualification is not part of the policy, and the row is an unqualified major.
The Value Sets page prints no qualification, and the two pages agree.

Whitespace is a different question and is settled before this module is
reached. The merge collapses runs of whitespace on both sides before comparing,
so two texts that differ only in where a line was wrapped never arrive here as
a difference at all.
"""

# What the policy's four columns mean, as an enum of plain strings.
#
# NEW_ARTIFACT is not a version outcome at all: it says the change is not
# allowed to be expressed as a version, and a new canonical is needed. When one
# of these shows up in a comparison it is an error to escalate, not a number to
# compute.
NEW_ARTIFACT = "new-artifact"
NO_CHANGE = "no-change"
INCREMENT = "increment"
NOT_APPLICABLE = "not-applicable"

# CodeSystem, transcribed from the Code Systems page's "Data element changes"
# table. Elements we never emit (meta, implicitRules, language) are kept so
# that the transcription can be checked against the page row for row.
CODE_SYSTEM_POLICY = {
    "id": NEW_ARTIFACT,
    "meta.versionId": NO_CHANGE,
    "meta.lastUpdated": NO_CHANGE,
    "meta.source": NO_CHANGE,
    "meta.profile": INCREMENT,
    "meta.security": NO_CHANGE,
    "meta.tag": NO_CHANGE,
    "implicitRules": NO_CHANGE,
    "language": NO_CHANGE,
    "url": NEW_ARTIFACT,
    # Changing or removing is a new artifact; adding is an increment. The
    # comparison reports which of the two happened, and `disposition` reads
    # the sub-key.
    "identifier.changed": NEW_ARTIFACT,
    "identifier.removed": NEW_ARTIFACT,
    "identifier.added": INCREMENT,
    "version": NOT_APPLICABLE,
    "name": INCREMENT,
    "title": INCREMENT,
    "status": INCREMENT,
    "experimental": INCREMENT,
    "date": NOT_APPLICABLE,
    "publisher": NOT_APPLICABLE,
    "contact": NOT_APPLICABLE,
    # Any difference at all, down to a comma. See the module docstring.
    "description": INCREMENT,
    "useContext": INCREMENT,
    "jurisdiction": INCREMENT,
    "purpose": INCREMENT,
    "copyright": NOT_APPLICABLE,
    "caseSensitive": INCREMENT,
    # "This is in open discussion and policy will be updated once resolved."
    "valueSet": NOT_APPLICABLE,
    "hierarchyMeaning": INCREMENT,
    "compositional": INCREMENT,
    "versionNeeded": NOT_APPLICABLE,
    # "THO only supports complete for HL7 code systems", so a changed value is
    # a new artifact rather than a version.
    "content": NEW_ARTIFACT,
    "supplements": NOT_APPLICABLE,
    "count": NOT_APPLICABLE,
    "filter": INCREMENT,
    "property": INCREMENT,
    "concept": INCREMENT,
}

# ValueSet, transcribed from the Value Sets page. The compose sub-elements are
# listed individually on the page; they are collapsed here to the two roots
# that our comparison can actually distinguish, because every one of the listed
# leaves carries the same disposition and a finer split would be a distinction
# without a difference.
VALUE_SET_POLICY = {
    "id": NEW_ARTIFACT,
    "meta.versionId": NO_CHANGE,
    "meta.lastUpdated": NO_CHANGE,
    "meta.source": NO_CHANGE,
    "meta.profile": INCREMENT,
    "meta.security": NO_CHANGE,
    "meta.tag": NO_CHANGE,
    "implicitRules": NO_CHANGE,
    "language": NO_CHANGE,
    "url": NEW_ARTIFACT,
    "identifier.changed": NEW_ARTIFACT,
    "identifier.removed": NEW_ARTIFACT,
    "identifier.added": INCREMENT,
    "version": NOT_APPLICABLE,
    "name": INCREMENT,
    "title": INCREMENT,
    "status": INCREMENT,
    "experimental": INCREMENT,
    "date": NOT_APPLICABLE,
    "publisher": NOT_APPLICABLE,
    "contact": NOT_APPLICABLE,
    # Read exactly as the CodeSystem's is: any difference at all.
    "description": INCREMENT,
    "useContext": INCREMENT,
    "jurisdiction": INCREMENT,
    "immutable": NOT_APPLICABLE,
    "purpose": INCREMENT,
    "copyright": NOT_APPLICABLE,
    "compose.lockedDate": NOT_APPLICABLE,
    "compose.inactive": INCREMENT,
    "compose.include": INCREMENT,
    "compose.exclude": INCREMENT,
    "expansion": NOT_APPLICABLE,
}

POLICIES = {
    "CodeSystem": CODE_SYSTEM_POLICY,
    "ValueSet": VALUE_SET_POLICY,
}

INITIAL_VERSION = "1.0.0"


def disposition(resource_type, element):
    """What the policy says about a change to one element.

    Args:
        resource_type: ``"CodeSystem"`` or ``"ValueSet"``.
        element: An element name as the policy table spells it, without the
            resource type prefix -- ``"description"``, ``"compose.include"``.

    Returns:
        One of NEW_ARTIFACT, NO_CHANGE, INCREMENT or NOT_APPLICABLE.
        An element the policy does not list returns INCREMENT, because an
        unlisted element is more likely to be one we have misspelled or the
        policy has not caught up with than one that genuinely does not matter,
        and over-incrementing is the safer of the two mistakes.
    """
    policy = POLICIES[resource_type]
    if element in policy:
        return policy[element]
    # `compose.include.concept.code` and friends are listed as leaves on the
    # Value Sets page but only ever reported by us at the `compose.include`
    # level; fall back to the nearest listed ancestor before giving up.
    parts = element.split(".")
    while len(parts) > 1:
        parts.pop()
        ancestor = ".".join(parts)
        if ancestor in policy:
            return policy[ancestor]
    return INCREMENT


def bump(version):
    """Return the next major version after `version`, in `n.0.0` form.

    A version that is not in `n.0.0` form is not something this module can
    increment safely, so it raises rather than guessing. THO's v2 corpus is
    uniformly `n.0.0`; anything else means the baseline is not what we think.
    """
    parts = version.split(".")
    if len(parts) != 3 or not parts[0].isdigit():
        raise ValueError(f"Not an n.0.0 version: {version!r}")
    return f"{int(parts[0]) + 1}.0.0"


def next_version(resource_type, baseline_version, changed_elements):
    """Work out the version to publish.

    Args:
        resource_type: ``"CodeSystem"`` or ``"ValueSet"``.
        baseline_version: The version THO publishes today, or None when THO
            publishes no such artifact.
        changed_elements: The element names that differ from THO's artifact.

    Returns:
        A dict with:
            version      the version to write
            reason       why, in a phrase fit to put in a report
            incremented  whether the version moved
            triggers     the changed elements that caused the increment
            judgement    always empty. No element in the policy is left to a
                         human ruling, so nothing is ever collected here; the
                         key stays because the merge report and the pages built
                         from it read it by name
            newArtifact  changed elements the policy says cannot be versioned
                         at all -- an escalation, not a number
    """
    if baseline_version is None:
        return {
            "version": INITIAL_VERSION,
            "reason": "THO publishes no such artifact, so this is a first "
                      "publication.",
            "incremented": False,
            "triggers": [],
            "judgement": [],
            "newArtifact": [],
        }

    triggers = []
    new_artifact = []
    for element in changed_elements:
        verdict = disposition(resource_type, element)
        if verdict == INCREMENT:
            triggers.append(element)
        elif verdict == NEW_ARTIFACT:
            new_artifact.append(element)

    if not triggers:
        return {
            "version": baseline_version,
            "reason": "Nothing the policy counts as a change, so THO's "
                      "version stands.",
            "incremented": False,
            "triggers": [],
            "judgement": [],
            "newArtifact": new_artifact,
        }

    named = ", ".join(sorted(set(triggers)))
    return {
        "version": bump(baseline_version),
        "reason": f"Changed: {named}.",
        "incremented": True,
        "triggers": sorted(set(triggers)),
        "judgement": [],
        "newArtifact": new_artifact,
    }
