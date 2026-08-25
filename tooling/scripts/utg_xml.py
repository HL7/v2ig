#!/usr/bin/env python3
"""Serialize FHIR resources as XML in the shape the UTG repository uses.

UTG stores its v2 terminology as hand-maintainable XML rather than JSON, and
the files follow a narrow house style. This module reproduces that style
exactly, because our output has to sit alongside 416 existing CodeSystems
without looking foreign to a curator reading a pull request.

The style, read off all 855 files in `input/sourceOfTruth/v2/` on 2026-08-24:

  * XML declaration, then a blank line, then the root element.
  * Root carries `xmlns="http://hl7.org/fhir"` and nothing else.
  * Two-space indent, LF line endings.
  * An element with no children is self-closing: `<code value="F"/>`.
  * No trailing newline at end of file (414 of 416 CodeSystems, 439 of 439
    ValueSets).
  * No `<meta>` and no `<text>` narrative anywhere -- narrative is generated
    downstream rather than stored, so it is not a source of diff noise.
  * An apostrophe inside an attribute is written `&#39;`.

Why a bespoke serializer rather than ElementTree: none of the standard
serializers will do self-closing empty elements, a blank line after the
declaration, no trailing newline, and `&#39;` all at once. The rules are
simple enough that writing them out directly is clearer than fighting a
library into shape.

Byte-exact round-tripping of UTG's existing files is a nice-to-have, not a
requirement -- their curator confirmed on 2026-08-20 that clean diffs are not
something UTG relies on.
"""

XML_DECLARATION = '<?xml version="1.0" encoding="UTF-8"?>'
FHIR_NAMESPACE = "http://hl7.org/fhir"
INDENT = "  "


def escape_attribute(text):
    """Escape a string for use inside a double-quoted XML attribute.

    Non-ASCII characters are left as literal UTF-8. UTG is inconsistent here --
    it has a literal `©` in every copyright statement but `&#xE4;` in the
    German designations -- and literal UTF-8 is both valid and easier to read
    in a diff.

    Tabs and newlines are escaped numerically. XML parsers normalize raw
    whitespace inside attributes to spaces, so a literal newline would not
    survive a round trip.
    """
    replacements = [
        ("&", "&amp;"),   # must be first, or it would double-escape the rest
        ("<", "&lt;"),
        (">", "&gt;"),
        ('"', "&quot;"),
        ("'", "&#39;"),
        ("\t", "&#9;"),
        ("\n", "&#10;"),
        ("\r", "&#13;"),
    ]
    for old, new in replacements:
        text = text.replace(old, new)
    return text


class Node:
    """One XML element.

    A node either carries attributes and no children, in which case it is
    written self-closing, or it carries children, in which case it is written
    across several lines. FHIR XML needs nothing more than that: primitives
    are `<name value="..."/>`, complex types are containers, and an extension
    is a container with a `url` attribute.
    """

    def __init__(self, name, **attributes):
        """Create an element.

        Args:
            name: The element name, for example ``"code"``.
            **attributes: Attribute values, in the order given. An attribute
                whose value is None is dropped, so callers can pass optional
                values without guarding every one.
        """
        self.name = name
        self.attributes = {k: v for k, v in attributes.items() if v is not None}
        self.children = []

    def add(self, child):
        """Append a child element and return it, so calls can be chained."""
        self.children.append(child)
        return child

    def add_value(self, name, value):
        """Append a `<name value="..."/>` primitive, skipping empty values.

        Returns the new node, or None if nothing was added. FHIR has no way to
        represent an empty string, so an absent value and a blank one are the
        same thing and both mean "leave the element out".
        """
        if value is None or value == "":
            return None
        return self.add(Node(name, value=str(value)))

    def render(self, depth=0):
        """Render this element and its children as a list of lines."""
        pad = INDENT * depth
        attributes = "".join(
            f' {name}="{escape_attribute(str(value))}"'
            for name, value in self.attributes.items()
        )
        if not self.children:
            return [f"{pad}<{self.name}{attributes}/>"]

        lines = [f"{pad}<{self.name}{attributes}>"]
        for child in self.children:
            lines.extend(child.render(depth + 1))
        lines.append(f"{pad}</{self.name}>")
        return lines


def render_document(root):
    """Render a root Node as a complete UTG-style XML document.

    The FHIR namespace is added to the root here rather than by the caller, so
    that every document gets it and no document gets it twice.

    Returns:
        The document as a string, with no trailing newline.
    """
    root.attributes = {"xmlns": FHIR_NAMESPACE, **root.attributes}
    return "\n".join([XML_DECLARATION, ""] + root.render())
