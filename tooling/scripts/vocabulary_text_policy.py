#!/usr/bin/env python3
"""The text normalization policy for the V2.9.1 Chapter 2C vocabulary.

Chapter 2C as published is the source, and the governing requirement is
fidelity: the extraction emits what the document says. A change is made only
where a reviewer has decided it cannot alter meaning, and every change is
recorded so it can be seen and reversed.

The rules live here rather than inside the extractor because more than one
script has to agree on them: the extractor applies them, and the
python-docx-vs-LLM comparison has to apply the same policy to both corpuses or
it would report our own deliberate change as a disagreement between the
pipelines.

Rules are applied in the order listed in ``RULES`` and each reports its own
count separately, so the change log can attribute every edit to the decision
that authorized it. See `docs/adr/0008-v291-vocabulary-representation.md` for
the decisions and `v291-extracted/vocabulary-changelog.md` for what each one
changed.

Not handled here: leading and trailing whitespace, which is a plain
``str.strip`` at the point of extraction (ADR-0008 D2).
"""

import re
from collections import namedtuple

# Fields whose content is descriptive prose. Every rule below is confined to
# these unless it says otherwise.
#
# Matching is on the field name alone rather than on the (block, field) pair.
# "Description" means the same thing in all four blocks that carry it --
# concept domain, code system, value set and table metadata -- and the other
# three names occur only in coded content. Keying on the name alone also lets
# the comparison script apply this policy without having to reproduce the
# extractor's block naming.
#
# Deliberately NOT in scope:
#   value                          a code, never prose
#   SymbolicName, Full Name, URI   identifiers
#   Content Logical Definition     a value set expression, not prose
#   where used                     a list of segment references
DESCRIPTIVE_FIELDS = frozenset({
    "Description",     # conceptDomain, codeSystem, valueSet, tableMetadata
    "definition",      # codedContent
    "comment",         # codedContent
    "displayName",     # codedContent
})

DISPLAY_NAME_ONLY = frozenset({"displayName"})

# The fields the general space-collapse rule covers (ADR-0008 D7). Two fields
# that are not prose are included, because the reviewer decided each on its own
# evidence:
#
#   where used                  a comma-separated list of field references.
#                               `SPM-15, SAC-43,  PAC-7` -- the run after the
#                               comma is presentation, exactly as in prose.
#   Content Logical Definition  a value set expression. The one run in Chapter
#                               2C sits between a URL and the word `where`,
#                               where it cannot be significant.
#
# They are NOT in DESCRIPTIVE_FIELDS, because the prose rules -- the comma after
# "e.g.", dash spacing -- have no business editing a reference list or an
# expression.
COLLAPSE_FIELDS = DESCRIPTIVE_FIELDS | frozenset({
    "where used",
    "Content Logical Definition",
})

# Passed as a rule's field set to mean "every field". Used by the two rules
# that repair a corrupt character rather than adjust presentation: a character
# that should not be in the document is no more welcome in an identifier than
# in a sentence.
ANY_FIELD = None

# Every dash-like character that appears in Chapter 2C prose.
DASHES = "-‐‑‒–—−"

# Characters that can close a sentence after the final period: the quote marks
# in both their straight and typographic forms, and the closing brackets. The
# published text really does end sentences with `cannulas.)` followed by two
# spaces.
SENTENCE_CLOSERS = "\"'’”)]"


# --------------------------------------------------------------------------
# Rule 1 -- spaces after a period                                  ADR-0008 D3
# --------------------------------------------------------------------------

# Only the ordinary space character counts. A tab, a newline or a non-breaking
# space after a period is a different irregularity and is reported, not
# changed.
SPACES_AFTER_PERIOD_RE = re.compile(r"(?<=\.) {2,}")

# The same, where a closing quote or bracket sits between the period and the
# spaces. The lookbehind is a fixed two characters, which Python requires.
SPACES_AFTER_SENTENCE_CLOSE_RE = re.compile(
    r"(?<=\.[" + re.escape(SENTENCE_CLOSERS) + r"]) {2,}")

SPACES_AFTER_COMMA_RE = re.compile(r"(?<=,) {2,}")

REPEATED_SPACES_RE = re.compile(r" {2,}")


def _collapse(pattern, text):
    """Replace every match of ``pattern`` with a single space."""
    return pattern.subn(" ", text)


