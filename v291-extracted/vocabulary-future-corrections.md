# Chapter 2C vocabulary — the second pass

**What this file is for.** Step one is to load the V2.9.1 Chapter 2C vocabulary
into THO as a *high-fidelity representation of what was published*. This file
is the list of things to come back to **after** that, when the content itself
can be improved rather than merely carried across faithfully.

Nothing here is a bug in the extraction, and nothing here should be acted on
during the fidelity load. Each entry is a piece of published content that is
correct-as-published but would be better expressed differently once we are
free to change it.

**Related files** — read these first if you are picking this up cold.

| File | What it holds |
|---|---|
| `docs/adr/0008-v291-vocabulary-representation.md` | The decisions taken during the fidelity load, and why |
| `v291-extracted/vocabulary-changelog.md` | Every change made to the published text on its way in, plus what was deliberately left alone |
| `v291-extracted/vocabulary-review-report.html` | The browsable catalog — what still needs deciding |
| `v291-extracted/v2mgmt-review-report.md` | Defects in the *published document* to raise with V2 Management. Different question: those are things the source got wrong, these are things we would express better |

---

## 001 — Cross-references to sections of V2, with no version attached

**Raised** 2026-08-18 · **Scope** 5 tables, 97 places

Chapter 2C prose points at individual sections of V2 by clause number, and the
reference does not say which version of V2 the number belongs to. A clause
number is not stable across versions, so a bare `section 4.5.3.32` is only
resolvable if you already know which edition was meant.

| Table | Places | Field | What it looks like |
|---|---:|---|---|
| 0717 | 61 | `codedContent.definition`, `.comment` | `Section 2.31`, `Section 2.13`, `Section 2.15` — **and also** `Section 164.506`, `Section 164.522` |
| 0440 | 21 | `codedContent.comment` | `sections 6.5.6.14`, `section 4.5.2.1`, `sections 4.5.3.32 and 7.4.1.32` |
| 0396 | 7 | `codedContent.comment`, `.displayName` | `chapter 7`, `section 7.4.2.6`, `chapter 2` |
| 0356 | 6 | `codedContent.comment`, `.displayName` | `sections 2.8.28.6.1and 2.9.2`, `sections 2.16.93 and 2.7.2` |
| 0119 | 2 | `codedContent.comment` | `Chapter 12` |

### What to decide

1. **Which references are to V2 at all.** Table 0717's `Section 164.506`,
   `164.508`, `164.520`, `164.522` and `164.524` are **45 CFR** — the HIPAA
   Privacy Rule — not V2. They must not be rewritten as V2 links. The same
   table also carries genuine V2 references (`Section 2.13`, `2.31`), so the
   two kinds sit side by side in one field and cannot be told apart by shape
   alone.
2. **Which version each V2 reference means.** In some cases the surrounding
   prose says; in most it does not. A reference written when the chapter was
   drafted may point at a clause that has since moved.
3. **Whether they should become URLs into V2+.** If V2+ publishes a stable
   anchor per clause, a live link is far more useful than a number the reader
   has to go and look up — and it makes the reference verifiable, which a bare
   number never is. That argues for rewriting them, but only where the target
   is known with confidence.
4. **What to do where the target no longer exists.** Some clauses will have
   been renumbered or removed. A dangling link is worse than a bare number, so
   there needs to be an answer for that case before any rewriting starts.

### One thing to fix in passing

Table 0356 publishes `sections 2.8.28.6.1and 2.9.2` — no space before `and`.
Left as published during the fidelity load; it belongs with the other
missing-space defects listed under "Still outstanding" in the change log.

---

## 002 — Contact details embedded in code comments

**Raised** 2026-08-18 · **Scope** table 0396, at least 2 codes

Table 0396's comments carry postal addresses, phone numbers, fax numbers and
email addresses for the organizations that maintain external code lists:

```
National Council for Prescription Drug Programs, 924Ø East Raintree Drive, Scottsdale, AZ 8526Ø.
Phone: (48Ø) 477-1ØØØ
Fax: (48Ø) 767-1Ø42
e-mail: ncpdp@ncpdp.org
www.ncpdp.org
```

This is the kind of content that is out of date the moment it is published, and
it is the wrong place for it: a `concept.definition` is not a directory entry.
If the information is worth keeping, a URL to the organization's own page is
both shorter and self-maintaining. Fax numbers in particular are probably not
worth carrying forward at all.

---

## 003 — Digits written as characters that are not digits

