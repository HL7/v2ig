# Chapter 2C defects, grouped for decision

Review list for V2 Management — 34 open findings.

This document replaces the blanket policy question `esc-retain-known-errors`. V2 Management ruled on 2026-10-08 that There is no one-size-fits-all answer to reproduce-or-correct. It has to be decided per class of defect and possibly case by case, with individual issues reviewed for decision.

Findings are grouped by class and ordered so the classes needing the cheapest answer come first. Each entry says what the chapter publishes, what this guide currently publishes, and the decision needed. Nothing here requires a general rule before an instance can be decided.

---

## Content lost in publication (2)

The chapter is missing content it was meant to carry, and in each case the intended content is recoverable or evidenced. Nothing here is a disagreement about what the standard should say — only about what the published document failed to say.

**Cost of granting the class:** Republish the affected block. No change to meaning, so nothing to ballot.

### Table 0821 Gender Identity publishes its coded content grid completely blank

**Tables:** 0821  
**Goes to:** V2 Management  
**Register id:** `esc-0821-blank-grid`

*Why this class: Six rows by five columns, every cell empty, in a fully populated section. THO's matching value set holds exactly the five concepts the row count implies.*

The grid is six rows by five columns and every cell is empty, while the section around it is fully populated: three code systems (SNOMED CT, FHIR DataAbsentReason, V3 NullFlavor), three code system versions, and a value set. Both extraction pipelines independently find zero codes, so this is the document rather than the tooling. The row count is the tell. Six rows is a header plus five code rows, and THO's ValueSet/gender-identity — whose OID 2.16.840.1.113883.4.642.3.3291 is exactly the one Chapter 2C prints for this value set — holds exactly five concepts: three SNOMED CT gender identities, asked-declined, and UNK. The grid was meant to carry those five and lost them somewhere in publication. Compare table 0823 Sexual Orientation, built the same way, which prints its codes. Minor, in the same section: the value set description runs two sentences together with no space — “…within their community.Used in HL7 Version 2.x messages”.

**What this guide publishes today:**

- `0821` Gender Identity: withheld on a ruling

**Decision needed:** Confirm the five intended codes and republish the grid. This project reuses THO's value set in the meantime, so nothing is blocked — but the published chapter is missing content and a reader of the PDF cannot tell what the table contains.

---

### Sixteen Value Set descriptions stop mid-word, all at about 250 characters

**Tables:** 0038, 0170, 0227, 0254, 0315, 0326, 0335, 0389, 0392, 0406, 0508, 0510, 0511, 0513, 0520, 0544  
**Goes to:** V2 Management  
**Register id:** `esc-truncated-value-set-descriptions`

*Why this class: Sixteen descriptions stop mid-word at about 250 characters. The cut-off is uniform, so the loss is at publication.*

Found while checking a generated resource rather than by looking for it. Table 0227's value set description ends “… the code system may be acce”. Sweeping the corpus for the same shape found sixteen Value Set descriptions that end without terminal punctuation, every one of them between 242 and 252 characters long. Nothing else in the chapter behaves this way: Code System descriptions run to 500 and 800 characters and end in complete sentences, and the same tables' own table-level descriptions are complete — 0227's runs to 582 characters and finishes cleanly. So this is not extraction loss and not an authoring habit; it is a length cap of roughly 250 characters applied to one field somewhere in the publication toolchain. This one does reach the output. Unlike the Full Name defects, the Value Set Description becomes ValueSet.description, so sixteen generated ValueSets currently carry a sentence that stops mid-word. THO was checked as a recovery source and is not one. All sixteen tables have a ValueSet in hl7.terminology.r5, all sixteen carry a description, and fifteen of them are truncated at exactly the same point — identical text once whitespace and this project's own text policy are normalized on both sides. So the defect did not originate in this extraction and it did not originate in the chapter's rendering: the same clipped field fed both documents, and the truncated text is already published in THO. The single exception is table 0227, and it is the proof. THO's ValueSet/v2-0227 continues past the cut with 171 more characters, completing the very word the chapter stops in the middle of — “may be acce” becomes “may be accessed via” followed by the PHIN VADS link for the MVX code system. One table's full text therefore survives somewhere, which is good evidence the other fifteen do too.

**What this guide publishes today:**

- `0038` Order status: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0170` Derived Specimen: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0227` Manufacturers of Vaccines (code=MVX): ValueSet published; code system is another body's — VS 4.0.0 (held)
- `0254` Kind of Quantity: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0315` Living Will Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0326` Visit Indicator: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0335` Repeat Pattern: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0389` Analyte Repeat Status: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 4.0.0 (incremented)
- `0392` Match Reason: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0406` Participant Organization Unit Type: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0508` Blood Product Processing Requirements: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0510` Blood Product Dispense Status: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0511` BP Observation Status Codes Interpretation: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0513` Blood Product Transfusion/Disposition Status: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0520` Message Waiting Priority: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0544` Container Condition: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)

**Decision needed:** Recover the fifteen full descriptions from whatever source Chapter 2C is generated from — most likely whoever maintains the chapter's underlying table content holds them intact, since the loss is at publication rather than at authoring. This project can detect the truncation but cannot reconstruct the text, and inventing an ending would be worse than publishing the fragment. On the errata guidance this is content lost during the editing process rather than a change of meaning, so restoring it should qualify as a technical correction and need no ballot. Two things follow that are worth deciding at the same time. 0227's full text is available now from THO and can be restored immediately on the same reasoning; say whether to take it. And because the truncated text is already published in THO, the correction needs to be made in both places or the two will diverge. Every affected table is listed below with the text as it currently stands.

---

## Presentation and wording (6)

Defects a reader notices and no processor does: styling, copy-paste in a metadata field, inconsistent phrasing. They are listed because they are wrong, not because they block anything.

**Cost of granting the class:** Editorial pass on the chapter. No effect on any artifact this guide publishes.

### All six UCUM-backed tables name the code system “Donation Duration Units Code System”

**Tables:** 0567, 0568, 0929, 0930, 0931, 0932  
**Goes to:** V2 Management  
**Register id:** `esc-ucum-full-name`

*Why this class: All six UCUM-backed tables carry the same copy-pasted Full Name. A metadata field, not a binding.*

Every table in Chapter 2C backed by UCUM carries the same Code System Identification block — OID 2.16.840.1.113883.6.8, symbolic name ucum, URI http://unitsofmeasure.org — with Full Name: Donation Duration Units Code System. Only 0932 is about donation duration; the name was copy-pasted across Weight Units, Volume Units and Temperature Units, twice over, since 0567/0568 duplicate 0929/0930. The name is wrong even on 0932. The code system being identified is UCUM, so its full name is the Unified Code for Units of Measure, not the name of whichever table happens to point at it.

**What this guide publishes today:**

- `0567` Weight Units: withheld on a ruling
- `0568` Volume Units: withheld on a ruling
- `0929` Weight Units: ValueSet published; code system is another body's — VS 4.0.0 (incremented)
- `0930` Volume Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)
- `0931` Temperature Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)
- `0932` Donation Duration Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)

**Decision needed:** Cleared to correct. Measured against HL7's errata guidance this is squarely a technical correction — a name inconsistently applied during editing, where fixing it makes the chapter say what was plainly intended. Set the Full Name to UCUM's own name in all six. Note that this changes no generated resource. UCUM is an external code system, so these six tables produce a ValueSet and no CodeSystem, and the ValueSet takes its name and description from the Value Set block rather than the Code System block. The correction is to the chapter, and to the report that mirrors it.

---

### The copy-pasted Full Name is not confined to the UCUM tables

**Tables:** 0001, 0125, 0180, 0203, 0458, 0820 and others  
**Goes to:** V2 Management  
**Register id:** `esc-full-name-copy-paste`

*Why this class: The same copy-paste beyond the UCUM tables. Separating genuine exceptions from errors needs somebody who knows the tables.*

Checking the UCUM finding against the whole chapter turned up the same defect elsewhere. 412 of the 444 Code System Identification blocks follow the pattern &lt;Table Name&gt; Code System exactly, which makes the exceptions easy to see. Some are legitimate — a table pointing at SNOMED CT or ISO 3166 should name that system, not itself. Others are the UCUM defect again, a name carried over from a different table: 0001 Administrative Sex is named “Jurisdiction Gender Code System”, 0125 Value Type is “Data Types”, 0180 Masterfile Action Code is “Record-level Event Code”, 0203 Identifier Type is “Practitioner ID Number Type”, 0458 OCE Edit Code is “Reimbursement Action Code”, 0820 Gender Harmony Concepts is “Personal Pronouns”. One more, 0232, begins with a stray hyphen: - Insurance Company Contact Reason Code System. Like the UCUM case, none of this reaches a generated resource; the emitted name and title come from the symbolic name.

**What this guide publishes today:**

- `0001` Administrative Sex: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0125` Value Type: ValueSet published; code system is another body's — VS 3.0.0 (held)
- `0180` Masterfile Action Code: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0203` Identifier Type: CodeSystem + ValueSet published — CS 6.0.0 (incremented) VS 3.0.0 (held)
- `0458` OCE Edit Code: ValueSet published; code system is another body's — VS 1.0.0 (held)
- `0820` Gender Harmony Concepts: ValueSet published; code system is another body's — VS 1.0.0 (held)

**Decision needed:** If the UCUM correction is approved as a technical correction, the same reasoning covers these. Someone who knows the tables needs to separate the genuine exceptions from the copy-paste errors — this project can produce the candidate list but cannot make that call.

---

### Two tables publish literal placeholder text — noObject and noDescription

**Tables:** 0560, 0910  
**Goes to:** V2 Management  
**Register id:** `esc-placeholder-metadata`

*Why this class: Literal noObject and noDescription placeholder text reaching print. The 0560 half of it is a content error and is listed there.*

Tables 0560 (Quantity Units) and 0910 (Acquisition Modality) each carry a Code System Identification block reading OID -, symbolic name noObject, description noDescription, and — again copy-pasted from somewhere else — Full Name: Name Representation Code System. These are not values; they are a tool's way of saying the field was left blank, and they were published. Worth noting that this placeholder appears in exactly these two sections and nowhere else in Chapter 2C, and that both are tables with no genuine code system. The placeholder is a reliable marker of the condition, not random noise. The two tables have then been treated completely differently downstream, and that is the finding. They present identically in the chapter: same placeholder block, same absence of a code system, both declaring a concept domain and a value set. For 0910, THO has nothing — no CodeSystem, no ValueSet, and neither does the UTG repository. The chapter declares no code system, so none was minted. That is the treatment that follows from the source. For 0560, THO publishes both CodeSystem/v2-0560 and ValueSet/v2-0560 at version 3.0.0, and so does UTG. The CodeSystem is content: complete and carries five concepts — FL Units, DY Days, HS Hours, MN Month, YY Years — under the title Quantity Units and the description “HL7-defined code system of concepts specifying the adjustment quantity”. Four of the five are units of time. So a code system was minted at an HL7 canonical for a table whose source declares none, and the content it was filled with is the same content flagged as wrong elsewhere on this list. Since 2026-09-17 this project publishes both 0560 resources (ADR-0010) and still writes nothing for 0910. The two are separated on evidence rather than by name: the placeholder is overridden only where the chapter lists codes under it, THO publishes a code system at the table's own canonical, and the chapter declares a value set. 0560 is the only table in the corpus that meets all three; 0910 meets none. The placeholders themselves remain a defect in the published chapter either way.

**What this guide publishes today:**

- `0560` Quantity Units: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0910` Acquisition Modality: concept domain only, no artifact