# --------------------------------------------------------------------------
# Rules 7a and 7b -- corrupt characters                            ADR-0008 D7
# --------------------------------------------------------------------------

# A non-breaking space that was encoded as UTF-8 and then read back as
# Latin-1, so the two bytes C2 A0 became the two characters "Â" and NBSP. One
# occurrence, in table 0301.
#
# The rule deletes the stray "Â" and leaves whatever space follows it for the
# later rules to tidy. It has to accept an ordinary space as well as a
# non-breaking one, because the LLM extraction of the same cell substitutes an
# ASCII space for the non-breaking one -- and a rule that repaired one corpus
# but not the other would be reported as a disagreement between the pipelines.
#
# Requiring a space after it is what keeps the rule off a real "Â": a word
# like "Ângstrom" has a letter there, not a space.
MOJIBAKE_NBSP_RE = re.compile("Â(?=[ \u00a0])")

# Characters from the Unicode private use area. These are Symbol- and
# Wingdings-font glyphs that mean nothing outside the font they were typed in:
# Chapter 2C uses U+F06C three times in table 0964 as a list bullet, each one
# followed by a tab. Deleting the character leaves the tab, so the three lines
# read as the indented list they were meant to be -- which is exactly what the
# LLM extraction produced independently.
PRIVATE_USE_AREA_RE = re.compile(r"[\uE000-\uF8FF\U000F0000-\U000FFFFD\U00100000-\U0010FFFD]")

# One or more non-breaking spaces in prose. Chapter 2C picks these up from Word
# hyperlinks and from manual line-break control; none of them is meaningful in
# a FHIR resource, where the renderer decides where lines break.
NBSP_RUN_RE = re.compile(" +")


# A run of spaces sitting immediately before the punctuation that closes a
# clause, where at least one of them is non-breaking. One occurrence, in table
# 0827: the chapter publishes `...for statistical use (M49)`, a non-breaking
# space, then the full stop.
#
# The rule DELETES the run rather than turning it into an ordinary space, and
# that is the whole reason it exists separately from the rule below. Spacing the
# non-breaking space out leaves `(M49) .`, a defect we would have introduced
# ourselves; deleting it gives `(M49).`, which is what the sentence says.
#
# It is confined to runs containing a non-breaking space on purpose. Chapter 2C
# has 19 further places where an ORDINARY space sits before closing punctuation
# (`Placer Applications .`), and those were not this rule's to take: the
# reviewer worked through them one at a time and they are now in
# MANUAL_CORRECTIONS under D14. Only the spaces Word inserted are a rule's
# business.
#
# The lookahead matches the extractor's own detector: punctuation followed by
# whitespace or the end of the value really is closing a clause, where the
# period inside `2p16.3` is not.
NBSP_BEFORE_PUNCTUATION_RE = re.compile(
    r"(?<=\S)"                                  # a real character, not more space
    r"[ \u00a0]*\u00a0[ \u00a0]*"               # spaces, at least one non-breaking
    r"(?=[.,;:](?:\s|$))"                       # punctuation that closes the clause
)


def repair_mojibake_nbsp(text):
    """Drop the stray "Â" from a double-encoded non-breaking space.

    Only the stray letter goes; the space after it stays exactly as it was,
    for the space rules to deal with under their own decisions.
    """
    return MOJIBAKE_NBSP_RE.subn("", text)


def remove_private_use_characters(text):
    """Delete Symbol-font glyphs that carry no meaning outside their font."""
    return PRIVATE_USE_AREA_RE.subn("", text)


def non_breaking_space_to_space(text):
    """Turn every run of non-breaking spaces in prose into one ordinary space."""
    return NBSP_RUN_RE.subn(" ", text)


def remove_nbsp_before_punctuation(text):
    """Delete a non-breaking space that sits against closing punctuation.

    Runs before :func:`non_breaking_space_to_space`, which would otherwise turn
    the space into an ordinary one and leave the defect behind in a new form.
    """
    return NBSP_BEFORE_PUNCTUATION_RE.subn("", text)


# --------------------------------------------------------------------------
# Rules 7c and 7d -- the remaining runs of spaces                  ADR-0008 D7
# --------------------------------------------------------------------------

# A run of spaces at the start of a line. Chapter 2C uses these as an indent
# under an introductory sentence -- table 0396 lists NCPDP code sets that way.
# The indent is structure, not a typo, so it is regularized rather than
# removed: exactly two spaces, whatever was published.
LINE_INITIAL_INDENT_RE = re.compile(r"(?<=\n) {2,}")

