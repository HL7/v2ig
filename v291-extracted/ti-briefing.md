# V2.9.1 Chapter 2C terminology

_Executive briefing and IG walkthrough — Terminology Infrastructure WG — 2026-09-21_

This guide turns the whole of **Chapter 2C of HL7 V2.9.1 — 799 tables** — into FHIR CodeSystems and ValueSets: **824 artifacts**, built and validating, with **zero broken links** across 625,068 checked.

**It is additive with respect to THO.** We publish at THO's own canonical URLs, which means a naive load would silently delete anything THO carries that Chapter 2C is silent about. It does not: **7,580 values that exist only in THO are preserved**, and **732 of 823 artifacts keep THO's existing version number** because nothing about them actually changed. The merge is the mechanism, and it is inspectable table by table.

**It surfaces issues as classes, not as a list of incidents.** Where the same defect appears in twenty-five tables, it is one item that says so. That is what makes a committee answer tractable: one ruling settles twenty-five tables.

**It keeps an auditable record of every place the representation is not perfect** — both the places where v2.9.1 could not be reproduced exactly and something had to be resolved, and the places where this guide will substantively change content THO already publishes. Those are on separate pages from the open questions, deliberately: one page asks you for something, the other asks you for nothing and exists so that nothing is hidden.

**What this room is being asked for** is on the last section of this page: five questions with terminology-infrastructure teeth, plus one defect that is THO's rather than ours.

| | |
|---|---|
| **824** | artifacts generated |
| **732** | keep THO's version |
| **7,580** | THO-only values preserved |
| **0** | broken links |
| **57** | open items |
| **5** | questions for this room |

## The walkthrough — six stops

### 1. Home (`index.html`)

> This is the whole of Chapter 2C as FHIR, and here is its size.

Point at the counts and move on: **399 CodeSystems, 424 ValueSets**, plus the `conceptdomains` code system, **824 total**. The page self-checks these numbers against what was actually staged, so they cannot drift from the build.

Thirty seconds. The interesting pages are the next five.

### 2. The THO merge (`tho-merge.html`)

> We publish at THO's canonicals, so the merge is the thing that stops us destroying what THO already has.

**This is the most important page in the guide for this audience.** Four numbers carry the additive claim:

| Class | Count | What it means |
| --- | --- | --- |
| **Kept from THO** | 7,580 | Content THO publishes that Chapter 2C says nothing about. Without the merge each of these would have been _deleted_ from an artifact at THO's own URL. None of them changes the artifact, so none costs a version increment. |
| **Disagreements** | 489 | Both sides carry a value and they differ. The chapter's value is published — publishing the chapter is what this guide is for — and each one is listed so it is a decision rather than an accident. |
| **Added here** | 159 | Content Chapter 2C has and THO does not. These are real changes and they do drive version increments. |
| **Not published** | 45 | THO has an artifact, this guide writes nothing at that canonical. THO's artifact stands untouched; the merge does not invent a replacement. |

Then the versioning table, which is the same claim from the other side:

- **CodeSystems** — 339 keep THO's version, 58 incremented, 2 first publication at 1.0.0.
- **ValueSets** — 393 keep THO's version, 22 incremented, 9 first publication at 1.0.0.

**732 of 823 unchanged.** That is the number to say out loud. A version is computed from the policy on every run rather than asserted by hand, so “unchanged” is a derived fact about content, not a claim about intent.

### 3. Table index — coverage (`table-index.html`)

> All 799 tables on one page, and the twenty that are not where you would expect.

The whole chapter, one row per table, showing which code system, value set and concept domain each one landed on. For most tables the artifact exists both here and in THO — this guide is a redraft of something THO already carries, and that is the unshaded norm.

Go straight to **the tables whose artifact is missing, unexpected, or cannot expand** — **20 of 799**, in four kinds:

| Kind | Count | Meaning |
| --- | --- | --- |
| **New to THO** | 9 | This guide authors something THO does not carry. |
| **Dangling in THO** | 4 | THO's value set composes from a code system THO does not publish, so **it cannot expand**. See the ask below — this one is THO's, not ours. |
| **In THO, not here** | 2 | THO publishes at this canonical and this guide does not author it. |
| **Nothing anywhere** | 5 | No concept domain, no code system, no value set — here or in THO. Nobody has decided what these should be. |

