# Upstream report: `genQAHtml` overflows a signed int on large IGs

**File against:** `HL7/fhir-ig-publisher` — `ValidationPresenter` lives here,
unlike the comparison renderer.

**Status:** drafted 2026-11-10; blank filled 2026-11-13 (see "Outcome with
comparison pages suppressed" at the end). **Ready to file, not yet filed.**

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

## Outcome with comparison pages suppressed

Measured 2026-11-13 (run 6), same publisher 2.1.1, with
`version-comparison` = `n/a` and a cleared `temp/`:

- **`qa.html` writes: 7,247,496 bytes.** No `NegativeArraySizeException`.
- Summary: errors = 3294, warn = 814, info = 89, **broken links = 0**.
- "Checking Output HTML" scanned 9,684 html files in 1 min 30 s; the whole
  publisher run took 15.4 min and peaked at 3 GB of heap.

So this is filed as a **latent scaling defect**: real, and certain to recur
above the threshold, but not affecting this IG now that the comparison pages
are gone. Building the whole page as one `String` puts a hard ceiling on the
size of IG the QA report can describe. It is still worth fixing, and option 1
above (streaming the write) is the fix that removes the ceiling.

Broken links fell from 56,515 to **0**, not by the ~7,300 this draft
expected. The unexplained remainder the earlier draft pointed at came from
the comparison pages too, plus pages from earlier runs that Jekyll copied out
of a stale `temp/` (cleared since). Nothing in the IG's own content was
contributing.