INDENT_WIDTH = 2

# A run of spaces held between two quote marks. Table 0496 uses the pair
# `""      ""` as a ditto mark standing for the entry above it, so those spaces
# are the value rather than spacing around it. Collapsing them would turn a
# published (if peculiar) construct into nonsense. Expressed structurally, not
# as a table number, so it holds if the document changes.
DITTO_RUN_RE = re.compile(r'(?<=["“”‘’]) {2,}(?=["“”‘’])')


def collapse_remaining_space_runs(text):
    """Collapse every run of two or more spaces the earlier rules left behind.

    Two runs are left alone, each for a reason that is about what the spaces
    are doing rather than where they appear:

    * a run at the start of a line, which is an indent -- handled by
      :func:`regularize_line_initial_indent`, which runs first;
    * a run between two quote marks, which is a ditto mark.

    Returns:
        A ``(text, count)`` pair, where ``count`` is how many runs collapsed.
    """
    protected = {m.start() for m in DITTO_RUN_RE.finditer(text)}

    changes = 0
    out = []
    last = 0
    for match in REPEATED_SPACES_RE.finditer(text):
        at_line_start = match.start() == 0 or text[match.start() - 1] == "\n"
        if at_line_start or match.start() in protected:
            continue
        out.append(text[last:match.start()])
        out.append(" ")
        last = match.end()
        changes += 1
    out.append(text[last:])
    return "".join(out), changes


def regularize_line_initial_indent(text):
    """Give every indented line exactly two spaces.

    An indent is deliberate structure, so it is kept -- but at a consistent
    width, because three spaces on one line and four on the next is the same
    kind of typesetting noise as a double space after a period.

    An indent that is already two spaces wide is not counted as a change.
    ``re.subn`` would count it, and a change log full of no-op entries would
    make the real ones harder to find.
    """
    indent = " " * INDENT_WIDTH
    changes = 0
    out = []
    last = 0
    for match in LINE_INITIAL_INDENT_RE.finditer(text):
        if match.group(0) == indent:
            continue
        out.append(text[last:match.start()])
        out.append(indent)
        last = match.end()
        changes += 1
    out.append(text[last:])
    return "".join(out), changes


# --------------------------------------------------------------------------
# Rule 5 -- spacing around a dash used as a separator               ADR-0008 D5
# --------------------------------------------------------------------------

# A run of dashes together with whatever ordinary spaces surround it.
DASH_RUN_RE = re.compile(r"( *)([" + re.escape(DASHES) + r"]+)( *)")

# Words that follow a suspended hyphen, where the dash belongs to the word
# before it and is not a separator at all. Chapter 2C carries the German
# "OPS Operationen- und Prozedurenschlussel" fifteen times; the English
# equivalent is "pre- and post-operative".
SUSPENDED_COMPOUND_FOLLOWERS = ("und", "oder", "and", "or")


def _dash_run_is_separator(text, start, end, pre, dash, post):
    """Decide whether a dash run is a separator whose spacing may be fixed.

    A separator sits between two phrases and reads as punctuation. Everything
    else that looks like a dash is part of a value, and inserting spaces around
    it would corrupt the published text. The exclusions below are each drawn
    from a real pattern in Chapter 2C.

    Args:
        text: The whole value.
        start: Index where the run including its spaces begins.
        end: Index just past the run including its spaces.
        pre: The spaces immediately before the dashes.
        dash: The dash characters themselves.
        post: The spaces immediately after the dashes.

    Returns:
        True if the spacing around this run may be normalized.
    """
    if not pre and not post:
        # A tight dash: "HL7-defined", "ICD-10", "UB-04", a URL path segment.
        # 1,843 of the 2,516 dashes in Chapter 2C look like this. Never touched
        # -- adding spaces here would destroy the word.
        return False

    before = text[:start]
    after = text[end:]

    # A bullet or continuation dash at the start of a line, and a dash left
    # dangling at the end of one. "Share To Be Determined -\nCategory to be
    # determined" would otherwise gain a space before the line break.
    if not before or before.endswith("\n"):
        return False
    if not after or after.startswith("\n"):
        return False

    # A minus sign or a signed number: "Deep frozen: -16 to -20( C.".
    if after[:1].isdigit():
        return False

    # The dash of "+/-": "approximately 22 +/- 2 degrees C".
    if before[-1:] in "+/":
        return False

    # A suspended hyphen belonging to the preceding word.
    if not pre and after.split(" ", 1)[0].rstrip(",.;:").lower() \
            in SUSPENDED_COMPOUND_FOLLOWERS:
        return False

    # A dash immediately followed by punctuation is a defect the rule cannot
    # repair: "Default -.will be assumed". Leave it and report it.
    if after[:1] in ".,;:":
        return False

    # "Message is not -conformant", "Emergency -stop". A separator introduces a
    # phrase, and every genuine one in Chapter 2C is followed by a capital
    # letter or a digit -- "RSP -Dispense History Response", "4 -Deprecated".
    # When the following word is lowercase and joined to the dash, the hyphen
    # almost certainly belongs to that word instead, and spacing it out would
    # make the published defect worse rather than better.
    if pre and not post and after[:1].islower():
        return False

    return True


