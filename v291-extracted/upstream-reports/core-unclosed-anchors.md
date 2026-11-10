# Upstream report: unclosed `<a>` tags in comparison output

**File against:** `hapifhir/org.hl7.fhir.core` — **not** `HL7/fhir-ig-publisher`.
The comparison renderer lives in `org.hl7.fhir.r5.comparison`.

**Status:** drafted 2026-11-10, not yet filed. Searched both repos' issue
trackers and found nothing matching; chat.fhir.org is Zulip and could not be
searched, so "unreported" is not established.

**Versions this was verified against:** `org.hl7.fhir.r5-6.8.1.jar`, as
shipped inside IG Publisher CLI `2.1.1` (built 2026-02-19). Verified by
disassembling that jar, not by reading master — see the note on class
locations below.

---

## Title

Comparison output emits unclosed `<a>` tags, nesting XHTML ~4,300 levels deep

## Body

Generated version-comparison pages contain thousands of unclosed `<a>` tags.
Every such tag is an extra nesting level to a tolerant parser, so the
publisher's own `XhtmlParser` recurses ~4,300 frames deep on these pages and
overflows the default 1 MB JVM stack during "Checking Output HTML" — after a
complete and valid IG has already been written.

Measured on one real page, `comparison-v7.3.0/index.html`:

| | |
|---|---|
| Opening `<a …>` | 6,733 |
| Closing `</a>` | 2,439 |
| **Unclosed** | **4,294** |
| Peak nesting depth | 4,294 |
| Every other file in the output | ≤ 19 |

The ratio is stable across pages: a `comparison-v7.5.0/index.html` from the
same corpus measured 6,748 against 2,442.

### Two distinct causes

**1. `refCell` — the per-row common path.** On the class
`ResourceComparer$ResourceComparison` in 6.8.1 (see note below), the
`hasWebPath()` branch builds an anchor cell and returns without ever closing
the anchor:

```java
return "<td><a href=\"" + (Utilities.isAbsoluteUrl(p) ? "" : "../") + p + "\">"
     + Utilities.escapeXml(t) + "</td>";
```

Confirmed in bytecode at offsets 24–60 of `refCell`: the
`makeConcatWithConstants` recipe that assembles this cell contains no `</a>`.
This runs once per resource row, which is what makes the count large.

**2. `PlaceHolderComparison` — a typo.** The string sits in the constant pool
verbatim as:

```
.html">Failed<a></td>
```

`<a>` where `</a>` was meant, so it opens a second anchor instead of closing
the first. This path only fires when an individual comparison fails, so it
contributes far fewer instances than `refCell`.

**Both need fixing.** Correcting only the typo would leave the systemic one,
which produces the overwhelming majority of the unclosed tags.

### Corroboration from the arithmetic

`CanonicalResourceComparer$CanonicalResourceComparison` emits properly closed
anchors (`…">Comparison</a></td>`, `…-union.html">Union</a></td>`, and so on).
Those account for the 2,439 closed tags; the ~4,294 unclosed ones come from
`refCell`. The split matches the two code paths exactly.

### Note on class locations

In current master these methods appear on `ResourceComparer` itself. In 6.8.1
they are on the inner classes `ResourceComparer$ResourceComparison.refCell`
and `ResourceComparer$PlaceHolderComparison`. Same defects, different
location — worth checking which applies before patching.

### The cost is not only the stack — it is quadratic work

The nesting depth is also a performance defect, which is easy to miss
because the stack overflow is the louder symptom. A thread dump of a build
processing these pages shows the main thread RUNNABLE, burning CPU
one-for-one with wall clock, ~983 frames deep in a single line:

```
org.hl7.fhir.utilities.xhtml.XhtmlNode.allText(XhtmlNode.java:399)
  ... repeated ...
org.hl7.fhir.igtools.publisher.ConformanceStatementHandler
    .processMarkdownConformanceClauses(ConformanceStatementHandler.java:883)
```

`allText` recurses once per nesting level, so every pass that walks the DOM
of a ~4,300-deep page does work proportional to that depth at every node.
In our build the output HTML check over 29,024 files — of which three were
these pages — ran for over 45 minutes without emitting a line, and an
earlier run's equivalent step took 96 minutes. With the pages absent, the
same step completed in **3.5 seconds**.

So raising `-Xss` makes the build survive these pages; it does not make
them affordable. Well-formed output would fix both.

### Impact

Any IG whose canonical resolves to a package with published releases gets one
comparison directory per release, so the number of ~4,300-deep pages grows
with the dependency's release history rather than with anything in the IG. A
build that succeeds today can fail later with no local change: ours did,
surviving one such page in September 2026 and overflowing on three in
November. `-Xss16m` works around it; well-formed output would not need one.

---

## What we did locally, for context

We suppressed the pages entirely with `version-comparison` = `n/a`, since the
comparison was meaningless for us — our IG has never been published, so it was
diffing against an unrelated package's releases. That removes our exposure but
not the defect.