**Decision needed:** Two questions, and the second is the one that needs both groups. First, should the placeholder blocks be removed from the published chapter, and should a table with no code system simply have no Code System Identification block? Second: 0560 and 0910 present identically in the chapter and have been handled in opposite ways downstream. Either 0910 is missing resources or 0560 has resources it should never have had. This project now follows THO on both — publishing 0560's pair and nothing for 0910 — which removes the divergence from published THO content but does not answer the question. Confirm whether that split is correct, or whether both tables should be treated the same way. Nothing will be altered in THO's existing records on this project's initiative.

---

### “All codes” is used where a value set enumerates a handful of UCUM codes

**Tables:** 0929, 0930, 0931, 0932  
**Goes to:** V2 Management  
**Register id:** `esc-cld-inconsistent`

*Why this class: “All codes” used where a value set enumerates a handful. Classed as wording because the question underneath it -- whether “all codes” is a defined term -- is asked separately.*

Tables 0929 and 0930 give their Content Logical Definition as “enumerated per table content”, which is accurate. Tables 0931 and 0932 say “all codes” while doing exactly the same thing — listing two or three UCUM codes. Read literally, “all codes” against UCUM would be every unit of measure in existence. THO reads all four the same way and enumerates in every case.

**What this guide publishes today:**

- `0929` Weight Units: ValueSet published; code system is another body's — VS 4.0.0 (incremented)
- `0930` Volume Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)
- `0931` Temperature Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)
- `0932` Donation Duration Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)

**Decision needed:** Align the wording on the four tables. More usefully: is “all codes” meant to be a defined term with a specific mapping to ValueSet.compose, or is it informal prose? The answer affects how every one of the 438 value set blocks in the chapter is translated.

---

### Five concept domains are given two different descriptions within Chapter 2C

**Tables:** 5 concept domains  
**Goes to:** V2 Management  
**Register id:** `esc-conflicting-descriptions`

*Why this class: Five concept domains given two different descriptions within the chapter. Reconcilable at source without deciding anything.*

A concept domain has one description by definition, so a domain described two different ways in the same chapter is a source defect rather than something this project can adjudicate. The generator emits the first description in document order, which keeps the output deterministic; the alternatives are recorded in the concept domain section of this report.

**Decision needed:** Reconcile the five at source and say which description is correct.

---

### Two table headings are styled Normal instead of Heading 3

**Tables:** 0685, 0767  
**Goes to:** V2 Management  
**Register id:** `esc-heading-styles`

*Why this class: Two headings styled Normal instead of Heading 3. Affects navigation of the document and nothing else.*

Both tables are consequently absent from the document's own table of contents, and both were invisible to extraction until they were special-cased. Their content is complete and is extracted in full; the defect is in the styling of the published document. Recorded here for completeness — it is the smallest item on this list and needs nothing from this project.

**What this guide publishes today:**

- `0685` Item Code - External (RQD-3): concept domain only, no artifact
- `0767` Bolus Dose Amount Units (RXV-4): concept domain only, no artifact

**Decision needed:** Fix the styles in a future publication.

---

## Wrong or missing identifiers (7)

The chapter names the wrong thing, or omits a name it needs. A URI that points at the wrong code system is not a typographic matter — it resolves, and it resolves to something else.

**Cost of granting the class:** Correct the identifier. Mechanical, but it changes a normative value, so it needs confirming rather than just fixing.

### Table 0347 State/Province gives ISO 3166 part 1's URI for a part 2 code system, and calls a partial value set “all codes”

**Tables:** 0347  
**Goes to:** V2 Management  
**Register id:** `esc-0347-iso3166`

*Why this class: ISO 3166 part 1's URI given for a part 2 code system. It resolves, and it resolves to the wrong code system.*

The Code System Identification block correctly identifies ISO 3166-2 — OID 1.0.3166.2, symbolic name iso3166-2, described as “ISO 3166 Part 2 Country Subdivision Codes” — and then gives the URI as urn:iso:std:iso:3166, which is part 1. THO's NamingSystem/ISO3166Part2 carries both identifiers for this system and uses urn:iso:std:iso:3166:-2. Separately, the Value Set block gives its Content Logical Definition as “all codes” while its own URI points at ValueSet-v2-notAllCodes-0347, and THO's value set of that name enumerates two example concepts (CA-AB, US-MI). The published definition contradicts both its own URI and THO. The Full Name is wrong in the same way as the UCUM tables: “State/Province Code System” names the table, not the code system, which is ISO 3166-2.

**What this guide publishes today:**

- `0347` State/Province: ValueSet published; code system is another body's — VS 3.0.0 (incremented)

**Decision needed:** Two technical corrections — the URI, and the Content Logical Definition. Neither should be contentious, but both change published text.

---

### Table 0956's value set exists only in a withdrawn FHIR draft and a code repository being decommissioned