def normalize_dash_spacing(text):
    """Give every separator dash exactly one space on each side.

    Spacing is only ever *adjusted*; a space is never inserted around a dash
    that has none on either side. See :func:`_dash_run_is_separator` for what
    is excluded and why.

    The dash characters themselves are left exactly as published -- an en dash
    stays an en dash, and the four values reading "Results entered -- not
    verified" keep both hyphens. Only the surrounding spaces change.

    Returns:
        A ``(text, count)`` pair, where ``count`` is how many runs changed.
    """
    changes = 0
    out = []
    last = 0
    for match in DASH_RUN_RE.finditer(text):
        pre, dash, post = match.groups()
        if not _dash_run_is_separator(text, match.start(), match.end(),
                                      pre, dash, post):
            continue
        replacement = f" {dash} "
        if replacement == match.group(0):
            continue
        out.append(text[last:match.start()])
        out.append(replacement)
        last = match.end()
        changes += 1
    out.append(text[last:])
    return "".join(out), changes


# --------------------------------------------------------------------------
# Rule 6 -- the comma after "e.g." and "i.e."                       ADR-0008 D6
# --------------------------------------------------------------------------

# Matched only when the abbreviation is followed by a space, which excludes
# both the cases that are already correct ("e.g.,") and the five places where
# a colon introduces a bullet list ("e.g.:"), where a comma would be wrong.
#
# The capitalized forms are matched too. Thirteen values start a sentence with
# "E.g. From school, provider..." -- the same defect, and the replacement keeps
# whichever case was published.
ABBREVIATION_NEEDING_COMMA_RE = re.compile(r"\b([Ee]\.g\.|[Ii]\.e\.)(?= )")


def add_comma_after_abbreviation(text):
    """Insert the missing comma after "e.g." and "i.e.".

    This is the one rule that adds a character rather than adjusting
    whitespace, so it is deliberately narrow: it fires only where the
    abbreviation is followed by a space.
    """
    return ABBREVIATION_NEEDING_COMMA_RE.subn(r"\1,", text)


# --------------------------------------------------------------------------
# The rule chain
# --------------------------------------------------------------------------

# Order matters, for two separate reasons.
#
# *Correctness.* The character repairs run first, because each one produces
# text the later rules then have to tidy: dropping the stray "Â" leaves a
# non-breaking space, turning that into an ordinary space leaves a double space
# after a period. Within the space rules, the indent rule runs before the
# general collapse, which would otherwise eat the indent it is meant to keep.
#
# *Attribution.* The narrow space rules run before the broad ones, so a change
# lands under the most specific decision that authorized it rather than all of
# them falling into one undifferentiated bucket. This is why the display-name
# sweep reports 66 changes and not 74.
# --------------------------------------------------------------------------
# Detectors -- things the policy reports but does not change
# --------------------------------------------------------------------------
#
# These live here rather than in the extractor so that the review report can
# mark the exact spot in a value without keeping its own copy of the pattern.
# A report that highlights the wrong character is worse than one that
# highlights nothing, and two copies of a regex drift.

# A sentence running straight into the next with no space after the period:
# `...within their community.Used in HL7 Version 2.x messages` (table 0821).
#
# Requiring a lowercase letter before, and a capital followed by a lowercase
# after, keeps it off almost everything that legitimately contains a period --
# decimals (`v 2.5`), file extensions (`.pdf`), version numbers, acronyms
# (`HL7.ABC`) and any abbreviation followed by a lowercase word (`e.g. the`).
#
# The match spans the three joined characters rather than the period alone,
# so that the review report can highlight something a reader can actually see.
# A one-character mark in the middle of a 700-character paragraph is not much
# better than no mark.
MISSING_SPACE_AFTER_PERIOD_RE = re.compile(r"[a-z]\.[A-Z](?=[a-z])")