**Raised** 2026-08-18 · **Scope** table 0396, 8 places

NCPDP's house style writes zero as a slashed O, and Chapter 2C reproduces it
faithfully: `924Ø East Raintree Drive`, `8526Ø`, `(48Ø) 477-1ØØØ`,
`(48Ø) 767-1Ø42`. The character is `Ø` (U+00D8, LATIN CAPITAL LETTER O WITH
STROKE), not the digit zero.

Preserved during the fidelity load, and correctly so — it is what the document
says. But a phone number that cannot be dialled by copying it, and a postcode
that will not match any postcode field, are not doing their job. Whether these
should become ordinary digits is a content decision, and it interacts with
entry 002: if the contact block goes, so does most of this.

---

## 004 — A non-breaking hyphen where an ordinary one is meant

**Raised** 2026-08-18 · **Scope** table 0945, 4 places

`pre‑configured` uses U+2011 NON-BREAKING HYPHEN rather than an ordinary
hyphen. It reads identically and it is almost certainly a typesetting artifact
from Word, but changing a character is a content change and was out of scope
for the fidelity load. Trivial to fix; listed so it is not forgotten.

---

## 005 — A definition that is a ditto mark

**Raised** 2026-08-18 · **Scope** table 0496, code `028`

The published definition is:

```
""      "" w/o Surgery Capability
```

The pair of ditto marks stands for the definition of the entry above it. ADR-0008
D7 preserves the spaces between them deliberately, because in the published
document they *are* the value. But a `concept.definition` reading `""      ""`
is meaningless to anyone reading the resource rather than the printed table,
and no consumer can resolve what "the entry above" was.

The fix is to write out what the ditto stands for. This is also listed as an
open question in ADR-0008 Batch B, because it has to be answered one way or
another before the CodeSystem is generated — the difference is that Batch B
only has to decide what the resource carries, whereas this entry is about
getting the content right.

---

## 006 — Symbolic names that are not valid code tokens

**Raised** 2026-08-18 · **Scope** 55 concept domains

Chapter 2C's symbolic name is used verbatim as the concept code, and 55 of them
contain spaces, apostrophes, commas or an en dash:

```
Collector'sComment*
PrimaryKeyValue–STF
Diet,Supplement,orPreferenceCode
```

Still undecided even for the fidelity load — see the review report. If the
decision there is to emit them verbatim, then cleaning them up belongs here,
along with whatever mapping is needed so that anything already using the
published spelling still resolves.

ADR-0008 D9 has already taken this decision for one case: concept domain
`Masterfile Action Code` (table 0180) uses THO's `MasterfileActionCode`. That
is the precedent to weigh, in both directions — it shows the cleanup is
acceptable in principle, and it shows each one was looked at individually.

---

## 007 — Published typos deliberately carried through

**Raised** 2026-08-18 · **Scope** roughly 33 places

The fidelity load preserves these because repairing them would change what the
document says, and in several cases the intent is genuinely ambiguous. They are
collected in the change log under "Still outstanding"; the short version:

| Kind | Places | Example |
|---|---:|---|
| A dash the spacing rule refused to repair | 3 | `Message is not -conformant` (0357), `Emergency -stop` (0368), `Default -.will be assumed` (0919) |
| A comma with no space after it | 10 | `Electroneuro (EEG, EMG,EP,PSG)` (0074) |
| A space before the punctuation that closes a clause | 20 | `Placer Applications .` (0119) |

Each needs a human to say what was meant. They are listed here rather than
treated as extraction problems because that is exactly what they are not: the
extraction is faithful and the document is wrong.

---

## 008 — Definitions that disagree with THO

**Raised** 2026-08-18 · **Scope** 5 concept domains

Chapter 2C and THO describe the same concept domain differently for
`Confidentiality` (0952), `ContainerForm` (0967), `Country` (0675),
`EmploymentStatus` (0066) and `ObservationMethod` (0626). Under ADR-0008 D1
THO's wording wins and the difference is recorded.

Four of the five are not two versions of one definition but two unrelated
definitions — Chapter 2C's `Country` says "The domain of possible values
specifying the type of Country" where THO says "Countries of the world. ISO
3166, part 1, alpha-3 set." Only 0952 is close, and there the difference is
markdown emphasis plus a stray space before a colon.

Going to **V2 Management and TSMG** for discussion. Whichever way each one
lands, the losing text should not simply be dropped: at minimum it is evidence
about what the two communities each thought the domain meant.