This page answers _does the right kind of artifact exist at all_. It is a different question from the ledger's, and each page now says so in as many words — the two counts differ by an order of magnitude and a reader who met both used to conclude one page was broken.

### 4. Table ledger — content (`table-ledger.html`)

> Per table, exactly how we differ from THO and why.

The per-table view of the same merge. For any table, this is where a reviewer sees the individual differences, what was kept from THO, which register items name it, and the OID situation.

Headline: **96 tables differ from THO** in at least one published element, **101 carry an open register item**, and **14 are blocked on a decision** with nothing published for them yet.

Demonstrate **“Also affects”** on any difference — it is the feature that matters most here. A row reading _24 other tables_ tells you immediately that you are looking at a policy question rather than a data-entry question, and that answering it once answers it twenty-five times. That is the whole reason this is reviewable at committee speed.

### 5. What needs an answer (`open-items.html`)

> Everything the guide is actually asking anyone for, in one place.

**57 open items** plus **7 general questions**. The general questions are the ones where producing anything at all required a judgement rather than a fact; each states **what this build currently does** and **what we would change** if the answer comes back differently.

Say this part explicitly, because it is the thing that makes the guide safe to review: **none of them is blocking.** Every question has a defensible working answer already applied and shipping. We are asking for confirmation, not for permission to proceed.

Of the 57, **39 are escalations** (defects in the published chapter, in THO, or in both — none of them ours to resolve) and **14 are decisions** still to take.

### 6. Evidence — the audit trail (`evidence.html`)

> Everything already settled, so that nothing is hidden. This page asks you for nothing.

The counterpart to the previous page, and the answer to “what did you change without telling us?”

- **Decided** — 74 groups, **1,534 values**. Where the guide made a call and applied it.
- **Informational** — 17 groups, **544 values**. Disclosures that need no action.

The split between this page and the last is **by the action class the underlying report already assigns**, not by a second editorial judgement. A finding moves pages by being re-classified and cannot appear on both; an unclassified group stops the build rather than being quietly dropped.

Worth saying out loud: **this page says outright that it asks for nothing.** It exists so that a reviewer can satisfy themselves that the things not being asked about were not being hidden.

## What we are asking this room for

### 1. Does reordering a code system's concepts count as a change? [TSMG]

This is the artifact-versioning question, and it is the one item in the guide that is explicitly TSMG's rather than V2 Management's.

Chapter 2C and THO frequently agree on the whole set of concepts but present them in a different order. Under our versioning policy a version increments when the content changes. Is concept order content?

**What this build does:** treats order as presentation, not content, so a pure reordering keeps THO's version. That is why the “unchanged” count is as high as it is.

**If the answer is no,** a meaningful number of artifacts move from “unchanged” to “incremented” and the headline 732 falls. Nothing else changes — the published content is identical either way.

**Ask:** Confirm that concept order is presentation, or tell us it is content and we will re-run the policy.

Not table-specific — it decides how many of the 823 artifacts keep THO's version.