# Characters that mean the period belongs to an address rather than a
# sentence. `Patrick.Revelle@ngc.com` and any URL path would otherwise match.
_ADDRESS_CHARACTERS = frozenset("@/:\\")


def missing_space_after_period_sites(text):
    """Find periods that look like a sentence boundary with the space missing.

    Args:
        text: The value as emitted.

    Returns:
        A list of ``(start, end)`` spans, one per site.

    A dotted identifier such as ``Observation.Code`` or
    ``HealthInformationManagementReason.PurposeOfUse`` is reported too. Nothing
    in the text distinguishes one from a genuine missing space, and guessing
    wrong in a detector means a real defect goes unseen -- so they are listed
    and the reader decides. Two of them in Chapter 2C, one in table 0396 and
    one in 0717, and they are the only two sites the detector still reports:
    the reviewer worked through the other ten and they are repaired
    individually in MISSING_SPACE_CORRECTIONS under ADR-0008 D17.
    """
    if not text:
        return []

    sites = []
    for match in MISSING_SPACE_AFTER_PERIOD_RE.finditer(text):
        # Widen to the whitespace-delimited token the period sits in; if that
        # token looks like an address, the period is part of it.
        start = text.rfind(" ", 0, match.start()) + 1
        end = text.find(" ", match.end())
        token = text[start:end if end != -1 else len(text)]
        if _ADDRESS_CHARACTERS & set(token):
            continue
        sites.append((match.start(), match.end()))
    return sites


# --------------------------------------------------------------------------
# Individual corrections                                          ADR-0008 D14
# --------------------------------------------------------------------------
#
# Not every defect generalizes into a rule. Some of the spaces before closing
# punctuation in Chapter 2C were worth removing and some were not, and the
# difference is not expressible as a pattern -- it is a reviewer looking at
# each one and saying. These are those, recorded individually.
#
# Matching is on a text fragment within a named table, NOT on a location path.
# Two reasons, both learned the hard way:
#
#   * The two extraction pipelines index coded content rows differently -- the
#     value below in table 0003 is row 348 to python-docx and row 347 to the
#     LLM -- so a location key would apply the correction to one corpus and
#     silently miss it in the other, which is the exact failure D6, D7 and D10
#     each produced in a different form.
#   * A fragment that no longer appears is a loud failure. If Chapter 2C is
#     re-extracted and the text has moved, the correction stops firing and the
#     count in the change log drops, rather than quietly editing the wrong
#     cell.
#
# Fragments are matched against the text AFTER the rule chain has run, because
# that is the text the reviewer was reading when they decided.
Correction = namedtuple("Correction", "published corrected why")