**Tables:** 0956  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-0956-no-stable-home`

*Why this class: The only two value sets that carry these codes are a withdrawn FHIR 3.3 ballot draft and a PHIN VADS entry the CDC is decommissioning. Neither is a location anything should be bound to, so the table has no usable value set identity at all.*

0956 Job Supervisory Level or Pay Grade declares the code system PHOccupationalDataForHealthODH and gives its content logical definition as “unspecified”, which is not a shape this guide can build. THO publishes no ValueSet/v2-0956 and no obvious equivalent. Two candidate value sets exist and neither is a durable home. One is valueset-supervisory-level-odh-us, published in FHIR 3.3 (2018May) — a draft ballot snapshot, not a released FHIR version, and not a canonical anything should be bound to today. The other is a PHIN VADS value set at OID 2.16.840.1.114222.4.11.7613; PHIN VADS is being decommissioned by the CDC, so everything hosted there is of uncertain future. Pointing this guide at either would be binding V2.9.1 content to a location that is known in advance to be going away. That is worse than publishing nothing, because a dead pointer in a published IG is harder to retract than an acknowledged gap.

**What this guide publishes today:**

- `0956` Job Supervisory Level or Pay Grade: BLOCKED — no artifact, pipeline cannot settle it

**Decision needed:** Something needs to happen for 0956 and nobody yet knows what. This item exists to keep that fact from being lost, which is the whole of its present purpose. The question for V2 Management and TSMG is where the supervisory level / pay grade codes should live once PHIN VADS is gone: a THO value set created for the purpose, an external code system record pointing at whatever the CDC designates as the successor, or a decision that the table is not viable and should become concept domain only. In the meantime this guide publishes no CodeSystem and no ValueSet for 0956, by decision rather than by omission. Its concept domain JobSupervisoryLevelorPayGrade is published in CodeSystem/conceptdomains and is unaffected, so a binding to the domain remains expressible while the terminology question is settled.

---

### Table 0962 resolved itself when a cached package appeared, which is a reproducibility problem rather than a ruling

**Tables:** 0962  
**Goes to:** V2 Management  
**Register id:** `esc-0962-already-in-tho`

*Why this class: A FHIR core page URL where the code system canonical belongs. It resolves only through an identifier FHIR marks superseded, in a package that reaches the build machine by accident rather than by declaration.*

0962 Device Status routes needs-decision because its code system block gives a FHIR core page URL, http://hl7.org/fhir/codesystem-device-status.html, and an OID 2.16.840.1.113883.4.642.1.200 that nothing in THO or FHIR core resolves. So the writer cannot say what the value set composes over and emits nothing. THO nevertheless publishes ValueSet/v2-0962, active at 3.0.0, carrying this table's value set OID 2.16.840.1.113883.4.642.3.209 and composing over http://hl7.org/fhir/device-status — the real canonical the chapter's page link was pointing at. The artifact exists, it is correct, and nothing about it is in doubt. There is a loose end in this repository because of it. vs-v2-0962.xml is tracked and staged from an earlier run, when the table still routed to an artifact. It is byte-equivalent in substance to THO's. Nothing prunes it, because the prune deliberately removes only the exact paths of suppressed tables — a broader sweep would be wrong under --table. So the writer warns about it on every run, and it is the only artifact in the IG that no route accounts for.

**What this guide publishes today:**

- `0962` Device Status: ValueSet published; code system is another body's — VS 3.0.0 (held)

**Decision needed:** The table is no longer blocked, and nobody decided that. On 2026-11-05 it began routing value-set-only and publishing ValueSet/v2-0962 — correctly: the output is identical to THO's, same compose over http://hl7.org/fhir/device-status, same value set OID, same version 3.0.0, and the orphan warning is gone. What changed was the machine, not the chapter and not this repository. load_oid_index reads the FHIR R5 core package out of ~/.fhir/packages as well as the THO snapshot. That package was not present, so the OID resolved to nothing; the IG Publisher downloaded it during a build earlier the same day, and the next run of the writer resolved 2.16.840.1.113883.4.642.1.200 through CodeSystem-device-status.json — on an identifier FHIR itself marks use: "old". So no ruling is needed for 0962 itself. The outcome is right and matches what the committee has said seven times this month about tables THO already serves. What needs attention is that the corpus this guide generates depends on whether a package happens to be cached on the build machine. A fresh checkout would have produced a different IG from this one, with a different table count and a needs-decision entry nobody could explain. The question for the project, not the committee: should the FHIR core package be pinned and vendored the way tho-r5/ is, so the OID index is a declared input rather than a property of the machine? Everything else the writer reads is version-pinned and recorded in a report; this one is not, and it silently moved a table between routes.

---

### Four more GP2 tables look like CMS I/OCE content and are published as though HL7 owned them

**Tables:** 0466, 0468, 0469, 0470  
**Goes to:** Financial Management WG  
**Register id:** `esc-gp2-oce-siblings`

*Why this class: Four GP2 tables publishing CMS I/OCE content, if that is what it is, at HL7 canonicals. The same shape as 0460, which was realigned once somebody read its own description.*

Between 2026-11-05 and 2026-11-06 four tables in the GP1/GP2 pair were realigned as CMS Integrated Outpatient Code Editor content: 0458, 0459, 0460 and 0467. Each now publishes a value set over an external code system record CMS owns, and 0460 stopped minting a v2 CodeSystem it never should have had. A sweep of the corpus for I/OCE and APC references found four more tables in the same segment that were not part of that batch, all stewarded by FM, all Type: User, all with all codes content logical definitions over canonicals this guide or UTG constructed: 0466 Ambulatory Payment Classification Code (GP2-7), 0468 Payment Adjustment Code (GP2-9), 0469 Packaging Status Code (GP2-10) and 0470 Reimbursement Type Code (GP2-12). The evidence is not equally strong across the four. 0468's own code displays name I/OCE return-buffer concepts — “payment adjustment applies to APC (status indicator G)”, “(status indicator H)”, “(status indicator J)”, and “specific list of HCPCS codes”. 0470's codes are APC payment categories outright: OPPS, Pckg, Lab, Thrpy, Mamm, PartH. 0466 is APC by name and its description says “the derived Ambulatory Payment Classification (APC) code”. 0469 is the weakest: the inference is field adjacency rather than content, and nothing in its own text names CMS or the I/OCE. For comparison, the precedent that makes this worth asking: 0460's code system description had said the codes specify “the OCE status of the line item” all along, and the table was still being published with a freshly minted HL7 canonical. The same mistake, if it is one, would not announce itself in these four either.

**What this guide publishes today:**

- `0466` Ambulatory Payment Classification Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0468` Payment Adjustment Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0469` Packaging Status Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0470` Reimbursement Type Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)

**Decision needed:** This is a question for the Financial Management Work Group, which stewards both this vocabulary and the GP1/GP2 segments that use it, rather than for V2 Management. For each of the four: are the codes CMS's, published in the I/OCE specification, in the way 0458, 0459, 0460 and 0467's are? If so each needs an external code system record in THO and a value set composing over it, and this guide should stop publishing a CodeSystem for it — the same treatment the other four just received. If the codes are genuinely HL7's, nothing changes and this item closes with that on the record. Nothing is being changed for these four in the meantime. They continue to publish a CodeSystem and a ValueSet at their existing canonicals exactly as before, so no answer is urgent and no artifact is at risk while the question is open.

---

### Table 0725 Mood Codes omits the URI of the v3 code system it draws from

**Tables:** 0725  
**Goes to:** V2 Management  
**Register id:** `esc-0725-missing-uri`

*Why this class: The URI of the v3 code system the table draws from is omitted.*

The table's code system block gives a symbolic name actMood, a description of tbd, and OID 2.16.840.1.113883.5.1001 — and no URI field at all. The codes are v3 ActMood codes, not v2 codes; THO's own ValueSet/v2-0725 draws them from http://terminology.hl7.org/CodeSystem/v3-ActMood. The output is already correct, because the OID the chapter does print resolves through THO to exactly that URL, so the writer emits a value set only and points it at the v3 code system. Recorded because the defect is in the published chapter and will mislead anyone reading it directly: a reader sees a code system with no URI and a description of tbd, with nothing to indicate the codes are v3. It also means the correct result here depends entirely on OID resolution succeeding.

**What this guide publishes today:**

- `0725` Mood Codes: ValueSet published; code system is another body's — VS 4.0.0 (incremented)

**Decision needed:** Confirm this as a technical correction under the editing-process test — add the URI http://terminology.hl7.org/CodeSystem/v3-ActMood and replace the tbd description. Nothing in the generated output changes.

---

### Three artifacts where one OID would end up naming two things, which versioning cannot reconcile

**Tables:** 0001, 0719  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-oid-conflicts`

*Why this class: One OID on two artifacts, for 0001 and 0719. An identifier that identifies two things identifies neither. The third conflict, 0078, was removed rather than adjudicated.*

Two artifacts carry a different identifier OID in Chapter 2C than the one THO publishes at the same canonical URL, and a third would create the same breach from the other direction. CodeSystem/v2-0001 Administrative Sex: the chapter gives 2.16.840.1.113883.18.458, THO publishes 2.16.840.1.113883.18.2. Both sit in the HL7 v2 code system arc, so neither is obviously a stray. This is the most widely implemented table in V2. The chapter's block is titled Jurisdiction Gender Code System, not Administrative Sex, and ...18.458 resolves to nothing anywhere in THO — so this may be a disagreement about which code system the table points at rather than a mistyped digit. ValueSet/v2-0719: the chapter gives 2.16.840.1.113883.1.11.20429, THO publishes ...20428. These are adjacent but they are not near-misses: both are v3 value set OIDs and both are in use, ...20428 for ActInformationSensitivityPolicy's parent InformationSensitivityPolicy and ...20429 for ActInformationSensitivityPolicy itself. THO's ValueSet/v2-0719 shares ...20428 with THO's own v3-InformationSensitivityPolicy — one OID on two artifacts — which fits THO's own description of 0719, that it “was created in THO in error due to an oversight in the import processing”. So the question is which v3 value set table 0719 corresponds to, not which digit is a typo. ValueSet/v2-0078 Interpretation Codes is different in kind, and the difference is the point: we create this one, THO does not. Chapter 2C prints the canonical http://terminology.hl7.org/ValueSet/v2-0078 for the table and the value set OID 2.16.840.1.113883.1.11.78. THO publishes nothing at that canonical, so this is a first publication rather than a disagreement with an existing artifact. But …1.11.78 is not free. THO's ValueSet/v3-ObservationInterpretation already carries it, on a value set whose content logical definition is byte-identical to the one we would write: a single bare include of CodeSystem/v3-ObservationInterpretation, no filter, no enumerated concepts. It is the only ValueSet in the snapshot with either that OID or that compose. So publishing v2-0078 at the chapter's canonical with the chapter's identifier puts one OID on two artifacts — the same policy breach this item already records for 0719. Why this is not a versioning question. The THO artifact versioning policy treats every other divergence found in this comparison as something a version increment covers. Identifiers are the exception: the policy states that an identifier cannot be changed or removed, that adding one makes it immutable, and that an identifier change requires a new artifact rather than a new version — “extreme care must be taken with identifiers”. Publishing our OID at THO's canonical would therefore be a policy violation, not a bump. Every other artifact agrees. Counting the tables where Chapter 2C and THO both give an OID for the same resource type: 395 of 396 code systems and 411 of 412 value sets carry identical identifiers. (0078 is not in that count: THO publishes no artifact at that canonical to compare against.)

**What this guide publishes today:**

- `0001` Administrative Sex: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0719` Access Restriction Reason Code: retired on a ruling, superseded — VS 4.0.0 (incremented)

