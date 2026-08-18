#!/usr/bin/env python3
"""The text normalization policy for the V2.9.1 Chapter 2C vocabulary.

Chapter 2C as published is the source, and the governing requirement is
fidelity: the extraction emits what the document says. Only changes that
cannot alter meaning are made automatically, and every one of them is
recorded so a reviewer can see it.

Two normalizations are currently in force. They are collected here, rather
than inside the extractor, because more than one script has to agree on them:
the extractor applies them, and the python-docx-vs-LLM comparison has to apply
the same policy to both corpuses or it would report our own deliberate change
as a disagreement between the pipelines.

1. Leading and trailing whitespace is stripped (ADR-0008 D2).

2. Two or more spaces following a period are collapsed to one, in descriptive
   text only (ADR-0008 D3). This module owns rule 2; rule 1 is a plain
   ``str.strip`` at the point of extraction.

Everything else the published text does -- internal double spaces that do not
follow a period, non-breaking spaces, embedded newlines, typographic dashes
and quotes -- is preserved exactly and merely reported.
"""

import re

# Fields whose content is descriptive prose, where the space following a
# sentence-ending period is presentation rather than data.
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

# A period followed by two or more ordinary spaces. Only the space character
# counts: a tab, a newline or a non-breaking space after the period is a
# different irregularity and is reported rather than changed.
SPACES_AFTER_PERIOD_RE = re.compile(r"(?<=\.) {2,}")


def is_descriptive_field(field):
    """Say whether a field holds descriptive prose subject to the period rule.

    Args:
        field: The field name on its own, e.g. ``'Description'`` or
            ``'displayName'``. Callers holding a full location path such as
            ``'codedContent[12].displayName'`` should split it first.

    Returns:
        True if the period rule applies to this field.
    """
    return field in DESCRIPTIVE_FIELDS


def collapse_spaces_after_period(text):
    """Collapse runs of two or more spaces that follow a period.

    This is the one place the rule is implemented, so the extractor and the
    cross-pipeline comparison cannot drift apart.

    Args:
        text: The published text, already stripped of surrounding whitespace.

    Returns:
        A ``(collapsed_text, run_count)`` pair, where ``run_count`` is how many
        separate runs of spaces were collapsed. A value with three sentences
        spaced this way counts as two runs, not one, so the change log can
        report characters changed as well as values changed.
    """
    collapsed, count = SPACES_AFTER_PERIOD_RE.subn(" ", text)
    return collapsed, count


def normalize_descriptive_text(field, text):
    """Apply the period rule to a value if its field is in scope.

    Args:
        field: The field name, as accepted by :func:`is_descriptive_field`.
        text: The value to normalize.

    Returns:
        A ``(text, run_count)`` pair. When the field is out of scope, or the
        value is empty or absent, the text is returned unchanged with a count
        of zero. An absent value stays absent rather than becoming an empty
        string, so a caller cannot lose the distinction.
    """
    if not text or not is_descriptive_field(field):
        return text, 0
    return collapse_spaces_after_period(text)
