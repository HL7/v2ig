
<style>.tl-note { font-size: 0.85em; color: #555; }</style>

This guide publishes its code systems and value sets at **THO's own canonical URLs**. A canonical URL is an identifier: publishing at one says *this is that artifact*, not *this is our version of that artifact*. So anything THO carries that our output leaves out is not a gap in a draft — it is content deleted from the artifact that URL names.

The rule this guide follows, and what this page reports on:

> Where THO has content and Chapter 2C has no opinion, **THO's content survives**. Where both have something and they differ, the **chapter wins** and the disagreement is recorded.

Everything below is measured against a local snapshot of the **`hl7.terminology.r5` package, version 7.3.0**, not against a live server. 8,275 observations in total.

### Kept from THO

Content THO publishes that Chapter 2C says nothing about. Without the merge each of these would have been deleted from an artifact published at THO's own canonical URL. None of them changes the artifact relative to THO, so none of them costs a version increment.

**7,588 in total.**

| What | Count | Tables |
|---|---:|---|
| Concept definitions kept from THO<br/><span class="tl-note">Chapter 2C has no definition column at all, so without this every definition THO has written would be deleted from the artifact.</span> | 4,855 | 382 |
| Comments-as-published kept from THO<br/><span class="tl-note">THO records the comment text as the chapter of the day printed it, alongside the current one. Nothing in Chapter 2C corresponds to it, so it can only be kept or lost.</span> | 1,276 | 89 |
| Translations kept from THO<br/><span class="tl-note">The chapter has no way to express a translation, so there is no disagreement to have -- only a loss to avoid.</span> | 1,061 | 125 |
| Codes kept from THO that the chapter does not list<br/><span class="tl-note">THO publishes these codes at this canonical. Dropping them would remove codes implementers may already be sending.</span> | 211 | 37 |
| Usage notes kept from THO<br/><span class="tl-note">Guidance THO carries on individual concepts, with no counterpart in the chapter's grid.</span> | 122 | 15 |
| Deprecation markers kept from THO<br/><span class="tl-note">The HL7 version in which a code was deprecated. The chapter's status column says that a code is deprecated but not when.</span> | 40 | 3 |
| Resource descriptions kept from THO<br/><span class="tl-note">Where the chapter's description is missing or a placeholder such as 'tbd', THO's text stands.</span> | 7 | 7 |
| Resource names kept from THO<br/><span class="tl-note">The chapter supplies no name.</span> | 5 | 5 |
| Resource titles kept from THO<br/><span class="tl-note">The chapter supplies no title.</span> | 5 | 5 |
| Identifiers kept from THO<br/><span class="tl-note">The chapter gives no OID. Publishing without THO's would be *removing* an identifier, which the policy says needs a whole new artifact rather than a new version.</span> | 4 | 4 |
| Value set members kept from THO<br/><span class="tl-note">Codes THO enumerates in the value set that the chapter's table does not.</span> | 2 | 2 |

### Where the chapter and THO disagree

Both carry a value and the two differ by more than whitespace. The chapter's value is published, because publishing the chapter is what this guide is for, and the disagreement is listed here so that it is a decision rather than an accident.

**483 in total.**

| What | Count | Tables |
|---|---:|---|
| Concept status where the chapter and THO disagree<br/><span class="tl-note">Most of these are codes THO still marks 'N' -- new, in some past release -- that the 2.9.1 chapter no longer flags, so ours reads 'active'.</span> | 259 | 26 |
| Concept comments where the chapter and THO disagree | 98 | 23 |
| Value set member displays where the chapter and THO disagree | 51 | 7 |
| Displays where the chapter and THO disagree<br/><span class="tl-note">Both carry a display and they differ beyond whitespace.</span> | 44 | 15 |
| Descriptions differing only in punctuation<br/><span class="tl-note">Same words in the same order; only punctuation or spacing moved. The chapter's text is published and no version is incremented, which is the versioning policy's editorial-correction carve-out applied as far as a program honestly can. Recorded so the waiver can be reversed in one place if TSMG rules otherwise.</span> | 10 | 5 |
| Definitions where the chapter and THO disagree<br/><span class="tl-note">Both carry a definition and they differ. The chapter's wins, because this guide publishes the chapter.</span> | 6 | 5 |
| Purposes where the chapter and THO disagree<br/><span class="tl-note">The purpose is generated from the table number and name, so a difference here is a disagreement about the table's name.</span> | 3 | 3 |
| Descriptions that differ in what they say<br/><span class="tl-note">The words themselves differ, so this is not an editorial correction and it does increment the version.</span> | 3 | 3 |
| Identifiers where the chapter and THO disagree<br/><span class="tl-note">The chapter's OID is published. Under the versioning policy a changed identifier cannot be expressed as a version at all — it calls for a new artifact at a new canonical — so each of these needs resolving before publication.</span> | 2 | 2 |
| Resource titles where the chapter and THO disagree | 2 | 2 |
| Resource status where the chapter and THO disagree | 2 | 2 |
| Resource names where the chapter and THO disagree | 1 | 1 |
| Purposes where the chapter and THO disagree<br/><span class="tl-note">The purpose is generated from the table number and name, so a difference here is a disagreement about the table's name.</span> | 1 | 1 |
| Resource names where the chapter and THO disagree | 1 | 1 |

### What this guide contributes

Content in Chapter 2C that THO does not carry. These are real changes to the artifact and they do drive version increments.

**159 in total.**

| What | Count | Tables |
|---|---:|---|
| Concept comments the chapter adds | 119 | 9 |
| Codes the chapter lists that THO does not publish<br/><span class="tl-note">New content this guide contributes.</span> | 38 | 3 |
| A hierarchy meaning the chapter states and THO omits | 1 | 1 |
| Value set members the chapter lists that THO does not | 1 | 1 |

### Where this guide is silent and THO is not

THO publishes an artifact and this guide publishes nothing at that canonical. Nothing is destroyed — THO's artifact stands untouched — so the merge does not invent a replacement. They are listed because a reviewer should see the gaps deliberately rather than discover them.

**45 in total.**

| What | Count | Tables |
|---|---:|---|
| Artifacts THO publishes that this guide does not<br/><span class="tl-note">Publishing nothing at a canonical destroys nothing -- THO's artifact stands -- so the merge does not invent one. Listed so that the silence is deliberate and visible.</span> | 45 | 25 |

### What it does to version numbers

Version numbers are not hand-applied. Each artifact is compared against THO's after the merge, and the [TSMG artifact versioning policy](https://confluence.hl7.org/spaces/TSMG/pages/134947510) decides what that comparison means. The format is `n.0.0` — there is no minor or patch, so every qualifying change is a major increment.

An artifact that ends up matching THO **keeps THO's version**. That is the merge's largest practical effect: filling content back in removes the change that would otherwise have forced an increment.

Every difference counts, whatever its size: a description that gained a comma increments exactly as a reworded one does. Some of the increments below rest on nothing more than that, and the per-table ledger says which.

The one rule behind these numbers that used to rest on a judgement rather than a fact — whether reordering a code system's concepts is a change — **was answered by TSMG on 2026-09-21: it is not, and it does not increment the version.** That confirmed what this build already did, so no number here moved. The ruling and its attribution are recorded under [Answered by committee](evidence.html#gq-does-reordering-a-code-system).

| Outcome | Count |
|---|---:|
| codeSystem: first publication at 1.0.0 | 1 |
| codeSystem: incremented | 58 |
| codeSystem: unchanged, THO's version kept | 339 |
| valueSet: first publication at 1.0.0 | 6 |
| valueSet: incremented | 21 |
| valueSet: unchanged, THO's version kept | 394 |

### The artifacts THO has and this guide does not

45 of them, across 25 tables. Each is listed with the reason the writer gave for publishing nothing.

| Table | Resource | Why this guide writes nothing |
|---|---|---|
| [0005](table-ledger.html#tbl-0005) | CodeSystem | Declared concept domain only. A binding to a domain needs no value set. |
| [0005](table-ledger.html#tbl-0005) | ValueSet | Declared concept domain only. A binding to a domain needs no value set. |
| [0012](table-ledger.html#tbl-0012) | CodeSystem | The chapter has no section for it. |
| [0012](table-ledger.html#tbl-0012) | ValueSet | The chapter has no section for it. |
| [0033](table-ledger.html#tbl-0033) | CodeSystem | The chapter has no section for it. |
| [0033](table-ledger.html#tbl-0033) | ValueSet | The chapter has no section for it. |
| [0034](table-ledger.html#tbl-0034) | CodeSystem | The chapter has no section for it. |
| [0034](table-ledger.html#tbl-0034) | ValueSet | The chapter has no section for it. |
| [0048](table-ledger.html#tbl-0048) | CodeSystem | The chapter has no section for it. |
| [0048](table-ledger.html#tbl-0048) | ValueSet | The chapter has no section for it. |
| [0070](table-ledger.html#tbl-0070) | CodeSystem | The chapter has no section for it. |
| [0070](table-ledger.html#tbl-0070) | ValueSet | The chapter has no section for it. |
| [0102](table-ledger.html#tbl-0102) | CodeSystem | The chapter has no section for it. |
| [0102](table-ledger.html#tbl-0102) | ValueSet | The chapter has no section for it. |
| [0106](table-ledger.html#tbl-0106) | CodeSystem | The chapter has no section for it. |
| [0106](table-ledger.html#tbl-0106) | ValueSet | The chapter has no section for it. |
| [0107](table-ledger.html#tbl-0107) | CodeSystem | The chapter has no section for it. |
| [0107](table-ledger.html#tbl-0107) | ValueSet | The chapter has no section for it. |
| [0108](table-ledger.html#tbl-0108) | CodeSystem | The chapter has no section for it. |
| [0108](table-ledger.html#tbl-0108) | ValueSet | The chapter has no section for it. |
| [0109](table-ledger.html#tbl-0109) | CodeSystem | The chapter has no section for it. |
| [0109](table-ledger.html#tbl-0109) | ValueSet | The chapter has no section for it. |
| [0133](table-ledger.html#tbl-0133) | CodeSystem | Declared concept domain only. A binding to a domain needs no value set. |
| [0133](table-ledger.html#tbl-0133) | ValueSet | Declared concept domain only. A binding to a domain needs no value set. |
| [0156](table-ledger.html#tbl-0156) | CodeSystem | The chapter has no section for it. |
| [0156](table-ledger.html#tbl-0156) | ValueSet | The chapter has no section for it. |
| [0157](table-ledger.html#tbl-0157) | CodeSystem | The chapter has no section for it. |
| [0157](table-ledger.html#tbl-0157) | ValueSet | The chapter has no section for it. |
| [0158](table-ledger.html#tbl-0158) | CodeSystem | The chapter has no section for it. |
| [0158](table-ledger.html#tbl-0158) | ValueSet | The chapter has no section for it. |
| [0290](table-ledger.html#tbl-0290) | CodeSystem | The chapter has no section for it. |
| [0290](table-ledger.html#tbl-0290) | ValueSet | The chapter has no section for it. |
| [0323](table-ledger.html#tbl-0323) | CodeSystem | The chapter has no section for it. |
| [0323](table-ledger.html#tbl-0323) | ValueSet | The chapter has no section for it. |
| [0399](table-ledger.html#tbl-0399) | ValueSet | The correct value set for table 0399 already exists in THO, ValueSet/v2-notAllCodes-0399. It is the one to use; this guide creates nothing for the table. |
| [0456](table-ledger.html#tbl-0456) | ValueSet | Declared concept domain only. A binding to a domain needs no value set. |
| [0524](table-ledger.html#tbl-0524) | CodeSystem | The chapter has no section for it. |
| [0524](table-ledger.html#tbl-0524) | ValueSet | The chapter has no section for it. |
| [0529](table-ledger.html#tbl-0529) | CodeSystem | The chapter has no section for it. |
| [0529](table-ledger.html#tbl-0529) | ValueSet | The chapter has no section for it. |
| [0567](table-ledger.html#tbl-0567) | ValueSet | Tables 0567 and 0568 should never have been created. Their value sets will be retired by a separate Jira ticket against THO, not by this IG, which is to do nothing with them. |
| [0568](table-ledger.html#tbl-0568) | ValueSet | Tables 0567 and 0568 should never have been created. Their value sets will be retired by a separate Jira ticket against THO, not by this IG, which is to do nothing with them. |
| [0962](table-ledger.html#tbl-0962) | ValueSet | The code system is given only as OID 2.16.840.1.113883.4.642.1.200, which nothing in THO or FHIR core resolves to a canonical URL. |
| [4000](table-ledger.html#tbl-4000) | CodeSystem | The chapter has no section for it. |
| [4000](table-ledger.html#tbl-4000) | ValueSet | The chapter has no section for it. |

### Where the detail lives

This page is deliberately a summary: there are thousands of instances and the useful question here is what kinds of thing happened, not which of eight thousand rows to read first.

For one table, read the **[per-table ledger](table-ledger.html)** — it has a section per table carrying every difference from THO individually, and it says, for each one, how many other tables the same class of difference reaches. Every table number on this page links into it.