- [The versioning table: 339 + 393 artifacts currently unchanged](../vocab-ig/output/tho-merge.html)
- [Question 1, with what this build does and what would change](../vocab-ig/output/open-items.html#gq-does-reordering-a-code-system)

### 2. The concept status letters, and where they should be defined [TSMG / THO]

It is a question about THO's property vocabulary, which is this room's to answer.

Chapter 2C marks concepts with status letters — including `B` — that describe a concept's standing within the table. FHIR has no native slot for them, so they become properties, and a property needs a definition somewhere durable.

**The question is where.** If these letters are a v2 concern they belong in a v2 code system; if they are the same idea THO already expresses elsewhere, they should reuse THO's existing property rather than minting a parallel vocabulary that means the same thing.

**Ask:** Tell us whether these letters should be defined in THO's existing property vocabulary or in a v2-specific one.

**Affected tables:** 0003, 0357, 0440

0440 is the one carrying `B`. The `N`-reads-as-`active` mapping spans 25 tables and is now listed per table as “written differently” rather than as a disagreement.

- [Question 2, on where the letters should be defined](../vocab-ig/output/open-items.html#gq-the-concept-status-b-and)

### 3. Three OIDs where one number would end up naming two artifacts [Identifiers]

An OID naming two distinct artifacts is an identifier defect that outlives whatever we publish.

In three cases the chapter's numbering leads to a single OID being carried by two different artifacts. An identifier that resolves to two things is not an identifier, and unlike a content disagreement this does not get better by picking a winner on content grounds.

**Ask:** Rule on which artifact keeps the number, or confirm that a new OID should be minted for the other.

**Affected tables:** 0001, 0078, 0719

The only two OID disagreements in the corpus (0001, 0719) plus 0078, which is different in kind. 395 of 396 code system OIDs and 411 of 412 value set OIDs agree.

- [Question 4, with the OID for each side side by side](../vocab-ig/output/open-items.html#gq-three-oids-where-one-number)

### 4. Chapter 2C gives every table an OID, and it is published nowhere [Identifiers]

It is a modelling question about what survives the move from V2 to FHIR, and the current behaviour is an accident rather than a decision.

In V2 the _table_ is the thing with an identity. In FHIR that table becomes a code system **and** a value set, and neither of them is the table. So the table's own OID is carried by no published resource.

**This is current behaviour, not a decision anyone has taken.** It is called out in the guide in exactly those terms. Note also that **50 of the table OIDs are not identifiers at all** — they are a bare arc root with no leaf, on tables the chapter itself types _undefined_. Nothing should ever resolve those.

**Ask:** Decide whether the table OID should land on the code system, the value set, both, or be allowed to lapse.

All 799 tables carry one; 50 of them are a bare arc root with no leaf.

- [The OID overview at the head of the ledger](../vocab-ig/output/table-ledger.html)
- [Question 6, on where the table OID should land](../vocab-ig/output/open-items.html#gq-chapter-2c-gives-every-table)

### 5. Two descriptions where THO says more than the chapter [Merge policy]

It is the one place where the merge rule and the fidelity rule point in opposite directions.

Our default is that on a genuine disagreement the chapter wins, because publishing the chapter is the point. In two cases THO's description is simply _better_ — more complete, and not in conflict. Fidelity says publish the chapter's; the additive principle says do not throw away what THO has.

**What this build does:** publishes the chapter's text and lists both, so the choice is visible rather than silent.

**Ask:** Confirm the chapter wins even when THO's text is better, or give us a rule for when it does not.

**Affected tables:** 0227, 0719

0227 is settled; 0719 is the one still open.

- [Question 5, with both descriptions in full](../vocab-ig/output/open-items.html#gq-two-descriptions-where-tho-says)

### 6. Four THO value sets compose from code systems THO does not publish [THO defect]

This one is not ours and is not a question &mdash; it is a defect in THO that we found, and this is the room that can fix it.

Four value sets published by THO compose from a code system THO does not publish. **They cannot expand.** Any client that tries to expand them fails, and that is true today, independent of anything this guide does.

We are not proposing to fix them — they are THO's artifacts. They are flagged on the table index as _Dangling in THO_ so that the situation is visible rather than inherited silently.

**Ask:** Take these four away as a THO maintenance item.

**Affected tables:** 0350, 0351, 0456, 0895

All four are flagged _Dangling in THO_ on the table index, which names the code system each one composes from.

- [The coverage anomalies, where these are listed with the other 16](../vocab-ig/output/table-index.html#coverage-anomalies)

The remaining general questions in the guide are about what Chapter 2C itself says rather than about terminology infrastructure, and are going to **V2 Management**: **Table 0560**, a code system the chapter says does not exist; and **Table 0292**, published against the chapter's own flag pending a ruling. They are listed here only so that nobody leaves thinking they have seen the whole register.

Every figure on this page is transcribed from the **2026-09-20** build of the vocabulary IG and is reproduced in the guide on the page named beside it. Where this page and the guide disagree, the guide is right.