**Decision needed:** Adjudicate each OID. For 0001, establish which of ...18.458 and ...18.2 is the registered identifier for the Administrative Sex code system, and correct the other source. For 0719, establish whether ...20429 or ...20428 is right. Until both are settled this project publishes THO's identifier rather than the chapter's, because the policy forbids changing a published identifier and the canonical URL is THO's. That is now enforced in the pipeline rather than left as a recommendation: the identifier is the one element where the chapter does not win a disagreement, because an identifier is identity rather than content. Both conflicts are recomputed on every run, so neither can drift out of view. A third option has been raised and needs ruling on: publish both OIDs as identifiers. identifier is 0..* on both CodeSystem and ValueSet, so it is mechanically available, and it would avoid choosing before the committees have. It is not obviously right: two identifiers on one artifact asserts that both OIDs name it, which for 0719 is demonstrably false — ...20429 names a different v3 value set, which THO also publishes. Carrying both would be defensible for 0001, where the two may be the same code system under two registrations, and misleading for 0719. Please rule per artifact rather than as a blanket policy. 0078 was the third conflict here and has been answered — see esc-0078-alias-of-v3. V2 Management ruled on 2026-10-14 that the existing v3-ObservationInterpretation serves and no second artifact is created, which removed that collision rather than adjudicating it. It is not a precedent for these two: 0078's collision existed only because this guide was about to create the second artifact, and 0001 and 0719 are conflicts between artifacts that already exist.

---

### Chapter 2C gives every table its own OID, and this guide publishes it nowhere

**Tables:** 798 tables  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-table-oid-unpublished`

*Why this class: The Table OID arc is published nowhere. A default rather than a decision, which is why it is worth making one.*

Chapter 2C carries three OIDs per table, in three separate metadata blocks, and they identify three different things: a Table OID in the 2.16.840.1.113883.12.* arc (798 of 799 tables), a Code System OID in ...113883.18.* (435 tables), and a Value Set OID in ...113883.21.* (438 tables). THO uses the same two latter arcs for the same two resource types, so the code system and value set OIDs have an obvious home and are written to CodeSystem.identifier and ValueSet.identifier. The table OID has no home. In V2 the table is the thing with an identity; in FHIR that table becomes a code system and a value set, and neither of them is the table. So the .12 OID is carried by no resource this guide publishes. That is not a decision anyone took — it is what happens by default when a one-to-one identifier meets a one-to-two split, and it means 798 published identifiers from the chapter appear in no output. Worth knowing before ruling: 50 of the 798 are not identifiers at all but the bare arc root 2.16.840.1.113883.1 with no leaf, on the 50 tables the chapter types undefined; and the table OID is not dead elsewhere — THO's own description of table 0227 cites PHIN VADS by the .12.227 table OID, so implementers do resolve these.

**Decision needed:** Decide where a V2 table OID belongs in a FHIR representation of that table, and whether this guide should start writing it. The options each say something different and none is free. Putting it on the CodeSystem says the code system is the table, which is wrong for the 24 value-set-only tables whose codes belong to another authority. Putting it on both resources asserts one identifier for two artifacts, which is the same shape as the defect registered at esc-oid-conflicts. Putting it on the concept domain concept has no identifier element to hold it. Putting it nowhere is the current behaviour and may well be right — but it should be a ruling rather than an accident, because the identifier is in the published chapter and its absence from the FHIR artifacts is silent.

---

## The chapter contradicting itself (6)

A table says two incompatible things about itself, so no reading of it is faithful. These cannot be reproduced faithfully — something has to be chosen — which is why they are the ones most likely to be producing a wrong artifact right now.

**Cost of granting the class:** Decide which reading is correct. Usually one line in the chapter, but somebody has to know the table's history.

### Table 0954's logical definition would include an abstract concept THO's equivalent excludes

**Tables:** 0954, 0957  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-0954-cld-exclude`

*Why this class: The logical definition would include an abstract concept THO's equivalent excludes. Either an omitted clause or a deliberate divergence; the chapter does not say which.*

Both tables define their value set as a subtree of v3-ObservationValue. 0957 Employment Status says it in two clauses — Include codes … where concept is-a _EmploymentStatus, then Exclude codes where code = _EmploymentStatus. That second clause matters: in FHIR, an is-a filter includes the concept it is rooted at, and _EmploymentStatus is an abstract grouper that should never be sent in a message. The exclusion is what makes the value set mean “the actual statuses”. 0954 Work Schedule has the include clause and no exclude clause, so read literally its value set contains the abstract _WorkSchedule grouper. THO's own ValueSet/v3-WorkScheduleODH does exclude it, and is otherwise identical to 0957's shape. So either the chapter dropped a clause from 0954, or the two tables genuinely differ — and nothing in the text says which. This project builds what the chapter says, so the generated ValueSet/v2-0954 currently has no exclude and differs from THO on exactly this point. There is a second line of defence, and it is the reason this is worth stating carefully rather than simply fixing. Both groupers carry notSelectable = true as a concept property in THO's CodeSystem/v3-ObservationValue — verified on both _WorkSchedule and _EmploymentStatus. A terminology server that honours that property will keep the abstract concept out of the expansion whether or not the value set excludes it, which makes the exclude clause optional rather than load-bearing. But notSelectable is an advisory property, and honouring it in expansion is a matter of server implementation rather than something the value set can require. An explicit exclude does not depend on any server behaviour; relying on the property does.

**What this guide publishes today:**

- `0954` Work Schedule ODH: withheld on a ruling
- `0957` Employment Status (ODH): withheld on a ruling

**Decision needed:** Confirm that 0954 is missing an Exclude codes where code = _WorkSchedule clause, in which case it is a technical correction and one line to apply. If the omission is deliberate, say so, because the value set then diverges from THO's and somebody will raise it again. The recommendation is to add it regardless of the notSelectable safety net: the clause costs nothing, it makes 0954 consistent with its sibling 0957 and with THO, and it removes a dependency on how a given expansion engine treats an advisory property.

---

### Table 0292 Vaccines Administered is flagged concept domain only and names a code system in the same section

**Tables:** 0292  
**Goes to:** V2 Management  
**Register id:** `esc-0292-cdo-contradiction`

*Why this class: Flagged concept-domain-only in the same section that names its code system and prints its canonical. The guide deviates tentatively under ADR-0011.*

The concept domain block sets Concept Domain Only: yes. The table metadata grid a few lines further down gives Full Name: Vaccines Administered Code System and URI: http://hl7.org/fhir/sid/cvx. Both are in the published section and they cannot both be acted on: a concept domain has no code system and no value set, and a table that prints a code system canonical is not a concept domain. Four independent signals say the grid is right and the flag is wrong — and that the code system belongs to the CDC rather than to HL7. One: THO publishes ValueSet/v2-0292, status: active, and its entire compose is a single bare include of http://hl7.org/fhir/sid/cvx — exactly the canonical the chapter prints. Two: NamingSystem/CVX registers table 0292's own table OID, 2.16.840.1.113883.12.292, against that URI, and calls the URI the “official canonical URL going forward”. THO's own registry ties the table OID and the CDC code system together. Three: the sibling table is answered the other way. 0227 Manufacturers of Vaccines (MVX) is the other half of the same CDC vaccine pair — same steward (OO), the same PHIN VADS prose in its description, the same Full Name-plus-URI shape in its table grid — and it is flagged Concept Domain Only: no. It is published, as a value set over http://hl7.org/fhir/sid/mvx resolved through NamingSystem/MVX, which is ADR-0008 D8. Two halves of one pair should not be classified differently. (The chapter also types 0227 Imported and 0292 External, which is a further inconsistency between them rather than a reason for the difference.) Four: of the 14 tables Chapter 2C types External, not one resolves to a code system of its own. Setting 0292 aside, six are concept domain only, three cannot be settled mechanically, and every one of the four this guide writes a resource for — 0820, 0952, 0955, 0958 — is value set only over somebody else's system. 0292 fits that shape exactly.

