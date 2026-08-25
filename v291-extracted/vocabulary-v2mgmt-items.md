# V2.9.1 Chapter 2C vocabulary: items for V2 Management and TSMG

Findings from building a FHIR IG that carries the Chapter 2C
vocabulary as CodeSystems and ValueSets. Each is a defect in the
published chapter, in `hl7.terminology.r5`, or in both, and none of
them is the IG project's to resolve.

The IG's governing requirement is fidelity -- it publishes exactly
what Chapter 2C publishes -- so where an item below is left
unanswered, the current behaviour is to reproduce the defect and
record it. The first item asks whether that is the right default.

Generated from `tooling/scripts/vocabulary_escalations.py`; the same
register appears at the top of
`v291-extracted/vocabulary-review-report.html`. Edit the module, not
this file.

---

## Contents

1. [Does “publish V2.9.1 as published” extend to publishing content that is known to be wrong?](#1) — policy
2. [Table 0560 _Quantity Units_ publishes time units, and THO carries the same error](#2) — 0560
3. [Table 0821 _Gender Identity_ publishes its coded content grid completely blank](#3) — 0821
4. [Table 0931 _Temperature Units_ publishes three codes, two of which are the same unit, and one of which is invalid](#4) — 0931
5. [All six UCUM-backed tables name the code system “Donation Duration Units Code System”](#5) — 0567, 0568, 0929, 0930, 0931, 0932
6. [The copy-pasted Full Name is not confined to the UCUM tables](#6) — 0001, 0125, 0180, 0203, 0458, 0820 and others
7. [Two tables publish literal placeholder text — `noObject` and `noDescription`](#7) — 0560, 0910
8. [Table 0347 _State/Province_ gives ISO 3166 part 1's URI for a part 2 code system, and calls a partial value set “all codes”](#8) — 0347
9. [“All codes” is used where a value set enumerates a handful of UCUM codes](#9) — 0929, 0930, 0931, 0932
10. [Two pairs of tables are duplicates of each other](#10) — 0567 / 0929, 0568 / 0930
11. [Five concept domains are given two different descriptions within Chapter 2C](#11) — 5 concept domains
12. [Five concept domain definitions differ between Chapter 2C and THO](#12) — 0952, 0967, 0675, 0066, 0626
13. [Sixteen Value Set descriptions stop mid-word, all at about 250 characters](#13) — 0038, 0170, 0227, 0254, 0315, 0326, 0335, 0389, 0392, 0406, 0508, 0510, 0511, 0513, 0520, 0544
14. [Table 0954's logical definition would include an abstract concept THO's equivalent excludes](#14) — 0954, 0957
15. [Where should a concept domain’s example codes live?](#15) — 0093, 0340, 0451
16. [Three “tables” that carry no terminology at all](#16) — 0010, 0188, 9999
17. [Two table headings are styled `Normal` instead of `Heading 3`](#17) — 0685, 0767

---

<a id="1"></a>

## 1. Does “publish V2.9.1 as published” extend to publishing content that is known to be wrong?

**Tables:** policy  
**Goes to:** V2 Management + TSMG

The governing requirement for this IG is fidelity: it carries exactly what Chapter 2C publishes. That is easy to hold while the divergences are typographic. It becomes a real question when the published content is not merely untidy but wrong — and two of the items below are exactly that. Table 0560 publishes time units under the name Quantity Units, and table 0931 publishes an invalid UCUM code alongside a valid one that means the same thing. There is already a precedent pointing the other way: for 0931, **THO chose to correct rather than reproduce**. Its `ValueSet/v2-0931` drops the bad code and records the history in the display text of the good one. So the two bodies have, at least once, answered this question differently. **HL7's own errata guidance gives a usable test.** A technical correction is defined there as “a non-controversial change that alters a document so that it says what the WG intended to say”, typically repairing changes to normative content “that were not made, were incorrectly made, or were inconsistently made during the editing process”. That cleanly separates the items on this list into two kinds. The editing-process defects — table 0821's grid emptied in publication, table 0411's canonical printed for a resource that does not exist, the links to rendered pages where canonical URLs belong, the missing spaces after a period — are technical corrections on that definition. The content defects — 0931's invalid UCUM code, 0560's time units — change what the standard _means_, and for normative content the same guidance requires any substantive change to be balloted.

**The ask:** Decide the rule, not the instance. When Chapter 2C publishes something demonstrably wrong, does this IG (a) reproduce it and record the defect, (b) reproduce it but mark it deprecated or inactive, or (c) correct it and publish the correction with a note? The answer sets the default for every item below, and the current answer — (a) — is an assumption nobody has ratified. **A narrower question would unblock most of the list:** may this project treat the editing-process defects above as technical corrections, leaving only the substantive ones for a ballot? The guidance also notes that where there is doubt, a Work Group may ask the TSC to rule.

<a id="2"></a>

## 2. Table 0560 _Quantity Units_ publishes time units, and THO carries the same error

**Tables:** 0560  
**Goes to:** V2 Management + TSMG

The table is named Quantity Units, its concept domain is “the domain of possible values that specify the adjustment quantity”, and it is bound to `ADJ-6`. The five codes it publishes are `FL` Units, `HS` Hours, `DY` Days, `MN` Month and `YY` Years. Four of the five are units of _time_. This is not a difference between the chapter and THO: `CodeSystem/v2-0560` in `hl7.terminology.r5` v3.0.0 publishes those same five concepts. Both are wrong in the same way, so correcting one without the other would fork them. The chapter also contradicts itself here — the table metadata says `Type: User` and “No suggested values”, and then lists five values. **There is a second, sharper problem.** Chapter 2C's code system block for 0560 is the `noObject` / `noDescription` placeholder — the chapter does not declare a code system for this table at all. THO nevertheless publishes both `CodeSystem/v2-0560` and `ValueSet/v2-0560`, and so does the UTG repository. So THO has minted a code system for a table whose source declares none. Of the tables this project treats as concept domain only, **0560 is the only one where THO carries resources**; 0910 carries the identical placeholder and THO has nothing for it, which is the treatment that looks correct.

**The ask:** Is this table salvageable, or is it a concept domain with no usable code system? If it is to be fixed, the fix has to be coordinated with TSMG so Chapter 2C and THO move together. **This project's working decision is concept domain only** — no CodeSystem and no ValueSet minted — which is reversible once the committee rules. Note that this decision puts us in direct conflict with content THO already publishes, so it needs TSMG as well as V2 Management. **We are not proposing to alter THO's existing records unilaterally.**

<a id="3"></a>

## 3. Table 0821 _Gender Identity_ publishes its coded content grid completely blank

**Tables:** 0821  
**Goes to:** V2 Management

The grid is six rows by five columns and _every cell is empty_, while the section around it is fully populated: three code systems (SNOMED CT, FHIR DataAbsentReason, V3 NullFlavor), three code system versions, and a value set. Both extraction pipelines independently find zero codes, so this is the document rather than the tooling. The row count is the tell. Six rows is a header plus **five** code rows, and THO's `ValueSet/gender-identity` — whose OID `2.16.840.1.113883.4.642.3.3291` is exactly the one Chapter 2C prints for this value set — holds exactly **five** concepts: three SNOMED CT gender identities, `asked-declined`, and `UNK`. The grid was meant to carry those five and lost them somewhere in publication. Compare table 0823 Sexual Orientation, built the same way, which prints its codes. Minor, in the same section: the value set description runs two sentences together with no space — “…within their community.Used in HL7 Version 2.x messages”.

**The ask:** Confirm the five intended codes and republish the grid. This project reuses THO's value set in the meantime, so nothing is blocked — but the published chapter is missing content and a reader of the PDF cannot tell what the table contains.

<a id="4"></a>

## 4. Table 0931 _Temperature Units_ publishes three codes, two of which are the same unit, and one of which is invalid

**Tables:** 0931  
**Goes to:** V2 Management

The three codes are `degF` (status `D`, comment “typo”), `[degF]`, and `Cel`. `degF` is not a valid UCUM code — UCUM requires the square brackets — so the table publishes a known-invalid code and its correction side by side, with two of the three entries meaning Degrees Fahrenheit. There is no Kelvin and no Rankine, so it is not a complete set of temperature units either. **THO has already dealt with this.** Its `ValueSet/v2-0931` v2.0.0 includes only `[degF]` and `Cel`, and folds the history into the display text: “Degrees Fahrenheit (note that V2 has erroneously published this for many years without the square brackets)”. Also in this table: the Code System Version block gives the UCUM version as `2`, which is not a UCUM version.

**The ask:** This is the cleanest test case for the policy question at the top of this list. Chapter 2C reproduces an error; THO corrected it and said so. Which does this IG follow? And separately: should 0931 be filled out into an actual set of temperature units, or is the two-code set intentional?

<a id="5"></a>

## 5. All six UCUM-backed tables name the code system “Donation Duration Units Code System”

**Tables:** 0567, 0568, 0929, 0930, 0931, 0932  
**Goes to:** V2 Management

Every table in Chapter 2C backed by UCUM carries the same Code System Identification block — OID `2.16.840.1.113883.6.8`, symbolic name `ucum`, URI `http://unitsofmeasure.org` — with `Full Name: Donation Duration Units Code System`. Only 0932 is about donation duration; the name was copy-pasted across Weight Units, Volume Units and Temperature Units, twice over, since 0567/0568 duplicate 0929/0930. The name is wrong even on 0932. The code system being identified is UCUM, so its full name is the Unified Code for Units of Measure, not the name of whichever table happens to point at it.

**The ask:** **Cleared to correct.** Measured against HL7's errata guidance this is squarely a technical correction — a name inconsistently applied during editing, where fixing it makes the chapter say what was plainly intended. Set the Full Name to UCUM's own name in all six. **Note that this changes no generated resource.** UCUM is an external code system, so these six tables produce a ValueSet and no CodeSystem, and the ValueSet takes its name and description from the Value Set block rather than the Code System block. The correction is to the chapter, and to the report that mirrors it.

<a id="6"></a>

## 6. The copy-pasted Full Name is not confined to the UCUM tables

**Tables:** 0001, 0125, 0180, 0203, 0458, 0820 and others  
**Goes to:** V2 Management

Checking the UCUM finding against the whole chapter turned up the same defect elsewhere. **412 of the 444 Code System Identification blocks follow the pattern `<Table Name> Code System` exactly**, which makes the exceptions easy to see. Some are legitimate — a table pointing at SNOMED CT or ISO 3166 should name that system, not itself. Others are the UCUM defect again, a name carried over from a different table: 0001 _Administrative Sex_ is named “Jurisdiction Gender Code System”, 0125 _Value Type_ is “Data Types”, 0180 _Masterfile Action Code_ is “Record-level Event Code”, 0203 _Identifier Type_ is “Practitioner ID Number Type”, 0458 _OCE Edit Code_ is “Reimbursement Action Code”, 0820 _Gender Harmony Concepts_ is “Personal Pronouns”. One more, 0232, begins with a stray hyphen: `- Insurance Company Contact Reason Code System`. Like the UCUM case, none of this reaches a generated resource; the emitted name and title come from the symbolic name.

**The ask:** If the UCUM correction is approved as a technical correction, the same reasoning covers these. Someone who knows the tables needs to separate the genuine exceptions from the copy-paste errors — this project can produce the candidate list but cannot make that call.

<a id="7"></a>

## 7. Two tables publish literal placeholder text — `noObject` and `noDescription`

**Tables:** 0560, 0910  
**Goes to:** V2 Management

Tables 0560 (Quantity Units) and 0910 (Acquisition Modality) each carry a Code System Identification block reading OID `-`, symbolic name `noObject`, description `noDescription`, and — again copy-pasted from somewhere else — `Full Name: Name Representation Code System`. These are not values; they are a tool's way of saying the field was left blank, and they were published. Worth noting that this placeholder appears in exactly these two sections and nowhere else in Chapter 2C, and that both are tables with no genuine code system. The placeholder is a reliable marker of the condition, not random noise, which is part of why both are treated as concept domain only. **The two tables have then been treated completely differently downstream, and that is the finding.** They present identically in the chapter: same placeholder block, same absence of a code system, both declaring a concept domain and a value set. **For 0910, THO has nothing** — no CodeSystem, no ValueSet, and neither does the UTG repository. The chapter declares no code system, so none was minted. That is the treatment that follows from the source. **For 0560, THO publishes both** `CodeSystem/v2-0560` and `ValueSet/v2-0560` at version 3.0.0, and so does UTG. The CodeSystem is `content: complete` and carries five concepts — `FL` Units, `DY` Days, `HS` Hours, `MN` Month, `YY` Years — under the title _Quantity Units_ and the description “HL7-defined code system of concepts specifying the adjustment quantity”. Four of the five are units of time. So a code system was minted at an HL7 canonical for a table whose source declares none, and the content it was filled with is the same content flagged as wrong elsewhere on this list. 0560 is the _only_ table this project treats as concept domain only where THO carries resources; there are eight such tables in total and the other seven have nothing.

**The ask:** Two questions, and the second is the one that needs both groups. First, should the placeholder blocks be removed from the published chapter, and should a table with no code system simply have no Code System Identification block? Second: **0560 and 0910 are the same case and have been handled in opposite ways.** Either 0910 is missing resources or 0560 has resources it should never have had. This project's working decision treats both as concept domain only, which means it declines to carry forward THO's existing 0560 CodeSystem and ValueSet — a divergence from published THO content that needs TSMG's agreement as well as V2 Management's. **Nothing will be altered in THO's existing records on this project's initiative.**

<a id="8"></a>

## 8. Table 0347 _State/Province_ gives ISO 3166 part 1's URI for a part 2 code system, and calls a partial value set “all codes”

**Tables:** 0347  
**Goes to:** V2 Management

The Code System Identification block correctly identifies ISO 3166-2 — OID `1.0.3166.2`, symbolic name `iso3166-2`, described as “ISO 3166 Part 2 Country Subdivision Codes” — and then gives the URI as `urn:iso:std:iso:3166`, which is part 1. THO's `NamingSystem/ISO3166Part2` carries both identifiers for this system and uses `urn:iso:std:iso:3166:-2`. Separately, the Value Set block gives its Content Logical Definition as “all codes” while its own URI points at `ValueSet-v2-notAllCodes-0347`, and THO's value set of that name enumerates two example concepts (`CA-AB`, `US-MI`). The published definition contradicts both its own URI and THO. The Full Name is wrong in the same way as the UCUM tables: “State/Province Code System” names the table, not the code system, which is ISO 3166-2.

**The ask:** Two technical corrections — the URI, and the Content Logical Definition. Neither should be contentious, but both change published text.

<a id="9"></a>

## 9. “All codes” is used where a value set enumerates a handful of UCUM codes

**Tables:** 0929, 0930, 0931, 0932  
**Goes to:** V2 Management

Tables 0929 and 0930 give their Content Logical Definition as “enumerated per table content”, which is accurate. Tables 0931 and 0932 say “all codes” while doing exactly the same thing — listing two or three UCUM codes. Read literally, “all codes” against UCUM would be every unit of measure in existence. THO reads all four the same way and enumerates in every case.

**The ask:** Align the wording on the four tables. More usefully: is “all codes” meant to be a defined term with a specific mapping to `ValueSet.compose`, or is it informal prose? The answer affects how every one of the 438 value set blocks in the chapter is translated.

<a id="10"></a>

## 10. Two pairs of tables are duplicates of each other

**Tables:** 0567 / 0929, 0568 / 0930  
**Goes to:** V2 Management

Table 0567 and table 0929 are both named Weight Units, declare the concept domain `WeightUnits`, and publish the same four UCUM codes. Table 0568 and table 0930 are both Volume Units with the same three codes. In both pairs the older table's value set URI already points at the newer table's value set (`ValueSet/v2-0929`, `ValueSet/v2-0930`), so the chapter appears to know they are the same thing.

**The ask:** Confirm the older numbers are deprecated in favour of the newer ones, and say so in the chapter. This IG needs to know whether to publish two resources or one with an alias.

<a id="11"></a>

## 11. Five concept domains are given two different descriptions within Chapter 2C

**Tables:** 5 concept domains  
**Goes to:** V2 Management

A concept domain has one description by definition, so a domain described two different ways in the same chapter is a source defect rather than something this project can adjudicate. The generator emits the first description in document order, which keeps the output deterministic; the alternatives are recorded in the concept domain section of this report.

**The ask:** Reconcile the five at source and say which description is correct.

<a id="12"></a>

## 12. Five concept domain definitions differ between Chapter 2C and THO

**Tables:** 0952, 0967, 0675, 0066, 0626  
**Goes to:** V2 Management + TSMG

For 577 of the 582 shared concept domains, Chapter 2C and THO agree word for word. These five do not. Only 0952 is close enough for a word-level comparison to be meaningful — it differs by formatting and a stray space. The other four are wholly different texts, which usually means the two bodies have attached different meanings to the same domain rather than phrasing one meaning two ways. Under ADR-0008 D1 THO's wording is currently the one published.

**The ask:** Reconcile the five between the two bodies. The four unrelated definitions matter more than the near-match: if Chapter 2C and THO genuinely disagree about what a domain means, choosing a wording does not fix that.

<a id="13"></a>

## 13. Sixteen Value Set descriptions stop mid-word, all at about 250 characters

**Tables:** 0038, 0170, 0227, 0254, 0315, 0326, 0335, 0389, 0392, 0406, 0508, 0510, 0511, 0513, 0520, 0544  
**Goes to:** V2 Management

Found while checking a generated resource rather than by looking for it. Table 0227's value set description ends “… the code system may be acce”. Sweeping the corpus for the same shape found **sixteen Value Set descriptions that end without terminal punctuation, every one of them between 242 and 252 characters long**. Nothing else in the chapter behaves this way: Code System descriptions run to 500 and 800 characters and end in complete sentences, and the same tables' own table-level descriptions are complete — 0227's runs to 582 characters and finishes cleanly. So this is not extraction loss and not an authoring habit; it is **a length cap of roughly 250 characters applied to one field** somewhere in the publication toolchain. **This one does reach the output.** Unlike the Full Name defects, the Value Set Description becomes `ValueSet.description`, so sixteen generated ValueSets currently carry a sentence that stops mid-word.

**The ask:** The truncated text needs recovering from whatever source the chapter was generated from — this project cannot reconstruct it, only detect it. On the errata guidance this is content lost during the editing process rather than a change of meaning, so it should qualify as a technical correction. Until the full text is available the truncated form is published as-is, since inventing an ending would be worse.

<a id="14"></a>

## 14. Table 0954's logical definition would include an abstract concept THO's equivalent excludes

**Tables:** 0954, 0957  
**Goes to:** V2 Management + TSMG

Both tables define their value set as a subtree of `v3-ObservationValue`. 0957 _Employment Status_ says it in two clauses — _Include codes … where concept is-a `_EmploymentStatus`_, then _Exclude codes where code = `_EmploymentStatus`_. That second clause matters: in FHIR, an `is-a` filter includes the concept it is rooted at, and `_EmploymentStatus` is an abstract grouper that should never be sent in a message. The exclusion is what makes the value set mean “the actual statuses”. **0954 _Work Schedule_ has the include clause and no exclude clause**, so read literally its value set contains the abstract `_WorkSchedule` grouper. THO's own `ValueSet/v3-WorkScheduleODH` **does** exclude it, and is otherwise identical to 0957's shape. So either the chapter dropped a clause from 0954, or the two tables genuinely differ — and nothing in the text says which. This project builds what the chapter says, so **the generated `ValueSet/v2-0954` currently has no exclude** and differs from THO on exactly this point.

**The ask:** Confirm that 0954 is missing an _Exclude codes where code = `_WorkSchedule`_ clause, in which case it is a technical correction and one line to apply. If the omission is deliberate, say so, because the value set then diverges from THO's and somebody will raise it again.

<a id="15"></a>

## 15. Where should a concept domain’s example codes live?

**Tables:** 0093, 0340, 0451  
**Goes to:** V2 Management

These three tables are declared _Concept Domain Only_ and yet each publishes a small set of codes — three, two and one respectively. That is not a contradiction: the V3 requirements for declaring a concept domain **call for example codes**, so the tables are conforming. It does leave the codes with nowhere obvious to go. A concept domain is not a code system, so the examples cannot be concepts; and a domain is bound with an extension on the binding rather than through a value set, so there is no value set to put them in either. **No CodeSystem and no ValueSet is minted for any of the three**, and nothing in THO or UTG carries one today, so nothing has to be unpicked whichever way this goes.

**The ask:** The likely representation is a **concept property on the concept in the concept domain code system**, carrying the example codes. Confirm that shape, or name another. Until it is decided the example codes are extracted and held but not published anywhere.

<a id="16"></a>

## 16. Three “tables” that carry no terminology at all

**Tables:** 0010, 0188, 9999  
**Goes to:** V2 Management

Of the 799 sections in Chapter 2C, exactly three declare no concept domain, no code system, no value set and no codes. `0010` _Physician ID_ and `0188` _Operator ID_ are User tables whose descriptions end “No suggested values” — they are site-defined identifiers, and were arguably never code tables. `9999` _Placeholder Table Representation_ is not a table at all: it carries the literal placeholder strings `noObject` and `noDescription`, the same markers that appear in the two concept-domain-only tables. **Checked against both THO and the UTG repository: there is no CodeSystem and no ValueSet for any of the three.** Nothing has been minted for them and nothing needs to be withdrawn.

**The ask:** Confirm that 0010 and 0188 should be concept domains rather than code tables, and decide what becomes of 9999 — a placeholder that occupies a table number is a trap for anyone generating resources from the chapter mechanically. This project writes nothing for any of the three.

<a id="17"></a>

## 17. Two table headings are styled `Normal` instead of `Heading 3`

**Tables:** 0685, 0767  
**Goes to:** V2 Management

Both tables are consequently absent from the document's own table of contents, and both were invisible to extraction until they were special-cased. Their content is complete and is extracted in full; the defect is in the styling of the published document. Recorded here for completeness — it is the smallest item on this list and needs nothing from this project.

**The ask:** Fix the styles in a future publication.
