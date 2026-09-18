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
14. [Twenty-three concepts have a code that is nothing but punctuation](#14) — 0005, 0066, 0093, 0200, 0255, 0291, 0359, 0365, 0366, 0367, 0418, 0466, 0487, 0492, 0505, 0523, 0544
15. [Table 0954's logical definition would include an abstract concept THO's equivalent excludes](#15) — 0954, 0957
16. [Where should a concept domain’s example codes live?](#16) — 0093, 0340, 0451
17. [Three “tables” that carry no terminology at all](#17) — 0010, 0188, 9999
18. [Chapter 2C deprecates tables 0567 and 0568 — does anything in THO get deprecated with them?](#18) — 0567, 0568
19. [Table 0823 _Sexual Orientation_ draws on three code systems and has no value set in THO](#19) — 0823
20. [Table 0459 names its code system only by an OID that nothing resolves](#20) — 0459
21. [User-defined tables are treated three different ways, and two of them get a freshly minted canonical](#21) — 0460, 0411, 0093
22. [Table 0725 _Mood Codes_ omits the URI of the v3 code system it draws from](#22) — 0725
23. [Table 0340's code grid lists code systems, not codes](#23) — 0340
24. [Two table headings are styled `Normal` instead of `Heading 3`](#24) — 0685, 0767
25. [Four THO value sets draw from v2 code systems that THO does not publish, so they cannot expand](#25) — 0350, 0351, 0456, 0895
26. [THO's `v2-tables` names 35 concept domains that `conceptdomains` does not define](#26) — 35 tables in v2-tables, none of them in Chapter 2C 2.9.1
27. [`v2-tables` misspells the concept domain for table 0034 as `SiteAdminstered`](#27) — 0034
28. [Table 0133 says three incompatible things about itself, and THO publishes nine codes for it](#28) — 0133
29. [Chapter 2C and THO give different OIDs for the same two artifacts, which versioning cannot reconcile](#29) — 0001, 0719
30. [Chapter 2C gives every table its own OID, and this guide publishes it nowhere](#30) — 798 tables
31. [The concept statuses `N` and `B` are defined nowhere, and `N` decays](#31) — 25 tables, 261 concepts
32. [Does reordering a code system's concepts count as a change for versioning?](#32) — 32 tables
33. [How far does the description “editorial corrections” carve-out reach?](#33) — policy; 12 descriptions, 25 concepts
34. [Two THO descriptions carry text the chapter's do not, including THO documenting its own error](#34) — 0227, 0719

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

**The ask:** Is this table salvageable, or is it a concept domain with no usable code system? If it is to be fixed, the fix has to be coordinated with TSMG so Chapter 2C and THO move together. **This project's working decision changed on 2026-09-17 (ADR-0010): it now publishes both the CodeSystem and the ValueSet**, carrying the chapter's five codes. The earlier decision was concept domain only, and it was reversed because the `noObject` marker is contradicted by everything around it — the chapter's own five codes, the value set OID it prints, its `all codes` content logical definition, and THO's existing pair. Treating the marker as authoritative was losing published content _and_ putting us in conflict with THO rather than agreement with it. **The naming problem this item is really about is untouched by that change**: four of the five codes are still units of time under a table called Quantity Units, in our output and in THO's alike. That still needs V2 Management and TSMG together, and **we are not proposing to alter THO's existing records unilaterally.** The contradiction is stated in the guide itself, on the General questions page, so a reader meets it rather than having to find this register.

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

Tables 0560 (Quantity Units) and 0910 (Acquisition Modality) each carry a Code System Identification block reading OID `-`, symbolic name `noObject`, description `noDescription`, and — again copy-pasted from somewhere else — `Full Name: Name Representation Code System`. These are not values; they are a tool's way of saying the field was left blank, and they were published. Worth noting that this placeholder appears in exactly these two sections and nowhere else in Chapter 2C, and that both are tables with no genuine code system. The placeholder is a reliable marker of the condition, not random noise. **The two tables have then been treated completely differently downstream, and that is the finding.** They present identically in the chapter: same placeholder block, same absence of a code system, both declaring a concept domain and a value set. **For 0910, THO has nothing** — no CodeSystem, no ValueSet, and neither does the UTG repository. The chapter declares no code system, so none was minted. That is the treatment that follows from the source. **For 0560, THO publishes both** `CodeSystem/v2-0560` and `ValueSet/v2-0560` at version 3.0.0, and so does UTG. The CodeSystem is `content: complete` and carries five concepts — `FL` Units, `DY` Days, `HS` Hours, `MN` Month, `YY` Years — under the title _Quantity Units_ and the description “HL7-defined code system of concepts specifying the adjustment quantity”. Four of the five are units of time. So a code system was minted at an HL7 canonical for a table whose source declares none, and the content it was filled with is the same content flagged as wrong elsewhere on this list. **Since 2026-09-17 this project publishes both 0560 resources (ADR-0010) and still writes nothing for 0910.** The two are separated on evidence rather than by name: the placeholder is overridden only where the chapter lists codes under it, THO publishes a code system at the table's own canonical, and the chapter declares a value set. 0560 is the only table in the corpus that meets all three; 0910 meets none. The placeholders themselves remain a defect in the published chapter either way.

**The ask:** Two questions, and the second is the one that needs both groups. First, should the placeholder blocks be removed from the published chapter, and should a table with no code system simply have no Code System Identification block? Second: **0560 and 0910 present identically in the chapter and have been handled in opposite ways downstream.** Either 0910 is missing resources or 0560 has resources it should never have had. This project now follows THO on both — publishing 0560's pair and nothing for 0910 — which removes the divergence from published THO content but does not answer the question. Confirm whether that split is correct, or whether both tables should be treated the same way. **Nothing will be altered in THO's existing records on this project's initiative.**

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

Found while checking a generated resource rather than by looking for it. Table 0227's value set description ends “… the code system may be acce”. Sweeping the corpus for the same shape found **sixteen Value Set descriptions that end without terminal punctuation, every one of them between 242 and 252 characters long**. Nothing else in the chapter behaves this way: Code System descriptions run to 500 and 800 characters and end in complete sentences, and the same tables' own table-level descriptions are complete — 0227's runs to 582 characters and finishes cleanly. So this is not extraction loss and not an authoring habit; it is **a length cap of roughly 250 characters applied to one field** somewhere in the publication toolchain. **This one does reach the output.** Unlike the Full Name defects, the Value Set Description becomes `ValueSet.description`, so sixteen generated ValueSets currently carry a sentence that stops mid-word. **THO was checked as a recovery source and is not one.** All sixteen tables have a ValueSet in `hl7.terminology.r5`, all sixteen carry a description, and **fifteen of them are truncated at exactly the same point** — identical text once whitespace and this project's own text policy are normalized on both sides. So the defect did not originate in this extraction and it did not originate in the chapter's rendering: the same clipped field fed both documents, and the truncated text is already published in THO. **The single exception is table 0227, and it is the proof.** THO's `ValueSet/v2-0227` continues past the cut with 171 more characters, completing the very word the chapter stops in the middle of — “may be acce” becomes “may be accessed via” followed by the PHIN VADS link for the MVX code system. One table's full text therefore survives somewhere, which is good evidence the other fifteen do too.

**The ask:** **Recover the fifteen full descriptions from whatever source Chapter 2C is generated from** — most likely whoever maintains the chapter's underlying table content holds them intact, since the loss is at publication rather than at authoring. This project can detect the truncation but cannot reconstruct the text, and inventing an ending would be worse than publishing the fragment. On the errata guidance this is content lost during the editing process rather than a change of meaning, so **restoring it should qualify as a technical correction** and need no ballot. Two things follow that are worth deciding at the same time. 0227's full text is available now from THO and can be restored immediately on the same reasoning; say whether to take it. And because the truncated text is already published in THO, the correction needs to be made in both places or the two will diverge. Every affected table is listed below with the text as it currently stands.

| Table | Name | Chars | Value Set description as published | In THO |
|---|---|---|---|---|
| 0038 | Order status | 252 | Value Set of codes that specify the status of an order. The purpose of these values are to report the status of an order either upon request (solicited), or when the status changes (unsolicited). The values are not intended to initiate action. It is as | Identical, truncated at the same point. |
| 0170 | Derived Specimen | 252 | Value Set of codes that specify the parents and children for diagnostic studies, especially in microbiology, where the initial specimen (e.g., blood) is processed to produce results (e.g., the identity of the bacteria grown out of the culture). The pro | Identical, truncated at the same point. |
| 0227 | Manufacturers of Vaccines (code=MVX) | 252 | Value Set of codes that specify the organization that manufactures a vaccine. The values are maintained by the US Centers of Disease Control. Note that the source of truth for these code values are maintained by the CDC, and the code system may be acce | THO carries the complete text. |
| 0254 | Kind of Quantity | 242 | Value Set of codes that describe the underlying kind of property represented by an observation. The categories distinguish concentrations from total amounts, molar concentrations from mass concentrations, partial pressures from colors, and so | Identical, truncated at the same point. |
| 0315 | Living Will Code | 251 | Value Set of codes that specify whether or not the patient has a living will and, if so, whether a copy fo the living will is on file at the healthcare facility. If the patient does not have a living will, the value of this field indicates whether the | Identical, truncated at the same point. |
| 0326 | Visit Indicator | 251 | Value Set of codes that specify the level on which data are being sent. It is the indicator used to send data at two levels, visit and account. HL7 recommends sending an "A" or no value when the data in the message are at the account level or "V" to i | Identical, truncated at the same point. |
| 0335 | Repeat Pattern | 244 | Value Set of codes that specify the interval between repeated services. See the Comment/Usage Note in the table below, as the table contains both precoordinated codes that may be used in an HL7 field or component and also explanatory patterns i | Identical, truncated at the same point. |
| 0389 | Analyte Repeat Status | 244 | Value Set of codes identifying the repeat status for the analyte/result (e.g., original, rerun, repeat, reflex). The following are assumptions regarding the table values: Repeated without dilution — performed usually to confirm correctness of r | Identical, truncated at the same point. |
| 0392 | Match Reason | 242 | Value Set of codes identifying what search components (e.g., name, birthdate, social security number) of the record returned matched the original query where the responding system does not assign numeric match weights or confidence levels. It | Identical, truncated at the same point. |
| 0406 | Participant Organization Unit Type | 244 | Value Set of codes that specify the environment in which the provider acts in the role associated with the provider type, and inludes codes for venues outside of formal organized healthcare settings, such as Home. The provider environment is no | Identical, truncated at the same point. |
| 0508 | Blood Product Processing Requirements | 243 | Value Set of codes that specify additional information about the blood component class associated with the Universal Service ID. The placer of the order can specify any required processing of the blood product that must be completed prior to t | Identical, truncated at the same point. |
| 0510 | Blood Product Dispense Status | 245 | Value Set of codes that specify the current status of the specified blood product as indicated by the filler or placer. For example, the first status change of a product that may trigger a Blood Product Dispense Status Message occurs when it fir | Identical, truncated at the same point. |
| 0511 | BP Observation Status Codes Interpretation | 245 | Value Set of codes that specify the interpretation for the blood product observation status codes. A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first c | Identical, truncated at the same point. |
| 0513 | Blood Product Transfusion/Disposition Status | 245 | Value Set of codes that specify the current status of the specified blood product as indicated by the placer. For example, the placer may return the blood product to the transfusion service unused because an IV could not be started. The blood co | Identical, truncated at the same point. |
| 0520 | Message Waiting Priority | 244 | Value Set of codes that specify how important the most important waiting mesasge is. For example, if there are 3 low priority messages, 1 medium priority message and 1 high priority message, the message waiting priority would be "high", because | Identical, truncated at the same point. |
| 0544 | Container Condition | 244 | Value Set of codes that specify at each receipt the status of the container in which the specimen is shipped in chain of custody cases where specimens are moved from lab to lab. If the container is compromised in any way (seal broken, container | Identical, truncated at the same point. |

<a id="14"></a>

## 14. Twenty-three concepts have a code that is nothing but punctuation

**Tables:** 0005, 0066, 0093, 0200, 0255, 0291, 0359, 0365, 0366, 0367, 0418, 0466, 0487, 0492, 0505, 0523, 0544  
**Goes to:** V2 Management + TSMG

Noticed in table 0291, whose code system carries a concept whose code is a single ellipsis character. Sweeping both Chapter 2C and THO's v2 code systems for the same shape — a code with no letter and no digit anywhere in it — found **23 concepts across 17 tables**. They are not one problem but three, and only the first is defensible. **Four are genuine codes and should be left alone.** `*` in 0255 and 0505, `#` in 0505 and `%` in 0523 all carry real definitions — _Indicates a percent change_, _The first service request in a cyclic group_. A single-character symbol is an awkward code but it is a code, and all four are in both sources. **Eighteen are an ellipsis placeholder masquerading as a concept** — 13 written as three full stops and 5 as the single ellipsis character. Their display text gives them away: _No suggested values defined_, _user-defined codes_, _see chapter 3_. These are rows that said “nothing to see here” in a printed table and were then loaded as though they were content. Nobody can send `...` in a message and mean anything by it. **Five tables carry the same placeholder twice.** 0291, 0365, 0366, 0367 and 0418 each have `...` (three full stops) _and_ `…` (one ellipsis character) as two separate concepts, with identical display text where they have any. That is one placeholder encoded two ways and minted as two codes. In 0418 the ellipsis concept has **no display text at all**. **This is overwhelmingly a THO problem rather than a chapter problem.** Sixteen of the 23 exist only in THO, six are in both, and one — 0093's `...` — is only in Chapter 2C. Every duplicate pair is THO-only. So the chapter has largely stopped publishing these and THO has gone on carrying them, which is the pattern this whole baseline exercise exists to correct. One further oddity: 0492's code is `??`, displayed _Inappropriate due to ..._ — a display that is itself truncated, beside a code that looks like a data-entry artefact.

**The ask:** **Review all 23 and say which are real.** The recommendation is: keep the four symbol codes; retire the ellipsis placeholders, which were never concepts; and for the five duplicate pairs retire at least the redundant spelling even if the placeholder itself is kept. Nothing is proposed for this release — the chapter is reproduced as published, so 0093's placeholder is currently emitted as a concept and the THO-only ones are untouched. But these codes are in published code systems today, so retiring them is a change to content in the field and needs a decision from the owners rather than from this project. Listed in full below.

| Table | Name | Code | Display | Appears in |
|---|---|---|---|---|
| 0005 | Race | ... | see chapter 3 | THO only |
| 0066 | Employment Status | ... | see chapter 6 | THO only |
| 0093 | Release Information | ... | user-defined codes | Chapter 2C only |
| 0200 | Name Type | ... | No suggested values defined | THO only |
| 0255 | Duration Categories | * | (asterisk) Life of the "unit" | Chapter 2C and THO |
| 0291 | Subtype of Referenced Data | ... | Source RFC 2046 | THO only |
| 0291 | Subtype of Referenced Data | … | Source RFC 2046 | THO only |
| 0359 | Diagnosis Priority | ... | No suggested values defined | THO only |
| 0365 | Equipment State | ... | (null) No state change | THO only |
| 0365 | Equipment State | … | (null) No state change | THO only |
| 0366 | Local/Remote Control State | ... | (null) No state change | THO only |
| 0366 | Local/Remote Control State | … | (null) No state change | THO only |
| 0367 | Alert Level | ... | (null) No level change | THO only |
| 0367 | Alert Level | … | (null) No level change | THO only |
| 0418 | Procedure Priority | ... | No suggested values defined | Chapter 2C and THO |
| 0418 | Procedure Priority | … | (none) | THO only |
| 0466 | Ambulatory Payment Classification Code | ... | No suggested values defined | Chapter 2C and THO |
| 0487 | Specimen Type | ... | No suggested values | THO only |
| 0492 | Specimen Appropriateness | ?? | Inappropriate due to ... | THO only |
| 0505 | Cyclic Entry/Exit Indicator | # | The last service request in a cyclic group. | Chapter 2C and THO |
| 0505 | Cyclic Entry/Exit Indicator | * | The first service request in a cyclic group | Chapter 2C and THO |
| 0523 | Computation Type | % | Indicates a percent change | Chapter 2C and THO |
| 0544 | Container Condition | ... | No suggested values | THO only |

<a id="15"></a>

## 15. Table 0954's logical definition would include an abstract concept THO's equivalent excludes

**Tables:** 0954, 0957  
**Goes to:** V2 Management + TSMG

Both tables define their value set as a subtree of `v3-ObservationValue`. 0957 _Employment Status_ says it in two clauses — _Include codes … where concept is-a `_EmploymentStatus`_, then _Exclude codes where code = `_EmploymentStatus`_. That second clause matters: in FHIR, an `is-a` filter includes the concept it is rooted at, and `_EmploymentStatus` is an abstract grouper that should never be sent in a message. The exclusion is what makes the value set mean “the actual statuses”. **0954 _Work Schedule_ has the include clause and no exclude clause**, so read literally its value set contains the abstract `_WorkSchedule` grouper. THO's own `ValueSet/v3-WorkScheduleODH` **does** exclude it, and is otherwise identical to 0957's shape. So either the chapter dropped a clause from 0954, or the two tables genuinely differ — and nothing in the text says which. This project builds what the chapter says, so **the generated `ValueSet/v2-0954` currently has no exclude** and differs from THO on exactly this point. **There is a second line of defence, and it is the reason this is worth stating carefully rather than simply fixing.** Both groupers carry `notSelectable = true` as a concept property in THO's `CodeSystem/v3-ObservationValue` — verified on both `_WorkSchedule` and `_EmploymentStatus`. A terminology server that honours that property will keep the abstract concept out of the expansion whether or not the value set excludes it, which makes the exclude clause _optional_ rather than load-bearing. But `notSelectable` is an advisory property, and honouring it in expansion is a matter of server implementation rather than something the value set can require. An explicit exclude does not depend on any server behaviour; relying on the property does.

**The ask:** Confirm that 0954 is missing an _Exclude codes where code = `_WorkSchedule`_ clause, in which case it is a technical correction and one line to apply. If the omission is deliberate, say so, because the value set then diverges from THO's and somebody will raise it again. The recommendation is to add it regardless of the `notSelectable` safety net: the clause costs nothing, it makes 0954 consistent with its sibling 0957 and with THO, and it removes a dependency on how a given expansion engine treats an advisory property.

<a id="16"></a>

## 16. Where should a concept domain’s example codes live?

**Tables:** 0093, 0340, 0451  
**Goes to:** V2 Management

These three tables are declared _Concept Domain Only_ and yet each publishes a small set of codes — three, two and one respectively. That is not a contradiction: the V3 requirements for declaring a concept domain **call for example codes**, so the tables are conforming. It does leave the codes with nowhere obvious to go. A concept domain is not a code system, so the examples cannot be concepts; and a domain is bound with an extension on the binding rather than through a value set, so there is no value set to put them in either. **No CodeSystem and no ValueSet is minted for any of the three**, and nothing in THO or UTG carries one today, so nothing has to be unpicked whichever way this goes.

**The ask:** The likely representation is a **concept property on the concept in the concept domain code system**, carrying the example codes. Confirm that shape, or name another. Until it is decided the example codes are extracted and held but not published anywhere.

<a id="17"></a>

## 17. Three “tables” that carry no terminology at all

**Tables:** 0010, 0188, 9999  
**Goes to:** V2 Management

Of the 799 sections in Chapter 2C, exactly three declare no concept domain, no code system, no value set and no codes. `0010` _Physician ID_ and `0188` _Operator ID_ are User tables whose descriptions end “No suggested values” — they are site-defined identifiers, and were arguably never code tables. `9999` _Placeholder Table Representation_ is not a table at all: it carries the literal placeholder strings `noObject` and `noDescription`, the same markers that appear in the two concept-domain-only tables. **Checked against both THO and the UTG repository: there is no CodeSystem and no ValueSet for any of the three.** Nothing has been minted for them and nothing needs to be withdrawn.

**The ask:** Confirm that 0010 and 0188 should be concept domains rather than code tables, and decide what becomes of 9999 — a placeholder that occupies a table number is a trap for anyone generating resources from the chapter mechanically. This project writes nothing for any of the three.

<a id="18"></a>

## 18. Chapter 2C deprecates tables 0567 and 0568 — does anything in THO get deprecated with them?

**Tables:** 0567, 0568  
**Goes to:** V2 Management + TSMG

Both table descriptions say so outright: _“Note this table has been deprecated and is replacaced by table 0929”_ for Weight Units, and the same sentence naming 0930 for Volume Units. (The misspelling is the chapter's.) But the deprecation was recorded in prose only, and nothing downstream reflects it. **The value sets were not deprecated.** THO publishes `ValueSet/v2-0567` and `ValueSet/v2-0568` as live resources alongside `v2-0929` and `v2-0930`, none of them carrying a deprecation marker, and this project reproduces all four. So a consumer reading THO cannot tell that two of the four are superseded. **The chapter contradicts itself on identity.** Table 0567 prints its own value set URI as `http://terminology.hl7.org/ValueSet/v2-0929` and 0568 prints `…/v2-0930` — the replacement's canonical, not its own. Under the rule that a canonical URL is an identifier and THO's existing one wins, this project publishes them at `v2-0567` and `v2-0568`, which is why no collision occurred. Had the chapter's printed URI been honoured, two pairs of resources would have claimed the same canonical. **Separately, the contents do not match the description.** 0568's concept domain is “the domain of possible values of units of measure that are used to specify volume” and its code system is UCUM, but it enumerates three codes; 0567 enumerates four. These are a small subset of the UCUM units for the quantity, so the CLD and the description promise a great deal more than the value set delivers.

**The ask:** Two questions, and the first is the one that needs a group rather than an individual. **(1)** Chapter 2C deprecated these tables; does a concomitant deprecation need to be reflected in THO — marking `ValueSet/v2-0567` and `v2-0568` deprecated or retired — or does the chapter's prose deprecation stop at the chapter? This project currently publishes both as live, which is fidelity to THO and arguably not fidelity to the chapter. **(2)** Is the enumerated subset intended, or should these value sets be an intensional reference to the UCUM units for the quantity? Note that whichever way (2) goes, it applies equally to the replacements 0929 and 0930.

<a id="19"></a>

## 19. Table 0823 _Sexual Orientation_ draws on three code systems and has no value set in THO

**Tables:** 0823  
**Goes to:** V2 Management + TSMG

The table is `Type: HL7-EXT`, stewarded by PA, and declares three code systems — SNOMED CT, `DataAbsentReason` and `NullFlavor`. Drawing a value set from three code systems is perfectly normal, and the table does print its five codes. **What is missing is the value set itself: THO publishes no `ValueSet/v2-0823`.** The writer cannot proceed because the chapter does not state which of the three declared systems each code belongs to, so it emits nothing. The pattern is worth noting: this is the sister table to `0821` _Gender Identity_, built the same way and recorded above for having its grid emptied in publication. Both are Gender Harmony Project material. The plausible reading is that both were entered into Chapter 2C in anticipation of a V2 implementation that was subsequently not carried through — which would explain why one lost its codes and the other never got a value set in THO.

**The ask:** Confirm whether tables 0821 and 0823 are live commitments or abandoned ones. If live, the per-code system assignments are needed before a value set can be generated, and a `ValueSet/v2-0823` needs to exist in THO. If they were dropped, say so and this project will record them as published-but-unimplemented rather than as blockers.

<a id="20"></a>

## 20. Table 0459 names its code system only by an OID that nothing resolves

**Tables:** 0459  
**Goes to:** V2 Management + TSMG

`0459` _Reimbursement Action Code_ is an External table stewarded by FM. It declares one code system, `cms-OCEEditCode-cs`, identified solely by OID `2.16.840.1.113883.6.301.9` with no URI. **Neither THO nor the FHIR core packages resolve that OID to a canonical URL**, so there is no way to say what code system the table's four codes belong to. The writer therefore emits nothing for this table — not a CodeSystem, not a ValueSet — and it is one of only two tables in the chapter blocked this way. Note the reviewer's separate reading that this table may be better modelled as a concept domain, which would dissolve the question rather than answer it.

**The ask:** Supply the canonical URL for the CMS OCE Edit Code system, or confirm that an external code system record needs to be created in THO for it. If neither is available, decide whether 0459 should become concept-domain-only, in which case no value set is needed and the OID becomes documentation rather than a dependency.

<a id="21"></a>

## 21. User-defined tables are treated three different ways, and two of them get a freshly minted canonical

**Tables:** 0460, 0411, 0093  
**Goes to:** V2 Management

`0460` _Denial or Rejection Code_ and `0411` _Supplemental Service Information Values_ are the **only two tables in the whole chapter** for which this project mints a new CodeSystem canonical — every other code-bearing table either reuses a THO canonical or draws on another authority's code system. Both are `Type: User`. A user-defined table is by definition a set of suggested values that an implementation is expected to replace, so minting `CodeSystem/v2-0460` publishes suggestions with the authority of a standard code system. **The chapter is not consistent about this.** Compare `0093` _Release Information_, also `Type: User`, which is declared concept-domain-only and so produces no code system and no value set at all — even though it lists `Y` and `N` in its grid. Three user tables, three outcomes: 0460 and 0411 get minted resources, 0093 gets nothing. Nothing in the chapter explains the difference. 0411 additionally has the defect already recorded above — the chapter prints a canonical for a resource that does not exist — and is a mess independent of this question.

**The ask:** Decide what a user-defined table should produce. Options: a CodeSystem and ValueSet like any other (the current behaviour), a concept domain only (as 0093 is treated), or a ValueSet whose codes are marked as examples. The answer decides whether these two new canonicals should exist at all, and it should be applied to 0093 at the same time so that like tables are treated alike.

<a id="22"></a>

## 22. Table 0725 _Mood Codes_ omits the URI of the v3 code system it draws from

**Tables:** 0725  
**Goes to:** V2 Management

The table's code system block gives a symbolic name `actMood`, a description of `tbd`, and OID `2.16.840.1.113883.5.1001` — and **no URI field at all**. The codes are v3 ActMood codes, not v2 codes; THO's own `ValueSet/v2-0725` draws them from `http://terminology.hl7.org/CodeSystem/v3-ActMood`. **The output is already correct**, because the OID the chapter does print resolves through THO to exactly that URL, so the writer emits a value set only and points it at the v3 code system. Recorded because the defect is in the published chapter and will mislead anyone reading it directly: a reader sees a code system with no URI and a description of `tbd`, with nothing to indicate the codes are v3. It also means the correct result here depends entirely on OID resolution succeeding.

**The ask:** Confirm this as a technical correction under the editing-process test — add the URI `http://terminology.hl7.org/CodeSystem/v3-ActMood` and replace the `tbd` description. Nothing in the generated output changes.

<a id="23"></a>

## 23. Table 0340's code grid lists code systems, not codes

**Tables:** 0340  
**Goes to:** V2 Management

`0340` _Procedure Code Modifier_ is declared concept-domain-only, so this project writes nothing for it and nothing is blocked. But its code grid is not empty: it holds two rows, `CPTM` “CPT Modifier Code” and `HPC` “CMS (formerly HCFA) Procedure Codes (HCPCS)”, both with long comments citing the publishing body. **These are identifiers of external code systems, not concepts in a code system of the table's own.** The chapter is using the code grid for two incompatible purposes without distinguishing them, which is a trap for anyone generating resources from it mechanically — a naive reading mints a code system whose concepts are the names of other code systems. If the intent is that a procedure code modifier is drawn from CPT or HCPCS, those are external code systems that may warrant external code system records in THO.

**The ask:** Confirm that 0340 is correctly concept-domain-only and that the two rows are documentation of candidate external code systems rather than codes. If they are meant to be usable, they need to be expressed as external code system references rather than as grid rows.

<a id="24"></a>

## 24. Two table headings are styled `Normal` instead of `Heading 3`

**Tables:** 0685, 0767  
**Goes to:** V2 Management

Both tables are consequently absent from the document's own table of contents, and both were invisible to extraction until they were special-cased. Their content is complete and is extracted in full; the defect is in the styling of the published document. Recorded here for completeness — it is the smallest item on this list and needs nothing from this project.

**The ask:** Fix the styles in a future publication.

<a id="25"></a>

## 25. Four THO value sets draw from v2 code systems that THO does not publish, so they cannot expand

**Tables:** 0350, 0351, 0456, 0895  
**Goes to:** TSMG / UTG

Found by putting this corpus side by side with `hl7.terminology.r5#7.3.0` rather than by inspection. Each of these four value sets is published by THO at `ValueSet/v2-NNNN` and composes from `CodeSystem/v2-NNNN` at the matching canonical — and THO publishes no such code system. An expansion has nothing to draw from. **This is not a defect this project introduces or can repair.** Chapter 2C agrees with THO that these tables have no codes of their own: 0350 _Occurrence Code_, 0351 _Occurrence Span_ and 0456 _Revenue code_ all point at the National Uniform Billing Committee, and the chapter declares a concept domain for each rather than a code set. This guide therefore writes nothing for them, which is correct. The dangling value sets are THO's, and they predate us. 0895 _Present On Admission (POA) Indicator_ is the same shape but arrives by a different route: this project has it on the needs-decision list because its Content Logical Definition is not one of the shapes we build. Two neighbouring cases are **not** defects and should not be swept in: 0005 _Race_ and 0292 _Vaccines Administered_ also have THO value sets with no v2 code system, but they compose from the CDC race codes and CVX respectively — an external authority owning the codes is the intended arrangement, not a gap.

**The ask:** Decide what should happen to the four. Either the missing v2 code systems should be published, or the value sets should compose from the external authority that actually owns the codes (NUBC for three of them), or they should be retired. Whichever way it goes, it is worth asking how four unexpandable value sets came to be published, because the same process would produce more.

<a id="26"></a>

## 26. THO's `v2-tables` names 35 concept domains that `conceptdomains` does not define

**Tables:** 35 tables in v2-tables, none of them in Chapter 2C 2.9.1  
**Goes to:** TSMG / UTG

`CodeSystem/v2-tables` is THO's own index of V2 tables — 628 entries, each carrying properties including `vocab-domain`, the concept domain the table names. 624 entries carry a domain, and **37 of those name a concept that THO's own `conceptdomains` 3.0.0 does not contain**. This project's proposed additions happen to cover two of them (`DangerCode`, `Location`), leaving 35. **The gap is confined to tables the chapter has dropped.** All 35 sit among the 39 `v2-tables` entries that Chapter 2C 2.9.1 no longer carries at all, so no row of this guide is affected and nothing here is blocked. That also suggests the cause: when a table left the chapter its concept domain stopped being maintained, but its `vocab-domain` property stayed behind. Only three of the 39 are typed _no longer used_; the rest are still typed _HL7_ or _User_, so the index does not mark them as retired. **One caveat on how hard to push this.** `vocab-domain` is declared as type `string` rather than `code`, so it is not formally a reference into `conceptdomains` and nothing validates it. But 587 of 624 values do resolve, which makes the 37 look like drift rather than design.

**The ask:** Confirm that `vocab-domain` is meant to resolve into `conceptdomains`. If it is, either the 35 missing domains should be restored, or the entries that name them should be marked as no longer used, or the property should be cleared for tables that have left the standard. If it is genuinely a free string with no such contract, that is worth stating, because readers will assume otherwise. Retyping it as `code` would let validation catch the next occurrence.

<a id="27"></a>

## 27. `v2-tables` misspells the concept domain for table 0034 as `SiteAdminstered`

**Tables:** 0034  
**Goes to:** TSMG / UTG

`CodeSystem/v2-tables` gives table 0034 the `vocab-domain` `SiteAdminstered`, missing the second _i_ of _Administered_. The same entry's display is **SITE ADMINISTERED**, spelled correctly, which settles that this is a typo rather than a deliberate name. Neither `SiteAdminstered` nor a correctly spelled `SiteAdministered` exists in `conceptdomains`, so the property also resolves to nothing — it is one of the 35 gaps in `esc-v2tables-domain-gaps`. **This one is cheaper to fix than it looks, and it is worth being precise about why.** `v2-tables` is a convenience index that makes V2 table metadata available in THO. Nobody sends `SiteAdminstered` in a message and no instance data binds to it, so correcting the string breaks no implementation. That makes it a technical correction rather than a substantive change. **A typo in a real code, in a real code system, is a different problem entirely** — there the code is an identifier that implementations have already sent and stored, and the remedy is deprecation plus a correctly spelled replacement, not an edit. Nothing in that harder category has been found in the v2 tables so far; this item is deliberately not making that claim.

**The ask:** Correct the `vocab-domain` value for table 0034 to `SiteAdministered` as a technical correction. The change should still be traceable — recorded in the UTG change history like any other edit — but it does not need the deprecate-and-replace treatment that a published code would. Separately, whether the corrected domain should then be _defined_ in `conceptdomains`, or the property cleared because table 0034 has left the standard, is part of `esc-v2tables-domain-gaps`.

<a id="28"></a>

## 28. Table 0133 says three incompatible things about itself, and THO publishes nine codes for it

**Tables:** 0133  
**Goes to:** V2 Management

Table 0133 _Procedure practitioner identifier code type_ carries three statements that cannot all hold. **One:** its concept domain block sets `Concept Domain Only: yes`, and it publishes no code system, no value set and no codes — so this project writes nothing for it, which is the correct reading of that flag. **Two:** its own table metadata describes it as a code set: “HL7-defined table of concepts which specify the different types of practitioners associated with this procedure. _This set of codes is known to be incomplete._” A table that is concept-domain-only has no set of codes to be incomplete. **Three:** the same description says the table is obsolete — “as of v2.6, this table and the field(s) it was used in was replaced by table 443 used in the ROL segment” — yet its `Type` is `undefined` rather than anything marking it withdrawn, and it is still published in 2.9.1. **Meanwhile THO publishes `CodeSystem/v2-0133` with nine codes, `content: complete` and `status: active`,** plus a matching value set. So the chapter says there are no codes, says the codes are incomplete, and says the table was superseded in v2.6, while THO says there are nine active ones. This is why 0133 shows as _In THO, not here_ on the table index: the divergence is real and is not ours to resolve.

**The ask:** Decide what 0133 is. If it was genuinely replaced by table 0443 in v2.6, it should be marked withdrawn in the chapter and its THO code system and value set retired or deprecated, rather than left active. If it is still live, the `Concept Domain Only` flag contradicts both its own description and THO's nine codes, and one of the three has to give. Either way the description should stop asserting an incomplete code set for a table that publishes none.

<a id="29"></a>

## 29. Chapter 2C and THO give different OIDs for the same two artifacts, which versioning cannot reconcile

**Tables:** 0001, 0719  
**Goes to:** V2 Management + TSMG

Two artifacts carry a different `identifier` OID in Chapter 2C than the one THO publishes at the same canonical URL. **`CodeSystem/v2-0001` _Administrative Sex_:** the chapter gives `2.16.840.1.113883.18.458`, THO publishes `2.16.840.1.113883.18.2`. Both sit in the HL7 v2 code system arc, so neither is obviously a stray. This is the most widely implemented table in V2. The chapter's block is titled _Jurisdiction Gender Code System_, not _Administrative Sex_, and `...18.458` resolves to nothing anywhere in THO — so this may be a disagreement about _which code system_ the table points at rather than a mistyped digit. **`ValueSet/v2-0719`:** the chapter gives `2.16.840.1.113883.1.11.20429`, THO publishes `...20428`. These are adjacent but they are not near-misses: both are **v3** value set OIDs and both are in use, `...20428` for `ActInformationSensitivityPolicy`'s parent `InformationSensitivityPolicy` and `...20429` for `ActInformationSensitivityPolicy` itself. THO's `ValueSet/v2-0719` **shares** `...20428` with THO's own `v3-InformationSensitivityPolicy` — one OID on two artifacts — which fits THO's own description of 0719, that it “was created in THO in error due to an oversight in the import processing”. So the question is which v3 value set table 0719 corresponds to, not which digit is a typo. **Why this is not a versioning question.** The THO artifact versioning policy treats every other divergence found in this comparison as something a version increment covers. Identifiers are the exception: the policy states that an identifier cannot be changed or removed, that adding one makes it immutable, and that an identifier change requires a _new_ artifact rather than a new version — “extreme care must be taken with identifiers”. Publishing our OID at THO's canonical would therefore be a policy violation, not a bump. Every other artifact agrees. Counting the tables where Chapter 2C and THO _both_ give an OID for the same resource type: **395 of 396** code systems and **411 of 412** value sets carry identical identifiers.

**The ask:** Adjudicate each OID. For 0001, establish which of `...18.458` and `...18.2` is the registered identifier for the Administrative Sex code system, and correct the other source. For 0719, establish whether `...20429` or `...20428` is right. Until both are settled this project publishes THO's identifier rather than the chapter's, because the policy forbids changing a published identifier and the canonical URL is THO's. **That is now enforced in the pipeline** rather than left as a recommendation: the identifier is the one element where the chapter does not win a disagreement, because an identifier is identity rather than content. Both conflicts are recomputed on every run, so neither can drift out of view. **A third option has been raised and needs ruling on: publish _both_ OIDs as identifiers.** `identifier` is 0..* on both CodeSystem and ValueSet, so it is mechanically available, and it would avoid choosing before the committees have. It is not obviously right: two identifiers on one artifact asserts that both OIDs name it, which for 0719 is demonstrably false — `...20429` names a different v3 value set, which THO also publishes. Carrying both would be defensible for 0001, where the two may be the same code system under two registrations, and misleading for 0719. **Please rule per artifact rather than as a blanket policy.**

<a id="30"></a>

## 30. Chapter 2C gives every table its own OID, and this guide publishes it nowhere

**Tables:** 798 tables  
**Goes to:** V2 Management + TSMG

Chapter 2C carries **three** OIDs per table, in three separate metadata blocks, and they identify three different things: a **Table OID** in the `2.16.840.1.113883.12.*` arc (798 of 799 tables), a **Code System OID** in `...113883.18.*` (435 tables), and a **Value Set OID** in `...113883.21.*` (438 tables). THO uses the same two latter arcs for the same two resource types, so the code system and value set OIDs have an obvious home and are written to `CodeSystem.identifier` and `ValueSet.identifier`. **The table OID has no home.** In V2 the table is the thing with an identity; in FHIR that table becomes a code system _and_ a value set, and neither of them _is_ the table. So the `.12` OID is carried by no resource this guide publishes. That is not a decision anyone took — it is what happens by default when a one-to-one identifier meets a one-to-two split, and it means 798 published identifiers from the chapter appear in no output. Worth knowing before ruling: 50 of the 798 are not identifiers at all but the bare arc root `2.16.840.1.113883.1` with no leaf, on the 50 tables the chapter types _undefined_; and the table OID is not dead elsewhere — THO's own description of table 0227 cites PHIN VADS by the `.12.227` table OID, so implementers do resolve these.

**The ask:** Decide where a V2 table OID belongs in a FHIR representation of that table, and whether this guide should start writing it. The options each say something different and none is free. Putting it on the **CodeSystem** says the code system is the table, which is wrong for the 24 value-set-only tables whose codes belong to another authority. Putting it on **both** resources asserts one identifier for two artifacts, which is the same shape as the defect registered at `esc-oid-conflicts`. Putting it on the **concept domain** concept has no `identifier` element to hold it. Putting it **nowhere** is the current behaviour and may well be right — but it should be a ruling rather than an accident, because the identifier is in the published chapter and its absence from the FHIR artifacts is silent.

<a id="31"></a>

## 31. The concept statuses `N` and `B` are defined nowhere, and `N` decays

**Tables:** 25 tables, 261 concepts  
**Goes to:** V2 Management + TSMG

Chapter 2C carries its own legend for the status column: blank means an active code, `B` means “backwards-compatible use only”, `D` means “deprecated or inactive”, `R` means “retired”, and `N` means **“new in this release”**. Blank, `D` and `R` have unambiguous FHIR equivalents and are written as `active`, `deprecated` and `retired`. `N` and `B` do not, and both this project and THO pass them through as themselves. **Neither is defined anywhere.** The property they are written to is `status`, defined by FHIR at `http://hl7.org/fhir/concept-properties#status`, whose own definition reads “a code that indicates the status of the concept. Typical values are active, experimental, deprecated, and retired.” Neither `N` nor `B` is among them. They are not in `utg-concept-properties` either, and no value set enumerates them. Across the whole of `hl7.terminology.r5` they appear _only_ in v2 code systems — 210 concepts carry `N` and 6 carry `B`. **`N` is worse than undefined, because it decays.** “New in this release” was a statement about whichever release first printed it, and nothing updates it afterwards. That is visible in the data: THO still marks 210 concepts `N` from past releases while the 2.9.1 chapter marks only 70, and **205 of the 261 status disagreements between the chapter and THO are exactly this** — THO saying `N` where the current chapter says nothing, so this project publishes `active`.

**The ask:** Three remedies would each resolve this, and they are not the same decision. **One:** define `N` and `B` as concept properties in `utg-concept-properties`, so that what is already published is at least legal. **Two:** replace `N` with something that does not decay — the version a concept was introduced in is a fact that stays true, where a “new” flag silently expires. **Three:** rule that `N` is not a status at all and should not survive into FHIR. Meanwhile this project publishes the chapter's value, passes `N` and `B` through unchanged, and records all 261 disagreements.

<a id="32"></a>

## 32. Does reordering a code system's concepts count as a change for versioning?

**Tables:** 32 tables  
**Goes to:** TSMG

This project compares its concepts against THO's as a set keyed by code, so a code system whose codes are identical to THO's but listed in a different order is treated as unchanged and keeps THO's version. The reasoning is that order is not information in a flat code system: a `CodeSystem` with `hierarchyMeaning` of `is-a` and no nesting says nothing by putting one code before another. **32 tables carry exactly THO's codes in a different order.** If order is a change under the artifact versioning policy, those 32 all increment — and they increment again every time the chapter is re-laid-out, which is a version number spent on typesetting.

**The ask:** Confirm that concept order is not a versionable change, or say that it is. Either answer is one line in this project's comparison. The question is asked because the policy's element table lists `CodeSystem.concept (and all subelements)` without qualification, and a literal reading could be taken to cover sequence.

<a id="33"></a>

## 33. How far does the description “editorial corrections” carve-out reach?

**Tables:** policy; 12 descriptions, 25 concepts  
**Goes to:** TSMG

The Code Systems versioning policy qualifies exactly one element: `CodeSystem.description` is “major unless only change is improved clarity or perform editorial corrections”. This project applies that where it can do so honestly — where our description and THO's contain exactly the same words in the same order, so that only punctuation or spacing moved. **12 descriptions across 7 tables** are waived on that basis, every one of them our `e.g.,` against THO's `e.g.`, or our `code system.` against THO's `code system .`. Three things about this need confirming. **First, the rule itself:** is a punctuation-only difference an editorial correction? **Second, the asymmetry it creates.** The carve-out is written against `description` alone, while `CodeSystem.concept (and all subelements)` is listed unqualified. So **4 concept definitions and 21 concept displays that differ from THO only in punctuation do increment**. A comma in a description is free; the same comma in a display costs a major version. This project has not smoothed that over, because guessing at an unwritten carve-out is how a pipeline quietly stops matching the rules it claims to follow — but it looks more like an oversight than a decision. **Third, the Value Sets policy has no equivalent carve-out at all**, so read literally it makes every description difference a major increment however trivial. This project treats `ValueSet.description` exactly as it treats `CodeSystem.description`, rather than encode an asymmetry believed to be a drafting slip.

**The ask:** Confirm the punctuation waiver, say whether it should extend to concept definitions and displays, and confirm whether the missing ValueSet carve-out is deliberate. Each answer is a located change in this project; none of them is a rewrite.

<a id="34"></a>

## 34. Two THO descriptions carry text the chapter's do not, including THO documenting its own error

**Tables:** 0227, 0719  
**Goes to:** V2 Management + TSMG

Of the description differences between this project's output and THO, all but two are punctuation. These two are not, and in both THO's text carries something the chapter's does not. **`ValueSet/v2-0227`:** THO's description ends with a link to the code system on PHIN VADS. The chapter's stops before it, so publishing the chapter's drops a working source reference for a code system HL7 does not itself maintain. **`ValueSet/v2-0719`:** THO's description ends “Note that this resource was created in THO in error due to an oversight in the import processing.” That is THO documenting its own mistake in the artifact's description. It is not something Chapter 2C should inherit, but it does say the artifact needs attention rather than a redraft — and 0719 is also one of the two artifacts with an OID conflict. This project publishes the chapter's description in both cases and increments the version. The merge fills an absent value from THO but never splices two pieces of prose together, because concatenating them would publish text neither source wrote.

**The ask:** For 0227, decide whether the source reference should be carried into the chapter's description or dropped. For 0719, decide what should happen to a THO artifact whose own description says it was created in error — and settle that together with its OID conflict, since the two are likely the same story.