**What this guide publishes today:**

- `0292` Vaccines Administered: ValueSet published; code system is another body's — VS 3.0.0 (held)

**Decision needed:** Confirm that 0292 should be routed value set only, its value set composing over http://hl7.org/fhir/sid/cvx, consistent with 0227 and with the external-code-system rule in ADR-0008 Batch A — and that the Concept Domain Only: yes flag is the error. Minting a CodeSystem/v2-0292 would be the wrong answer, and it is worth saying so explicitly because it is the shape most of the corpus takes. The chapter publishes zero codes for this table, so there would be nothing to put in it; THO deliberately carries no CodeSystem for CVX, only the NamingSystem; and a v2-0292 code system would claim the table OID that NamingSystem/CVX has already bound to the CDC's URI. This guide tentatively publishes 0292 as a real table on that reading rather than writing nothing for it, because writing nothing discards the one thing the chapter states unambiguously: which code system the table draws on. It is flagged in the guide as needing attention, so the tentative reading is visible rather than silent, and it is reverted if the ruling goes the other way.

---

### Table 0823 Sexual Orientation draws on three code systems and has no value set in THO

**Tables:** 0823  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-0823-not-in-tho`

*Why this class: The chapter publishes a table THO has nothing for, and the guide cannot settle it mechanically.*

The table is Type: HL7-EXT, stewarded by PA, and declares three code systems — SNOMED CT, DataAbsentReason and NullFlavor. Drawing a value set from three code systems is perfectly normal, and the table does print its five codes. What is missing is the value set itself: THO publishes no ValueSet/v2-0823. The writer cannot proceed because the chapter does not state which of the three declared systems each code belongs to, so it emits nothing. The pattern is worth noting: this is the sister table to 0821 Gender Identity, built the same way and recorded above for having its grid emptied in publication. Both are Gender Harmony Project material. The plausible reading is that both were entered into Chapter 2C in anticipation of a V2 implementation that was subsequently not carried through — which would explain why one lost its codes and the other never got a value set in THO.

**What this guide publishes today:**

- `0823` Sexual Orientation: ValueSet published; code system is another body's — VS 1.0.0 (held)

**Decision needed:** Confirm whether tables 0821 and 0823 are live commitments or abandoned ones. If live, the per-code system assignments are needed before a value set can be generated, and a ValueSet/v2-0823 needs to exist in THO. If they were dropped, say so and this project will record them as published-but-unimplemented rather than as blockers.

---

### Table 0340's code grid lists code systems, not codes

**Tables:** 0340  
**Goes to:** V2 Management  
**Register id:** `esc-0340-code-grid-misuse`

*Why this class: The code grid lists code systems rather than codes, so the grid does not mean what a grid means elsewhere.*

0340 Procedure Code Modifier is declared concept-domain-only, so this project writes nothing for it and nothing is blocked. But its code grid is not empty: it holds two rows, CPTM “CPT Modifier Code” and HPC “CMS (formerly HCFA) Procedure Codes (HCPCS)”, both with long comments citing the publishing body. These are identifiers of external code systems, not concepts in a code system of the table's own. The chapter is using the code grid for two incompatible purposes without distinguishing them, which is a trap for anyone generating resources from it mechanically — a naive reading mints a code system whose concepts are the names of other code systems. If the intent is that a procedure code modifier is drawn from CPT or HCPCS, those are external code systems that may warrant external code system records in THO.

**What this guide publishes today:**

- `0340` Procedure Code Modifier: concept domain only, no artifact

**Decision needed:** Confirm that 0340 is correctly concept-domain-only and that the two rows are documentation of candidate external code systems rather than codes. If they are meant to be usable, they need to be expressed as external code system references rather than as grid rows.

---

### The concept statuses N and B are defined nowhere; N is now mapped, B is not

**Tables:** 0003, 0125, 0357 for B; 25 tables, 261 concepts for N  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-status-n-b-undefined`

*Why this class: Status letters N and B are used and defined nowhere, so the chapter uses a vocabulary it does not publish.*

Chapter 2C carries its own legend for the status column: blank means an active code, B means “backwards-compatible use only”, D means “deprecated or inactive”, R means “retired”, and N means “new in this release”. Blank, D and R have unambiguous FHIR equivalents and are written as active, deprecated and retired. N and B do not. Neither is defined anywhere. The property they are written to is status, defined by FHIR at http://hl7.org/fhir/concept-properties#status, whose own definition reads “a code that indicates the status of the concept. Typical values are active, experimental, deprecated, and retired.” Neither N nor B is among them. They are not in utg-concept-properties either, and no value set enumerates them. Across the whole of hl7.terminology.r5 they appear only in v2 code systems — 210 concepts carry N and 6 carry B. N is worse than undefined, because it decays. “New in this release” was a statement about whichever release first printed it, and nothing updates it afterwards. That is visible in the data: THO still marks 210 concepts N from past releases while the 2.9.1 chapter marks only 70, and 205 of the 261 status disagreements between the chapter and THO are exactly this — THO saying N where the current chapter says nothing, so this project publishes active. N is now mapped to active, as a technical correction. The reviewer ruled on this half on 2026-09-19, and the three findings above are the grounds taken together: “new in this release” is not a status but a provenance note; it expires with nothing to update it, so a value printed in 2.9.1 is already a claim about some earlier release; and it is not a legal value of the standard FHIR property this guide writes it into, whose own definition enumerates active, experimental, deprecated and retired. A code marked N is in every case an active code, so writing active says what the chapter means and says it in the same vocabulary D and R already use. On the errata test in the first item of this register that is a change that makes the document say what the work group intended, not a change to what the standard means. B is deferred, deliberately. “Backwards-compatible use only” is a real statement about a code and it has no obvious FHIR equivalent: not deprecated, because the code is still correct for existing senders; not retired; and not plainly active either, because the restriction is real. It is also small enough to take one at a time — five concepts in three tables: 0003 Event code O57 (OMQ — General Order Message with Document Payload), 0125 Value Type code IS (Coded value for user-defined tables), and 0357 Message Error Condition Codes 204, 205 and 206 (Unknown key identifier, Duplicate key identifier, Application record locked). Five concepts is a review, not a policy.

**What this guide publishes today:**

- `0003` Event: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 4.0.0 (incremented)
- `0125` Value Type: ValueSet published; code system is another body's — VS 3.0.0 (held)
- `0357` Message Error Condition Codes: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)

**Decision needed:** Two things remain. (1) Rule on B, per concept. Five concepts in three tables is small enough to look at individually, and they are not obviously the same case — 0125's IS is a data type code, 0357's three are error conditions. For each, say whether the FHIR status should be active, deprecated, or active with a separate marker recording the backwards-compatibility restriction. (2) Decide where, if anywhere, these letters should be defined. Even with N resolved by mapping, THO still publishes 210 concepts carrying it as a literal status value and 6 carrying B, against a property whose definition admits neither. Defining them in utg-concept-properties would at least make what is already published legal; replacing N with a non-decaying “version introduced” property would be better, and the chapter already records that fact in prose elsewhere. What this guide does now: N is written as active; B is passed through unchanged pending (1); and all 261 chapter-versus-THO status disagreements are still recorded, because mapping N does not make the underlying divergence go away.

---

### 191 concepts say they are active and deprecated as of 2.9 at the same time

**Tables:** 0003, 0006, 0065, 0066, 0074, 0076, 0104, 0131, 0163, 0175, 0191, 0200, 0207, 0211, 0223, 0272, 0277, 0278, 0279, 0281, 0291, 0294, 0354, 0359, 0365, 0366, 0367, 0391, 0396, 0418, 0440, 0474, 0487, 0492, 0544, 0916  
**Goes to:** V2 Management  
**Register id:** `esc-deprecation-flag-contradicts-status`

*Why this class: 191 concepts say they are active and deprecated at once. The largest single class by concept count.*

The contradiction. 241 concepts across 36 code systems carry the concept property v2-table-deprecated with the value 2.9. Of those, 191 carry a concept status that is neither deprecated nor retired — 169 say active and 22 say N. (N is now mapped to active, per the item above, so all 191 read active.) The other 50 do say deprecated, which is what the flag implies. So the two properties agree on 50 concepts and contradict each other on 191, and both values are the chapter's, reproduced faithfully. The property is defined twice, at one URI, to mean two different things. CodeSystem/utg-concept-properties defines v2-table-deprecated as a table-level assertion — “Indicates that although still being published in the V2 international standard, the table has been deprecated in favor of alternative codes, and will be withdrawn in the future” — with the comment “used only in v2-tables.xml”. THO's individual v2 CodeSystems declare the same code at that same URI, …utg-concept-properties#v2-table-deprecated, describe it as “Version of HL7 in which the code was deprecated”, and use it on concepts. Two definitions, one identifier. The data settles which definition the values follow. All 241 values are the string 2.9, which is a version and not a yes. And v2-tables itself — the file the first definition says is the property's only user — carries it on zero of its 628 entries. The concept-level reading is the one in use; the table-level definition is the stale one. What this does not say, because it bounds the ask. None of the 36 code systems has all of its concepts flagged. It is 241 concepts out of the 2,230 those 36 contain, or 10.8%; the most affected is 0272 Document Confidentiality Status at 6 of 9, the least 0487 Specimen Type at 2 of 315. So this is a claim about individual codes, and CodeSystem.status = active is correct on all 36. Nothing here generalises to 0567 and 0568, where the whole table is deprecated and a different mechanism is needed.

