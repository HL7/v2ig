# Upstream report: `genQAHtml` overflows a signed int on large IGs

**File against:** `HL7/fhir-ig-publisher` — `ValidationPresenter` lives here,
unlike the comparison renderer.

**Status:** drafted 2026-11-10, **not yet filed — one blank to fill.** See
"Before filing" at the end.

**Version:** IG Publisher CLI `2.1.1`, built 2026-02-19.

---

## Title

`genQAHtml` builds qa.html as one String and throws
`NegativeArraySizeException` on large IGs

## Body

On a large IG the publisher completes the entire build — validation passes,
every page is written, the package builds — and then dies writing `qa.html`:

```
java.lang.NegativeArraySizeException: -1360072342
  at java.lang.String.encodeUTF8_UTF16(String.java:1288)
  at java.lang.String.getBytes(String.java:1788)
  at org.hl7.fhir.utilities.FileUtilities.stringToFile(FileUtilities.java:86)
  at org.hl7.fhir.igtools.renderers.ValidationPresenter.genQAHtml(ValidationPresenter.java:916)
```

`genQAHtml` accumulates the whole QA page into a single `StringBuilder` and
makes one `FileUtilities.stringToFile(b.toString(), path)` call at the end.
`getBytes(UTF-8)` sizes its destination array at up to three bytes per char,
and on a large enough page that multiplication overflows a signed 32-bit int.

Read as unsigned, `-1360072342` is **2,934,894,954 bytes — 2.73 GiB**, which
is 787 MB past `Integer.MAX_VALUE`.

### Why this is a ceiling rather than a tuning problem

A Java array cannot be longer than `Integer.MAX_VALUE`, so no heap size
helps. We confirmed that the hard way: at `-Xmx8g` the same method threw
`OutOfMemoryError`; raising it to `-Xmx12g` got past the shortage (the run
peaked around 7 GB) and produced the overflow above instead. 32 GB would
throw the identical exception.

### Two secondary effects worth fixing alongside

**A zero-byte `qa.html` is left behind.** `stringToFile` creates the file
before the encode throws, so the output directory ends up with an empty
`qa.html`. Anything testing `exists()` — including downstream tooling and CI
— reads that as a successful build. A failed write would be better off
removing the partial file.

**The failure is unguarded.** There is no size check before the write and no
`try`/`catch` around it, so a multi-hour build is lost at the final step with
no partial QA output and no actionable message.

### Suggested fixes, in preference order

1. **Stream the write.** Use a `Writer` and append incrementally rather than
   materialising `b.toString()`. This removes the ceiling rather than moving
   it, and is the only option that scales.
2. **Paginate `qa.html`** above some file-count or message-count threshold.
3. **At minimum, fail cleanly** — check the length before encoding, emit a
   diagnostic naming the size, and delete the partial file.

### Context on how we got there

The IG is ~800 terminology resources, but the page size came from broken-link
reporting rather than from the resources: the run reported 56,515 broken links
of 677,466 checked. Most of those originated in the publisher's own generated
comparison directories — see the companion report on unclosed `<a>` tags
against `hapifhir/org.hl7.fhir.core`. So the two defects compound: one
generates malformed output at volume, the other cannot serialise the report
about it.

---

## Before filing

Fill in the outcome of the run with comparison pages suppressed
(`version-comparison` = `n/a`), which removed ~7,300 of the broken links.
Two possibilities, and they want different framing:

- **If `qa.html` now writes:** the report stands as a latent scaling defect —
  real, architecturally guaranteed above the threshold, but not currently
  biting anyone. Say so honestly; it is still worth fixing.
- **If it still overflows:** the page is large for a reason not yet
  identified, and that is a stronger report. 56,515 total broken links
  exceeded the 12,284 missing *local* targets we could account for, so the
  unexplained remainder is where to look first.

Do not file with this section unresolved.
