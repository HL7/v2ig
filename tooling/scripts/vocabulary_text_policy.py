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

# Order matters. The sentence and comma rules run before the display-name
# sweep so that a change is attributed to the most specific decision that
# authorizes it, rather than all of them landing in one undifferentiated
# bucket. The comma rule runs last so it cannot create work for the spacing
# rules.
RULES = (
    # (kind, fields it applies to, function)
    ("double_space_after_period", DESCRIPTIVE_FIELDS,
     lambda t: _collapse(SPACES_AFTER_PERIOD_RE, t)),
    ("double_space_after_sentence_close", DESCRIPTIVE_FIELDS,
     lambda t: _collapse(SPACES_AFTER_SENTENCE_CLOSE_RE, t)),
    ("double_space_after_comma", DESCRIPTIVE_FIELDS,
     lambda t: _collapse(SPACES_AFTER_COMMA_RE, t)),
    ("repeated_space_in_display_name", DISPLAY_NAME_ONLY,
     lambda t: _collapse(REPEATED_SPACES_RE, t)),
    ("dash_spacing", DESCRIPTIVE_FIELDS, normalize_dash_spacing),
    ("missing_comma_after_abbreviation", DESCRIPTIVE_FIELDS,
     add_comma_after_abbreviation),
)

RULE_KINDS = tuple(kind for kind, _, _ in RULES)


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
        if field not in fields:
            continue
        before = text
        text, count = rule(text)
        if count:
            applied.append((kind, count, before, text))
    return text, applied