**What this guide publishes today:**

- `0003` Event: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 4.0.0 (incremented)
- `0006` Religion: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0065` Specimen Action Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0066` Employment Status: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0074` Diagnostic Service Section ID: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0076` Message Type: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0104` Version ID: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0131` Contact Role: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0163` Body Site: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0175` Master File Identifier Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0191` Type of Referenced Data: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0200` Name Type: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0207` Processing Mode: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0211` Alternate Character Sets: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0223` Living Dependency: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0272` Document Confidentiality Status: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0277` Appointment Type Codes: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0278` Filler status codes: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0279` Allow Substitution Codes: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0281` Referral Type: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0291` Subtype of Referenced Data: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 4.0.0 (incremented)
- `0294` Time Selection Criteria Parameter Class Codes: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0354` Message Structure: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0359` Diagnosis Priority: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0365` Equipment State: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0366` Local/Remote Control State: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0367` Alert Level: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 4.0.0 (incremented)
- `0391` Segment Group: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0396` Coding System: CodeSystem + ValueSet published — CS 6.0.0 (incremented) VS 3.0.0 (held)
- `0418` Procedure Priority: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0440` Data Types: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0474` Practitioner Organization Unit Type: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0487` Specimen Type: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0492` Specimen Appropriateness: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0544` Container Condition: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0916` Relevant Clinicial Information: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)

**Decision needed:** Confirm that a concept whose v2-table-deprecated is 2.9 should carry status: deprecated. One ruling resolves all 191, because there is nothing case-by-case about it: the flag says the code was deprecated in 2.9, and 2.9 has shipped. This guide has not applied that, and is surfacing it for decision rather than fixing it. Both the status and the flag are published values and both are reproduced, contradiction included. Changing 191 concept statuses is a content change to published normative material — which is the question the first item in this register asks in general terms — and it is not something to do on inference. Two smaller things should be settled alongside it. Give v2-table-deprecated a single definition, the concept-level one, since that is what the values are; or split it into two properties with two URIs, because at present one identifier means “this table is deprecated” in one place and “the version this code was deprecated in” in another. And decide whether the flag is still wanted once status says the same thing, or whether it becomes the record of when, which status cannot carry.

---

## Open representation questions (4)

Not defects in the chapter: places where the chapter is clear and FHIR offers no settled way to say it. The guide has taken a working answer in each case and the answer is reversible.

**Cost of granting the class:** Confirm the shape, or name another. Sets a precedent beyond this guide.

### Twenty-three concepts have a code that is nothing but punctuation

**Tables:** 0005, 0066, 0093, 0200, 0255, 0291, 0359, 0365, 0366, 0367, 0418, 0466, 0487, 0492, 0505, 0523, 0544  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-punctuation-codes`

*Why this class: Twenty-three concepts whose code is nothing but punctuation. Part placeholder, part real symbol; the split needs review per code.*

Noticed in table 0291, whose code system carries a concept whose code is a single ellipsis character. Sweeping both Chapter 2C and THO's v2 code systems for the same shape — a code with no letter and no digit anywhere in it — found 23 concepts across 17 tables. They are not one problem but three, and only the first is defensible. Four are genuine codes and should be left alone. * in 0255 and 0505, # in 0505 and % in 0523 all carry real definitions — Indicates a percent change, The first service request in a cyclic group. A single-character symbol is an awkward code but it is a code, and all four are in both sources. Eighteen are an ellipsis placeholder masquerading as a concept — 13 written as three full stops and 5 as the single ellipsis character. Their display text gives them away: No suggested values defined, user-defined codes, see chapter 3. These are rows that said “nothing to see here” in a printed table and were then loaded as though they were content. Nobody can send ... in a message and mean anything by it. Five tables carry the same placeholder twice. 0291, 0365, 0366, 0367 and 0418 each have ... (three full stops) and … (one ellipsis character) as two separate concepts, with identical display text where they have any. That is one placeholder encoded two ways and minted as two codes. In 0418 the ellipsis concept has no display text at all. This is overwhelmingly a THO problem rather than a chapter problem. Sixteen of the 23 exist only in THO, six are in both, and one — 0093's ... — is only in Chapter 2C. Every duplicate pair is THO-only. So the chapter has largely stopped publishing these and THO has gone on carrying them, which is the pattern this whole baseline exercise exists to correct. One further oddity: 0492's code is ??, displayed Inappropriate due to ... — a display that is itself truncated, beside a code that looks like a data-entry artefact.

**What this guide publishes today:**

- `0005` Race: concept domain only, no artifact
- `0066` Employment Status: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0093` Release Information: concept domain only, no artifact
- `0200` Name Type: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0255` Duration Categories: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0291` Subtype of Referenced Data: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 4.0.0 (incremented)
- `0359` Diagnosis Priority: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0365` Equipment State: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0366` Local/Remote Control State: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0367` Alert Level: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 4.0.0 (incremented)
- `0418` Procedure Priority: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0466` Ambulatory Payment Classification Code: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0487` Specimen Type: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0492` Specimen Appropriateness: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0505` Cyclic Entry/Exit Indicator: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)
- `0523` Computation Type: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0544` Container Condition: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)

**Decision needed:** Review all 23 and say which are real. The recommendation is: keep the four symbol codes; retire the ellipsis placeholders, which were never concepts; and for the five duplicate pairs retire at least the redundant spelling even if the placeholder itself is kept. Nothing is proposed for this release — the chapter is reproduced as published, so 0093's placeholder is currently emitted as a concept and the THO-only ones are untouched. But these codes are in published code systems today, so retiring them is a change to content in the field and needs a decision from the owners rather than from this project. Listed in full below.

---

### Where should a concept domain’s example codes live?

**Tables:** 0093, 0340, 0451  
**Goes to:** V2 Management  
**Register id:** `esc-domain-example-codes`

*Why this class: Where a concept domain's example codes should live. Extracted and held, published nowhere, pending a shape.*

These three tables are declared Concept Domain Only and yet each publishes a small set of codes — three, two and one respectively. That is not a contradiction: the V3 requirements for declaring a concept domain call for example codes, so the tables are conforming. It does leave the codes with nowhere obvious to go. A concept domain is not a code system, so the examples cannot be concepts; and a domain is bound with an extension on the binding rather than through a value set, so there is no value set to put them in either. No CodeSystem and no ValueSet is minted for any of the three, and nothing in THO or UTG carries one today, so nothing has to be unpicked whichever way this goes.

**What this guide publishes today:**

- `0093` Release Information: concept domain only, no artifact
- `0340` Procedure Code Modifier: concept domain only, no artifact
- `0451` Substance Identifier: concept domain only, no artifact

**Decision needed:** The likely representation is a concept property on the concept in the concept domain code system, carrying the example codes. Confirm that shape, or name another. Until it is decided the example codes are extracted and held but not published anywhere.

---

### Do the UCUM weight and volume value sets mean the handful of codes they list, or the UCUM units for the quantity?

**Tables:** 0929, 0930  
**Goes to:** V2 Management  
**Register id:** `esc-0929-0930-enumerated-subset`

*Why this class: Whether the enumerated subset is intended or the value sets should reference the UCUM units for the quantity. Survives the 2026-09-23 ruling that retired 0567 and 0568.*

This is the half of the 0567/0568 question that the 2026-09-23 ruling did not reach. That ruling retires 0567 and 0568, which removes them from this guide — but it leaves the same question standing against their live replacements, which this guide does publish. The replacements carry byte-identical code lists to the tables being retired. 0929 enumerates the same four codes as 0567 — [lb_av], [oz_av], kg, g — and 0930 the same three as 0568: l, [pt_us], ml. So retiring the old pair does not retire the question; it moves it. The description promises more than the value set delivers. 0930's concept domain is “the domain of possible values of units of measure that are used to specify volume” and its code system is UCUM, which has a great many volume units. Three are enumerated. A sender needing centilitres, fluid ounces or cubic centimetres finds them absent from a value set whose description says it covers the quantity. Whether that is a deliberate interoperability constraint — a short list implementers can actually support — or an accident of how the table was first populated is not something this project can determine from the chapter.

**What this guide publishes today:**

- `0929` Weight Units: ValueSet published; code system is another body's — VS 4.0.0 (incremented)
- `0930` Volume Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)

**Decision needed:** Is the enumerated subset intended, or should these value sets be an intensional reference to the UCUM units for the quantity? If the short list is deliberate, the descriptions should say so, because as written they describe the whole quantity. If it is not, these are two value sets that need rebuilding and the replacement tables inherited the defect they were meant to replace.

---

### What should a user-defined table produce? Three of them were treated three different ways

**Tables:** 0093  
**Goes to:** V2 Management  
**Register id:** `esc-0460-user-defined-mint`

*Why this class: Whether a user-defined table gets a minted code system. Sharper since 0411 was ruled concept-domain-only: 0460 is now the only minted canonical in the corpus.*

0460 Denial or Rejection Code and 0411 Supplemental Service Information Values are the only two tables in the whole chapter for which this project mints a new CodeSystem canonical — every other code-bearing table either reuses a THO canonical or draws on another authority's code system. Both are Type: User. A user-defined table is by definition a set of suggested values that an implementation is expected to replace, so minting CodeSystem/v2-0460 publishes suggestions with the authority of a standard code system. The chapter is not consistent about this. Compare 0093 Release Information, also Type: User, which is declared concept-domain-only and so produces no code system and no value set at all — even though it lists Y and N in its grid. Three user tables, three outcomes: 0460 and 0411 get minted resources, 0093 gets nothing. Nothing in the chapter explains the difference. 0411 additionally has the defect already recorded above — the chapter prints a canonical for a resource that does not exist — and is a mess independent of this question.

**What this guide publishes today:**

- `0093` Release Information: concept domain only, no artifact

**Decision needed:** Both of the minted canonicals this item was about are gone, and the question underneath them is still open. 0411 was ruled concept-domain-only in October (esc-0411-concept-domain-only). 0460 was realigned in November as CMS I/OCE content (esc-0460-oce-realignment), which withdrew its minted CodeSystem for a reason specific to that table rather than as an answer to this one. This guide now mints no CodeSystem canonical anywhere in the corpus. What remains unanswered is the principle, and 0093 Release Information is where it still bites: a Type: User table, declared concept-domain-only, listing Y and N in a grid that reaches no artifact. Decide what a user-defined table should produce — a CodeSystem and ValueSet like any other, a concept domain only, or a ValueSet whose codes are marked as examples — so that the next such table is handled by a rule rather than case by case. The answer no longer changes any published artifact; it decides what happens to 0093's codes and sets the precedent.

---

## Published content that is wrong (3)

The chapter publishes something that is incorrect as terminology — an invalid code, codes that do not match the table's own name. Correcting these changes what the standard means.

**Cost of granting the class:** Substantive change to normative content. On HL7's errata guidance this is the kind that needs a ballot rather than a technical correction.

### Table 0560 Quantity Units publishes time units, and THO carries the same error

**Tables:** 0560  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-0560-content`