MANUAL_CORRECTIONS = {
    "0003": (
        Correction("Successful , with", "Successful, with",
                   "Space before the comma in a display name."),
    ),
    "0119": (
        Correction("Placer Applications .", "Placer Applications.",
                   "Space before the period that ends the comment."),
    ),
    "0356": (
        Correction('Extension Technique". .', 'Extension Technique".',
                   "A second period, preceded by a space, after the period "
                   "that already closed the sentence."),
    ),
    "0396": (
        Correction("2p16.3 . ", "2p16.3. ",
                   "Space before the period that ends the sentence."),
        Correction('"2004" , ', '"2004", ',
                   "Space before the comma. Three identical comments carry "
                   "it, so this fires three times."),
    ),
    "0440": (
        Correction(
            "7.4.1.32-( OBR-32) , 4.5.3.33 and 7.4.1.33 - ( OBR-33) "
            "4.5.3.34 and 7.4.1.34 - ( OBR-34) 4.5.3.35 and 7.4.1.35 - "
            "( OBR-35)",
            "7.4.1.32 - (OBR-32), 4.5.3.33 and 7.4.1.33 - (OBR-33) "
            "4.5.3.34 and 7.4.1.34 - (OBR-34) 4.5.3.35 and 7.4.1.35 - "
            "(OBR-35)",
            "Three defects in one passage of the NDL comment, corrected "
            "together because they overlap: a space after each of four "
            "opening parentheses, a space before the comma after "
            "(OBR-32), and no space around the hyphen in 7.4.1.32-(OBR-32) "
            "where the other three have one. Written out in full rather "
            "than as three narrow fragments, so the diff shows exactly what "
            "the passage becomes."),
    ),
    "0717": (
        Correction(".pdf , ", ".pdf, ",
                   "Space before the comma that follows a URL. Two coded "
                   "rows carry it, HIPAANOPP and HIPAAPsyNotes, once each. "
                   "The line breaks in both values are untouched."),
    ),
    "0952": (
        Correction("Usage Note : ", "Usage Note: ",
                   "Space before the colon that introduces the usage note."),
        Correction("code system .", "code system.",
                   "Space before the period that ends the first sentence of "
                   "the value set description."),
    ),
    "0577": (
        Correction("type of BC Component .", "type of BC Component.",
                   "Space before the period that ends the description."),
    ),
    "0578": (
        Correction("Donation Type / Intended Use .",
                   "Donation Type / Intended Use.",
                   "Space before the period that ends the description."),
    ),
    "0579": (
        Correction("type of BP Blood Group .", "type of BP Blood Group.",
                   "Space before the period that ends the description."),
    ),
    "0580": (
        Correction("type of BC Special Testing .",
                   "type of BC Special Testing.",
                   "Space before the period that ends the description."),
    ),
    "0582": (
        Correction("type of BC Component .", "type of BC Component.",
                   "Space before the period that ends the description."),
    ),
    "0604": (
        Correction("type of Modality .", "type of Modality.",
                   "Space before the period that ends the description."),
    ),
    "0785": (
        Correction("type of Container Type .", "type of Container Type.",
                   "Space before the period that ends the description."),
    ),
}


# --------------------------------------------------------------------------
# The missing space after a period                                ADR-0008 D17
# --------------------------------------------------------------------------
#
# D16 built MISSING_SPACE_AFTER_PERIOD_RE as a detector and repaired nothing,
# on the grounds that inserting a character is a bigger licence than removing
# one. The reviewer then read the twelve sites it found and decided ten of
# them: they are sentence boundaries that lost their space in publication, and
# the space goes back in.
#
# The other two are NOT defects and are deliberately absent from this table:
#
#   0396  `...passed in HL7 OBX-3 or Observation.Code`
#   0717  `...ActHealthInformationManagementReason.PurposeOfUse`
#
# Both are dotted identifiers, where a space would corrupt the name. The
# detector still reports them, because nothing in the text tells an identifier
# apart from a sentence boundary and a reader should be able to see that the
# question was asked and answered.
#
# This is a separate table from MANUAL_CORRECTIONS rather than more entries in
# it, so that each change lands under the decision that authorized it -- the
# same reason the rule chain runs its narrow rules before its broad ones.
#
# Kept as individual corrections rather than a rule for the reason D16 gave and
# these ten do not overturn: no pattern separates the ten from the two. The
# word before the period is lowercase in some real ones (`identifier.Retained`)
# and capitalized in others (`Codes.This`), which is also true of the two
# identifiers, so the only reliable test is a reader looking at the sentence.
MISSING_SPACE_CORRECTIONS = {
    "0301": (
        Correction("identifier.Retained", "identifier. Retained",
                   "The sentence that begins \"Retained for backward "
                   "compatibility\" runs into the one before it. Four coded "
                   "rows carry the identical comment, so this fires four "
                   "times."),
        Correction("bits.Retained", "bits. Retained",
                   "The same sentence in a fifth row, after a different "
                   "opening clause."),
    ),
    "0396": (
        Correction("vocabulary.RxNorm", "vocabulary. RxNorm",
                   "The closing sentence of the RxNorm comment runs into the "
                   "one before it."),
    ),
    "0399": (
        Correction("Codes.This", "Codes. This",
                   "The code system description opens with the title \"ISO "
                   "3166 Part 1 Country Codes\" and runs straight into the "
                   "sentence after it."),
    ),
    "0454": (
        Correction("unit.Health", "unit. Health",
                   "The table description runs into the phrase \"Health Care "
                   "Provider Area of Specialization\"."),
    ),
    "0719": (
        Correction("permitted.Code", "permitted. Code",
                   "The code system description runs into the sentence "
                   "beginning \"Code system of concepts\". Only python-docx "
                   "can see this one: the LLM truncated the value well before "
                   "this point, and it is one of the 14 known truncations."),
    ),
    "0821": (
        Correction("community.Used", "community. Used",
                   "The value set description runs into the sentence "
                   "beginning \"Used in HL7 Version 2.x messages\"."),
    ),
}


