<style>
.ri-item { border-left: 3px solid #d0d7de; padding: 0.1rem 0 0.1rem 1rem;
           margin: 1.1rem 0; }
.ri-item > .ri-key { font-weight: 600; font-family: monospace; color: #24292f; }
.ri-item > .ri-who { color: #57606a; font-size: 0.9em; margin-top: 0.4rem; }
.ri-item p { margin: 0.45rem 0; }
.ri-item p.ask { background: #fff8e5; border-left: 2px solid #d4a72c;
                 padding: 0.35rem 0.6rem; }
.ri-escalate { border-left-color: #cf222e; }
.ri-decide   { border-left-color: #d4a72c; }
.ri-count { color: #57606a; font-weight: 400; }
.ri-group { margin-top: 1.6rem; }
.ri-blurb { color: #24292f; background: #f6f8fa; padding: 0.6rem 0.8rem;
            border-radius: 4px; }
.ri-ev table { font-size: 0.92em; }
.ri-ev td, .ri-ev th { vertical-align: top; padding: 0.2rem 0.5rem; }
.ri-scroll { max-height: 18rem; overflow: auto; }
.ri-answered { background: #eaf5ea; border-left: 3px solid #1a7f37;
               padding: 0.5rem 0.8rem; margin: 0.6rem 0 0.9rem; }
.ri-answered p { margin: 0.35rem 0; }
</style>

Questions this guide has had to answer in order to produce anything at all,
where the answer is a judgement rather than a fact, and where somebody other
than us should confirm it.

Each one says **what this build currently does**, so that a reader is never
guessing, and **what we would change** if the answer comes back differently.
None of them is blocking: every question below has a defensible working answer
already applied.

All **6** questions below are for **V2 Management**. TSMG owns the artifact versioning policy; V2 Management owns what Chapter 2C says.

There are **56 open items** below, plus **6 general questions** that have a working answer already applied. Everything this guide has *settled* is on the [evidence page](evidence.html) instead, so that this page stays a list of things somebody still has to do.

**1 question has since been answered** and moved to the evidence page: [1. Does reordering a code system's concepts count as a change?](evidence.html#gq-does-reordering-a-code-system).

### For V2 Management / TSMG

#### Open items <span class="ri-count">&mdash; 34 items</span>

<div class="ri-blurb">Defects in the published Chapter 2C, in THO, or in both. None of these is this project's to resolve, and each needs a committee answer. They are listed first because a representation decision can be revisited at any time, whereas getting an item onto an agenda has a lead time.</div>

<div class="ri-item ri-escalate">
  <div class="ri-key">policy</div>
  <p><b>Does &ldquo;publish V2.9.1 as published&rdquo; extend to publishing content that is known to be wrong?</b></p><p>The governing requirement for this IG is fidelity: it carries exactly what Chapter 2C publishes. That is easy to hold while the divergences are typographic. It becomes a real question when the published content is not merely untidy but wrong &mdash; and two of the items below are exactly that. Table 0560 publishes time units under the name Quantity Units, and table 0931 publishes an invalid UCUM code alongside a valid one that means the same thing. There is already a precedent pointing the other way: for 0931, <b>THO chose to correct rather than reproduce</b>. Its <code>ValueSet/v2-0931</code> drops the bad code and records the history in the display text of the good one. So the two bodies have, at least once, answered this question differently. <b>HL7's own errata guidance gives a usable test.</b> A technical correction is defined there as &ldquo;a non-controversial change that alters a document so that it says what the WG intended to say&rdquo;, typically repairing changes to normative content &ldquo;that were not made, were incorrectly made, or were inconsistently made during the editing process&rdquo;. That cleanly separates the items on this list into two kinds. The editing-process defects &mdash; table 0821's grid emptied in publication, table 0411's canonical printed for a resource that does not exist, the links to rendered pages where canonical URLs belong, the missing spaces after a period &mdash; are technical corrections on that definition. The content defects &mdash; 0931's invalid UCUM code, 0560's time units &mdash; change what the standard <i>means</i>, and for normative content the same guidance requires any substantive change to be balloted.</p><p class="ask"><b>The ask:</b> Decide the rule, not the instance. When Chapter 2C publishes something demonstrably wrong, does this IG (a) reproduce it and record the defect, (b) reproduce it but mark it deprecated or inactive, or (c) correct it and publish the correction with a note? The answer sets the default for every item below, and the current answer &mdash; (a) &mdash; is an assumption nobody has ratified. <b>A narrower question would unblock most of the list:</b> may this project treat the editing-process defects above as technical corrections, leaving only the substantive ones for a ballot? The guidance also notes that where there is doubt, a Work Group may ask the TSC to rule.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0560</div>
  <p><b>Table 0560 <i>Quantity Units</i> publishes time units, and THO carries the same error</b></p><p>The table is named Quantity Units, its concept domain is &ldquo;the domain of possible values that specify the adjustment quantity&rdquo;, and it is bound to <code>ADJ-6</code>. The five codes it publishes are <code>FL</code> Units, <code>HS</code> Hours, <code>DY</code> Days, <code>MN</code> Month and <code>YY</code> Years. Four of the five are units of <i>time</i>. This is not a difference between the chapter and THO: <code>CodeSystem/v2-0560</code> in <code>hl7.terminology.r5</code> v3.0.0 publishes those same five concepts. Both are wrong in the same way, so correcting one without the other would fork them. The chapter also contradicts itself here &mdash; the table metadata says <code>Type: User</code> and &ldquo;No suggested values&rdquo;, and then lists five values. <b>There is a second, sharper problem.</b> Chapter 2C's code system block for 0560 is the <code>noObject</code> / <code>noDescription</code> placeholder &mdash; the chapter does not declare a code system for this table at all. THO nevertheless publishes both <code>CodeSystem/v2-0560</code> and <code>ValueSet/v2-0560</code>, and so does the UTG repository. So THO has minted a code system for a table whose source declares none. Of the tables this project treats as concept domain only, <b>0560 is the only one where THO carries resources</b>; 0910 carries the identical placeholder and THO has nothing for it, which is the treatment that looks correct.</p><p class="ask"><b>The ask:</b> Is this table salvageable, or is it a concept domain with no usable code system? If it is to be fixed, the fix has to be coordinated with TSMG so Chapter 2C and THO move together. <b>This project's working decision changed on 2026-09-17 (ADR-0010): it now publishes both the CodeSystem and the ValueSet</b>, carrying the chapter's five codes. The earlier decision was concept domain only, and it was reversed because the <code>noObject</code> marker is contradicted by everything around it &mdash; the chapter's own five codes, the value set OID it prints, its <code>all codes</code> content logical definition, and THO's existing pair. Treating the marker as authoritative was losing published content <i>and</i> putting us in conflict with THO rather than agreement with it. <b>The naming problem this item is really about is untouched by that change</b>: four of the five codes are still units of time under a table called Quantity Units, in our output and in THO's alike. That still needs V2 Management and TSMG together, and <b>we are not proposing to alter THO's existing records unilaterally.</b> The contradiction is stated in the guide itself, on the General questions page, so a reader meets it rather than having to find this register.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0821</div>
  <p><b>Table 0821 <i>Gender Identity</i> publishes its coded content grid completely blank</b></p><p>The grid is six rows by five columns and <i>every cell is empty</i>, while the section around it is fully populated: three code systems (SNOMED CT, FHIR DataAbsentReason, V3 NullFlavor), three code system versions, and a value set. Both extraction pipelines independently find zero codes, so this is the document rather than the tooling. The row count is the tell. Six rows is a header plus <b>five</b> code rows, and THO's <code>ValueSet/gender-identity</code> &mdash; whose OID <code>2.16.840.1.113883.4.642.3.3291</code> is exactly the one Chapter 2C prints for this value set &mdash; holds exactly <b>five</b> concepts: three SNOMED CT gender identities, <code>asked-declined</code>, and <code>UNK</code>. The grid was meant to carry those five and lost them somewhere in publication. Compare table 0823 Sexual Orientation, built the same way, which prints its codes. Minor, in the same section: the value set description runs two sentences together with no space &mdash; &ldquo;&hellip;within their community.Used in HL7 Version 2.x messages&rdquo;.</p><p class="ask"><b>The ask:</b> Confirm the five intended codes and republish the grid. This project reuses THO's value set in the meantime, so nothing is blocked &mdash; but the published chapter is missing content and a reader of the PDF cannot tell what the table contains.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0931</div>
  <p><b>Table 0931 <i>Temperature Units</i> publishes three codes, two of which are the same unit, and one of which is invalid</b></p><p>The three codes are <code>degF</code> (status <code>D</code>, comment &ldquo;typo&rdquo;), <code>[degF]</code>, and <code>Cel</code>. <code>degF</code> is not a valid UCUM code &mdash; UCUM requires the square brackets &mdash; so the table publishes a known-invalid code and its correction side by side, with two of the three entries meaning Degrees Fahrenheit. There is no Kelvin and no Rankine, so it is not a complete set of temperature units either. <b>THO has already dealt with this.</b> Its <code>ValueSet/v2-0931</code> v2.0.0 includes only <code>[degF]</code> and <code>Cel</code>, and folds the history into the display text: &ldquo;Degrees Fahrenheit (note that V2 has erroneously published this for many years without the square brackets)&rdquo;. Also in this table: the Code System Version block gives the UCUM version as <code>2</code>, which is not a UCUM version.</p><p class="ask"><b>The ask:</b> This is the cleanest test case in the corpus for reproduce-versus-correct, and the one to decide first: Chapter 2C reproduces an error, THO corrected it and said so, and the two cannot both be followed. Which does this IG follow? And separately: should 0931 be filled out into an actual set of temperature units, or is the two-code set intentional?</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0567, 0568, 0929, 0930, 0931, 0932</div>
  <p><b>All six UCUM-backed tables name the code system &ldquo;Donation Duration Units Code System&rdquo;</b></p><p>Every table in Chapter 2C backed by UCUM carries the same Code System Identification block &mdash; OID <code>2.16.840.1.113883.6.8</code>, symbolic name <code>ucum</code>, URI <code>http://unitsofmeasure.org</code> &mdash; with <code>Full Name: Donation Duration Units Code System</code>. Only 0932 is about donation duration; the name was copy-pasted across Weight Units, Volume Units and Temperature Units, twice over, since 0567/0568 duplicate 0929/0930. The name is wrong even on 0932. The code system being identified is UCUM, so its full name is the Unified Code for Units of Measure, not the name of whichever table happens to point at it.</p><p class="ask"><b>The ask:</b> <b>Cleared to correct.</b> Measured against HL7's errata guidance this is squarely a technical correction &mdash; a name inconsistently applied during editing, where fixing it makes the chapter say what was plainly intended. Set the Full Name to UCUM's own name in all six. <b>Note that this changes no generated resource.</b> UCUM is an external code system, so these six tables produce a ValueSet and no CodeSystem, and the ValueSet takes its name and description from the Value Set block rather than the Code System block. The correction is to the chapter, and to the report that mirrors it.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0001, 0125, 0180, 0203, 0458, 0820 and others</div>
  <p><b>The copy-pasted Full Name is not confined to the UCUM tables</b></p><p>Checking the UCUM finding against the whole chapter turned up the same defect elsewhere. <b>412 of the 444 Code System Identification blocks follow the pattern <code>&lt;Table Name&gt; Code System</code> exactly</b>, which makes the exceptions easy to see. Some are legitimate &mdash; a table pointing at SNOMED CT or ISO 3166 should name that system, not itself. Others are the UCUM defect again, a name carried over from a different table: 0001 <i>Administrative Sex</i> is named &ldquo;Jurisdiction Gender Code System&rdquo;, 0125 <i>Value Type</i> is &ldquo;Data Types&rdquo;, 0180 <i>Masterfile Action Code</i> is &ldquo;Record-level Event Code&rdquo;, 0203 <i>Identifier Type</i> is &ldquo;Practitioner ID Number Type&rdquo;, 0458 <i>OCE Edit Code</i> is &ldquo;Reimbursement Action Code&rdquo;, 0820 <i>Gender Harmony Concepts</i> is &ldquo;Personal Pronouns&rdquo;. One more, 0232, begins with a stray hyphen: <code>- Insurance Company Contact Reason Code System</code>. Like the UCUM case, none of this reaches a generated resource; the emitted name and title come from the symbolic name.</p><p class="ask"><b>The ask:</b> If the UCUM correction is approved as a technical correction, the same reasoning covers these. Someone who knows the tables needs to separate the genuine exceptions from the copy-paste errors &mdash; this project can produce the candidate list but cannot make that call.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0560, 0910</div>
  <p><b>Two tables publish literal placeholder text &mdash; <code>noObject</code> and <code>noDescription</code></b></p><p>Tables 0560 (Quantity Units) and 0910 (Acquisition Modality) each carry a Code System Identification block reading OID <code>-</code>, symbolic name <code>noObject</code>, description <code>noDescription</code>, and &mdash; again copy-pasted from somewhere else &mdash; <code>Full Name: Name Representation Code System</code>. These are not values; they are a tool's way of saying the field was left blank, and they were published. Worth noting that this placeholder appears in exactly these two sections and nowhere else in Chapter 2C, and that both are tables with no genuine code system. The placeholder is a reliable marker of the condition, not random noise. <b>The two tables have then been treated completely differently downstream, and that is the finding.</b> They present identically in the chapter: same placeholder block, same absence of a code system, both declaring a concept domain and a value set. <b>For 0910, THO has nothing</b> &mdash; no CodeSystem, no ValueSet, and neither does the UTG repository. The chapter declares no code system, so none was minted. That is the treatment that follows from the source. <b>For 0560, THO publishes both</b> <code>CodeSystem/v2-0560</code> and <code>ValueSet/v2-0560</code> at version 3.0.0, and so does UTG. The CodeSystem is <code>content: complete</code> and carries five concepts &mdash; <code>FL</code> Units, <code>DY</code> Days, <code>HS</code> Hours, <code>MN</code> Month, <code>YY</code> Years &mdash; under the title <i>Quantity Units</i> and the description &ldquo;HL7-defined code system of concepts specifying the adjustment quantity&rdquo;. Four of the five are units of time. So a code system was minted at an HL7 canonical for a table whose source declares none, and the content it was filled with is the same content flagged as wrong elsewhere on this list. <b>Since 2026-09-17 this project publishes both 0560 resources (ADR-0010) and still writes nothing for 0910.</b> The two are separated on evidence rather than by name: the placeholder is overridden only where the chapter lists codes under it, THO publishes a code system at the table's own canonical, and the chapter declares a value set. 0560 is the only table in the corpus that meets all three; 0910 meets none. The placeholders themselves remain a defect in the published chapter either way.</p><p class="ask"><b>The ask:</b> Two questions, and the second is the one that needs both groups. First, should the placeholder blocks be removed from the published chapter, and should a table with no code system simply have no Code System Identification block? Second: <b>0560 and 0910 present identically in the chapter and have been handled in opposite ways downstream.</b> Either 0910 is missing resources or 0560 has resources it should never have had. This project now follows THO on both &mdash; publishing 0560's pair and nothing for 0910 &mdash; which removes the divergence from published THO content but does not answer the question. Confirm whether that split is correct, or whether both tables should be treated the same way. <b>Nothing will be altered in THO's existing records on this project's initiative.</b></p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0347</div>
  <p><b>Table 0347 <i>State/Province</i> gives ISO 3166 part 1's URI for a part 2 code system, and calls a partial value set &ldquo;all codes&rdquo;</b></p><p>The Code System Identification block correctly identifies ISO 3166-2 &mdash; OID <code>1.0.3166.2</code>, symbolic name <code>iso3166-2</code>, described as &ldquo;ISO 3166 Part 2 Country Subdivision Codes&rdquo; &mdash; and then gives the URI as <code>urn:iso:std:iso:3166</code>, which is part 1. THO's <code>NamingSystem/ISO3166Part2</code> carries both identifiers for this system and uses <code>urn:iso:std:iso:3166:-2</code>. Separately, the Value Set block gives its Content Logical Definition as &ldquo;all codes&rdquo; while its own URI points at <code>ValueSet-v2-notAllCodes-0347</code>, and THO's value set of that name enumerates two example concepts (<code>CA-AB</code>, <code>US-MI</code>). The published definition contradicts both its own URI and THO. The Full Name is wrong in the same way as the UCUM tables: &ldquo;State/Province Code System&rdquo; names the table, not the code system, which is ISO 3166-2.</p><p class="ask"><b>The ask:</b> Two technical corrections &mdash; the URI, and the Content Logical Definition. Neither should be contentious, but both change published text.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0929, 0930, 0931, 0932</div>
  <p><b>&ldquo;All codes&rdquo; is used where a value set enumerates a handful of UCUM codes</b></p><p>Tables 0929 and 0930 give their Content Logical Definition as &ldquo;enumerated per table content&rdquo;, which is accurate. Tables 0931 and 0932 say &ldquo;all codes&rdquo; while doing exactly the same thing &mdash; listing two or three UCUM codes. Read literally, &ldquo;all codes&rdquo; against UCUM would be every unit of measure in existence. THO reads all four the same way and enumerates in every case.</p><p class="ask"><b>The ask:</b> Align the wording on the four tables. More usefully: is &ldquo;all codes&rdquo; meant to be a defined term with a specific mapping to <code>ValueSet.compose</code>, or is it informal prose? The answer affects how every one of the 438 value set blocks in the chapter is translated.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0567 / 0929, 0568 / 0930</div>
  <p><b>Two pairs of tables are duplicates of each other</b></p><p>Table 0567 and table 0929 are both named Weight Units, declare the concept domain <code>WeightUnits</code>, and publish the same four UCUM codes. Table 0568 and table 0930 are both Volume Units with the same three codes. In both pairs the older table's value set URI already points at the newer table's value set (<code>ValueSet/v2-0929</code>, <code>ValueSet/v2-0930</code>), so the chapter appears to know they are the same thing.</p><p class="ask"><b>The ask:</b> Confirm the older numbers are deprecated in favour of the newer ones, and say so in the chapter. This IG needs to know whether to publish two resources or one with an alias.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">5 concept domains</div>
  <p><b>Five concept domains are given two different descriptions within Chapter 2C</b></p><p>A concept domain has one description by definition, so a domain described two different ways in the same chapter is a source defect rather than something this project can adjudicate. The generator emits the first description in document order, which keeps the output deterministic; the alternatives are recorded in the concept domain section of this report.</p><p class="ask"><b>The ask:</b> Reconcile the five at source and say which description is correct.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0952, 0967, 0675, 0066, 0626</div>
  <p><b>Five concept domain definitions differ between Chapter 2C and THO</b></p><p>For 577 of the 582 shared concept domains, Chapter 2C and THO agree word for word. These five do not. Only 0952 is close enough for a word-level comparison to be meaningful &mdash; it differs by formatting and a stray space. The other four are wholly different texts, which usually means the two bodies have attached different meanings to the same domain rather than phrasing one meaning two ways. Under ADR-0008 D1 THO's wording is currently the one published.</p><p class="ask"><b>The ask:</b> Reconcile the five between the two bodies. The four unrelated definitions matter more than the near-match: if Chapter 2C and THO genuinely disagree about what a domain means, choosing a wording does not fix that.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0038, 0170, 0227, 0254, 0315, 0326, 0335, 0389, 0392, 0406, 0508, 0510, 0511, 0513, 0520, 0544</div>
  <p><b>Sixteen Value Set descriptions stop mid-word, all at about 250 characters</b></p><p>Found while checking a generated resource rather than by looking for it. Table 0227's value set description ends &ldquo;&hellip; the code system may be acce&rdquo;. Sweeping the corpus for the same shape found <b>sixteen Value Set descriptions that end without terminal punctuation, every one of them between 242 and 252 characters long</b>. Nothing else in the chapter behaves this way: Code System descriptions run to 500 and 800 characters and end in complete sentences, and the same tables' own table-level descriptions are complete &mdash; 0227's runs to 582 characters and finishes cleanly. So this is not extraction loss and not an authoring habit; it is <b>a length cap of roughly 250 characters applied to one field</b> somewhere in the publication toolchain. <b>This one does reach the output.</b> Unlike the Full Name defects, the Value Set Description becomes <code>ValueSet.description</code>, so sixteen generated ValueSets currently carry a sentence that stops mid-word. <b>THO was checked as a recovery source and is not one.</b> All sixteen tables have a ValueSet in <code>hl7.terminology.r5</code>, all sixteen carry a description, and <b>fifteen of them are truncated at exactly the same point</b> &mdash; identical text once whitespace and this project's own text policy are normalized on both sides. So the defect did not originate in this extraction and it did not originate in the chapter's rendering: the same clipped field fed both documents, and the truncated text is already published in THO. <b>The single exception is table 0227, and it is the proof.</b> THO's <code>ValueSet/v2-0227</code> continues past the cut with 171 more characters, completing the very word the chapter stops in the middle of &mdash; &ldquo;may be acce&rdquo; becomes &ldquo;may be accessed via&rdquo; followed by the PHIN VADS link for the MVX code system. One table's full text therefore survives somewhere, which is good evidence the other fifteen do too.</p><p class="ask"><b>The ask:</b> <b>Recover the fifteen full descriptions from whatever source Chapter 2C is generated from</b> &mdash; most likely whoever maintains the chapter's underlying table content holds them intact, since the loss is at publication rather than at authoring. This project can detect the truncation but cannot reconstruct the text, and inventing an ending would be worse than publishing the fragment. On the errata guidance this is content lost during the editing process rather than a change of meaning, so <b>restoring it should qualify as a technical correction</b> and need no ballot. Two things follow that are worth deciding at the same time. 0227's full text is available now from THO and can be restored immediately on the same reasoning; say whether to take it. And because the truncated text is already published in THO, the correction needs to be made in both places or the two will diverge. Every affected table is listed below with the text as it currently stands.</p><table class="evidence"><thead><tr><th>Table</th><th>Name</th><th>Chars</th><th>Value Set description as published</th><th>In THO</th></tr></thead><tbody><tr><td>0038</td><td>Order status</td><td>252</td><td>Value Set of codes that specify the status of an order. The purpose of these values are to report the status of an order either upon request (solicited), or when the status changes (unsolicited). The values are not intended to initiate action. It is as</td><td>Identical, truncated at the same point.</td></tr><tr><td>0170</td><td>Derived Specimen</td><td>252</td><td>Value Set of codes that specify the parents and children for diagnostic studies, especially in microbiology, where the initial specimen (e.g., blood) is processed to produce results (e.g., the identity of the bacteria grown out of the culture). The pro</td><td>Identical, truncated at the same point.</td></tr><tr><td>0227</td><td>Manufacturers of Vaccines (code=MVX)</td><td>252</td><td>Value Set of codes that specify the organization that manufactures a vaccine. The values are maintained by the US Centers of Disease Control. Note that the source of truth for these code values are maintained by the CDC, and the code system may be acce</td><td>THO carries the complete text.</td></tr><tr><td>0254</td><td>Kind of Quantity</td><td>242</td><td>Value Set of codes that describe the underlying kind of property represented by an observation. The categories distinguish concentrations from total amounts, molar concentrations from mass concentrations, partial pressures from colors, and so</td><td>Identical, truncated at the same point.</td></tr><tr><td>0315</td><td>Living Will Code</td><td>251</td><td>Value Set of codes that specify whether or not the patient has a living will and, if so, whether a copy fo the living will is on file at the healthcare facility. If the patient does not have a living will, the value of this field indicates whether the</td><td>Identical, truncated at the same point.</td></tr><tr><td>0326</td><td>Visit Indicator</td><td>251</td><td>Value Set of codes that specify the level on which data are being sent. It is the indicator used to send data at two levels, visit and account. HL7 recommends sending an &quot;A&quot; or no value when the data in the message are at the account level or &quot;V&quot; to i</td><td>Identical, truncated at the same point.</td></tr><tr><td>0335</td><td>Repeat Pattern</td><td>244</td><td>Value Set of codes that specify the interval between repeated services. See the Comment/Usage Note in the table below, as the table contains both precoordinated codes that may be used in an HL7 field or component and also explanatory patterns i</td><td>Identical, truncated at the same point.</td></tr><tr><td>0389</td><td>Analyte Repeat Status</td><td>244</td><td>Value Set of codes identifying the repeat status for the analyte/result (e.g., original, rerun, repeat, reflex). The following are assumptions regarding the table values: Repeated without dilution — performed usually to confirm correctness of r</td><td>Identical, truncated at the same point.</td></tr><tr><td>0392</td><td>Match Reason</td><td>242</td><td>Value Set of codes identifying what search components (e.g., name, birthdate, social security number) of the record returned matched the original query where the responding system does not assign numeric match weights or confidence levels. It</td><td>Identical, truncated at the same point.</td></tr><tr><td>0406</td><td>Participant Organization Unit Type</td><td>244</td><td>Value Set of codes that specify the environment in which the provider acts in the role associated with the provider type, and inludes codes for venues outside of formal organized healthcare settings, such as Home. The provider environment is no</td><td>Identical, truncated at the same point.</td></tr><tr><td>0508</td><td>Blood Product Processing Requirements</td><td>243</td><td>Value Set of codes that specify additional information about the blood component class associated with the Universal Service ID. The placer of the order can specify any required processing of the blood product that must be completed prior to t</td><td>Identical, truncated at the same point.</td></tr><tr><td>0510</td><td>Blood Product Dispense Status</td><td>245</td><td>Value Set of codes that specify the current status of the specified blood product as indicated by the filler or placer. For example, the first status change of a product that may trigger a Blood Product Dispense Status Message occurs when it fir</td><td>Identical, truncated at the same point.</td></tr><tr><td>0511</td><td>BP Observation Status Codes Interpretation</td><td>245</td><td>Value Set of codes that specify the interpretation for the blood product observation status codes. A status is considered preliminary until a blood product has reached a final disposition for the patient. For example, when the product is first c</td><td>Identical, truncated at the same point.</td></tr><tr><td>0513</td><td>Blood Product Transfusion/Disposition Status</td><td>245</td><td>Value Set of codes that specify the current status of the specified blood product as indicated by the placer. For example, the placer may return the blood product to the transfusion service unused because an IV could not be started. The blood co</td><td>Identical, truncated at the same point.</td></tr><tr><td>0520</td><td>Message Waiting Priority</td><td>244</td><td>Value Set of codes that specify how important the most important waiting mesasge is. For example, if there are 3 low priority messages, 1 medium priority message and 1 high priority message, the message waiting priority would be &quot;high&quot;, because</td><td>Identical, truncated at the same point.</td></tr><tr><td>0544</td><td>Container Condition</td><td>244</td><td>Value Set of codes that specify at each receipt the status of the container in which the specimen is shipped in chain of custody cases where specimens are moved from lab to lab. If the container is compromised in any way (seal broken, container</td><td>Identical, truncated at the same point.</td></tr></tbody></table>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0005, 0066, 0093, 0200, 0255, 0291, 0359, 0365, 0366, 0367, 0418, 0466, 0487, 0492, 0505, 0523, 0544</div>
  <p><b>Twenty-three concepts have a code that is nothing but punctuation</b></p><p>Noticed in table 0291, whose code system carries a concept whose code is a single ellipsis character. Sweeping both Chapter 2C and THO's v2 code systems for the same shape &mdash; a code with no letter and no digit anywhere in it &mdash; found <b>23 concepts across 17 tables</b>. They are not one problem but three, and only the first is defensible. <b>Four are genuine codes and should be left alone.</b> <code>*</code> in 0255 and 0505, <code>#</code> in 0505 and <code>%</code> in 0523 all carry real definitions &mdash; <i>Indicates a percent change</i>, <i>The first service request in a cyclic group</i>. A single-character symbol is an awkward code but it is a code, and all four are in both sources. <b>Eighteen are an ellipsis placeholder masquerading as a concept</b> &mdash; 13 written as three full stops and 5 as the single ellipsis character. Their display text gives them away: <i>No suggested values defined</i>, <i>user-defined codes</i>, <i>see chapter 3</i>. These are rows that said &ldquo;nothing to see here&rdquo; in a printed table and were then loaded as though they were content. Nobody can send <code>...</code> in a message and mean anything by it. <b>Five tables carry the same placeholder twice.</b> 0291, 0365, 0366, 0367 and 0418 each have <code>...</code> (three full stops) <i>and</i> <code>&hellip;</code> (one ellipsis character) as two separate concepts, with identical display text where they have any. That is one placeholder encoded two ways and minted as two codes. In 0418 the ellipsis concept has <b>no display text at all</b>. <b>This is overwhelmingly a THO problem rather than a chapter problem.</b> Sixteen of the 23 exist only in THO, six are in both, and one &mdash; 0093's <code>...</code> &mdash; is only in Chapter 2C. Every duplicate pair is THO-only. So the chapter has largely stopped publishing these and THO has gone on carrying them, which is the pattern this whole baseline exercise exists to correct. One further oddity: 0492's code is <code>??</code>, displayed <i>Inappropriate due to ...</i> &mdash; a display that is itself truncated, beside a code that looks like a data-entry artefact.</p><p class="ask"><b>The ask:</b> <b>Review all 23 and say which are real.</b> The recommendation is: keep the four symbol codes; retire the ellipsis placeholders, which were never concepts; and for the five duplicate pairs retire at least the redundant spelling even if the placeholder itself is kept. Nothing is proposed for this release &mdash; the chapter is reproduced as published, so 0093's placeholder is currently emitted as a concept and the THO-only ones are untouched. But these codes are in published code systems today, so retiring them is a change to content in the field and needs a decision from the owners rather than from this project. Listed in full below.</p><table class="evidence"><thead><tr><th>Table</th><th>Name</th><th>Code</th><th>Display</th><th>Appears in</th></tr></thead><tbody><tr><td>0005</td><td>Race</td><td>...</td><td>see chapter 3</td><td>THO only</td></tr><tr><td>0066</td><td>Employment Status</td><td>...</td><td>see chapter 6</td><td>THO only</td></tr><tr><td>0093</td><td>Release Information</td><td>...</td><td>user-defined codes</td><td>Chapter 2C only</td></tr><tr><td>0200</td><td>Name Type</td><td>...</td><td>No suggested values defined</td><td>THO only</td></tr><tr><td>0255</td><td>Duration Categories</td><td>*</td><td>(asterisk) Life of the &quot;unit&quot;</td><td>Chapter 2C and THO</td></tr><tr><td>0291</td><td>Subtype of Referenced Data</td><td>...</td><td>Source RFC 2046</td><td>THO only</td></tr><tr><td>0291</td><td>Subtype of Referenced Data</td><td>…</td><td>Source RFC 2046</td><td>THO only</td></tr><tr><td>0359</td><td>Diagnosis Priority</td><td>...</td><td>No suggested values defined</td><td>THO only</td></tr><tr><td>0365</td><td>Equipment State</td><td>...</td><td>(null) No state change</td><td>THO only</td></tr><tr><td>0365</td><td>Equipment State</td><td>…</td><td>(null) No state change</td><td>THO only</td></tr><tr><td>0366</td><td>Local/Remote Control State</td><td>...</td><td>(null) No state change</td><td>THO only</td></tr><tr><td>0366</td><td>Local/Remote Control State</td><td>…</td><td>(null) No state change</td><td>THO only</td></tr><tr><td>0367</td><td>Alert Level</td><td>...</td><td>(null) No level change</td><td>THO only</td></tr><tr><td>0367</td><td>Alert Level</td><td>…</td><td>(null) No level change</td><td>THO only</td></tr><tr><td>0418</td><td>Procedure Priority</td><td>...</td><td>No suggested values defined</td><td>Chapter 2C and THO</td></tr><tr><td>0418</td><td>Procedure Priority</td><td>…</td><td>(none)</td><td>THO only</td></tr><tr><td>0466</td><td>Ambulatory Payment Classification Code</td><td>...</td><td>No suggested values defined</td><td>Chapter 2C and THO</td></tr><tr><td>0487</td><td>Specimen Type</td><td>...</td><td>No suggested values</td><td>THO only</td></tr><tr><td>0492</td><td>Specimen Appropriateness</td><td>??</td><td>Inappropriate due to ...</td><td>THO only</td></tr><tr><td>0505</td><td>Cyclic Entry/Exit Indicator</td><td>#</td><td>The last service request in a cyclic group.</td><td>Chapter 2C and THO</td></tr><tr><td>0505</td><td>Cyclic Entry/Exit Indicator</td><td>*</td><td>The first service request in a cyclic group</td><td>Chapter 2C and THO</td></tr><tr><td>0523</td><td>Computation Type</td><td>%</td><td>Indicates a percent change</td><td>Chapter 2C and THO</td></tr><tr><td>0544</td><td>Container Condition</td><td>...</td><td>No suggested values</td><td>THO only</td></tr></tbody></table>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0954, 0957</div>
  <p><b>Table 0954's logical definition would include an abstract concept THO's equivalent excludes</b></p><p>Both tables define their value set as a subtree of <code>v3-ObservationValue</code>. 0957 <i>Employment Status</i> says it in two clauses &mdash; <i>Include codes &hellip; where concept is-a <code>_EmploymentStatus</code></i>, then <i>Exclude codes where code = <code>_EmploymentStatus</code></i>. That second clause matters: in FHIR, an <code>is-a</code> filter includes the concept it is rooted at, and <code>_EmploymentStatus</code> is an abstract grouper that should never be sent in a message. The exclusion is what makes the value set mean &ldquo;the actual statuses&rdquo;. <b>0954 <i>Work Schedule</i> has the include clause and no exclude clause</b>, so read literally its value set contains the abstract <code>_WorkSchedule</code> grouper. THO's own <code>ValueSet/v3-WorkScheduleODH</code> <b>does</b> exclude it, and is otherwise identical to 0957's shape. So either the chapter dropped a clause from 0954, or the two tables genuinely differ &mdash; and nothing in the text says which. This project builds what the chapter says, so <b>the generated <code>ValueSet/v2-0954</code> currently has no exclude</b> and differs from THO on exactly this point. <b>There is a second line of defence, and it is the reason this is worth stating carefully rather than simply fixing.</b> Both groupers carry <code>notSelectable = true</code> as a concept property in THO's <code>CodeSystem/v3-ObservationValue</code> &mdash; verified on both <code>_WorkSchedule</code> and <code>_EmploymentStatus</code>. A terminology server that honours that property will keep the abstract concept out of the expansion whether or not the value set excludes it, which makes the exclude clause <i>optional</i> rather than load-bearing. But <code>notSelectable</code> is an advisory property, and honouring it in expansion is a matter of server implementation rather than something the value set can require. An explicit exclude does not depend on any server behaviour; relying on the property does.</p><p class="ask"><b>The ask:</b> Confirm that 0954 is missing an <i>Exclude codes where code = <code>_WorkSchedule</code></i> clause, in which case it is a technical correction and one line to apply. If the omission is deliberate, say so, because the value set then diverges from THO's and somebody will raise it again. The recommendation is to add it regardless of the <code>notSelectable</code> safety net: the clause costs nothing, it makes 0954 consistent with its sibling 0957 and with THO, and it removes a dependency on how a given expansion engine treats an advisory property.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0093, 0340, 0451</div>
  <p><b>Where should a concept domain&rsquo;s example codes live?</b></p><p>These three tables are declared <i>Concept Domain Only</i> and yet each publishes a small set of codes &mdash; three, two and one respectively. That is not a contradiction: the V3 requirements for declaring a concept domain <b>call for example codes</b>, so the tables are conforming. It does leave the codes with nowhere obvious to go. A concept domain is not a code system, so the examples cannot be concepts; and a domain is bound with an extension on the binding rather than through a value set, so there is no value set to put them in either. <b>No CodeSystem and no ValueSet is minted for any of the three</b>, and nothing in THO or UTG carries one today, so nothing has to be unpicked whichever way this goes.</p><p class="ask"><b>The ask:</b> The likely representation is a <b>concept property on the concept in the concept domain code system</b>, carrying the example codes. Confirm that shape, or name another. Until it is decided the example codes are extracted and held but not published anywhere.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">9999</div>
  <p><b>Table 9999 is a placeholder occupying a table number</b></p><p><b>This item covered three tables. 0010 and 0188 have both since been withdrawn &mdash; see <code>esc-0010-withdrawn</code> and <code>esc-0188-withdrawn</code> &mdash; leaving only 9999. What follows is the original finding, which measured all three together.</b> Of the 799 sections in Chapter 2C, exactly three declare no concept domain, no code system, no value set and no codes. <code>0010</code> <i>Physician ID</i> and <code>0188</code> <i>Operator ID</i> are User tables whose descriptions end &ldquo;No suggested values&rdquo; &mdash; they are site-defined identifiers, and were arguably never code tables. <b>One measurement turns that judgement into a fact.</b> Of the 799 sections only <b>three</b> carry no concept domain block at all, and of the <b>149</b> tables whose description says &ldquo;No suggested values&rdquo;, <b>147 carry one</b>. The two that do not are 0010 and 0188. The chapter supplies a concept domain for every peer of these two and omitted it for exactly these two, so the omission is an outlier rather than the house style for site-defined identifiers. <code>9999</code> <i>Placeholder Table Representation</i> is not a table at all: it carries the literal placeholder strings <code>noObject</code> and <code>noDescription</code>, the same markers that appear in the two concept-domain-only tables. <b>Checked against both THO and the UTG repository: there is no CodeSystem and no ValueSet for any of the three.</b> Nothing has been minted for them and nothing needs to be withdrawn.</p><p class="ask"><b>The ask:</b> Decide what becomes of 9999. A placeholder that occupies a table number is a trap for anyone generating resources from the chapter mechanically, and this project writes nothing for it. <b>Its two companions in this finding were both withdrawn</b>, which is not an answer for 9999: 0010 and 0188 were real tables that stopped being needed, and 9999 was never a table at all.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0292</div>
  <p><b>Table 0292 <i>Vaccines Administered</i> is flagged concept domain only and names a code system in the same section</b></p><p>The concept domain block sets <code>Concept Domain Only: yes</code>. The table metadata grid a few lines further down gives <code>Full Name: Vaccines Administered Code System</code> and <code>URI: http://hl7.org/fhir/sid/cvx</code>. Both are in the published section and they cannot both be acted on: a concept domain has no code system and no value set, and a table that prints a code system canonical is not a concept domain. <b>Four independent signals say the grid is right and the flag is wrong</b> &mdash; and that the code system belongs to the CDC rather than to HL7. <b>One:</b> THO publishes <code>ValueSet/v2-0292</code>, <code>status: active</code>, and its entire compose is a single bare include of <code>http://hl7.org/fhir/sid/cvx</code> &mdash; exactly the canonical the chapter prints. <b>Two:</b> <code>NamingSystem/CVX</code> registers table 0292's own table OID, <code>2.16.840.1.113883.12.292</code>, against that URI, and calls the URI the &ldquo;official canonical URL going forward&rdquo;. THO's own registry ties the table OID and the CDC code system together. <b>Three: the sibling table is answered the other way.</b> <code>0227</code> <i>Manufacturers of Vaccines (MVX)</i> is the other half of the same CDC vaccine pair &mdash; same steward (OO), the same PHIN VADS prose in its description, the same <code>Full Name</code>-plus-<code>URI</code> shape in its table grid &mdash; and it is flagged <code>Concept Domain Only: no</code>. It is published, as a value set over <code>http://hl7.org/fhir/sid/mvx</code> resolved through <code>NamingSystem/MVX</code>, which is ADR-0008 D8. Two halves of one pair should not be classified differently. (The chapter also types 0227 <i>Imported</i> and 0292 <i>External</i>, which is a further inconsistency between them rather than a reason for the difference.) <b>Four:</b> of the 14 tables Chapter 2C types <code>External</code>, <b>not one</b> resolves to a code system of its own. Setting 0292 aside, six are concept domain only, three cannot be settled mechanically, and every one of the four this guide writes a resource for &mdash; 0820, 0952, 0955, 0958 &mdash; is value set only over somebody else's system. 0292 fits that shape exactly.</p><p class="ask"><b>The ask:</b> Confirm that 0292 should be routed <b>value set only</b>, its value set composing over <code>http://hl7.org/fhir/sid/cvx</code>, consistent with 0227 and with the external-code-system rule in ADR-0008 Batch A &mdash; and that the <code>Concept Domain Only: yes</code> flag is the error. <b>Minting a <code>CodeSystem/v2-0292</code> would be the wrong answer</b>, and it is worth saying so explicitly because it is the shape most of the corpus takes. The chapter publishes zero codes for this table, so there would be nothing to put in it; THO deliberately carries no CodeSystem for CVX, only the NamingSystem; and a <code>v2-0292</code> code system would claim the table OID that <code>NamingSystem/CVX</code> has already bound to the CDC's URI. <b>This guide tentatively publishes 0292 as a real table</b> on that reading rather than writing nothing for it, because writing nothing discards the one thing the chapter states unambiguously: which code system the table draws on. It is flagged in the guide as needing attention, so the tentative reading is visible rather than silent, and it is reverted if the ruling goes the other way.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0929, 0930</div>
  <p><b>Do the UCUM weight and volume value sets mean the handful of codes they list, or the UCUM units for the quantity?</b></p><p>This is the half of the 0567/0568 question that the 2026-09-23 ruling did not reach. That ruling retires 0567 and 0568, which removes them from this guide &mdash; but it leaves the same question standing against their live replacements, which this guide does publish. <b>The replacements carry byte-identical code lists to the tables being retired.</b> 0929 enumerates the same four codes as 0567 &mdash; <code>[lb_av]</code>, <code>[oz_av]</code>, <code>kg</code>, <code>g</code> &mdash; and 0930 the same three as 0568: <code>l</code>, <code>[pt_us]</code>, <code>ml</code>. So retiring the old pair does not retire the question; it moves it. <b>The description promises more than the value set delivers.</b> 0930's concept domain is &ldquo;the domain of possible values of units of measure that are used to specify volume&rdquo; and its code system is UCUM, which has a great many volume units. Three are enumerated. A sender needing centilitres, fluid ounces or cubic centimetres finds them absent from a value set whose description says it covers the quantity. Whether that is a deliberate interoperability constraint &mdash; a short list implementers can actually support &mdash; or an accident of how the table was first populated is not something this project can determine from the chapter.</p><p class="ask"><b>The ask:</b> Is the enumerated subset intended, or should these value sets be an intensional reference to the UCUM units for the quantity? If the short list is deliberate, the descriptions should say so, because as written they describe the whole quantity. If it is not, these are two value sets that need rebuilding and the replacement tables inherited the defect they were meant to replace.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0823</div>
  <p><b>Table 0823 <i>Sexual Orientation</i> draws on three code systems and has no value set in THO</b></p><p>The table is <code>Type: HL7-EXT</code>, stewarded by PA, and declares three code systems &mdash; SNOMED CT, <code>DataAbsentReason</code> and <code>NullFlavor</code>. Drawing a value set from three code systems is perfectly normal, and the table does print its five codes. <b>What is missing is the value set itself: THO publishes no <code>ValueSet/v2-0823</code>.</b> The writer cannot proceed because the chapter does not state which of the three declared systems each code belongs to, so it emits nothing. The pattern is worth noting: this is the sister table to <code>0821</code> <i>Gender Identity</i>, built the same way and recorded above for having its grid emptied in publication. Both are Gender Harmony Project material. The plausible reading is that both were entered into Chapter 2C in anticipation of a V2 implementation that was subsequently not carried through &mdash; which would explain why one lost its codes and the other never got a value set in THO.</p><p class="ask"><b>The ask:</b> Confirm whether tables 0821 and 0823 are live commitments or abandoned ones. If live, the per-code system assignments are needed before a value set can be generated, and a <code>ValueSet/v2-0823</code> needs to exist in THO. If they were dropped, say so and this project will record them as published-but-unimplemented rather than as blockers.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0459</div>
  <p><b>Table 0459 names its code system only by an OID that nothing resolves</b></p><p><code>0459</code> <i>Reimbursement Action Code</i> is an External table stewarded by FM. It declares one code system, <code>cms-OCEEditCode-cs</code>, identified solely by OID <code>2.16.840.1.113883.6.301.9</code> with no URI. <b>Neither THO nor the FHIR core packages resolve that OID to a canonical URL</b>, so there is no way to say what code system the table's four codes belong to. The writer therefore emits nothing for this table &mdash; not a CodeSystem, not a ValueSet &mdash; and it is one of only two tables in the chapter blocked this way. Note the reviewer's separate reading that this table may be better modelled as a concept domain, which would dissolve the question rather than answer it.</p><p class="ask"><b>The ask:</b> Supply the canonical URL for the CMS OCE Edit Code system, or confirm that an external code system record needs to be created in THO for it. If neither is available, decide whether 0459 should become concept-domain-only, in which case no value set is needed and the OID becomes documentation rather than a dependency.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0460, 0093</div>
  <p><b>User-defined tables are treated three different ways, and two of them get a freshly minted canonical</b></p><p><code>0460</code> <i>Denial or Rejection Code</i> and <code>0411</code> <i>Supplemental Service Information Values</i> are the <b>only two tables in the whole chapter</b> for which this project mints a new CodeSystem canonical &mdash; every other code-bearing table either reuses a THO canonical or draws on another authority's code system. Both are <code>Type: User</code>. A user-defined table is by definition a set of suggested values that an implementation is expected to replace, so minting <code>CodeSystem/v2-0460</code> publishes suggestions with the authority of a standard code system. <b>The chapter is not consistent about this.</b> Compare <code>0093</code> <i>Release Information</i>, also <code>Type: User</code>, which is declared concept-domain-only and so produces no code system and no value set at all &mdash; even though it lists <code>Y</code> and <code>N</code> in its grid. Three user tables, three outcomes: 0460 and 0411 get minted resources, 0093 gets nothing. Nothing in the chapter explains the difference. 0411 additionally has the defect already recorded above &mdash; the chapter prints a canonical for a resource that does not exist &mdash; and is a mess independent of this question.</p><p class="ask"><b>The ask:</b> <b>0411 has since been answered &mdash; it is concept domain only, see <code>esc-0411-concept-domain-only</code> &mdash; which sharpens this question rather than shrinking it.</b> Two of the three user tables now produce nothing, leaving <b>0460 as the only minted CodeSystem canonical in the entire corpus</b>. Decide what a user-defined table should produce. Options: a CodeSystem and ValueSet like any other (the current behaviour), a concept domain only (as 0093 is treated), or a ValueSet whose codes are marked as examples. The answer decides whether these two new canonicals should exist at all, and it should be applied to 0093 at the same time so that like tables are treated alike.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0725</div>
  <p><b>Table 0725 <i>Mood Codes</i> omits the URI of the v3 code system it draws from</b></p><p>The table's code system block gives a symbolic name <code>actMood</code>, a description of <code>tbd</code>, and OID <code>2.16.840.1.113883.5.1001</code> &mdash; and <b>no URI field at all</b>. The codes are v3 ActMood codes, not v2 codes; THO's own <code>ValueSet/v2-0725</code> draws them from <code>http://terminology.hl7.org/CodeSystem/v3-ActMood</code>. <b>The output is already correct</b>, because the OID the chapter does print resolves through THO to exactly that URL, so the writer emits a value set only and points it at the v3 code system. Recorded because the defect is in the published chapter and will mislead anyone reading it directly: a reader sees a code system with no URI and a description of <code>tbd</code>, with nothing to indicate the codes are v3. It also means the correct result here depends entirely on OID resolution succeeding.</p><p class="ask"><b>The ask:</b> Confirm this as a technical correction under the editing-process test &mdash; add the URI <code>http://terminology.hl7.org/CodeSystem/v3-ActMood</code> and replace the <code>tbd</code> description. Nothing in the generated output changes.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0340</div>
  <p><b>Table 0340's code grid lists code systems, not codes</b></p><p><code>0340</code> <i>Procedure Code Modifier</i> is declared concept-domain-only, so this project writes nothing for it and nothing is blocked. But its code grid is not empty: it holds two rows, <code>CPTM</code> &ldquo;CPT Modifier Code&rdquo; and <code>HPC</code> &ldquo;CMS (formerly HCFA) Procedure Codes (HCPCS)&rdquo;, both with long comments citing the publishing body. <b>These are identifiers of external code systems, not concepts in a code system of the table's own.</b> The chapter is using the code grid for two incompatible purposes without distinguishing them, which is a trap for anyone generating resources from it mechanically &mdash; a naive reading mints a code system whose concepts are the names of other code systems. If the intent is that a procedure code modifier is drawn from CPT or HCPCS, those are external code systems that may warrant external code system records in THO.</p><p class="ask"><b>The ask:</b> Confirm that 0340 is correctly concept-domain-only and that the two rows are documentation of candidate external code systems rather than codes. If they are meant to be usable, they need to be expressed as external code system references rather than as grid rows.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0685, 0767</div>
  <p><b>Two table headings are styled <code>Normal</code> instead of <code>Heading 3</code></b></p><p>Both tables are consequently absent from the document's own table of contents, and both were invisible to extraction until they were special-cased. Their content is complete and is extracted in full; the defect is in the styling of the published document. Recorded here for completeness &mdash; it is the smallest item on this list and needs nothing from this project.</p><p class="ask"><b>The ask:</b> Fix the styles in a future publication.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">35 tables in v2-tables, none of them in Chapter 2C 2.9.1</div>
  <p><b>THO's <code>v2-tables</code> names 35 concept domains that <code>conceptdomains</code> does not define</b></p><p><code>CodeSystem/v2-tables</code> is THO's own index of V2 tables &mdash; 628 entries, each carrying properties including <code>vocab-domain</code>, the concept domain the table names. 624 entries carry a domain, and <b>37 of those name a concept that THO's own <code>conceptdomains</code> 3.0.0 does not contain</b>. This project's proposed additions happen to cover two of them (<code>DangerCode</code>, <code>Location</code>), leaving 35. <b>The gap is confined to tables the chapter has dropped.</b> All 35 sit among the 39 <code>v2-tables</code> entries that Chapter 2C 2.9.1 no longer carries at all, so no row of this guide is affected and nothing here is blocked. That also suggests the cause: when a table left the chapter its concept domain stopped being maintained, but its <code>vocab-domain</code> property stayed behind. Only three of the 39 are typed <i>no longer used</i>; the rest are still typed <i>HL7</i> or <i>User</i>, so the index does not mark them as retired. <b>One caveat on how hard to push this.</b> <code>vocab-domain</code> is declared as type <code>string</code> rather than <code>code</code>, so it is not formally a reference into <code>conceptdomains</code> and nothing validates it. But 587 of 624 values do resolve, which makes the 37 look like drift rather than design.</p><p class="ask"><b>The ask:</b> Confirm that <code>vocab-domain</code> is meant to resolve into <code>conceptdomains</code>. If it is, either the 35 missing domains should be restored, or the entries that name them should be marked as no longer used, or the property should be cleared for tables that have left the standard. If it is genuinely a free string with no such contract, that is worth stating, because readers will assume otherwise. Retyping it as <code>code</code> would let validation catch the next occurrence.</p>
  <div class="ri-who">Goes to: TSMG / UTG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0034</div>
  <p><b><code>v2-tables</code> misspells the concept domain for table 0034 as <code>SiteAdminstered</code></b></p><p><code>CodeSystem/v2-tables</code> gives table 0034 the <code>vocab-domain</code> <code>SiteAdminstered</code>, missing the second <i>i</i> of <i>Administered</i>. The same entry's display is <b>SITE ADMINISTERED</b>, spelled correctly, which settles that this is a typo rather than a deliberate name. Neither <code>SiteAdminstered</code> nor a correctly spelled <code>SiteAdministered</code> exists in <code>conceptdomains</code>, so the property also resolves to nothing &mdash; it is one of the 35 gaps in <code>esc-v2tables-domain-gaps</code>. <b>This one is cheaper to fix than it looks, and it is worth being precise about why.</b> <code>v2-tables</code> is a convenience index that makes V2 table metadata available in THO. Nobody sends <code>SiteAdminstered</code> in a message and no instance data binds to it, so correcting the string breaks no implementation. That makes it a technical correction rather than a substantive change. <b>A typo in a real code, in a real code system, is a different problem entirely</b> &mdash; there the code is an identifier that implementations have already sent and stored, and the remedy is deprecation plus a correctly spelled replacement, not an edit. Nothing in that harder category has been found in the v2 tables so far; this item is deliberately not making that claim.</p><p class="ask"><b>The ask:</b> Correct the <code>vocab-domain</code> value for table 0034 to <code>SiteAdministered</code> as a technical correction. The change should still be traceable &mdash; recorded in the UTG change history like any other edit &mdash; but it does not need the deprecate-and-replace treatment that a published code would. Separately, whether the corrected domain should then be <i>defined</i> in <code>conceptdomains</code>, or the property cleared because table 0034 has left the standard, is part of <code>esc-v2tables-domain-gaps</code>.</p>
  <div class="ri-who">Goes to: TSMG / UTG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">v2-tables, all 628 entries</div>
  <p><b>Should <code>CodeSystem/v2-tables</code> be retired?</b></p><p><code>CodeSystem/v2-tables</code> is not a code system in the sense the rest of THO uses the term. Its 628 concepts are <i>table numbers</i>: the code is the number, the display is the table's name, and the content is a dozen properties carrying the table's OIDs, type, steward, binding strength and concept domain. Nobody sends <code>0005</code> in a V2 message meaning &ldquo;table 5&rdquo;. It is an index of metadata that was given a code system's shape because that was the container available. <b>THO's own description concedes that the index does not work.</b> Under the title line it reads: <i>&ldquo;Please note that V2 Code System and Value Set URIs are present, but the URIs do not resolve. The addition of the appropriate THO artifacts for these are in progress.&rdquo;</i> The index's substance is pointers, and the description says the pointers are broken. Two items above are instances of exactly that: the <code>vocab-domain</code> property names 35 concept domains <code>conceptdomains</code> does not define, and one of those names is a typo. <b>Nothing depends on it definitionally.</b> Checked across all 4,177 files in the <code>hl7.terminology.r5</code> snapshot: <b>no ValueSet composes from it, no CodeSystem supplements it, and nothing binds to it.</b> Outside its own file the only references are three packaging entries &mdash; the <code>hl7.terminology</code> ImplementationGuide manifest, <code>List/v2-Publishing</code> and <code>List/v2-rendering</code> &mdash; and the UTG change-history bundles, which record edits made to it rather than use it. <b>The one real coupling argues for retirement rather than against it.</b> Fourteen properties in <code>CodeSystem/utg-concept-properties</code> carry the comment <i>&ldquo;used only in v2-tables.xml&rdquo;</i>: <code>v2-table-oid</code>, <code>v2-cs-oid</code>, <code>v2-cs-uri</code>, <code>v2-vs-oid</code>, <code>v2-vs-uri</code>, <code>v2-cs-version</code>, <code>v2-table-type</code>, <code>v2-table-deprecated</code>, <code>v2TblStatus</code>, <code>v2-binding</code>, <code>v2-where-used</code>, <code>v2-version-tbl-introduced</code>, <code>v2-version-csvs-introduced</code> and <code>vocab-domain</code>. Retiring <code>v2-tables</code> orphans all fourteen &mdash; which is another way of saying that fourteen property definitions exist to serve one artifact that nothing else reads. (<code>v2-table-deprecated</code> is the exception, and it is a problem in its own right; see the item below.) The case for keeping it is that a machine-readable index of V2 table metadata is genuinely useful &mdash; this guide had to rebuild most of the same information from the chapter. That is an argument for the index existing, not for it being a CodeSystem.</p><p class="ask"><b>The ask:</b> Decide whether <code>CodeSystem/v2-tables</code> should be retired, and if so what takes its place. It carries no codes anyone sends, it has no definitional dependents, and its own description says its pointers do not resolve. <b>The reasoning is already in this register.</b> <code>esc-v2tables-siteadministered</code> argues that correcting a misspelled <code>vocab-domain</code> is a technical correction <i>because</i> nobody sends that value in a message and no instance data binds to it. This item is the same observation taken one step further. If the index is worth keeping, the question is what shape it should have, because a CodeSystem whose concepts are not concepts will keep attracting the defects recorded above, and a reader who finds a code system in THO is entitled to assume its codes turn up in instances. If it is retired, the 14 properties that exist only to serve it should go with it, and this guide's per-table pages become where that information lives. Either way the answer needs both groups: V2 Management owns what the tables are, TSMG owns what THO publishes about them.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0001, 0719</div>
  <p><b>Three artifacts where one OID would end up naming two things, which versioning cannot reconcile</b></p><p>Two artifacts carry a different <code>identifier</code> OID in Chapter 2C than the one THO publishes at the same canonical URL, and a third would create the same breach from the other direction. <b><code>CodeSystem/v2-0001</code> <i>Administrative Sex</i>:</b> the chapter gives <code>2.16.840.1.113883.18.458</code>, THO publishes <code>2.16.840.1.113883.18.2</code>. Both sit in the HL7 v2 code system arc, so neither is obviously a stray. This is the most widely implemented table in V2. The chapter's block is titled <i>Jurisdiction Gender Code System</i>, not <i>Administrative Sex</i>, and <code>...18.458</code> resolves to nothing anywhere in THO &mdash; so this may be a disagreement about <i>which code system</i> the table points at rather than a mistyped digit. <b><code>ValueSet/v2-0719</code>:</b> the chapter gives <code>2.16.840.1.113883.1.11.20429</code>, THO publishes <code>...20428</code>. These are adjacent but they are not near-misses: both are <b>v3</b> value set OIDs and both are in use, <code>...20428</code> for <code>ActInformationSensitivityPolicy</code>'s parent <code>InformationSensitivityPolicy</code> and <code>...20429</code> for <code>ActInformationSensitivityPolicy</code> itself. THO's <code>ValueSet/v2-0719</code> <b>shares</b> <code>...20428</code> with THO's own <code>v3-InformationSensitivityPolicy</code> &mdash; one OID on two artifacts &mdash; which fits THO's own description of 0719, that it &ldquo;was created in THO in error due to an oversight in the import processing&rdquo;. So the question is which v3 value set table 0719 corresponds to, not which digit is a typo. <b><code>ValueSet/v2-0078</code> <i>Interpretation Codes</i> is different in kind, and the difference is the point: <i>we</i> create this one, THO does not.</b> Chapter 2C prints the canonical <code>http://terminology.hl7.org/ValueSet/v2-0078</code> for the table and the value set OID <code>2.16.840.1.113883.1.11.78</code>. THO publishes nothing at that canonical, so this is a first publication rather than a disagreement with an existing artifact. But <code>&hellip;1.11.78</code> is not free. THO's <code>ValueSet/v3-ObservationInterpretation</code> already carries it, on a value set whose content logical definition is <i>byte-identical</i> to the one we would write: a single bare include of <code>CodeSystem/v3-ObservationInterpretation</code>, no filter, no enumerated concepts. It is the only ValueSet in the snapshot with either that OID or that compose. So publishing <code>v2-0078</code> at the chapter's canonical with the chapter's identifier puts <b>one OID on two artifacts</b> &mdash; the same policy breach this item already records for 0719. <b>Why this is not a versioning question.</b> The THO artifact versioning policy treats every other divergence found in this comparison as something a version increment covers. Identifiers are the exception: the policy states that an identifier cannot be changed or removed, that adding one makes it immutable, and that an identifier change requires a <i>new</i> artifact rather than a new version &mdash; &ldquo;extreme care must be taken with identifiers&rdquo;. Publishing our OID at THO's canonical would therefore be a policy violation, not a bump. Every other artifact agrees. Counting the tables where Chapter 2C and THO <i>both</i> give an OID for the same resource type: <b>395 of 396</b> code systems and <b>411 of 412</b> value sets carry identical identifiers. (0078 is not in that count: THO publishes no artifact at that canonical to compare against.)</p><p class="ask"><b>The ask:</b> Adjudicate each OID. For 0001, establish which of <code>...18.458</code> and <code>...18.2</code> is the registered identifier for the Administrative Sex code system, and correct the other source. For 0719, establish whether <code>...20429</code> or <code>...20428</code> is right. Until both are settled this project publishes THO's identifier rather than the chapter's, because the policy forbids changing a published identifier and the canonical URL is THO's. <b>That is now enforced in the pipeline</b> rather than left as a recommendation: the identifier is the one element where the chapter does not win a disagreement, because an identifier is identity rather than content. Both conflicts are recomputed on every run, so neither can drift out of view. <b>A third option has been raised and needs ruling on: publish <i>both</i> OIDs as identifiers.</b> <code>identifier</code> is 0..* on both CodeSystem and ValueSet, so it is mechanically available, and it would avoid choosing before the committees have. It is not obviously right: two identifiers on one artifact asserts that both OIDs name it, which for 0719 is demonstrably false &mdash; <code>...20429</code> names a different v3 value set, which THO also publishes. Carrying both would be defensible for 0001, where the two may be the same code system under two registrations, and misleading for 0719. <b>Please rule per artifact rather than as a blanket policy.</b> <b>0078 was the third conflict here and has been answered</b> &mdash; see <code>esc-0078-alias-of-v3</code>. V2 Management ruled on 2026-10-14 that the existing <code>v3-ObservationInterpretation</code> serves and no second artifact is created, which removed that collision rather than adjudicating it. <b>It is not a precedent for these two:</b> 0078's collision existed only because this guide was about to create the second artifact, and 0001 and 0719 are conflicts between artifacts that already exist.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">798 tables</div>
  <p><b>Chapter 2C gives every table its own OID, and this guide publishes it nowhere</b></p><p>Chapter 2C carries <b>three</b> OIDs per table, in three separate metadata blocks, and they identify three different things: a <b>Table OID</b> in the <code>2.16.840.1.113883.12.*</code> arc (798 of 799 tables), a <b>Code System OID</b> in <code>...113883.18.*</code> (435 tables), and a <b>Value Set OID</b> in <code>...113883.21.*</code> (438 tables). THO uses the same two latter arcs for the same two resource types, so the code system and value set OIDs have an obvious home and are written to <code>CodeSystem.identifier</code> and <code>ValueSet.identifier</code>. <b>The table OID has no home.</b> In V2 the table is the thing with an identity; in FHIR that table becomes a code system <i>and</i> a value set, and neither of them <i>is</i> the table. So the <code>.12</code> OID is carried by no resource this guide publishes. That is not a decision anyone took &mdash; it is what happens by default when a one-to-one identifier meets a one-to-two split, and it means 798 published identifiers from the chapter appear in no output. Worth knowing before ruling: 50 of the 798 are not identifiers at all but the bare arc root <code>2.16.840.1.113883.1</code> with no leaf, on the 50 tables the chapter types <i>undefined</i>; and the table OID is not dead elsewhere &mdash; THO's own description of table 0227 cites PHIN VADS by the <code>.12.227</code> table OID, so implementers do resolve these.</p><p class="ask"><b>The ask:</b> Decide where a V2 table OID belongs in a FHIR representation of that table, and whether this guide should start writing it. The options each say something different and none is free. Putting it on the <b>CodeSystem</b> says the code system is the table, which is wrong for the 24 value-set-only tables whose codes belong to another authority. Putting it on <b>both</b> resources asserts one identifier for two artifacts, which is the same shape as the defect registered at <code>esc-oid-conflicts</code>. Putting it on the <b>concept domain</b> concept has no <code>identifier</code> element to hold it. Putting it <b>nowhere</b> is the current behaviour and may well be right &mdash; but it should be a ruling rather than an accident, because the identifier is in the published chapter and its absence from the FHIR artifacts is silent.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0003, 0125, 0357 for B; 25 tables, 261 concepts for N</div>
  <p><b>The concept statuses <code>N</code> and <code>B</code> are defined nowhere; <code>N</code> is now mapped, <code>B</code> is not</b></p><p>Chapter 2C carries its own legend for the status column: blank means an active code, <code>B</code> means &ldquo;backwards-compatible use only&rdquo;, <code>D</code> means &ldquo;deprecated or inactive&rdquo;, <code>R</code> means &ldquo;retired&rdquo;, and <code>N</code> means <b>&ldquo;new in this release&rdquo;</b>. Blank, <code>D</code> and <code>R</code> have unambiguous FHIR equivalents and are written as <code>active</code>, <code>deprecated</code> and <code>retired</code>. <code>N</code> and <code>B</code> do not. <b>Neither is defined anywhere.</b> The property they are written to is <code>status</code>, defined by FHIR at <code>http://hl7.org/fhir/concept-properties#status</code>, whose own definition reads &ldquo;a code that indicates the status of the concept. Typical values are active, experimental, deprecated, and retired.&rdquo; Neither <code>N</code> nor <code>B</code> is among them. They are not in <code>utg-concept-properties</code> either, and no value set enumerates them. Across the whole of <code>hl7.terminology.r5</code> they appear <i>only</i> in v2 code systems &mdash; 210 concepts carry <code>N</code> and 6 carry <code>B</code>. <b><code>N</code> is worse than undefined, because it decays.</b> &ldquo;New in this release&rdquo; was a statement about whichever release first printed it, and nothing updates it afterwards. That is visible in the data: THO still marks 210 concepts <code>N</code> from past releases while the 2.9.1 chapter marks only 70, and <b>205 of the 261 status disagreements between the chapter and THO are exactly this</b> &mdash; THO saying <code>N</code> where the current chapter says nothing, so this project publishes <code>active</code>. <b><code>N</code> is now mapped to <code>active</code>, as a technical correction.</b> The reviewer ruled on this half on 2026-09-19, and the three findings above are the grounds taken together: &ldquo;new in this release&rdquo; is not a status but a provenance note; it expires with nothing to update it, so a value printed in 2.9.1 is already a claim about some earlier release; and it is not a legal value of the standard FHIR property this guide writes it into, whose own definition enumerates active, experimental, deprecated and retired. A code marked <code>N</code> is in every case an active code, so writing <code>active</code> says what the chapter means and says it in the same vocabulary <code>D</code> and <code>R</code> already use. On the errata test in the first item of this register that is a change that makes the document say what the work group intended, not a change to what the standard means. <b><code>B</code> is deferred, deliberately.</b> &ldquo;Backwards-compatible use only&rdquo; is a real statement about a code and it has no obvious FHIR equivalent: not <code>deprecated</code>, because the code is still correct for existing senders; not <code>retired</code>; and not plainly <code>active</code> either, because the restriction is real. It is also small enough to take one at a time &mdash; <b>five concepts in three tables</b>: <code>0003</code> <i>Event</i> code <code>O57</code> (OMQ &mdash; General Order Message with Document Payload), <code>0125</code> <i>Value Type</i> code <code>IS</code> (Coded value for user-defined tables), and <code>0357</code> <i>Message Error Condition Codes</i> <code>204</code>, <code>205</code> and <code>206</code> (Unknown key identifier, Duplicate key identifier, Application record locked). Five concepts is a review, not a policy.</p><p class="ask"><b>The ask:</b> Two things remain. <b>(1) Rule on <code>B</code>, per concept.</b> Five concepts in three tables is small enough to look at individually, and they are not obviously the same case &mdash; <code>0125</code>'s <code>IS</code> is a data type code, <code>0357</code>'s three are error conditions. For each, say whether the FHIR status should be <code>active</code>, <code>deprecated</code>, or <code>active</code> with a separate marker recording the backwards-compatibility restriction. <b>(2) Decide where, if anywhere, these letters should be defined.</b> Even with <code>N</code> resolved by mapping, THO still publishes 210 concepts carrying it as a literal status value and 6 carrying <code>B</code>, against a property whose definition admits neither. Defining them in <code>utg-concept-properties</code> would at least make what is already published legal; replacing <code>N</code> with a non-decaying &ldquo;version introduced&rdquo; property would be better, and the chapter already records that fact in prose elsewhere. <b>What this guide does now:</b> <code>N</code> is written as <code>active</code>; <code>B</code> is passed through unchanged pending (1); and all 261 chapter-versus-THO status disagreements are still recorded, because mapping <code>N</code> does not make the underlying divergence go away.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0003, 0006, 0065, 0066, 0074, 0076, 0104, 0131, 0163, 0175, 0191, 0200, 0207, 0211, 0223, 0272, 0277, 0278, 0279, 0281, 0291, 0294, 0354, 0359, 0365, 0366, 0367, 0391, 0396, 0418, 0440, 0474, 0487, 0492, 0544, 0916</div>
  <p><b>191 concepts say they are active and deprecated as of 2.9 at the same time</b></p><p><b>The contradiction.</b> <b>241 concepts across 36 code systems</b> carry the concept property <code>v2-table-deprecated</code> with the value <code>2.9</code>. Of those, <b>191 carry a concept <code>status</code> that is neither <code>deprecated</code> nor <code>retired</code></b> &mdash; 169 say <code>active</code> and 22 say <code>N</code>. (<code>N</code> is now mapped to <code>active</code>, per the item above, so all 191 read <code>active</code>.) The other 50 do say <code>deprecated</code>, which is what the flag implies. So the two properties agree on 50 concepts and contradict each other on 191, and both values are the chapter's, reproduced faithfully. <b>The property is defined twice, at one URI, to mean two different things.</b> <code>CodeSystem/utg-concept-properties</code> defines <code>v2-table-deprecated</code> as a <i>table-level</i> assertion &mdash; &ldquo;Indicates that although still being published in the V2 international standard, <b>the table</b> has been deprecated in favor of alternative codes, and will be withdrawn in the future&rdquo; &mdash; with the comment &ldquo;used only in v2-tables.xml&rdquo;. THO's individual v2 CodeSystems declare the same code at that same URI, <code>&hellip;utg-concept-properties#v2-table-deprecated</code>, describe it as &ldquo;<b>Version of HL7</b> in which <b>the code</b> was deprecated&rdquo;, and use it on concepts. Two definitions, one identifier. <b>The data settles which definition the values follow.</b> All 241 values are the string <code>2.9</code>, which is a version and not a yes. And <code>v2-tables</code> itself &mdash; the file the first definition says is the property's only user &mdash; carries it on <b>zero</b> of its 628 entries. The concept-level reading is the one in use; the table-level definition is the stale one. <b>What this does not say, because it bounds the ask.</b> <b>None of the 36 code systems has all of its concepts flagged.</b> It is 241 concepts out of the 2,230 those 36 contain, or 10.8%; the most affected is <code>0272</code> <i>Document Confidentiality Status</i> at 6 of 9, the least <code>0487</code> <i>Specimen Type</i> at 2 of 315. So this is a claim about individual codes, and <code>CodeSystem.status = active</code> is correct on all 36. Nothing here generalises to 0567 and 0568, where the whole table is deprecated and a different mechanism is needed.</p><p class="ask"><b>The ask:</b> Confirm that a concept whose <code>v2-table-deprecated</code> is <code>2.9</code> should carry <code>status: deprecated</code>. One ruling resolves all 191, because there is nothing case-by-case about it: the flag says the code was deprecated in 2.9, and 2.9 has shipped. <b>This guide has not applied that, and is surfacing it for decision rather than fixing it.</b> Both the status and the flag are published values and both are reproduced, contradiction included. Changing 191 concept statuses is a content change to published normative material &mdash; which is the question the first item in this register asks in general terms &mdash; and it is not something to do on inference. Two smaller things should be settled alongside it. Give <code>v2-table-deprecated</code> a <b>single</b> definition, the concept-level one, since that is what the values are; or split it into two properties with two URIs, because at present one identifier means &ldquo;this table is deprecated&rdquo; in one place and &ldquo;the version this code was deprecated in&rdquo; in another. And decide whether the flag is still wanted once <code>status</code> says the same thing, or whether it becomes the record of <i>when</i>, which <code>status</code> cannot carry.</p>
  <div class="ri-who">Goes to: V2 Management</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">policy; 12 descriptions, 25 concepts</div>
  <p><b>How far does the description &ldquo;editorial corrections&rdquo; carve-out reach?</b></p><p>The Code Systems versioning policy qualifies exactly one element: <code>CodeSystem.description</code> is &ldquo;major unless only change is improved clarity or perform editorial corrections&rdquo;. This project applies that where it can do so honestly &mdash; where our description and THO's contain exactly the same words in the same order, so that only punctuation or spacing moved. <b>12 descriptions across 7 tables</b> are waived on that basis, every one of them our <code>e.g.,</code> against THO's <code>e.g.</code>, or our <code>code system.</code> against THO's <code>code system .</code>. Three things about this need confirming. <b>First, the rule itself:</b> is a punctuation-only difference an editorial correction? <b>Second, the asymmetry it creates.</b> The carve-out is written against <code>description</code> alone, while <code>CodeSystem.concept (and all subelements)</code> is listed unqualified. So <b>4 concept definitions and 21 concept displays that differ from THO only in punctuation do increment</b>. A comma in a description is free; the same comma in a display costs a major version. This project has not smoothed that over, because guessing at an unwritten carve-out is how a pipeline quietly stops matching the rules it claims to follow &mdash; but it looks more like an oversight than a decision. <b>Third, the Value Sets policy has no equivalent carve-out at all</b>, so read literally it makes every description difference a major increment however trivial. This project treats <code>ValueSet.description</code> exactly as it treats <code>CodeSystem.description</code>, rather than encode an asymmetry believed to be a drafting slip.</p><p class="ask"><b>The ask:</b> Confirm the punctuation waiver, say whether it should extend to concept definitions and displays, and confirm whether the missing ValueSet carve-out is deliberate. Each answer is a located change in this project; none of them is a rewrite.</p>
  <div class="ri-who">Goes to: TSMG</div>
</div>
<div class="ri-item ri-escalate">
  <div class="ri-key">0227, 0719</div>
  <p><b>Two THO descriptions carry text the chapter's do not, including THO documenting its own error</b></p><p>Of the description differences between this project's output and THO, all but two are punctuation. These two are not, and in both THO's text carries something the chapter's does not. <b><code>ValueSet/v2-0227</code>:</b> THO's description ends with a link to the code system on PHIN VADS. The chapter's stops before it, so publishing the chapter's drops a working source reference for a code system HL7 does not itself maintain. <b><code>ValueSet/v2-0719</code>:</b> THO's description ends &ldquo;Note that this resource was created in THO in error due to an oversight in the import processing.&rdquo; That is THO documenting its own mistake in the artifact's description. It is not something Chapter 2C should inherit, but it does say the artifact needs attention rather than a redraft &mdash; and 0719 is also one of the two artifacts with an OID conflict. This project publishes the chapter's description in both cases and increments the version. The merge fills an absent value from THO but never splices two pieces of prose together, because concatenating them would publish text neither source wrote.</p><p class="ask"><b>The ask:</b> For 0227, decide whether the source reference should be carried into the chapter's description or dropped. For 0719, decide what should happen to a THO artifact whose own description says it was created in error &mdash; and settle that together with its OID conflict, since the two are likely the same story.</p>
  <div class="ri-who">Goes to: V2 Management + TSMG</div>
</div>

### For TSMG — the versioning policy

**Settled: a description difference is always a major increment.** The
published CodeSystem policy qualifies the rule — *"major unless only change is
improved clarity or perform editorial corrections"* — but that qualification
was left in the policy by error. There is no editorial exemption and no
improved-clarity exemption: every qualifying change increments. The CodeSystem
and ValueSet policies agree with each other on this, and the absence of the
qualification from the ValueSet policy is not an asymmetry to be read into.

**What that costs here: eleven artifacts increment for this reason alone**, all
`3.0.0` → `4.0.0` — CodeSystems 0083, 0367, 0389 and 0434, and ValueSets 0083,
0367, 0389, 0434, 0496, 0952 and 0959. All but one turn on a comma, almost
always `(i.e.` becoming `(i.e.,`. The exception is value set 0952, where the
whole difference is whitespace: a space before a full stop, and a doubled space
mid-sentence. The per-table ledger marks each one, saying that the two texts
contain the same words in the same order and differ only in punctuation, and
that it increments regardless.

The same rule applies without qualification to concept definitions and concept
displays, which the policy already lists unqualified, so nothing about them is
now exceptional.

**Version outcomes across the corpus** are computed from the merge and
published as a table on [what this guide keeps from THO](tho-merge.html). They
are deliberately not repeated here: this paragraph carried them for a while and
was a value set out of date within a month of being written, because a single
concept display losing its increment moves one of the totals.

**Nothing is open for TSMG.** The question put to them ([question 1](evidence.html#gq-does-reordering-a-code-system)) was answered; the ruling and what it changed are recorded on the evidence page.

### For V2 Management — what the chapter says

<a name="gq-the-concept-status-b-and"> </a>

#### 2. The concept status `B`, and where these letters should be defined

Chapter 2C carries its own legend for the status column:

| Code | Chapter 2C's meaning |
|---|---|
| *(empty)* | active code |
| `B` | backwards-compatible use only |
| `D` | deprecated or inactive |
| `R` | retired |
| `N` | new in this release |

Empty, `D` and `R` have unambiguous FHIR equivalents and are written as
`active`, `deprecated` and `retired`.

**`N` is settled: it is written as `active`, as a technical correction.** Three
things together decide it. "New in this release" is a provenance note, not a
status. It decays — nothing updates it after the release that set it, so a
letter printed in 2.9.1 is already a claim about some earlier release. And it
is not a value of the standard FHIR concept-status property this guide writes
it into, at `http://hl7.org/fhir/concept-properties#status`, whose own
definition reads *"a code that indicates the status of the concept. Typical
values are active, experimental, deprecated, and retired."* A code marked `N`
is in every case an active code, so `active` says what the chapter means, in
the same vocabulary `D` and `R` already use. This is not a new treatment: the
guide already publishes `active` for 205 concepts where THO still says `N` and
the current chapter says nothing, and the correction now also reaches concepts
inherited whole from THO. **No `N` survives anywhere in the output**, and that
departure from THO is recorded in the merge report rather than absorbed
silently.

**`B` is not settled, and is deferred for case-by-case review.**
"Backwards-compatible use only" is a real statement about a code and it has no
obvious FHIR equivalent: not `deprecated`, because the code is still correct
for existing senders; not `retired`; and not plainly `active` either, because
the restriction is real. Four concepts carry it into the output — table 0003
*Event* code `O57`, and table 0357 *Message Error Condition Codes* codes `204`,
`205` and `206`. **So this guide knowingly publishes four `status` values that
are not in the property's value set.** That is stated here rather than left for
a reader to notice.

**What we need, in two parts:**

1. **Rule on `B`, per concept.** Four concepts is a review, not a policy. For
   each, say whether the FHIR status should be `active`, `deprecated`, or
   `active` with a separate marker recording the backwards-compatibility
   restriction.
2. **Decide where, if anywhere, these letters should be defined.** Even with
   `N` resolved by mapping, THO still publishes concepts carrying `N` and `B`
   as literal status values, against a property whose definition admits
   neither, and no value set enumerates them. Defining them in
   `utg-concept-properties` would at least make what is already published
   legal. Replacing `N` with a non-decaying "version introduced" property would
   be better, and the chapter already records that fact in prose elsewhere.

<a name="gq-table-0560-a-code-system"> </a>

#### 3. Table 0560 — a code system the chapter says does not exist

Chapter 2C gives table 0560 a code system block whose symbolic name is
`noObject`, whose OID is `-` and whose description is `noDescription`. Read
literally, the table has no code system. Read in full, the same section:

- lists **five codes** — `FL` Units, `HS` Hours, `DY` Days, `MN` Month,
  `YY` Years;
- gives a **value set OID**, `2.16.840.1.113883.21.380`, and the symbolic name
  `hl7VS-quantityUnits`;
- says in its own metadata that the table has **"No suggested values"**, which
  the five codes directly contradict;
- names the code system **"Name Representation Code System"**, which belongs
  to a different table entirely.

Meanwhile **THO already publishes both artifacts** — `CodeSystem/v2-0560` with
those same five codes at OID `2.16.840.1.113883.18.455`, and `ValueSet/v2-0560`
at the OID the chapter gives.

**What we do:** publish the code system and the value set as the chapter's
content describes them. The `noObject` marker is treated as a defect in the
chapter rather than a statement about the table, on the evidence of the codes,
the value set OID, and THO's existing artifacts agreeing with each other and
disagreeing with the marker. The code system's name, title and OID are taken
from THO, since the chapter supplies only placeholders for all three. See
ADR-0009.

**What we would like:** the chapter's 0560 section corrected — the placeholder
block replaced with the real code system, the "No suggested values" note
removed, and the copied-in code system name fixed.

<a name="gq-three-oids-where-one-number"> </a>

#### 4. Three OIDs where one number would end up naming two artifacts

| Artifact | Chapter 2C | THO |
|---|---|---|
| `CodeSystem/v2-0001` | `2.16.840.1.113883.18.458` | `2.16.840.1.113883.18.2` |
| `ValueSet/v2-0719` | `2.16.840.1.113883.1.11.20429` | `2.16.840.1.113883.1.11.20428` |
| `ValueSet/v2-0078` | `2.16.840.1.113883.1.11.78` | *(THO publishes no such artifact)* |

The first two are the only disagreements in the corpus where both sides give an
OID for the same resource: 395 of 396 code system OIDs and 411 of 412 value set
OIDs are identical on both sides. The third is different in kind and is
described below.

Neither of the first two is a mistyped digit, and it is worth being precise
about what each one actually is:

- **`v2-0001`** — the chapter's block is titled *Jurisdiction Gender Code
  System*, not *Administrative Sex*, and `...18.458` resolves to nothing
  anywhere in THO. So this may be a disagreement about *which code system*
  table 0001 points at, rather than about a number. It is also the most widely
  implemented table in V2.
- **`v2-0719`** — both OIDs are **v3** value set OIDs and both are in use.
  `...20428` belongs to `InformationSensitivityPolicy`, `...20429` to
  `ActInformationSensitivityPolicy`. THO's `ValueSet/v2-0719` **shares**
  `...20428` with THO's own `v3-InformationSensitivityPolicy` — one OID on two
  artifacts — which fits THO's own note that 0719 "was created in THO in error
  due to an oversight in the import processing." The question is which v3
  value set table 0719 corresponds to.

**`ValueSet/v2-0078` *Interpretation Codes* is different in kind: this guide
creates it, THO does not.** Chapter 2C gives table 0078 the canonical
`http://terminology.hl7.org/ValueSet/v2-0078`, at which THO publishes nothing,
together with the value set OID `2.16.840.1.113883.1.11.78`. That OID is not
free. THO's `ValueSet/v3-ObservationInterpretation` already carries it, on a
value set whose content logical definition is **byte-identical** to the one
written here — a single bare include of
`CodeSystem/v3-ObservationInterpretation`, no filter, no enumerated concepts.
So publishing the chapter's canonical with the chapter's OID puts **one OID on
two artifacts**, which is the same breach the 0719 case already shows.

**Two further OID-sharing cases sit inside THO itself**, and are worth naming
because they establish that this shape is not unique to the tables above:
`2.16.840.1.113883.21.452` is the identifier on both `ValueSet/v2-0567` and
`ValueSet/v2-0929`, and `2.16.840.1.113883.21.453` on both `ValueSet/v2-0568`
and `ValueSet/v2-0930`.

**Why a version increment cannot settle any of this.** An OID is an
`identifier`, and the versioning policy puts identifiers outside the version
system altogether: *"Cannot change or remove a ... identifier ... You must
create a new [artifact] for identifier changes."* So whichever number in each
pair is wrong, the remedy is not a version bump, and publishing the other one
at the same canonical is not something a new version can express.

**What we do:** publish **THO's** OID for 0001 and 0719, and report the
conflict. This is the one place where the chapter does not win a disagreement,
and deliberately so — an identifier is identity rather than content, and the
canonical URL is THO's. For 0078 the chapter's OID is published, because there
is no THO artifact at that canonical to defer to.

**What we need.** These look most like **technical corrections** rather than
substantive changes — non-controversial changes that alter a document so that
it says what the work group intended it to say. If that is right, each can be
handled as an erratum against whichever source is wrong, without any version
consequence. Please confirm that reading and adjudicate per artifact: for 0001,
which of `...18.458` and `...18.2` is the registered identifier for the
Administrative Sex code system; for 0719, which of `...20429` and `...20428` is
right; and for 0078, whether the chapter's canonical should be published at all
given that THO already publishes the same content at
`v3-ObservationInterpretation` under that OID.

A further option has been raised for 0001 — publishing *both* OIDs as
identifiers, since `identifier` is `0..*`. It avoids choosing before you have,
but two identifiers assert that both OIDs name this artifact, which is
demonstrably false for 0719, where `...20429` names a different v3 value set
that THO also publishes. It may be right for 0001, where the two could be one
code system under two registrations. Please rule per artifact rather than as a
blanket policy.

<a name="gq-two-descriptions-where-tho-says"> </a>

#### 5. Two descriptions where THO says more than the chapter

These are the two description differences that are **not** punctuation, and
both are cases where THO's text carries something the chapter's does not:

- **`ValueSet/v2-0227`** — THO's description ends with a link to the code
  system on PHIN VADS. The chapter's description stops before it. Publishing
  the chapter's drops a working source reference.
- **`ValueSet/v2-0719`** — THO's description ends *"Note that this resource
  was created in THO in error due to an oversight in the import processing."*

These read as one question and are two, and only one of them is still open.

**0227 — settled.** The chapter's text here is one of the sixteen truncated
value set descriptions: it stops mid-word, and THO's continues and completes
the sentence. That is not the two sources disagreeing, it is the chapter being
incomplete, so THO's fuller text is published and the source reference
survives. The rule is general rather than a decision about this one table —
where the chapter's description is a prefix of THO's *and* stops mid-sentence,
THO holds the words the chapter lost. Exactly two descriptions in the chapter
are a prefix of THO's, and this is the only one that stops mid-sentence.
Recovering the text also means there is no longer a difference to increment
for, so this value set keeps THO's version rather than moving past it.

**0719 — open, and the description is not really the question.** Here the
chapter's text is complete and THO has *appended* a sentence recording its own
error, so the rule above does not reach it and the chapter's text stands. The
note THO carries documents a defect that goes further than the wording: 0719
also shares its identifier with `v3-InformationSensitivityPolicy`, which is one
of the cases in question 4. The question is whether the artifact should be
**retired in THO altogether**, and it should be settled together with the
identifier rather than as a matter of which sentence to publish.

<a name="gq-chapter-2c-gives-every-table"> </a>

#### 6. Chapter 2C gives every table its own OID, and we publish it nowhere

Chapter 2C carries **three** OIDs per table, in three separate metadata blocks,
identifying three different things:

| Chapter 2C block | Arc | Tables | Published to |
|---|---|---:|---|
| Table OID | `2.16.840.1.113883.12.*` | 798 | **nothing** |
| Code System OID | `2.16.840.1.113883.18.*` | 435 | `CodeSystem.identifier` |
| Value Set OID | `2.16.840.1.113883.21.*` | 438 | `ValueSet.identifier` |

The last two have an obvious home, and THO uses the same two arcs for the same
two resource types, so the comparison behind question 4 is like for like.

**The table OID has no home.** In V2 the table is the thing with an identity.
In FHIR that table becomes a code system *and* a value set, and neither of them
*is* the table — so there is no resource for the `.12` OID to sit on.

**Decided: the table OID stays out of the CodeSystem and ValueSet resources for
now.** None of the available homes is free. `CodeSystem.identifier` says the
code system is the table, which is wrong for the 24 value-set-only tables whose
codes belong to another authority. Putting it on *both* resources asserts one
identifier for two artifacts — the same shape as the defect in question 4. The
concept domain concept has no `identifier` element to hold it.

**An extension on both resources is kept as a documented option**, should V2
Management require the table OID to be preserved somewhere in the FHIR
resources. It is deliberately **not** a second `identifier`: two identifiers on
one resource assert that both OIDs name that artifact, and the table OID does
not name the code system or the value set — it names the table they were
derived from. An extension can say "this artifact came from table *n*" without
making that claim. It would have to be newly minted: no extension for this
exists in the THO snapshot. The snapshot defines nine extensions in total, none
of them identifier-bearing, and the only extensions in use on THO's code
systems and value sets are the standard work-group, FMM, standards-status,
normative-version, artifact-version and extensible-value-set extensions, plus
THO's own `ext-mif-assocConceptProp`.

Two things worth knowing before ruling. 50 of the 798 are not identifiers at
all — they are the bare arc root `2.16.840.1.113883.1` with no leaf, on the 50
tables the chapter types *undefined*. And the table OID is not dead: THO's own
description of table 0227 cites PHIN VADS by the `.12.227` table OID, so
implementers do resolve these.

**What we need, narrowly:** does V2 Management require the table OID to be
preserved in the FHIR resources at all? If it does, the extension is the shape
we would use, and the question of who defines it follows. If it does not, the
current behaviour becomes a ruling rather than a default.

<a name="gq-table-0292-published-against-the"> </a>

#### 7. Table 0292 — published against the chapter's own flag, pending a ruling

Chapter 2C flags table 0292 *Vaccines Administered* `Concept Domain Only: yes`,
which would mean no code system and no value set. The table metadata grid a few
lines further down **in the same section** gives `Full Name: Vaccines
Administered Code System` and `URI: http://hl7.org/fhir/sid/cvx`. Both
statements are published and they cannot both be acted on: a concept domain has
no code system and no value set, and a table that prints a code system
canonical is not a concept domain.

**What we do:** treat the grid as right and the flag as wrong. 0292 is
published **value set only**, its value set composing over
`http://hl7.org/fhir/sid/cvx`. Four independent signals point the same way:

- THO publishes `ValueSet/v2-0292`, `status: active`, whose entire compose is a
  single bare include of `http://hl7.org/fhir/sid/cvx` — exactly the canonical
  the chapter prints.
- `NamingSystem/CVX` registers table 0292's own table OID,
  `2.16.840.1.113883.12.292`, against that URI, and calls the URI the "official
  canonical URL going forward".
- The sibling table **0227** *Manufacturers of Vaccines (MVX)* — the other half
  of the same CDC vaccine pair, same steward, same `Full Name`-plus-`URI` shape
  — is flagged `Concept Domain Only: no` and is published exactly this way,
  over `http://hl7.org/fhir/sid/mvx`. Two halves of one pair should not be
  classified differently.
- Of the 14 tables the chapter types *External*, not one resolves to a code
  system of its own.

Minting a `CodeSystem/v2-0292` would be the wrong answer, and it is worth
saying so because it is the shape most of the corpus takes: the chapter
publishes zero codes for this table, so there would be nothing to put in it;
THO deliberately carries no CodeSystem for CVX, only the NamingSystem; and a
`v2-0292` code system would claim the table OID that `NamingSystem/CVX` has
already bound to the CDC's URI.

**This is a deliberate deviation and it is recorded as one.** It is the **only**
place in this build where the guide publishes something the chapter's own flag
contradicts while the question is still open. The deviation is tentative by
construction: it names this question, it is recomputed and counted on every
run so it cannot drift out of sight, and a ruling either way removes it. See
ADR-0011.

**What we need:** confirm that 0292 should be routed value set only over
`http://hl7.org/fhir/sid/cvx`, consistent with 0227, and that the
`Concept Domain Only: yes` flag is the error. **If the flag is authoritative,**
the deviation is withdrawn and 0292 reverts to concept domain only, with no
artifacts published for it.

---

### Decisions still to take

Judgements this guide cannot make for itself. Each one has a working answer applied, so none of them blocks a build; each is here because the answer is somebody else's to give.

#### For V2 Management / TSMG &mdash; Tables the XML writer will not guess at <span class="ri-count">&mdash; 15 items</span>

<div class="ri-blurb">The writer produces a CodeSystem or ValueSet only where the chapter says clearly enough what it should be. These tables it leaves alone, and each group below is one decision rather than one per table. Nothing here is a defect in the tooling; each is a place the published chapter is ambiguous, incomplete, or points somewhere that does not resolve.</div>

<div class="ri-item ri-decide">
  <div class="ri-key">3</div>
  <p>The table declares 2 code systems; which one the value set draws from is not stated.</p><p class="ask">0827 <i>Source Document Jurisdiction for Recorded Sex or  Gender</i>, 0828 <i>Sex Parameter for Clinical Use</i>, 0953 <i>Security Label Handling Instructions</i></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">2</div>
  <p>The code system is given only as OID 2.16.840.1.113883.6.301.9, which nothing in THO or FHIR core resolves to a canonical URL.</p><p class="ask">0458 <i>OCE Edit Code</i>, 0459 <i>Reimbursement Action Code</i></p><p>As published: <code>2.16.840.1.113883.6.301.9</code></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">2</div>
  <p>The table owns its code system but publishes no codes, so a complete CodeSystem cannot be built.</p><p class="ask">0467 <i>Modifier Edit Code</i>, 0895 <i>Present On Admission (POA) Indicator</i></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">2</div>
  <p>The table declares 3 code systems; which one the value set draws from is not stated.</p><p class="ask">0821 <i>Gender Identity</i>, 0823 <i>Sexual Orientation</i></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">2</div>
  <p>The Content Logical Definition is not one of the shapes we build -- all codes, enumerated per table content, or an is-a filter: &#x27;as defined in the linked value set&#x27;.</p><p class="ask">0822 <i>Personal Pronouns</i>, 0824 <i>Recorded Sex or Gender Type</i></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">1</div>
  <p>The Content Logical Definition is not one of the shapes we build -- all codes, enumerated per table content, or an is-a filter: &#x27;ISO 3166-1 alpha-3 axis&#x27;.</p><p class="ask">0399 <i>Country Code</i></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">1</div>
  <p>The Content Logical Definition is not one of the shapes we build -- all codes, enumerated per table content, or an is-a filter: &#x27;unspecified&#x27;.</p><p class="ask">0956 <i>Job Supervisory Level or Pay Grade</i></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">1</div>
  <p>The code system is given only as OID 2.16.840.1.113883.4.642.1.200, which nothing in THO or FHIR core resolves to a canonical URL.</p><p class="ask">0962 <i>Device Status</i></p><p>As published: <code>http://hl7.org/fhir/codesystem-device-status.html</code></p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">1</div>
  <p>The Content Logical Definition is not one of the shapes we build -- all codes, enumerated per table content, or an is-a filter: &#x27;See content logical definition of the referenced value set&#x27;.</p><p class="ask">0963 <i>Device Safety</i></p>
</div>

#### For the editor &mdash; Publication metadata Chapter 2C does not carry <span class="ri-count">&mdash; 5 items</span>

<div class="ri-blurb">Every generated resource needs a version, a date, a status and a publisher, and the chapter supplies none of them. Each value below is a single constant in <code>tooling/scripts/write_utg_xml.py</code>. None blocks generation; all of them are cheap to change now and expensive to change after the resources are in front of a committee.</div>

<div class="ri-item ri-decide">
  <div class="ri-key">&lt;code&gt;version&lt;/code&gt;</div>
  <p><b>Inherited per resource from the existing UTG file. <b>1.0.0 for the 14 resources UTG does not have.</b></b></p><p>UTG's own corpus is not uniform: its CodeSystems carry 3.0.0 (412), 5.0.0 (3) and 4.0.0 (1); its ValueSets carry 3.0.0 (430), 2.0.0 (6) and 4.0.0 (3). Inheriting keeps 807 of 823 resources exactly where UTG has them and confines the question to genuinely new content.</p><p class="ask"><b>To decide:</b> <b>Decided (2026-08-25): a brand-new CodeSystem or ValueSet starts at 1.0.0.</b> This replaces a 3.0.0 placeholder that had been chosen only to match the neighbouring resources. A first publication is a first version regardless of what sits beside it, and starting at 3.0.0 would imply two releases that never happened. The 14 affected resources, across 12 tables, are listed in the write report under <code>usedDefaultVersion</code>, which now records the fallback per resource rather than per table &mdash; a table can inherit a version for its CodeSystem and not for its ValueSet, and three do. <b>Two of those fourteen should probably not be in the list at all:</b> 0291 and 0347 fall back only because UTG files their value sets under <code>v2-notAllCodes-NNNN</code>, so the name-based lookup misses them. See the field-mapping document.</p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">&lt;code&gt;date&lt;/code&gt;</div>
  <p><b>Inherited from UTG; <code>2019-12-01</code> as the fallback.</b></p><p>414 of 416 UTG CodeSystems and 437 of 439 ValueSets carry <code>2019-12-01</code> &mdash; the date of the bulk v2 load, not a date anyone chose per resource.</p><p class="ask"><b>To decide:</b> Using it for new content asserts the resource existed in 2019, which is false. The alternatives are the date this work is published, or omitting <code>date</code> on new resources. Note that a build date would churn on every regeneration, which is why it is not a generated value today.</p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">&lt;code&gt;status&lt;/code&gt;, &lt;code&gt;experimental&lt;/code&gt;</div>
  <p><b><code>active</code> and <code>false</code> for everything.</b></p><p>Unanimous in UTG: all 416 CodeSystems and all 439 ValueSets carry exactly these two values.</p><p class="ask"><b>To decide:</b> Defensible to adopt without further thought for content that mirrors UTG. Worth a moment's thought for the two genuinely new CodeSystems (0411, 0460), which have never been published anywhere and are arguably <code>draft</code> until they have.</p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">&lt;code&gt;publisher&lt;/code&gt;, &lt;code&gt;contact&lt;/code&gt;</div>
  <p><b>&ldquo;Health Level Seven International&rdquo;, with <code>http://hl7.org</code> and <code>hq@HL7.org</code>.</b></p><p>Unanimous across all 855 UTG files.</p><p class="ask"><b>To decide:</b> No reason to diverge. The one thing to know is that the IG Publisher will <b>overwrite these</b> from the IG's own values unless <code>apply-publisher</code> and <code>apply-contact</code> are set false &mdash; along with <code>apply-version</code>, <code>apply-copyright</code>, <code>apply-wg</code>, <code>apply-jurisdiction</code> and <code>apply-license</code>, all of which the base template defaults to true.</p>
</div>
<div class="ri-item ri-decide">
  <div class="ri-key">ValueSet coverage</div>
  <p><b>One ValueSet wherever Chapter 2C declares a Value Set block.</b></p><p><b>This question turned out to be moot.</b> Across all 799 tables, &ldquo;declares a Value Set block&rdquo; and &ldquo;Concept Domain Only = no&rdquo; coincide exactly &mdash; 438 of each, the same set, no exceptions. The two candidate policies produce identical output.</p><p class="ask"><b>To decide:</b> Nothing to decide. Recorded so it is not reopened.</p>
</div>

#### Text changed: emphasis added &mdash; conceptDomain.Description <span class="ri-count">&mdash; 1 item</span>

<div class="ri-blurb">Difference between published and emitted text.  These were changed.</div>

<div class="ri-item ri-decide">
  <div class="ri-key">0133</div>
  <div class="cell">The domain of possible values of concepts which specify the different types of practitioners associated with this procedure.</div>
  <div class="ri-who">As emitted: <div class="cell">The domain of possible values of concepts which specify the different types of practitioners associated with this procedure. **Table 0133 was discontinued as of v2.6 and replaced by table 0443, used in the ROL segment.**</div></div>
</div>

#### Text changed: emphasis added &mdash; tableMetadata.Description <span class="ri-count">&mdash; 1 item</span>

<div class="ri-blurb">Difference between published and emitted text.  These were changed.</div>

<div class="ri-item ri-decide">
  <div class="ri-key">0133</div>
  <div class="cell">HL7-defined table of concepts which specify the different types of practitioners associated with this procedure. This set of codes is known to be incomplete. Note that as of v2.6, this table and the field(s) it was used in was replaced by table 443 used in the ROL segment.</div>
  <div class="ri-who">As emitted: <div class="cell">HL7-defined table of concepts which specify the different types of practitioners associated with this procedure. This set of codes is known to be incomplete. **This table was discontinued as of v2.6 and replaced by table 0443, used in the ROL segment.** Note that as of v2.6, this table and the field(s) it was used in was replaced by table 443 used in the ROL segment.</div></div>
</div>

### Where the rest of the detail is

- **[What this guide keeps from THO](tho-merge.html)** — the full class-by-class
  account of the merge, and what it does to version numbers.
- **[Known issues in this build](known-issues.html)** — defects in the build
  itself, as opposed to open questions about the content.
- **[Per-table ledger](table-ledger.html)** — one section per table: every
  difference from what THO publishes, and which open question touches it.
- **[Table index](table-index.html)** — per-table, which artifacts exist where.