*Why this class: A table named Quantity Units publishing four time units out of five codes. THO carries the same error, so a unilateral fix forks them.*

The table is named Quantity Units, its concept domain is “the domain of possible values that specify the adjustment quantity”, and it is bound to ADJ-6. The five codes it publishes are FL Units, HS Hours, DY Days, MN Month and YY Years. Four of the five are units of time. This is not a difference between the chapter and THO: CodeSystem/v2-0560 in hl7.terminology.r5 v3.0.0 publishes those same five concepts. Both are wrong in the same way, so correcting one without the other would fork them. The chapter also contradicts itself here — the table metadata says Type: User and “No suggested values”, and then lists five values. There is a second, sharper problem. Chapter 2C's code system block for 0560 is the noObject / noDescription placeholder — the chapter does not declare a code system for this table at all. THO nevertheless publishes both CodeSystem/v2-0560 and ValueSet/v2-0560, and so does the UTG repository. So THO has minted a code system for a table whose source declares none. Of the tables this project treats as concept domain only, 0560 is the only one where THO carries resources; 0910 carries the identical placeholder and THO has nothing for it, which is the treatment that looks correct.

**What this guide publishes today:**

- `0560` Quantity Units: CodeSystem + ValueSet published — CS 4.0.0 (incremented) VS 3.0.0 (held)

**Decision needed:** Is this table salvageable, or is it a concept domain with no usable code system? If it is to be fixed, the fix has to be coordinated with TSMG so Chapter 2C and THO move together. This project's working decision changed on 2026-09-17 (ADR-0010): it now publishes both the CodeSystem and the ValueSet, carrying the chapter's five codes. The earlier decision was concept domain only, and it was reversed because the noObject marker is contradicted by everything around it — the chapter's own five codes, the value set OID it prints, its all codes content logical definition, and THO's existing pair. Treating the marker as authoritative was losing published content and putting us in conflict with THO rather than agreement with it. The naming problem this item is really about is untouched by that change: four of the five codes are still units of time under a table called Quantity Units, in our output and in THO's alike. That still needs V2 Management and TSMG together, and we are not proposing to alter THO's existing records unilaterally. The contradiction is stated in the guide itself, on the General questions page, so a reader meets it rather than having to find this register.

---

### Table 0931 Temperature Units publishes three codes, two of which are the same unit, and one of which is invalid

**Tables:** 0931  
**Goes to:** V2 Management  
**Register id:** `esc-0931-temperature`

*Why this class: An invalid UCUM code published alongside its own correction. THO has already corrected this one, which makes it the sharpest test of reproduce-versus-correct in the corpus.*

The three codes are degF (status D, comment “typo”), [degF], and Cel. degF is not a valid UCUM code — UCUM requires the square brackets — so the table publishes a known-invalid code and its correction side by side, with two of the three entries meaning Degrees Fahrenheit. There is no Kelvin and no Rankine, so it is not a complete set of temperature units either. THO has already dealt with this. Its ValueSet/v2-0931 v2.0.0 includes only [degF] and Cel, and folds the history into the display text: “Degrees Fahrenheit (note that V2 has erroneously published this for many years without the square brackets)”. Also in this table: the Code System Version block gives the UCUM version as 2, which is not a UCUM version.

**What this guide publishes today:**

- `0931` Temperature Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)

**Decision needed:** This is the cleanest test case in the corpus for reproduce-versus-correct, and the one to decide first: Chapter 2C reproduces an error, THO corrected it and said so, and the two cannot both be followed. Which does this IG follow? And separately: should 0931 be filled out into an actual set of temperature units, or is the two-code set intentional?

---

### Two pairs of tables are duplicates of each other

**Tables:** 0567 / 0929, 0568 / 0930  
**Goes to:** V2 Management  
**Register id:** `esc-duplicate-tables`

*Why this class: Two pairs of tables duplicating each other. The 0567/0568 half is now settled; 0929 and 0930 remain.*

Table 0567 and table 0929 are both named Weight Units, declare the concept domain WeightUnits, and publish the same four UCUM codes. Table 0568 and table 0930 are both Volume Units with the same three codes. In both pairs the older table's value set URI already points at the newer table's value set (ValueSet/v2-0929, ValueSet/v2-0930), so the chapter appears to know they are the same thing.

**What this guide publishes today:**

- `0567` Weight Units: withheld on a ruling
- `0929` Weight Units: ValueSet published; code system is another body's — VS 4.0.0 (incremented)
- `0568` Volume Units: withheld on a ruling
- `0930` Volume Units: ValueSet published; code system is another body's — VS 3.0.0 (incremented)

**Decision needed:** Confirm the older numbers are deprecated in favour of the newer ones, and say so in the chapter. This IG needs to know whether to publish two resources or one with an alias.

---

## Where this guide and THO disagree (6)

Both bodies publish something, and they differ. Whatever is decided has to be decided for both, or the two fork.

**Cost of granting the class:** Coordination between V2 Management and TSMG. No unilateral fix is available.

### Five concept domain definitions differ between Chapter 2C and THO