# --------------------------------------------------------------------------
# Emphasis added on a committee ruling
# --------------------------------------------------------------------------
#
# Not corrections. The two tables above repair text that is wrong -- a space
# before a comma, a missing space after a period -- and both are defensible
# as technical corrections because they do not change what the text says.
# These change what the text *emphasises*, at a committee's explicit
# direction, and that is a different kind of act which should not hide inside
# a table called CORRECTIONS.
#
# The distinction matters for the change log: a reader auditing this guide's
# departures from the published chapter should be able to separate "we fixed
# a typo" from "a committee told us to make something stand out". The first
# needs no authority beyond the errata guidance; the second needs a named
# ruling, and every entry here carries one.
#
# Markdown is deliberate. These descriptions are rendered as markdown by the
# IG Publisher, so `**text**` reaches the reader as bold. That is the whole
# mechanism the ruling asked for -- see `esc-0133-contradictory`.
EMPHASIS_ADDED = {
    "0133": (
        Correction(
            "Note that as of v2.6, this table and the field(s) it was used "
            "in was replaced by table 443 used in the ROL segment.",
            "**This table was discontinued as of v2.6 and replaced by table "
            "0443, used in the ROL segment.** Note that as of v2.6, this "
            "table and the field(s) it was used in was replaced by table 443 "
            "used in the ROL segment.",
            "V2 Management, 2026-10-14: make it jump out that this is a "
            "discontinued code system, replaced as of v2.6. The original "
            "sentence is kept after the added one rather than rewritten, so "
            "the chapter's own wording is still there to compare against and "
            "nothing published is removed."),
        Correction(
            "The domain of possible values of concepts which specify the "
            "different types of practitioners associated with this "
            "procedure.",
            "The domain of possible values of concepts which specify the "
            "different types of practitioners associated with this "
            "procedure. **Table 0133 was discontinued as of v2.6 and "
            "replaced by table 0443, used in the ROL segment.**",
            "The same warning on the concept domain description, which is "
            "a different field from the one above. It is needed because "
            "0133 is concept-domain-only: the concept domain entry is the "
            "*only* artifact this guide publishes for the table, so a "
            "warning that reached the table description alone would appear "
            "on the review pages and nowhere a reader of the published "
            "guide would meet it."),
    ),
}


# Every table of individual corrections, with the rule kind each one reports
# under. The kind is what the change log and the review report use to attribute
# a change to its decision, so a new table needs a new kind, not a reused one.
CORRECTION_TABLES = (
    ("manual_correction", MANUAL_CORRECTIONS),
    ("missing_space_correction", MISSING_SPACE_CORRECTIONS),
    ("emphasis_added", EMPHASIS_ADDED),
)

# The kinds the tables above report under. Callers that count or describe every
# kind of change should use this rather than naming the kinds themselves, so a
# new correction table cannot be added without appearing in the change log.
CORRECTION_KINDS = tuple(kind for kind, _ in CORRECTION_TABLES)


def apply_manual_corrections(table, text):
    """Apply the individual corrections recorded for one table.

    Runs after the rule chain, and must be applied to BOTH extraction corpuses
    for the same reason every other character-level change must be.

    Args:
        table: The Chapter 2C table number, e.g. ``'0119'``.
        text: The value after :func:`apply_text_policy`.

    Returns:
        A ``(text, applied)`` pair in the same shape :func:`apply_text_policy`
        returns, so callers can log both the same way.
    """
    if not text:
        return text, []

    applied = []
    for kind, corrections in CORRECTION_TABLES:
        for correction in corrections.get(table, ()):
            places = text.count(correction.published)
            if not places:
                continue
            before = text
            text = text.replace(correction.published, correction.corrected)
            applied.append((kind, places, before, text))
    return text, applied