**Tables:** 0952, 0967, 0675, 0066, 0626  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-tho-definition-differences`

*Why this class: Five concept domain definitions where the two bodies disagree about what a domain means.*

For 577 of the 582 shared concept domains, Chapter 2C and THO agree word for word. These five do not. Only 0952 is close enough for a word-level comparison to be meaningful — it differs by formatting and a stray space. The other four are wholly different texts, which usually means the two bodies have attached different meanings to the same domain rather than phrasing one meaning two ways. Under ADR-0008 D1 THO's wording is currently the one published.

**What this guide publishes today:**

- `0952` Confidentiality Classification: retired on a ruling, superseded — VS 4.0.0 (incremented)
- `0967` Container Form: concept domain only, no artifact
- `0675` Country (PDC-2): concept domain only, no artifact
- `0066` Employment Status: CodeSystem + ValueSet published — CS 3.0.0 (held) VS 3.0.0 (held)
- `0626` Observation Method (OBX-17): concept domain only, no artifact

**Decision needed:** Reconcile the five between the two bodies. The four unrelated definitions matter more than the near-match: if Chapter 2C and THO genuinely disagree about what a domain means, choosing a wording does not fix that.

---

### THO's v2-tables names 35 concept domains that conceptdomains does not define

**Tables:** 35 tables in v2-tables, none of them in Chapter 2C 2.9.1  
**Goes to:** TSMG / UTG  
**Register id:** `esc-v2tables-domain-gaps`

*Why this class: Gaps in CodeSystem/v2-tables' concept domain coverage.*

CodeSystem/v2-tables is THO's own index of V2 tables — 628 entries, each carrying properties including vocab-domain, the concept domain the table names. 624 entries carry a domain, and 37 of those name a concept that THO's own conceptdomains 3.0.0 does not contain. This project's proposed additions happen to cover two of them (DangerCode, Location), leaving 35. The gap is confined to tables the chapter has dropped. All 35 sit among the 39 v2-tables entries that Chapter 2C 2.9.1 no longer carries at all, so no row of this guide is affected and nothing here is blocked. That also suggests the cause: when a table left the chapter its concept domain stopped being maintained, but its vocab-domain property stayed behind. Only three of the 39 are typed no longer used; the rest are still typed HL7 or User, so the index does not mark them as retired. One caveat on how hard to push this. vocab-domain is declared as type string rather than code, so it is not formally a reference into conceptdomains and nothing validates it. But 587 of 624 values do resolve, which makes the 37 look like drift rather than design.

**Decision needed:** Confirm that vocab-domain is meant to resolve into conceptdomains. If it is, either the 35 missing domains should be restored, or the entries that name them should be marked as no longer used, or the property should be cleared for tables that have left the standard. If it is genuinely a free string with no such contract, that is worth stating, because readers will assume otherwise. Retyping it as code would let validation catch the next occurrence.

---

### v2-tables misspells the concept domain for table 0034 as SiteAdminstered

**Tables:** 0034  
**Goes to:** TSMG / UTG  
**Register id:** `esc-v2tables-siteadministered`

*Why this class: A misspelled concept domain name in THO's own index.*

CodeSystem/v2-tables gives table 0034 the vocab-domain SiteAdminstered, missing the second i of Administered. The same entry's display is SITE ADMINISTERED, spelled correctly, which settles that this is a typo rather than a deliberate name. Neither SiteAdminstered nor a correctly spelled SiteAdministered exists in conceptdomains, so the property also resolves to nothing — it is one of the 35 gaps in esc-v2tables-domain-gaps. This one is cheaper to fix than it looks, and it is worth being precise about why. v2-tables is a convenience index that makes V2 table metadata available in THO. Nobody sends SiteAdminstered in a message and no instance data binds to it, so correcting the string breaks no implementation. That makes it a technical correction rather than a substantive change. A typo in a real code, in a real code system, is a different problem entirely — there the code is an identifier that implementations have already sent and stored, and the remedy is deprecation plus a correctly spelled replacement, not an edit. Nothing in that harder category has been found in the v2 tables so far; this item is deliberately not making that claim.

**Decision needed:** Correct the vocab-domain value for table 0034 to SiteAdministered as a technical correction. The change should still be traceable — recorded in the UTG change history like any other edit — but it does not need the deprecate-and-replace treatment that a published code would. Separately, whether the corrected domain should then be defined in conceptdomains, or the property cleared because table 0034 has left the standard, is part of esc-v2tables-domain-gaps.

---

### Should CodeSystem/v2-tables be retired?

**Tables:** v2-tables, all 628 entries  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-v2tables-retirement`

*Why this class: Whether CodeSystem/v2-tables should be retired at all.*

CodeSystem/v2-tables is not a code system in the sense the rest of THO uses the term. Its 628 concepts are table numbers: the code is the number, the display is the table's name, and the content is a dozen properties carrying the table's OIDs, type, steward, binding strength and concept domain. Nobody sends 0005 in a V2 message meaning “table 5”. It is an index of metadata that was given a code system's shape because that was the container available. THO's own description concedes that the index does not work. Under the title line it reads: “Please note that V2 Code System and Value Set URIs are present, but the URIs do not resolve. The addition of the appropriate THO artifacts for these are in progress.” The index's substance is pointers, and the description says the pointers are broken. Two items above are instances of exactly that: the vocab-domain property names 35 concept domains conceptdomains does not define, and one of those names is a typo. Nothing depends on it definitionally. Checked across all 4,177 files in the hl7.terminology.r5 snapshot: no ValueSet composes from it, no CodeSystem supplements it, and nothing binds to it. Outside its own file the only references are three packaging entries — the hl7.terminology ImplementationGuide manifest, List/v2-Publishing and List/v2-rendering — and the UTG change-history bundles, which record edits made to it rather than use it. The one real coupling argues for retirement rather than against it. Fourteen properties in CodeSystem/utg-concept-properties carry the comment “used only in v2-tables.xml”: v2-table-oid, v2-cs-oid, v2-cs-uri, v2-vs-oid, v2-vs-uri, v2-cs-version, v2-table-type, v2-table-deprecated, v2TblStatus, v2-binding, v2-where-used, v2-version-tbl-introduced, v2-version-csvs-introduced and vocab-domain. Retiring v2-tables orphans all fourteen — which is another way of saying that fourteen property definitions exist to serve one artifact that nothing else reads. (v2-table-deprecated is the exception, and it is a problem in its own right; see the item below.) The case for keeping it is that a machine-readable index of V2 table metadata is genuinely useful — this guide had to rebuild most of the same information from the chapter. That is an argument for the index existing, not for it being a CodeSystem.

**Decision needed:** Decide whether CodeSystem/v2-tables should be retired, and if so what takes its place. It carries no codes anyone sends, it has no definitional dependents, and its own description says its pointers do not resolve. The reasoning is already in this register. esc-v2tables-siteadministered argues that correcting a misspelled vocab-domain is a technical correction because nobody sends that value in a message and no instance data binds to it. This item is the same observation taken one step further. If the index is worth keeping, the question is what shape it should have, because a CodeSystem whose concepts are not concepts will keep attracting the defects recorded above, and a reader who finds a code system in THO is entitled to assume its codes turn up in instances. If it is retired, the 14 properties that exist only to serve it should go with it, and this guide's per-table pages become where that information lives. Either way the answer needs both groups: V2 Management owns what the tables are, TSMG owns what THO publishes about them.

---

### How far does the description “editorial corrections” carve-out reach?

**Tables:** policy; 12 descriptions, 25 concepts  
**Goes to:** TSMG  
**Register id:** `esc-description-editorial-carveout`

*Why this class: Which description differences count as editorial. The carve-out this guide applies is its own reading of the policy.*

The Code Systems versioning policy qualifies exactly one element: CodeSystem.description is “major unless only change is improved clarity or perform editorial corrections”. This project applies that where it can do so honestly — where our description and THO's contain exactly the same words in the same order, so that only punctuation or spacing moved. 12 descriptions across 7 tables are waived on that basis, every one of them our e.g., against THO's e.g., or our code system. against THO's code system .. Three things about this need confirming. First, the rule itself: is a punctuation-only difference an editorial correction? Second, the asymmetry it creates. The carve-out is written against description alone, while CodeSystem.concept (and all subelements) is listed unqualified. So 4 concept definitions and 21 concept displays that differ from THO only in punctuation do increment. A comma in a description is free; the same comma in a display costs a major version. This project has not smoothed that over, because guessing at an unwritten carve-out is how a pipeline quietly stops matching the rules it claims to follow — but it looks more like an oversight than a decision. Third, the Value Sets policy has no equivalent carve-out at all, so read literally it makes every description difference a major increment however trivial. This project treats ValueSet.description exactly as it treats CodeSystem.description, rather than encode an asymmetry believed to be a drafting slip.

**Decision needed:** Confirm the punctuation waiver, say whether it should extend to concept definitions and displays, and confirm whether the missing ValueSet carve-out is deliberate. Each answer is a located change in this project; none of them is a rewrite.

---

### Two THO descriptions carry text the chapter's do not, including THO documenting its own error

**Tables:** 0227, 0719  
**Goes to:** V2 Management + TSMG  
**Register id:** `esc-tho-descriptions-say-more`

*Why this class: THO's descriptions carry content the chapter's do not.*

Of the description differences between this project's output and THO, all but two are punctuation. These two are not, and in both THO's text carries something the chapter's does not. ValueSet/v2-0227: THO's description ends with a link to the code system on PHIN VADS. The chapter's stops before it, so publishing the chapter's drops a working source reference for a code system HL7 does not itself maintain. ValueSet/v2-0719: THO's description ends “Note that this resource was created in THO in error due to an oversight in the import processing.” That is THO documenting its own mistake in the artifact's description. It is not something Chapter 2C should inherit, but it does say the artifact needs attention rather than a redraft — and 0719 is also one of the two artifacts with an OID conflict. This project publishes the chapter's description in both cases and increments the version. The merge fills an absent value from THO but never splices two pieces of prose together, because concatenating them would publish text neither source wrote.

**What this guide publishes today:**

- `0227` Manufacturers of Vaccines (code=MVX): ValueSet published; code system is another body's — VS 4.0.0 (held)
- `0719` Access Restriction Reason Code: retired on a ruling, superseded — VS 4.0.0 (incremented)

**Decision needed:** For 0227, decide whether the source reference should be carried into the chapter's description or dropped. For 0719, decide what should happen to a THO artifact whose own description says it was created in error — and settle that together with its OID conflict, since the two are likely the same story.

---