RULES = (
    # (kind, fields it applies to, function)
    ("mojibake_non_breaking_space", ANY_FIELD, repair_mojibake_nbsp),
    ("private_use_area_character", ANY_FIELD, remove_private_use_characters),
    # Ahead of the general non-breaking-space rule: a non-breaking space
    # against closing punctuation is deleted (D10), not spaced out.
    ("nbsp_before_punctuation", COLLAPSE_FIELDS, remove_nbsp_before_punctuation),
    ("non_breaking_space_in_text", COLLAPSE_FIELDS, non_breaking_space_to_space),
    ("double_space_after_period", DESCRIPTIVE_FIELDS,
     lambda t: _collapse(SPACES_AFTER_PERIOD_RE, t)),
    ("double_space_after_sentence_close", DESCRIPTIVE_FIELDS,
     lambda t: _collapse(SPACES_AFTER_SENTENCE_CLOSE_RE, t)),
    ("double_space_after_comma", DESCRIPTIVE_FIELDS,
     lambda t: _collapse(SPACES_AFTER_COMMA_RE, t)),
    ("repeated_space_in_display_name", DISPLAY_NAME_ONLY,
     lambda t: _collapse(REPEATED_SPACES_RE, t)),
    # Dash spacing stays ahead of the general collapse. It is the more
    # specific rule -- it knows a separator dash from a hyphen -- and putting
    # the collapse first would silently absorb five of its changes, moving them
    # from D5's count into D7's.
    ("dash_spacing", DESCRIPTIVE_FIELDS, normalize_dash_spacing),
    ("line_initial_indent", COLLAPSE_FIELDS, regularize_line_initial_indent),
    ("repeated_space_collapsed", COLLAPSE_FIELDS, collapse_remaining_space_runs),
    ("missing_comma_after_abbreviation", DESCRIPTIVE_FIELDS,
     add_comma_after_abbreviation),
)

RULE_KINDS = tuple(kind for kind, _, _ in RULES)


def unresolved_space_runs(field, text):
    """Find runs of two or more spaces the rules left in the emitted text.

    The extractor reports what is still outstanding after the policy has run,
    and a reader needs to know *why* a run survived: a run nobody has decided
    about is a different thing from one a decision deliberately protects.

    Args:
        field: The field name the text came from.
        text: The value as emitted, after :func:`apply_text_policy`.

    Returns:
        A list of ``(start, end, reason)`` tuples. ``reason`` is one of:

        ``'ditto'``
            Held between two quote marks, so the spaces are the value. Table
            0496's ditto marks; protected by ADR-0008 D7.
        ``'indent'``
            At the start of a line, so it is an indent. Regularized to two
            spaces by D7 rather than removed.
        ``'not_in_scope'``
            In a field no collapse decision covers -- an identifier, a code, a
            full name. Nobody has decided about these.
    """
    if not text:
        return []

    ditto_starts = {m.start() for m in DITTO_RUN_RE.finditer(text)}
    in_scope = field in COLLAPSE_FIELDS

    runs = []
    for match in REPEATED_SPACES_RE.finditer(text):
        if not in_scope:
            reason = "not_in_scope"
        elif match.start() in ditto_starts:
            reason = "ditto"
        elif match.start() == 0 or text[match.start() - 1] == "\n":
            reason = "indent"
        else:
            # The collapse rule covers this field and none of the protections
            # apply, so the rule already took it. Reaching here would mean a
            # bug in the chain.
            reason = "not_in_scope"
        runs.append((match.start(), match.end(), reason))
    return runs


def is_descriptive_field(field):
    """Say whether a field holds descriptive prose the policy may touch.

    Args:
        field: The field name on its own, e.g. ``'Description'``. Callers
            holding a full location path such as ``'codedContent[12].comment'``
            should split it first.
    """
    return field in DESCRIPTIVE_FIELDS


def apply_text_policy(field, text):
    """Run every rule that applies to this field, in order.

    Args:
        field: The field name, as accepted by :func:`is_descriptive_field`.
        text: The value to normalize. An absent or empty value is returned
            unchanged rather than being turned into the other.

    Returns:
        A ``(text, applied)`` pair. ``applied`` is a list of
        ``(kind, count, before, after)`` for each rule that changed something,
        where ``count`` is how many separate places that rule changed, and
        ``before``/``after`` bracket that rule alone. Rules that changed
        nothing are omitted.

        Reporting each rule's own before and after, rather than the published
        text against the final text, is what lets the review report show a
        reader exactly what one decision did to a value that several decisions
        touched.
    """
    if not text:
        return text, []

    applied = []
    for kind, fields, rule in RULES:
        if fields is not ANY_FIELD and field not in fields:
            continue
        before = text
        text, count = rule(text)
        if count:
            applied.append((kind, count, before, text))
    return text, applied
