
One section per table: **everything this guide publishes that differs from what THO publishes**, everything it keeps from THO, and every open issue the register raises against that table.

[What this guide keeps from THO](tho-merge.html) reports the same merge by *class* — what kinds of thing happened and how often. This page is the other axis. Use that page to understand the merge; use this one to check a table.

Measured against a local snapshot of the **`hl7.terminology.r5` package, version 7.3.0**, not against a live server. 8,274 observations across 432 tables.

### How to read a section

- **Differences from THO** — listed one by one. A *disagreement* is where both sides carry a value and they differ by more than whitespace; the chapter's value is published, because publishing the chapter is what this guide is for. *Added here* is content Chapter 2C has and THO does not. *Not published* is a canonical where THO has an artifact and this guide writes nothing — THO's artifact stands untouched.
- **Also affects** says whether a difference is a one-off or an instance of a class of problem that is repeated elsewhere. A row reading *24 other tables* is a policy question, not a data-entry question, and answering it once answers it twenty-five times.
- **Kept from THO** — content THO publishes that the chapter is silent about, which the merge preserves rather than deleting. Given as counts: there are thousands and every one of them is the absence of a change.
- **Open issues** — items from the V2 Management / TSMG register that name this table.
- **Identifiers** — the OID situation, where there is one.

Values longer than a cell are truncated. Where two long values differ only near their end, both are shown from just before the point where they diverge, so the difference is always the part on display.

### About the OIDs

Chapter 2C gives each table **three** OIDs, in three separate metadata blocks, and they identify three different things:

| Chapter 2C block | Arc | Tables carrying one | Where it is published |
|---|---|---:|---|
| Table OID | `2.16.840.1.113883.12.*` <span class="tl-note">+ 50 in 1 other arc</span> | 798 | **nowhere** |
| Code System OID | `2.16.840.1.113883.18.*` <span class="tl-note">+ 34 in 7 other arcs</span> | 435 | `CodeSystem.identifier` |
| Value Set OID | `2.16.840.1.113883.21.*` <span class="tl-note">+ 20 in 4 other arcs</span> | 438 | `ValueSet.identifier` |

THO uses those same two arcs for those same two resource types, so the comparison is like for like: a code system OID is only ever checked against a code system OID.

**50 of those table OIDs are not identifiers.** They are `2.16.840.1.113883.1` — an arc root with no leaf on the end, on tables the chapter types *undefined*. The count above includes them because the chapter does; nothing should resolve them.

**The table OID has nowhere to go.** In V2 the table is the thing with an identity; in FHIR that table becomes a code system *and* a value set, and neither of them is the table. So the `.12` OID is carried by no published resource. That is the current behaviour rather than a decision anyone has taken — see [What needs an answer](open-items.html#gq-chapter-2c-gives-every-table).

**2 tables give an OID that disagrees with THO's** — [0001](#tbl-0001), [0719](#tbl-0719). THO's is published in both cases, because the canonical URL is THO's and an identifier is identity rather than content. Each is set out in that table's own section.

<a id="content-and-open-items"></a>

### Tables with a difference from THO or an open item

**93 tables differ from THO** in at least one element that survived into the published artifact, **114 carry an open register item**, and **2 are blocked on a decision** and have nothing published for them yet. Everything else either matches THO on every element compared, or is content THO has never seen.

This is about **content and governance**. Whether the right kind of artifact exists at all is a separate question, answered by [the tables whose artifact is missing, unexpected, or cannot expand](table-index.html#coverage-anomalies) on the table index — a much shorter list. A table can appear on both lists, on one, or on neither.

Each of these tables has its section heading shaded below, so the same information is available to somebody scrolling the page rather than following a link from here. Where a table qualifies on more than one count, the heading is shaded for the most serious of them and the line beneath it names them all.

<p class="tl-jump">Needs special consideration: <a href="#tbl-0821">0821</a></p>

<p class="tl-jump">Blocked on a decision: <a href="#tbl-0956">0956</a> <a href="#tbl-0963">0963</a></p>

<p class="tl-jump">Differs from THO: <a href="#tbl-0001">0001</a> <a href="#tbl-0003">0003</a> <a href="#tbl-0005">0005</a> <a href="#tbl-0012">0012</a> <a href="#tbl-0033">0033</a> <a href="#tbl-0034">0034</a> <a href="#tbl-0048">0048</a> <a href="#tbl-0070">0070</a> <a href="#tbl-0076">0076</a> <a href="#tbl-0083">0083</a> <a href="#tbl-0102">0102</a> <a href="#tbl-0104">0104</a> <a href="#tbl-0106">0106</a> <a href="#tbl-0107">0107</a> <a href="#tbl-0108">0108</a> <a href="#tbl-0109">0109</a> <a href="#tbl-0119">0119</a> <a href="#tbl-0123">0123</a> <a href="#tbl-0133">0133</a> <a href="#tbl-0136">0136</a> <a href="#tbl-0156">0156</a> <a href="#tbl-0157">0157</a> <a href="#tbl-0158">0158</a> <a href="#tbl-0174">0174</a> <a href="#tbl-0180">0180</a> <a href="#tbl-0200">0200</a> <a href="#tbl-0201">0201</a> <a href="#tbl-0202">0202</a> <a href="#tbl-0203">0203</a> <a href="#tbl-0206">0206</a> <a href="#tbl-0208">0208</a> <a href="#tbl-0211">0211</a> <a href="#tbl-0232">0232</a> <a href="#tbl-0254">0254</a> <a href="#tbl-0255">0255</a> <a href="#tbl-0278">0278</a> <a href="#tbl-0287">0287</a> <a href="#tbl-0290">0290</a> <a href="#tbl-0291">0291</a> <a href="#tbl-0294">0294</a> <a href="#tbl-0301">0301</a> <a href="#tbl-0323">0323</a> <a href="#tbl-0326">0326</a> <a href="#tbl-0338">0338</a> <a href="#tbl-0347">0347</a> <a href="#tbl-0354">0354</a> <a href="#tbl-0356">0356</a> <a href="#tbl-0357">0357</a> <a href="#tbl-0367">0367</a> <a href="#tbl-0369">0369</a> <a href="#tbl-0389">0389</a> <a href="#tbl-0396">0396</a> <a href="#tbl-0399">0399</a> <a href="#tbl-0433">0433</a> <a href="#tbl-0434">0434</a> <a href="#tbl-0440">0440</a> <a href="#tbl-0456">0456</a> <a href="#tbl-0487">0487</a> <a href="#tbl-0489">0489</a> <a href="#tbl-0496">0496</a> <a href="#tbl-0505">0505</a> <a href="#tbl-0513">0513</a> <a href="#tbl-0524">0524</a> <a href="#tbl-0529">0529</a> <a href="#tbl-0548">0548</a> <a href="#tbl-0555">0555</a> <a href="#tbl-0560">0560</a> <a href="#tbl-0567">0567</a> <a href="#tbl-0568">0568</a> <a href="#tbl-0717">0717</a> <a href="#tbl-0719">0719</a> <a href="#tbl-0725">0725</a> <a href="#tbl-0834">0834</a> <a href="#tbl-0906">0906</a> <a href="#tbl-0907">0907</a> <a href="#tbl-0909">0909</a> <a href="#tbl-0912">0912</a> <a href="#tbl-0914">0914</a> <a href="#tbl-0916">0916</a> <a href="#tbl-0929">0929</a> <a href="#tbl-0930">0930</a> <a href="#tbl-0937">0937</a> <a href="#tbl-0938">0938</a> <a href="#tbl-0945">0945</a> <a href="#tbl-0948">0948</a> <a href="#tbl-0949">0949</a> <a href="#tbl-0950">0950</a> <a href="#tbl-0951">0951</a> <a href="#tbl-0952">0952</a> <a href="#tbl-0959">0959</a> <a href="#tbl-0970">0970</a> <a href="#tbl-0971">0971</a> <a href="#tbl-4000">4000</a></p>

<p class="tl-jump">Open register item: <a href="#tbl-0001">0001</a> <a href="#tbl-0003">0003</a> <a href="#tbl-0005">0005</a> <a href="#tbl-0006">0006</a> <a href="#tbl-0010">0010</a> <a href="#tbl-0034">0034</a> <a href="#tbl-0038">0038</a> <a href="#tbl-0065">0065</a> <a href="#tbl-0066">0066</a> <a href="#tbl-0074">0074</a> <a href="#tbl-0076">0076</a> <a href="#tbl-0078">0078</a> <a href="#tbl-0093">0093</a> <a href="#tbl-0104">0104</a> <a href="#tbl-0125">0125</a> <a href="#tbl-0131">0131</a> <a href="#tbl-0133">0133</a> <a href="#tbl-0163">0163</a> <a href="#tbl-0170">0170</a> <a href="#tbl-0175">0175</a> <a href="#tbl-0180">0180</a> <a href="#tbl-0188">0188</a> <a href="#tbl-0191">0191</a> <a href="#tbl-0200">0200</a> <a href="#tbl-0203">0203</a> <a href="#tbl-0207">0207</a> <a href="#tbl-0211">0211</a> <a href="#tbl-0223">0223</a> <a href="#tbl-0227">0227</a> <a href="#tbl-0254">0254</a> <a href="#tbl-0255">0255</a> <a href="#tbl-0272">0272</a> <a href="#tbl-0277">0277</a> <a href="#tbl-0278">0278</a> <a href="#tbl-0279">0279</a> <a href="#tbl-0281">0281</a> <a href="#tbl-0291">0291</a> <a href="#tbl-0292">0292</a> <a href="#tbl-0294">0294</a> <a href="#tbl-0315">0315</a> <a href="#tbl-0326">0326</a> <a href="#tbl-0335">0335</a> <a href="#tbl-0340">0340</a> <a href="#tbl-0347">0347</a> <a href="#tbl-0350">0350</a> <a href="#tbl-0351">0351</a> <a href="#tbl-0354">0354</a> <a href="#tbl-0357">0357</a> <a href="#tbl-0359">0359</a> <a href="#tbl-0365">0365</a> <a href="#tbl-0366">0366</a> <a href="#tbl-0367">0367</a> <a href="#tbl-0389">0389</a> <a href="#tbl-0391">0391</a> <a href="#tbl-0392">0392</a> <a href="#tbl-0396">0396</a> <a href="#tbl-0399">0399</a> <a href="#tbl-0406">0406</a> <a href="#tbl-0411">0411</a> <a href="#tbl-0418">0418</a> <a href="#tbl-0440">0440</a> <a href="#tbl-0451">0451</a> <a href="#tbl-0456">0456</a> <a href="#tbl-0458">0458</a> <a href="#tbl-0459">0459</a> <a href="#tbl-0460">0460</a> <a href="#tbl-0466">0466</a> <a href="#tbl-0467">0467</a> <a href="#tbl-0468">0468</a> <a href="#tbl-0469">0469</a> <a href="#tbl-0470">0470</a> <a href="#tbl-0474">0474</a> <a href="#tbl-0487">0487</a> <a href="#tbl-0492">0492</a> <a href="#tbl-0505">0505</a> <a href="#tbl-0508">0508</a> <a href="#tbl-0510">0510</a> <a href="#tbl-0511">0511</a> <a href="#tbl-0513">0513</a> <a href="#tbl-0520">0520</a> <a href="#tbl-0523">0523</a> <a href="#tbl-0544">0544</a> <a href="#tbl-0560">0560</a> <a href="#tbl-0567">0567</a> <a href="#tbl-0568">0568</a> <a href="#tbl-0626">0626</a> <a href="#tbl-0675">0675</a> <a href="#tbl-0685">0685</a> <a href="#tbl-0719">0719</a> <a href="#tbl-0725">0725</a> <a href="#tbl-0767">0767</a> <a href="#tbl-0820">0820</a> <a href="#tbl-0821">0821</a> <a href="#tbl-0822">0822</a> <a href="#tbl-0823">0823</a> <a href="#tbl-0824">0824</a> <a href="#tbl-0827">0827</a> <a href="#tbl-0828">0828</a> <a href="#tbl-0895">0895</a> <a href="#tbl-0910">0910</a> <a href="#tbl-0916">0916</a> <a href="#tbl-0929">0929</a> <a href="#tbl-0930">0930</a> <a href="#tbl-0931">0931</a> <a href="#tbl-0932">0932</a> <a href="#tbl-0952">0952</a> <a href="#tbl-0953">0953</a> <a href="#tbl-0954">0954</a> <a href="#tbl-0956">0956</a> <a href="#tbl-0957">0957</a> <a href="#tbl-0959">0959</a> <a href="#tbl-0960">0960</a> <a href="#tbl-0962">0962</a> <a href="#tbl-0967">0967</a></p>

<p class="tl-legend">
<span class="tl-hd tl-hd-attention">Needs special consideration (1)</span>
<span class="tl-hd tl-hd-decision">Blocked on a decision (2)</span>
<span class="tl-hd tl-hd-both">Differs from THO and carries an open register item (39)</span>
<span class="tl-hd tl-hd-issue">Carries an open register item (73)</span>
<span class="tl-hd tl-hd-diff">Differs from THO (54)</span>
</p>

<style>
.tl-jump { line-height: 2; }
.tl-jump a { display: inline-block; padding: 0 0.35em; }
.tl-note { font-size: 0.85em; color: #555; }
.tl-hd { color: #14171a; padding: 0.18em 0.5em;
         border-left: 7px solid #8a8f94; border-radius: 3px; }
.tl-hd-diff      { background: #fdf2d5; border-left-color: #8a6100; }
.tl-hd-issue     { background: #ddeafa; border-left-color: #14507f; }
.tl-hd-both      { background: #e9dff7; border-left-color: #56308c; }
.tl-hd-decision  { background: #fbdcd7; border-left-color: #94241a; }
.tl-hd-attention { background: #f6bfb6; border-left-width: 14px;
                   border-left-color: #6e0d02; }
.tl-why { margin: 0.25em 0 0.9em; font-size: 0.85em;
          letter-spacing: 0.04em; text-transform: uppercase;
          color: #41474d; }
.tl-legend span { display: inline-block; font-size: 0.85em;
                  margin: 0 0.5em 0.4em 0; }
blockquote.tl-callout { border-left: 7px solid #94241a;
                        background: #fef6f4; color: #14171a;
                        padding: 0.8em 1.1em; margin: 0 0 1.1em; }
</style>

### Every table with something to report

**454 of the chapter's 798 tables.** The other 344 are listed at the foot of the page, and 18 canonicals that are not Chapter 2C tables at all have their own section after these.

<a id="tbl-0001"></a>

#### 0001 — Administrative Sex
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item · OID conflict with THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 1 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `identifier` | — | 2.16.840.1.113883.18.458 | 2.16.840.1.113883.18.2 | 1 other table |

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `X` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (13).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |
| Resource descriptions kept from THO | 1 |

**Open issues.**

- `esc-full-name-copy-paste` — The copy-pasted Full Name is not confined to the UCUM tables — *V2 Management* <span class="tl-note">(the register lists this table as an example; its list is not exhaustive)</span>
- `esc-oid-conflicts` — Three artifacts where one OID would end up naming two things, which versioning cannot reconcile — *V2 Management + TSMG*

**Identifiers.**

- **The chapter and THO give different OIDs for this CodeSystem.** The chapter says `2.16.840.1.113883.18.458`; THO says `2.16.840.1.113883.18.2`, and THO's is what this guide publishes, because the canonical is THO's and an identifier is identity rather than content. Registered as `esc-oid-conflicts`.
- Chapter 2C also gives the table itself the OID `2.16.840.1.113883.12.1`, which this guide publishes nowhere.

<a id="tbl-0002"></a>

#### 0002 — Marital Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (30).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 16 |
| Translations kept from THO | 14 |

<a id="tbl-0003"></a>

#### 0003 — Event
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept, purpose.
- Value set **4.0.0** — Changed: name, title.

**Differences from THO (19).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 29 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `O59` | An example is the IHE LCC profile which describes this message in the LAB-7 transaction | An example is the IHE LCC profile describes this message in the LAB-7 transaction | 22 other tables |
| Disagreement | `concept.property` (status) | `Q04` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `Q07` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `Q08` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `Q09` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `R03` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `R05` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `R06` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `R07` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `R08` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `R09` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `RAR` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `RDR` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `RER` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `RGR` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `X01` | deprecated | active | 25 other tables |
| Disagreement | `name` | — | Hl7VSEvent | Hl7VSEventCode | only here |
| Disagreement | `purpose` | — | Underlying Master Code System for V2 table 0003 (Event) | Underlying Master Code System for V2 table 0003 (Event Type) | 2 other tables |
| Disagreement | `title` | — | hl7VS-event | hl7VS-eventCode | 1 other table |

**Written differently, saying the same thing (29).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `K31` | RSP - Dispense History Response | RSP -Dispense History Response | Same text; only spacing differs. |
| `concept.display` | `O57` | OMQ - General Order Message with Document Payload | OMQ- General Order Message with Document Payload | Same text; only spacing differs. |
| `concept.display` | `P10` | BAR/ACK - Transmit Ambulatory Payment Classification(APC) | BAR/ACK -Transmit Ambulatory Payment Classification(APC) | Same text; only spacing differs. |
| `concept.display` | `S50` | Specimen Procedure Step Successful, with Derived Specimen(s) | Specimen Procedure Step Successful , with Derived Specimen(s) | Same text; only spacing differs. |
| `concept.property` (status) | `O51` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O52` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O53` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O54` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O55` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O56` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O58` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `O59` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `R42` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `R43` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S38` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S39` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S40` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S41` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S42` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S43` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S44` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S45` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S46` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S47` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S48` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S49` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S50` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S51` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `S52` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (620).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 367 |
| Translations kept from THO | 186 |
| Comments-as-published kept from THO | 50 |
| Deprecation markers kept from THO | 16 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-status-n-b-undefined` — The concept statuses `N` and `B` are defined nowhere; `N` is now mapped, `B` is not — *V2 Management + TSMG*

<a id="tbl-0004"></a>

#### 0004 — Patient Class

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (17).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Translations kept from THO | 8 |

<a id="tbl-0005"></a>

#### 0005 — Race
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: concept domain only.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">Declared concept domain only. A binding to a domain needs no value set.</span> | http://terminology.hl7.org/CodeSystem/v2-0005 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">Declared concept domain only. A binding to a domain needs no value set.</span> | http://terminology.hl7.org/ValueSet/v2-0005 | 23 other tables |

**Open issues.**

- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

**Answered by a committee.**

- `esc-0567-0568-representation` — Deprecating a V2 value set in THO has no established representation, and would be a first — *V2 Management, 2026-09-23*<br/><span class="tl-note">Both halves are settled, and neither lands on this IG. The 0567/0568 retirement goes to THO as a separate Jira ticket, so no deprecation needs representing here. For table 0005, the value set stays and the code system is correctly retired already; this IG will not link the value set and should not inform any change to it.</span>

<a id="tbl-0006"></a>

#### 0006 — Religion
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (107).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 85 |
| Translations kept from THO | 12 |
| Codes kept from THO that the chapter does not list | 10 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0007"></a>

#### 0007 — Admission Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0008"></a>

#### 0008 — Acknowledgment code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |

<a id="tbl-0009"></a>

#### 0009 — Ambulatory Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (32).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 16 |
| Translations kept from THO | 16 |

<a id="tbl-0010"></a>

#### 0010 — Physician ID
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: nothing written.*

**Answered by a committee.**

- `esc-0010-withdrawn` — Table 0010 _Physician ID_ carries no terminology and is withdrawn — *V2 Management, 2026-10-09*<br/><span class="tl-note">Table 10 goes away, and any terminology bindings to table 10 will be removed as v2+ is prepared.</span>

<a id="tbl-0017"></a>

#### 0017 — Transaction Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0027"></a>

#### 0027 — Priority

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0038"></a>

#### 0038 — Order status
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (18).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Translations kept from THO | 9 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0052"></a>

#### 0052 — Diagnosis Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 2 |

<a id="tbl-0061"></a>

#### 0061 — Check Digit Scheme

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (9).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0062"></a>

#### 0062 — Event Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0063"></a>

#### 0063 — Relationship

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (63).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 32 |
| Translations kept from THO | 31 |

<a id="tbl-0065"></a>

#### 0065 — Specimen Action Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (15).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0066"></a>

#### 0066 — Employment Status
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (23).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Translations kept from THO | 9 |
| Codes kept from THO that the chapter does not list | 4 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*
- `esc-tho-definition-differences` — Five concept domain definitions differ between Chapter 2C and THO — *V2 Management + TSMG*

<a id="tbl-0069"></a>

#### 0069 — Hospital Service

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0074"></a>

#### 0074 — Diagnostic Service Section ID
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (84).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 41 |
| Translations kept from THO | 39 |
| Codes kept from THO that the chapter does not list | 4 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0076"></a>

#### 0076 — Message Type
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `SET` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `VXX` | 4 - Deprecated | 4 -Deprecated | Same text; only spacing differs. |

**Kept from THO (340).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Comments-as-published kept from THO | 146 |
| Concept definitions kept from THO | 145 |
| Translations kept from THO | 37 |
| Codes kept from THO that the chapter does not list | 12 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0078"></a>

#### 0078 — Interpretation Codes
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-0078-alias-of-v3` — Table 0078 _Interpretation Codes_ duplicates an existing THO value set under a new URL — *V2 Management, 2026-10-14*<br/><span class="tl-note">The value set already exists, just at a different URL: `ValueSet-v3-ObservationInterpretation`. That value set is allowed to serve and no new one is created. The situation is noted in the ledger. This keeps fidelity to Chapter 2C in as much as the guide is simply not adding something, rather than doing something different.</span>

<a id="tbl-0080"></a>

#### 0080 — Nature of Abnormal Testing

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0083"></a>

#### 0083 — Outlier Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: description.
- Value set **4.0.0** — Changed: description.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `description` | — | HL7-defined code system of concepts specifying the type of outlier (i.e., period of care beyond DRG-standard stay in facility) that has been paid. Us… | HL7-defined code system of concepts specifying the type of outlier (i.e. period of care beyond DRG-standard stay in facility) that has been paid. Use… | Same words in the same order; only punctuation differs. |
| `description` | — | Value Set of codes that specify the type of outlier (i.e., period of care beyond DRG-standard stay in facility) that has been paid. | Value Set of codes that specify the type of outlier (i.e. period of care beyond DRG-standard stay in facility) that has been paid. | Same words in the same order; only punctuation differs. |

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0085"></a>

#### 0085 — Observation Result Status Codes Interpretation

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (28).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 15 |
| Translations kept from THO | 12 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0091"></a>

#### 0091 — Query Priority

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0092"></a>

#### 0092 — Re-Admission Indicator

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |
| Translations kept from THO | 1 |

<a id="tbl-0093"></a>

#### 0093 — Release Information
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-0460-user-defined-mint` — What should a user-defined table produce? Three of them were treated three different ways — *V2 Management*
- `esc-domain-example-codes` — Where should a concept domain’s example codes live? — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0098"></a>

#### 0098 — Type of Agreement

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0100"></a>

#### 0100 — Invocation event

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0103"></a>

#### 0103 — Processing ID

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Translations kept from THO | 4 |

<a id="tbl-0104"></a>

#### 0104 — Version ID
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (3).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 1 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.display` | `2.9` | Release 2.9 | Draft 2.9 | 14 other tables |
| Disagreement | `concept.property` (v2-concComment) | `2.9` | Sep. 2019 | Sep. 2017 | 22 other tables |
| Added here | `concept` | `2.9.1` | Draft 2.9.1 | nothing | 2 other tables |

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `2.9` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (37).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 16 |
| Comments-as-published kept from THO | 16 |
| Translations kept from THO | 4 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0105"></a>

#### 0105 — Source of Comment

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 3 |

<a id="tbl-0116"></a>

#### 0116 — Bed Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |

<a id="tbl-0119"></a>

#### 0119 — Order Control Codes
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (14).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 6 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `CH` | Placer or Filler Applications. Usage Note: Used in conjunction with the PA - Parent order control code. Refer to PA order control code for discussion. | Placer or Filler Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `CR` | Filler or Placer Applications. Usage Note: A response by the filler or placer application that a request to cancel (CA by the placer application) was… | Filler or Placer Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `DR` | Filler or Placer Applications. Usage Note: The filler or placer, in response to a request to discontinue (DC from the placer or filler application),… | Filler or Placer Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `FU` | Filler Applications. Usage Note: FU notifies the placer that the filler issued a refill for the order at the patient's request. | Filler Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `HD` | Placer Applications. Usage Note: Typical responses include, but are not limited to, CR - Cancelled as requested, UC - Unable to Cancel. | Placer Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `LI` | Placer or Filler Applications. Usage Note: Refer to Chapter 12 Patient Care for complete discussion. | Placer or Filler Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `MC` | applies to DFT^P03^DFT_P03 and DFT^P11^DFT_P11 Usage Note: applies to DFT^P03^DFT_P03 and DFT^P11^DFT_P11 | applies to DFT^P03^DFT_P03 and DFT^P11^DFT_P11 | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `NW` | Placer Applications. Usage Note: See comments for NA - Number Assigned. | Placer Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `OF` | Filler Applications. Usage Note: OF directly responds to the placer system's request for a refill. | Filler Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `OK` | Filler Applications. Usage Note: See comments for NA - Number Assigned. | Filler Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `PY` | Placer Applications. Usage Note: See comments for OP - Notification of order for outside dispense. | Placer Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `SN` | Placer Applications. Usage Note: See comments for NA - Number Assigned. | Placer Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `UF` | Filler Applications. Usage Note: Negative response to RF Refill order/service request, indicating that the receiving application was not able to comp… | Filler Applications. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `UN` | Placer or Filler Applications. Usage Note: Refer to Chapter 12 Patient Care for complete discussion. | Placer or Filler Applications. | 22 other tables |

**Written differently, saying the same thing (6).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (v2-concComment) | `AF` | Placer Applications. | Placer Applications . | Same text; only spacing differs. |
| `concept.property` (status) | `RA` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `RC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `RD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SQ` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SU` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (155).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Comments-as-published kept from THO | 52 |
| Concept definitions kept from THO | 51 |
| Translations kept from THO | 38 |
| Usage notes kept from THO | 14 |

<a id="tbl-0121"></a>

#### 0121 — Response Flag

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Translations kept from THO | 5 |
| Concept definitions kept from THO | 2 |

<a id="tbl-0122"></a>

#### 0122 — Charge Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (16).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 8 |

<a id="tbl-0123"></a>

#### 0123 — Result Status
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (3).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept.property` (v2-concComment) | `N` | Usage Note: Transitions/Relationships: OBR-25 Valid preceding state (... to N): O, I, S. Succeeding state (N to ...): P, A, R, F, X OBX-11 No OBX seg… | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `Y` | Usage Note: Used only on queries | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `Z` | Usage Note: Used only on queries | nothing | 8 other tables |

**Kept from THO (19).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Translations kept from THO | 11 |
| Concept definitions kept from THO | 5 |
| Usage notes kept from THO | 3 |

<a id="tbl-0124"></a>

#### 0124 — Transportation Mode

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0125"></a>

#### 0125 — Value Type
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Open issues.**

- `esc-full-name-copy-paste` — The copy-pasted Full Name is not confined to the UCUM tables — *V2 Management* <span class="tl-note">(the register lists this table as an example; its list is not exhaustive)</span>
- `esc-status-n-b-undefined` — The concept statuses `N` and `B` are defined nowhere; `N` is now mapped, `B` is not — *V2 Management + TSMG*

<a id="tbl-0126"></a>

#### 0126 — Quantity Limited Request

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0127"></a>

#### 0127 — Allergen Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (16).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 8 |

<a id="tbl-0128"></a>

#### 0128 — Allergy Severity

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0130"></a>

#### 0130 — Visit User Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0131"></a>

#### 0131 — Contact Role
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (20).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 8 |
| Codes kept from THO that the chapter does not list | 4 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0133"></a>

#### 0133 — Procedure practitioner identifier code type
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: concept domain only.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">Declared concept domain only. A binding to a domain needs no value set.</span> | http://terminology.hl7.org/CodeSystem/v2-0133 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">Declared concept domain only. A binding to a domain needs no value set.</span> | http://terminology.hl7.org/ValueSet/v2-0133 | 23 other tables |

**Answered by a committee.**

- `esc-0133-contradictory` — Table 0133 says three incompatible things about itself, and THO publishes nine codes for it — *V2 Management, 2026-10-14*<br/><span class="tl-note">Manipulate the markdown description so it jumps out that this is a discontinued code system as of v2.6 that was replaced.</span>

<a id="tbl-0135"></a>

#### 0135 — Assignment of Benefits

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 3 |

<a id="tbl-0136"></a>

#### 0136 — Yes/no Indicator
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: value set only.*

- Value set **4.0.0** — Changed: compose.include.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `N` | No | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `Y` | Yes | — | 6 other tables |

<a id="tbl-0137"></a>

#### 0137 — Mail Claim Party

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0140"></a>

#### 0140 — Military Service

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |

<a id="tbl-0142"></a>

#### 0142 — Military Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0144"></a>

#### 0144 — Eligibility Source

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0145"></a>

#### 0145 — Room Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |

<a id="tbl-0146"></a>

#### 0146 — Amount Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0147"></a>

#### 0147 — Policy Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0148"></a>

#### 0148 — Money or Percentage Indicator

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0149"></a>

#### 0149 — Day Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 1 |

<a id="tbl-0150"></a>

#### 0150 — Certification Patient Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 1 |

<a id="tbl-0155"></a>

#### 0155 — Accept/Application Acknowledgment Conditions

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0159"></a>

#### 0159 — Diet Code Specification Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 3 |

<a id="tbl-0160"></a>

#### 0160 — Tray Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

<a id="tbl-0161"></a>

#### 0161 — Allow Substitution

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 3 |

<a id="tbl-0162"></a>

#### 0162 — Route of Administration

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (87).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 43 |
| Translations kept from THO | 40 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0163"></a>

#### 0163 — Body Site
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (110).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 54 |
| Translations kept from THO | 54 |
| Codes kept from THO that the chapter does not list | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0164"></a>

#### 0164 — Administration Device

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (17).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Translations kept from THO | 8 |

<a id="tbl-0165"></a>

#### 0165 — Administration Method

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (30).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 15 |
| Translations kept from THO | 15 |

<a id="tbl-0166"></a>

#### 0166 — RX Component Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0167"></a>

#### 0167 — Substitution Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |
| Translations kept from THO | 3 |

<a id="tbl-0168"></a>

#### 0168 — Processing Priority

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0169"></a>

#### 0169 — Reporting Priority

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0170"></a>

#### 0170 — Derived Specimen
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 3 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0173"></a>

#### 0173 — Coordination of Benefits

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0174"></a>

#### 0174 — Nature of Service/Test/Observation
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (5).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.display` | `S` | …C, UA, electrolytes) This set indicates that the code being described is used to order multiple service/test/observation b | …C, UA, electrolytes)<p>This set indicates that the code being described is used to order multiple service/test/observation b | 14 other tables |
| Disagreement | `concept.property` (v2-concComment) | `A` | can be associated with one or more OM4 (specimen) segments a single direct observation and would usually be associated with an OM2 and/or OM3 segments | can be associated with one or more OM4 (specimen) segments<p>a single direct observation and would usually be associated with an OM2 and/or OM3 segme… | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `C` | can be associated with one or more OM4 (specimen) segments a derived quantity and would usually be associated with an OM6 segment | can be associated with one or more OM4 (specimen) segments<p>a derived quantity and would usually be associated with an OM6 segment | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `F` | can be associated with one or more OM4 (specimen) segments See comment for value S | can be associated with one or more OM4 (specimen) segments<p>See comment for value S | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `P` | can be associated with one or more OM4 (specimen) segments See comment for value S | can be associated with one or more OM4 (specimen) segments<p>See comment for value S | 22 other tables |

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Translations kept from THO | 5 |
| Comments-as-published kept from THO | 5 |
| Concept definitions kept from THO | 4 |

<a id="tbl-0175"></a>

#### 0175 — Master File Identifier Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (32).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 16 |
| Codes kept from THO that the chapter does not list | 10 |
| Translations kept from THO | 4 |
| Comments-as-published kept from THO | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0177"></a>

#### 0177 — Confidentiality Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (20).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Translations kept from THO | 10 |

<a id="tbl-0178"></a>

#### 0178 — File Level Event Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0179"></a>

#### 0179 — Response Level

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0180"></a>

#### 0180 — Masterfile Action Code
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: purpose.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `purpose` | — | Underlying Master Code System for V2 table 0180 (Masterfile Action Code) | Underlying Master Code System for V2 table 0180 (Record-level Event Code) | 2 other tables |

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 5 |

**Open issues.**

- `esc-full-name-copy-paste` — The copy-pasted Full Name is not confined to the UCUM tables — *V2 Management* <span class="tl-note">(the register lists this table as an example; its list is not exhaustive)</span>

<a id="tbl-0181"></a>

#### 0181 — MFN Record-level Error Return

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0183"></a>

#### 0183 — Active/Inactive

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0185"></a>

#### 0185 — Preferred Method of Contact

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |

<a id="tbl-0187"></a>

#### 0187 — Provider Billing

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0188"></a>

#### 0188 — Operator ID
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: nothing written.*

**Answered by a committee.**

- `esc-0188-withdrawn` — Table 0188 _Operator ID_ carries no terminology and is withdrawn — *V2 Management, 2026-10-14*<br/><span class="tl-note">Same situation as table 0010: the table goes away, and terminology bindings to it are removed as v2+ is prepared.</span>

<a id="tbl-0189"></a>

#### 0189 — Ethnic Group

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0190"></a>

#### 0190 — Address Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (48).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 18 |
| Translations kept from THO | 15 |
| Comments-as-published kept from THO | 15 |

<a id="tbl-0191"></a>

#### 0191 — Type of Referenced Data
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (22).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Translations kept from THO | 9 |
| Codes kept from THO that the chapter does not list | 3 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0193"></a>

#### 0193 — Amount Class

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0200"></a>

#### 0200 — Name Type
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (4).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 4 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `B` | … have changed later. This is not for temporary names assigned at birth while a newborn is not yet named | … have changed later.<p>This is not for temporary names assigned at birth while a newborn is not yet named | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `L` | …espond to legal name For many people, customary name is also their official name | …espond to legal name<p>For many people, customary name is also their official name | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `NAV` | Information is not available at this time but it is expected that it will be available later. Includes John or Jane Doe situations | Information is not available at this time but it is expected that it will be available later.<p>Includes John or Jane Doe situations | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `R` | (animals only) Retained for backwards compatibility only as of v2.7. Use "L" instead - has same meaning | (animals only)<p>Retained for backwards compatibility only as of v2.7. Use "L" instead - has same meaning | 22 other tables |

**Written differently, saying the same thing (4).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (v2-concComment) | `K` | …e proper names (i.e., married) uses one of the particular names in a professional | …e proper names (i.e. married) uses one of the particular names in a professional | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NB` | A name assigned on a temporary basis at birth. i.e., "Baby of Smith" | A name assigned on a temporary basis at birth. i.e. "Baby of Smith" | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `REL` | e.g., Sister Mary Francis, Brother John | e.g. Sister Mary Francis, Brother John | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `T` | Indigenous/Tribal/Community Name e.g., Chief Red Cloud | Indigenous/Tribal/Community Name e.g. Chief Red Cloud | Same words in the same order; only punctuation differs. |

**Kept from THO (66).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 22 |
| Translations kept from THO | 21 |
| Comments-as-published kept from THO | 21 |
| Codes kept from THO that the chapter does not list | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0201"></a>

#### 0201 — Telecommunication Use Code
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **6.0.0** — Changed: concept.
- Value set **4.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property:status` | `DSM` | active<br/><span class="tl-note">The published letter is not a value of the FHIR concept status property.</span> | N | 25 other tables |

**Kept from THO (21).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Translations kept from THO | 8 |
| Comments-as-published kept from THO | 3 |
| Codes kept from THO that the chapter does not list | 1 |

<a id="tbl-0202"></a>

#### 0202 — Telecommunication Equipment Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept` | `DSM` | Direct Secure Messaging | nothing | 2 other tables |

**Kept from THO (18).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Translations kept from THO | 8 |

<a id="tbl-0203"></a>

#### 0203 — Identifier Type
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **6.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (14).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 30 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `ANC` | Class: Financial Sometimes two distinct account numbers must be transmitted in the same message, one as the creditor, the other as the debitor. Kredi… | Class: Financial<p>Sometimes two distinct account numbers must be transmitted in the same message, one as the creditor, the other as the debitor.<p>K… | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `AND` | Class: Financial Sometimes two distinct account numbers must be transmitted in the same message, one as the creditor, the other as the debitor. Debit… | Class: Financial<p>Sometimes two distinct account numbers must be transmitted in the same message, one as the creditor, the other as the debitor.<p>D… | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `BC` | Class: Financial Replaces AM, DI, DS, MS, and VS beginning in v 2.5. | Class: Financial<p>Replaces AM, DI, DS, MS, and VS beginning in v 2.5. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `CC` | Class: Financial Use Case: needed especially for transmitting information about invoices. | Class: Financial<p>Use Case: needed especially for transmitting information about invoices. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `GKV` | Class: Insurance | GKV is a patient ID with a public insurance company. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `JHN` | Class: Insurance 2 uses: a) UK jurisdictional CHI number; b) Canadian provincial health card number: | Class: Insurance<p>2 uses: a) UK jurisdictional CHI number; b) Canadian provincial health card number: | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `KZVA` | Class: Insurance | KZVA is an ID for the practice of a dentist. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `NII` | … card number itself. Krankenkassen-ID der KV-Karte | … card number itself.<p>Krankenkassen-ID der KV-Karte | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `NIIP` | …ressed as the payor. Krankenkassen-ID des Rechnungsempfängers Use case: a subdivision issues the card with their identifier, but the main division is… | …ressed as the payor.<p>Krankenkassen-ID des Rechnungsempfängers<p>Use case: a subdivision issues the card with their identifier, but the main divisio… | 22 other tables |
| Disagreement | `concept.property` (status) | `NNxxx` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (v2-concComment) | `PKV` | Class: Insurance | PKV is a patient ID with an private insurance company. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `PPIN` | Class: Insurance Usage Note: Class: Insurance | Class: Insurance | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `XV` | Also referred to as HPID (Health Plan Identifier). Usage Note: The code value ‘XV’ is used in CMS mandated Health Insurance Portability and Accountab… | Also referred to as HPID (Health Plan Identifier). | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `ZANR` | Class: Insurance | ZANR is a dentist ID. | 22 other tables |

**Written differently, saying the same thing (30).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `GKV` | Insured's ID with Public Insurance | Insured's ID with Public Insurance | Same words; only capitalisation differs. THO's capitalisation is the better of the two, so this guide publishes it; the chapter has “insured's ID with public insurance”. |
| `concept.display` | `KZVA` | Dentist Office Number | Dentist Office Number | Same words; only capitalisation differs. THO's capitalisation is the better of the two, so this guide publishes it; the chapter has “dentist office number”. |
| `concept.display` | `PKV` | Insured's ID with Private Insurance | Insured's ID with Private Insurance | Same words; only capitalisation differs. THO's capitalisation is the better of the two, so this guide publishes it; the chapter has “insured's ID with private insurance”. |
| `concept.display` | `ZANR` | Dentist Identifier | Dentist Identifier | Same words; only capitalisation differs. THO's capitalisation is the better of the two, so this guide publishes it; the chapter has “dentist identifier”. |
| `concept.property` (status) | `AC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `AIN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `BCFN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CAAI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `DSG` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `FDR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `FDRFN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `FGN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GIN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GKV` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `KZVA` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OBI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PGN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PHC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PHE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PHO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PIN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PKV` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `RI` | … include human (e.g., a respiratory therapist), non-human (e.g., a companion animal), inanimate object (e.g., an exam room), organization (e.g., diab… | … include human (e.g. a respiratory therapist), non-human (e.g., a companion animal), inanimate object (e.g., an exam room), organization (e.g., diabe… | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `SAMN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SNBSN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SRX` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `STN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TRL` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `XV` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ZANR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (176).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Comments-as-published kept from THO | 81 |
| Concept definitions kept from THO | 57 |
| Translations kept from THO | 29 |
| Codes kept from THO that the chapter does not list | 7 |
| Usage notes kept from THO | 2 |

**Open issues.**

- `esc-full-name-copy-paste` — The copy-pasted Full Name is not confined to the UCUM tables — *V2 Management* <span class="tl-note">(the register lists this table as an example; its list is not exhaustive)</span>

<a id="tbl-0204"></a>

#### 0204 — Organizational Name Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0205"></a>

#### 0205 — Price Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0206"></a>

#### 0206 — Segment Action Code
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.definition` | `S` | Declares when segment falls under snapshot mode handling, i.e., all elements that were previously sent will be sent, not just any changes | Declares when segment falls under snapshot mode handling, i.e. all elements that were previously sent will be sent, not just any changes | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `S` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 3 |

<a id="tbl-0207"></a>

#### 0207 — Processing Mode
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0208"></a>

#### 0208 — Query Response Status
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `PD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TM` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0209"></a>

#### 0209 — Relational Operator

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0210"></a>

#### 0210 — Relational Conjunction

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |

<a id="tbl-0211"></a>

#### 0211 — Alternate Character Sets
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `UNICODE` | …code encoding codes. Usage Note: Available from The Unicode Consortium, P.O. Box 700519, San Jose, CA 95170-0519. See http://www.unicode.org/unicode/… | …code encoding codes. | 22 other tables |

**Kept from THO (36).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 21 |
| Comments-as-published kept from THO | 10 |
| Codes kept from THO that the chapter does not list | 4 |
| Usage notes kept from THO | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0213"></a>

#### 0213 — Purge Status Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0214"></a>

#### 0214 — Special Program Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0215"></a>

#### 0215 — Publicity Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0216"></a>

#### 0216 — Patient Status Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0217"></a>

#### 0217 — Visit Priority Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0220"></a>

#### 0220 — Living Arrangement

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0223"></a>

#### 0223 — Living Dependency
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Codes kept from THO that the chapter does not list | 3 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0224"></a>

#### 0224 — Transport Arranged

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0225"></a>

#### 0225 — Escort Required

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0227"></a>

#### 0227 — Manufacturers of Vaccines (code=MVX)
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **4.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Resource descriptions kept from THO | 1 |

**Open issues.**

- `esc-tho-descriptions-say-more` — Two THO descriptions carry text the chapter's do not, including THO documenting its own error — *V2 Management + TSMG*
- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0228"></a>

#### 0228 — Diagnosis Classification

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (16).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 8 |

<a id="tbl-0230"></a>

#### 0230 — Procedure Functional Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0231"></a>

#### 0231 — Student Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0232"></a>

#### 0232 — Insurance Company Contact Reason
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: purpose.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `purpose` | — | Underlying Master Code System for V2 table 0232 (Insurance Company Contact Reason) | Underlying Master Code System for V2 table 0232 (- Insurance Company Contact Reason) | Same words in the same order; only punctuation differs. |

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0234"></a>

#### 0234 — Report Timing

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |

<a id="tbl-0235"></a>

#### 0235 — Report Source

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |

<a id="tbl-0236"></a>

#### 0236 — Event Reported To

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0237"></a>

#### 0237 — Event Qualification

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0238"></a>

#### 0238 — Event Seriousness

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 2 |

<a id="tbl-0239"></a>

#### 0239 — Event Expected

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 2 |

<a id="tbl-0240"></a>

#### 0240 — Event Consequence

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (9).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |

<a id="tbl-0241"></a>

#### 0241 — Patient Outcome

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0242"></a>

#### 0242 — Primary Observer's Qualification

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0243"></a>

#### 0243 — Identity May Be Divulged

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 2 |

<a id="tbl-0247"></a>

#### 0247 — Status of Evaluation

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 12 |

<a id="tbl-0248"></a>

#### 0248 — Product Source

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0250"></a>

#### 0250 — Relatedness Assessment

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0251"></a>

#### 0251 — Action Taken in Response to the Event

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0252"></a>

#### 0252 — Causality Observations

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |

<a id="tbl-0253"></a>

#### 0253 — Indirect Exposure Mechanism

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0254"></a>

#### 0254 — Kind of Quantity
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (70).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 1 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept.property` (v2-concComment) | `ACT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ARB` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `CACT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `CCNT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `CFR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `CNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `CNST` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `COEF` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `CRAT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `DIFF` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ENT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ENTCAT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ENTNUM` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ENTSUB` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ENTVOL` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `KINV` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `LINC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `LIQ` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MASS` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MCRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MFR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MINC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MRAT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `MRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `NCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `NCNT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `NFR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `NRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `NUM` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OSMOL` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `PRES` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RANGE` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RATIO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RCRLTM` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RDEN` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `REL` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RLMCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RLSCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `RLTM` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SATFR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SCNCIN` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SCNT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SCNTR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SCRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SFR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SRAT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SUB` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SUSC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TEMP` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TEMPDF` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TEMPIN` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `THRMCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `THRSCNC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TIME` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TITR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TMDF` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TMSTP` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TYPE` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VCNT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VEL` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VELRT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VFR` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VISC` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VOL` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VRAT` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VRTO` | Usage Note: Adopted from the IUPAC Silver Book 1995” to the code | nothing | 8 other tables |

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `TIME` | Time (e.g., seconds) | Time (e.g. seconds) | Same words in the same order; only punctuation differs. |

**Kept from THO (172).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 102 |
| Usage notes kept from THO | 70 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0255"></a>

#### 0255 — Duration Categories
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `*` | Used for blood products. Usage Note: Deprecated March 2016; use code LU instead. | Used for blood products. | 22 other tables |
| Added here | `concept.property` (v2-concComment) | `LU` | Usage Note: In a master file update for blood products, no specific duration value can be specified (see OM1-43 “Point Versus Interval” field definit… | nothing | 8 other tables |

**Kept from THO (27).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 25 |
| Usage notes kept from THO | 2 |

**Open issues.**

- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0256"></a>

#### 0256 — Time Delay Post Challenge

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (44).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 44 |

<a id="tbl-0257"></a>

#### 0257 — Nature of Challenge

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0258"></a>

#### 0258 — Relationship Modifier

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0260"></a>

#### 0260 — Patient Location Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0261"></a>

#### 0261 — Location Equipment

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0262"></a>

#### 0262 — Privacy Level

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0263"></a>

#### 0263 — Level of Care

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0265"></a>

#### 0265 — Specialty Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (26).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 26 |

<a id="tbl-0267"></a>

#### 0267 — Days of the Week

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0268"></a>

#### 0268 — Override

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0269"></a>

#### 0269 — Charge On Indicator

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0270"></a>

#### 0270 — Document Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 14 |

<a id="tbl-0271"></a>

#### 0271 — Document Completion Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0272"></a>

#### 0272 — Document Confidentiality Status
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (9).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Codes kept from THO that the chapter does not list | 6 |
| Concept definitions kept from THO | 3 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0273"></a>

#### 0273 — Document Availability Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0275"></a>

#### 0275 — Document Storage Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0276"></a>

#### 0276 — Appointment reason codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0277"></a>

#### 0277 — Appointment Type Codes
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Codes kept from THO that the chapter does not list | 3 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0278"></a>

#### 0278 — Filler status codes
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (12).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.display` | `Blocked` | The indicated time slot(s) is(are) blocked | Blocked | 14 other tables |
| Disagreement | `concept.display` | `Booked` | The indicated appointment is booked | Booked | 14 other tables |
| Disagreement | `concept.display` | `Cancelled` | The indicated appointment was stopped from occurring (canceled prior to starting) | Cancelled | 14 other tables |
| Disagreement | `concept.display` | `Complete` | The indicated appointment has completed normally (was not discontinued, canceled, or deleted) | Complete | 14 other tables |
| Disagreement | `concept.display` | `DC` | The indicated appointment was discontinued (DC’ed while in progress, discontinued parent appointment, or discontinued child appointment) | Discontinued | 14 other tables |
| Disagreement | `concept.display` | `Deleted` | The indicated appointment was deleted from the filler application | Deleted | 14 other tables |
| Disagreement | `concept.display` | `Discontinued` | The indicated appointment was discontinued (DC’ed while in progress, discontinued parent appointment, or discontinued child appointment) | Discontinued | 14 other tables |
| Disagreement | `concept.display` | `Noshow` | The patient did not show up for the appointment | Noshow | 14 other tables |
| Disagreement | `concept.display` | `Overbook` | The appointment has been confirmed; however it is confirmed in an overbooked state | Overbook | 14 other tables |
| Disagreement | `concept.display` | `Pending` | Appointment has not yet been confirmed | Pending | 14 other tables |
| Disagreement | `concept.display` | `Started` | The indicated appointment has begun and is currently in progress | Started | 14 other tables |
| Disagreement | `concept.display` | `Waitlist` | Appointment has been placed on a waiting list for a particular slot, or set of slots | Waitlist | 14 other tables |

**Kept from THO (21).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 12 |
| Codes kept from THO that the chapter does not list | 9 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0279"></a>

#### 0279 — Allow Substitution Codes
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Codes kept from THO that the chapter does not list | 4 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0280"></a>

#### 0280 — Referral Priority

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0281"></a>

#### 0281 — Referral Type
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Codes kept from THO that the chapter does not list | 6 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0282"></a>

#### 0282 — Referral Disposition

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0283"></a>

#### 0283 — Referral Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0284"></a>

#### 0284 — Referral Category

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0286"></a>

#### 0286 — Provider Role

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0287"></a>

#### 0287 — Problem/Goal Action Code
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.definition` | `SP` | Declares when segment falls under snapshot mode handling, i.e., all elements that were previously sent will be sent, not just any changes | Declares when segment falls under snapshot mode handling, i.e. all elements that were previously sent will be sent, not just any changes | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `SP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |

<a id="tbl-0291"></a>

#### 0291 — Subtype of Referenced Data
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **4.0.0** — Changed: compose.include.

**Differences from THO (15).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `BASIC` | ISDN PCM audio data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `DICOM` | Digital Imaging and Communications in Medicine | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `FAX` | Facsimile data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `GIF` | Graphics Interchange Format | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `HTML` | Hypertext Markup Language | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `JOT` | Electronic ink data (Jot 1.0 standard) | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `JPEG` | Joint Photographic Experts Group | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `Octet-stream` | Uninterpreted binary data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `PICT` | PICT format image data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `PostScript` | PostScript program | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `RTF` | Rich Text Format | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `SGML` | Standard Generalized Markup Language (HL7 V2.3.1 and later) | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `TIFF` | TIFF image data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `XML` | Extensible Markup Language (HL7 V2.3.1 and later) | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `x-hl7-cda-level-one` | HL7 Clinical Document Architecture Level One document | — | 6 other tables |

**Kept from THO (19).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 15 |
| Codes kept from THO that the chapter does not list | 2 |
| Comments-as-published kept from THO | 1 |
| Value set members kept from THO | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0292"></a>

#### 0292 — Vaccines Administered
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Resource descriptions kept from THO | 1 |
| Resource names kept from THO | 1 |
| Resource titles kept from THO | 1 |
| Identifiers kept from THO | 1 |

**Open issues.**

- `esc-0292-cdo-contradiction` — Table 0292 _Vaccines Administered_ is flagged concept domain only and names a code system in the same section — *V2 Management*

**Identifiers.**

- Chapter 2C gives no OID for this ValueSet, so THO's `2.16.840.1.114222.4.11.934` is kept. Dropping it would be removing a published identifier.
- Chapter 2C also gives the table itself the OID `2.16.840.1.113883.12.292`, which this guide publishes nowhere.

<a id="tbl-0294"></a>

#### 0294 — Time Selection Criteria Parameter Class Codes
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (7).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `Fri` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Mon` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Sat` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Sun` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Thu` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Tue` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Wed` | In component 2, specify OK or NO. OK = Preferred appointment day NO = Day is not preferred | In component 2, specify OK or NO.<p>OK = Preferred appointment day NO = Day is not preferred | 22 other tables |

**Kept from THO (27).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Comments-as-published kept from THO | 9 |
| Codes kept from THO that the chapter does not list | 9 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0298"></a>

#### 0298 — CP Range Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0299"></a>

#### 0299 — Encoding

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 1 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0301"></a>

#### 0301 — Universal ID Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 7 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.definition` | `Random` | Usually a base64 encoded string of random bits. Note: Random IDs are typically used for instance identifiers, rather than an identifier of an Assigni… | Usually a base64 encoded string of random bits.<p>Note: Random IDs are typically used for instance identifiers, rather than an identifier of an Assig… | 4 other tables |
| Disagreement | `concept.property` (v2-concComment) | `Random` | Usually a base64 encoded string of random bits. Retained for backward compatibility only as of v2.7; equivalent to a locally defined entity identifie… | Usually a base64 encoded string of random bits.Retained for backward compatibility only as of v2.7; equivalent to a locally defined entity identifier… | 22 other tables |

**Written differently, saying the same thing (7).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.definition` | `CLIP` | …d number (for labs). Used by US Department of Defense. | …d number (for labs).Â Used by US Department of Defense. | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `CAP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `L` | Locally defined coding entity identifier. Retained for backward compatibility only as of v 2.8 | Locally defined coding entity identifier.Retained for backward compatibility only as of v 2.8 | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `L,M,N` | Locally defined coding entity identifier. Retained for backward compatibility only as of v 2.8 | Locally defined coding entity identifier.Retained for backward compatibility only as of v 2.8 | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `M` | Locally defined coding entity identifier. Retained for backward compatibility only as of v 2.8 | Locally defined coding entity identifier.Retained for backward compatibility only as of v 2.8 | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `N` | Locally defined coding entity identifier. Retained for backward compatibility only as of v 2.8 | Locally defined coding entity identifier.Retained for backward compatibility only as of v 2.8 | Same text; only spacing differs. |
| `concept.property` (status) | `NPI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (22).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Translations kept from THO | 13 |
| Comments-as-published kept from THO | 6 |
| Concept definitions kept from THO | 2 |
| Usage notes kept from THO | 1 |

<a id="tbl-0305"></a>

#### 0305 — Person Location Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (13).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 6 |

<a id="tbl-0309"></a>

#### 0309 — Coverage Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0311"></a>

#### 0311 — Job Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 4 |

<a id="tbl-0315"></a>

#### 0315 — Living Will Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0316"></a>

#### 0316 — Organ Donor Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0317"></a>

#### 0317 — Annotations

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0321"></a>

#### 0321 — Dispense Method

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0322"></a>

#### 0322 — Completion Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0324"></a>

#### 0324 — Location Characteristic ID

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 12 |

<a id="tbl-0325"></a>

#### 0325 — Location Relationship ID

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0326"></a>

#### 0326 — Visit Indicator
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept.property` (v2-concComment) | `A` | Usage Note: default | nothing | 8 other tables |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Translations kept from THO | 2 |
| Usage notes kept from THO | 1 |
| Concept definitions kept from THO | 1 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0329"></a>

#### 0329 — Quantity Method

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0330"></a>

#### 0330 — Marketing Basis

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0331"></a>

#### 0331 — Facility Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0332"></a>

#### 0332 — Source Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0334"></a>

#### 0334 — Disabled Person Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 3 |

<a id="tbl-0335"></a>

#### 0335 — Repeat Pattern
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (37).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 28 |
| Comments-as-published kept from THO | 9 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0336"></a>

#### 0336 — Referral Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0337"></a>

#### 0337 — Certification Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0338"></a>

#### 0338 — Practitioner ID Number Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: value set only.*

- Value set **4.0.0** — Changed: compose.include.

**Differences from THO (12).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `CY` | County number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `DEA` | Drug Enforcement Agency no. | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `GL` | General ledger number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `L&I` | Labor and industries number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `LI` | Labor and industries number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `MCD` | Medicaid number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `MCR` | Medicare number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `QA` | QA number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `SL` | State license number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `TAX` | Tax ID number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `TRL` | Training license number | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `UPIN` | Unique physician ID no. | — | 6 other tables |

<a id="tbl-0339"></a>

#### 0339 — Advanced Beneficiary Notice Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 3 |

<a id="tbl-0340"></a>

#### 0340 — Procedure Code Modifier
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-0340-code-grid-misuse` — Table 0340's code grid lists code systems, not codes — *V2 Management*
- `esc-domain-example-codes` — Where should a concept domain’s example codes live? — *V2 Management*

<a id="tbl-0344"></a>

#### 0344 — Patient's Relationship to Insured

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (29).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 19 |
| Translations kept from THO | 10 |

<a id="tbl-0347"></a>

#### 0347 — State/Province
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Changed: compose.include, name, title.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 1 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `title` | — | hl7VS-stateProvince | HL7 Value Set for State/Province | 1 other table |

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `name` | — | Hl7VSStateProvince | Hl7VsStateProvince | Same words; only capitalisation differs. <b>THO is the less capitalised side</b> — which may be correct style or may be a lost capital, so it is shown here rather than absorbed. |

**Open issues.**

- `esc-0347-iso3166` — Table 0347 _State/Province_ gives ISO 3166 part 1's URI for a part 2 code system, and calls a partial value set “all codes” — *V2 Management*

<a id="tbl-0350"></a>

#### 0350 — Occurrence Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Resource descriptions kept from THO | 1 |
| Resource names kept from THO | 1 |
| Resource titles kept from THO | 1 |
| Identifiers kept from THO | 1 |

**Answered by a committee.**

- `esc-0350-0351-not-domain-only` — Tables 0350 and 0351 are not concept domain only — *V2 Management, 2026-10-14*<br/><span class="tl-note">0350 and 0351 are **not** concept domain only. The value sets exist in THO, which makes them v2 content and therefore fair game for revision in this IG. This corrects the error in Chapter 2C that declares the tables concept domain only.</span>

**Identifiers.**

- Chapter 2C gives no OID for this ValueSet, so THO's `2.16.840.1.113883.21.227` is kept. Dropping it would be removing a published identifier.
- Chapter 2C also gives the table itself the OID `2.16.840.1.113883.12.350`, which this guide publishes nowhere.

<a id="tbl-0351"></a>

#### 0351 — Occurrence Span
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Resource descriptions kept from THO | 1 |
| Resource names kept from THO | 1 |
| Resource titles kept from THO | 1 |
| Identifiers kept from THO | 1 |

**Answered by a committee.**

- `esc-0350-0351-not-domain-only` — Tables 0350 and 0351 are not concept domain only — *V2 Management, 2026-10-14*<br/><span class="tl-note">0350 and 0351 are **not** concept domain only. The value sets exist in THO, which makes them v2 content and therefore fair game for revision in this IG. This corrects the error in Chapter 2C that declares the tables concept domain only.</span>

**Identifiers.**

- Chapter 2C gives no OID for this ValueSet, so THO's `2.16.840.1.113883.21.228` is kept. Dropping it would be removing a published identifier.
- Chapter 2C also gives the table itself the OID `2.16.840.1.113883.12.351`, which this guide publishes nowhere.

<a id="tbl-0353"></a>

#### 0353 — CWE statuses

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0354"></a>

#### 0354 — Message Structure
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 16 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.display` | `ADT_A30` | A30 | A30, A34, A35, A36, A46, A47, A48, A49 | 14 other tables |

**Written differently, saying the same thing (16).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `OML_O59` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OMQ_O57` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ORL_O53` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ORL_O54` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ORL_O55` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ORL_O56` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ORX_O58` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OSU_O51` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OSU_O52` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SET_S38` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SET_S40` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `SET_S41` | …t from storage (e.g., in biobanking). | …t from storage (e.g. in biobanking). | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `SET_S41` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SET_S45` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SET_S50` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SET_S52` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (346).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 243 |
| Codes kept from THO that the chapter does not list | 55 |
| Comments-as-published kept from THO | 47 |
| Translations kept from THO | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0355"></a>

#### 0355 — Primary Key Value Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0356"></a>

#### 0356 — Alternate Character Set Handling Scheme
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `ISO 2022-1994` | This standard is titled "Information Technology - Character Code Structure and Extension Technique". | This standard is titled "Information Technology - Character Code Structure and Extension Technique". . | Same words in the same order; only punctuation differs. |

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0357"></a>

#### 0357 — Message Error Condition Codes
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `198` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `199` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (37).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Comments-as-published kept from THO | 14 |
| Translations kept from THO | 13 |
| Concept definitions kept from THO | 10 |

**Open issues.**

- `esc-status-n-b-undefined` — The concept statuses `N` and `B` are defined nowhere; `N` is now mapped, `B` is not — *V2 Management + TSMG*

<a id="tbl-0359"></a>

#### 0359 — Diagnosis Priority
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Codes kept from THO that the chapter does not list | 3 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0360"></a>

#### 0360 — Degree/License/Certificate

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (61).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 61 |

<a id="tbl-0364"></a>

#### 0364 — Comment Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0365"></a>

#### 0365 — Equipment State
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Codes kept from THO that the chapter does not list | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0366"></a>

#### 0366 — Local/Remote Control State
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Codes kept from THO that the chapter does not list | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0367"></a>

#### 0367 — Alert Level
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: description.
- Value set **4.0.0** — Changed: description.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `description` | — | …ated equipment (e.g., processing event, inventory event, QC event). Used in the Equipment Detail (EQU) and Notification Detail (NDS) segments in HL7… | …ated equipment (e.g. processing event, inventory event, QC event). Used in the Equipment Detail (EQU) and Notification Detail (NDS) segments in HL7 V… | Same words in the same order; only punctuation differs. |
| `description` | — | …ated equipment (e.g., processing event, inventory event, QC event). | …ated equipment (e.g. processing event, inventory event, QC event). | Same words in the same order; only punctuation differs. |

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Comments-as-published kept from THO | 4 |
| Codes kept from THO that the chapter does not list | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0368"></a>

#### 0368 — Remote Control Command

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (23).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 21 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0369"></a>

#### 0369 — Specimen Role
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `H` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

<a id="tbl-0370"></a>

#### 0370 — Container Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

Nothing to report: what this guide publishes matches THO on every element compared.

<a id="tbl-0371"></a>

#### 0371 — Additive/Preservative

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (114).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 57 |
| Comments-as-published kept from THO | 57 |

<a id="tbl-0372"></a>

#### 0372 — Specimen Component

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0373"></a>

#### 0373 — Treatment

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |

<a id="tbl-0374"></a>

#### 0374 — System Induced Contaminants

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |

<a id="tbl-0375"></a>

#### 0375 — Artificial Blood

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0376"></a>

#### 0376 — Special Handling Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (34).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 17 |
| Comments-as-published kept from THO | 17 |

<a id="tbl-0377"></a>

#### 0377 — Other Environmental Factors

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0383"></a>

#### 0383 — Substance Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |

<a id="tbl-0384"></a>

#### 0384 — Substance Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 12 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0387"></a>

#### 0387 — Command Response

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0388"></a>

#### 0388 — Processing Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0389"></a>

#### 0389 — Analyte Repeat Status
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: description.
- Value set **4.0.0** — Changed: description.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `description` | — | …analyte/result (e.g., original, rerun, repeat, reflex). The following are assumptions regarding the table values: Repeated without dilution — perform… | …analyte/result (e.g. original, rerun, repeat, reflex). The following are assumptions regarding the table values: Repeated without dilution — performe… | Same words in the same order; only punctuation differs. |
| `description` | — | …analyte/result (e.g., original, rerun, repeat, reflex). The following are assumptions regarding the table values: Repeated without dilution — perform… | …analyte/result (e.g. original, rerun, repeat, reflex). The following are assumptions regarding the table values: Repeated without dilution — performe… | Same words in the same order; only punctuation differs. |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0391"></a>

#### 0391 — Segment Group
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (16).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Codes kept from THO that the chapter does not list | 16 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0392"></a>

#### 0392 — Match Reason
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0393"></a>

#### 0393 — Match Algorithms

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0394"></a>

#### 0394 — Response Modality

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0395"></a>

#### 0395 — Modify Indicator

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0396"></a>

#### 0396 — Coding System
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **6.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (83).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 29 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.display` | `ALPHAID2012` | German Alpha-ID v2012 | German Alpha-ID v2013 | 14 other tables |
| Disagreement | `concept.display` | `OPS2009` | OPS Germany v2009 | OPS Germany v2008 | 14 other tables |
| Disagreement | `concept.property` (status) | `99zzz` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `ALPHAID2012` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ALPHAID2013` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ALPHAID2014` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ALPHAID2015` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ALPHAID2016` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ICD10GM2012` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ICD10GM2013` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ICD10GM2014` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ICD10GM2015` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `ICD10GM2016` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `NCPDPnnnnsss` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `OPS2012` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `OPS2013` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `OPS2014` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `OPS2015` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (status) | `OPS2016` | active | deprecated | 25 other tables |
| Disagreement | `concept.property` (v2-concComment) | `PHDSCSOPT` | The Source of Payment Typology was developed and is maintained by the Public Health Data Standards Consortium's Payer Type Subcommittee. The purpose… | The Source of Payment Typology (SOPT) is maintained by the Centers for Disease Control and Prevention (CDC), National Center for Health Statistics (N… | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `ROLECLASS` | For use in v2.x systems interoperating with V3 systems. Identical to the code system 2.16.840.1.113883.5.110 RoleCode in the Version 3 vocabulary. | For use in v2.x systems interoperating with V3 systems. Identical to the code system 2.16.840.1.113883.5.111 RoleCode in the Version 3 vocabulary. | 22 other tables |
| Disagreement | `concept.property` (status) | `X12DEnnnn` | deprecated | active | 25 other tables |
| Added here | `concept` | `ALPHAID2017` | German Alpha-ID v2017 | nothing | 2 other tables |
| Added here | `concept` | `ALPHAID2018` | German Alpha-ID v2018 | nothing | 2 other tables |
| Added here | `concept` | `ALPHAID2019` | German Alpha-ID v2019 | nothing | 2 other tables |
| Added here | `concept` | `ALPHAID2020` | German Alpha-ID v2020 | nothing | 2 other tables |
| Added here | `concept` | `ALPHAID2021` | German Alpha-ID v2021 | nothing | 2 other tables |
| Added here | `concept` | `ALPHAID2022` | German Alpha-ID v2022 | nothing | 2 other tables |
| Added here | `concept` | `ALPHAID2023` | German Alpha-ID v2023 | nothing | 2 other tables |
| Added here | `concept` | `GLN` | Global Location Number | nothing | 2 other tables |
| Added here | `concept` | `GMDC2010` | German Major Diagnostic Codes v2010 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2011` | German Major Diagnostic Codes v2011 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2012` | German Major Diagnostic Codes v2012 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2013` | German Major Diagnostic Codes v2013 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2014` | German Major Diagnostic Codes v2014 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2015` | German Major Diagnostic Codes v2015 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2016` | German Major Diagnostic Codes v2016 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2017` | German Major Diagnostic Codes v2017 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2018` | German Major Diagnostic Codes v2018 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2019` | German Major Diagnostic Codes v2019 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2020` | German Major Diagnostic Codes v2020 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2021` | German Major Diagnostic Codes v2021 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2022` | German Major Diagnostic Codes v2022 | nothing | 2 other tables |
| Added here | `concept` | `GMDC2023` | German Major Diagnostic Codes v2023 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2017` | ICD 10 Germany v2017 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2018` | ICD 10 Germany v2018 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2019` | ICD 10 Germany v2019 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2020` | ICD 10 Germany v2020 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2021` | ICD 10 Germany v2021 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2022` | ICD 10 Germany v2022 | nothing | 2 other tables |
| Added here | `concept` | `ICD10GM2023` | ICD 10 Germany v2023 | nothing | 2 other tables |
| Added here | `concept` | `OPS2017` | OPS Germany v2017 | nothing | 2 other tables |
| Added here | `concept` | `OPS2018` | OPS Germany v2018 | nothing | 2 other tables |
| Added here | `concept` | `OPS2019` | OPS Germany v2019 | nothing | 2 other tables |
| Added here | `concept` | `OPS2020` | OPS Germany v2020 | nothing | 2 other tables |
| Added here | `concept` | `OPS2021` | OPS Germany v2021 | nothing | 2 other tables |
| Added here | `concept` | `OPS2022` | OPS Germany v2022 | nothing | 2 other tables |
| Added here | `concept` | `OPS2023` | OPS Germany v2023 | nothing | 2 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2010` | ID of the alphabetical Index ICD-10-GM-2010 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2011` | ID of the alphabetical Index ICD-10-GM-2011 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2012` | ID of the alphabetical Index ICD-10-GM-2012 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2013` | ID of the alphabetical Index ICD-10-GM-2013 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2014` | ID of the alphabetical Index ICD-10-GM-2014 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2015` | ID of the alphabetical Index ICD-10-GM-2015 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ALPHAID2016` | ID of the alphabetical Index ICD-10-GM-2016 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `DAR` | HL7 International maintained code system to specify why the normally expected content of the data element is missing. <https://terminology.hl7.org/Co… | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `GMDC2009` | German Major Diagnostic Codes v2009 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2010` | ICD German modification for 2010 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2011` | ICD German modification for 2011 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2012` | ICD German modification for 2012 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2013` | ICD German modification for 2013 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2014` | ICD German modification for 2014 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2015` | ICD German modification for 2015 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ICD10GM2016` | ICD German modification for 2016 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `ISO` | See chapter 7, section 7.4.2.6 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2010` | Source: OPS Operationen- und Prozedurenschlussel 2010 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2011` | Source: OPS Operationen- und Prozedurenschlussel 2011 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2012` | Source: OPS Operationen- und Prozedurenschlussel 2012 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2013` | Source: OPS Operationen- und Prozedurenschlussel 2013 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2014` | Source: OPS Operationen- und Prozedurenschlussel 2014 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2015` | Source: OPS Operationen- und Prozedurenschlussel 2015 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OPS2016` | Source: OPS Operationen- und Prozedurenschlussel 2016 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SPCU` | HL7 International maintained code system for parameter values that provide guidance on how a receiver should apply settings or reference ranges that… | nothing | 8 other tables |

**Written differently, saying the same thing (29).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `DAR` | DataAbsentReason | DataAbsentReason | Same words; only capitalisation differs. THO's capitalisation is the better of the two, so this guide publishes it; the chapter has “dataAbsentReason”. |
| `concept.display` | `HGVS.c` | HGVS - Transcript syntax | HGVS- Transcript syntax | Same text; only spacing differs. |
| `concept.display` | `HGVS.g` | HGVS - Genomic syntax | HGVS- Genomic syntax | Same text; only spacing differs. |
| `concept.display` | `SDM` | SNOMED - DICOM Microglossary | SNOMED- DICOM Microglossary | Same text; only spacing differs. |
| `concept.display` | `SPCU` | Sex Parameter For Clinical Use | Sex Parameter for Clinical Use | Same words; only capitalisation differs. <b>THO is the less capitalised side</b> — which may be correct style or may be a lost capital, so it is shown here rather than absorbed. |
| `concept.property` (status) | `CDCINDUSTRY2010` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CDCOCCUPATION2010` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CDCODH` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CMSOEC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CMSOMC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `COSMIC-Smpl` | … per unique mutation - more than 3 million of them. These contents are copyright COSMIC (http://cancer.sanger.ac.uk/cosmic/license) LHC has produced… | … per unique mutation- more than 3 million of them. These contents are copyright COSMIC (http://cancer.sanger.ac.uk/cosmic/license) LHC has produced a… | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `Chrom-Loc` | … of the locus - e.g., 2p16.3. There are other conventions for reporting ranges and locations at the end of the chromosomes. The table of these chromo… | … of the locus - e.g. 2p16.3 . There are other conventions for reporting ranges and locations at the end of the chromosomes. The table of these chromo… | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `GDRG2004` | German Handbook for DRGs. The THREE versions, "2004", "2005" and "2006" are active | German Handbook for DRGs. The THREE versions, "2004" , "2005" and "2006" are active | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `GDRG2005` | German Handbook for DRGs. The THREE versions, "2004", "2005" and "2006" are active | German Handbook for DRGs. The THREE versions, "2004" , "2005" and "2006" are active | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `GDRG2006` | German Handbook for DRGs. The THREE versions, "2004", "2005" and "2006" are active | German Handbook for DRGs. The THREE versions, "2004" , "2005" and "2006" are active | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `HL7nnnn` | … numeric digits e.g., HL70001 is valid, examples of invalid values include HL71, HL701, HL7001. | … numeric digits e.g. HL70001 is valid, examples of invalid values include HL71, HL701, HL7001. | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `I10P0` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `LN` | …nt instruments (e.g., Glascow Coma Score, PHQ-9 depression scale, CMS-required patient assessment instruments), and other clinical observations. | …nt instruments (e.g. Glascow Coma Score, PHQ-9 depression scale, CMS-required patient assessment instruments), and other clinical observations. | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP001` | …g immunization. E.g., From school, provider,public health agency. | …g immunization. E.g. From school, provider,public health agency. | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP002` | …g vaccination). E.g., Religious exemption, parental decision | …g vaccination). E.g. Religious exemption, parental decision | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP004` | CDC National Immunization Program's (NIP) defined table for vaccine contraindications and precautions. E.g., Allergy to egg ingestion, thimerosol | CDC National Immunization Program's (NIP) defined table for vaccine contraindications and precautions. E.g. Allergy to egg ingestion, thimerosol | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP007` | CDC National Immunization Program's (NIP) defined table for vaccinated at location (facility). E.g., Private doctor's office, Public Health Clinic | CDC National Immunization Program's (NIP) defined table for vaccinated at location (facility). E.g. Private doctor's office, Public Health Clinic | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP008` | CDC National Immunization Program's (NIP) defined table enumerates the type of funds used for purchasing vaccine. E.g., Public funds, Military funds | CDC National Immunization Program's (NIP) defined table enumerates the type of funds used for purchasing vaccine. E.g. Public funds, Military funds | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP009` | …ously reported. E.g., To health department, To manufacturer | …ously reported. E.g. To health department, To manufacturer | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `NIP010` | …orting System). E.g., Initial, Follow-up | …orting System). E.g. Initial, Follow-up | Same words in the same order; only punctuation differs. |
| `concept.property` (v2-concComment) | `RXNORM` | …ware and vocabulary. RxNorm is one of a suite of designated standards for use in U.S. Federal Government systems for the electronic exchange of clini… | …ware and vocabulary.RxNorm is one of a suite of designated standards for use in U.S. Federal Government systems for the electronic exchange of clinic… | Same text; only spacing differs. |
| `concept.property` (status) | `UB04FL42` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `UB04FL67` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `cdcgs1vis` | … document type (e.g., influenza, MMR) and the edition date of the VIS, as required by the National Childhood Vaccine Injury Act (NCVIA). For more inf… | … document type (e.g. influenza, MMR) and the edition date of the VIS, as required by the National Childhood Vaccine Injury Act (NCVIA). For more info… | Same words in the same order; only punctuation differs. |

**Kept from THO (285).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 240 |
| Deprecation markers kept from THO | 23 |
| Codes kept from THO that the chapter does not list | 14 |
| Comments-as-published kept from THO | 8 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0397"></a>

#### 0397 — Sequencing

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0398"></a>

#### 0398 — Continuation Style Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0399"></a>

#### 0399 — Country Code
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: withheld on a ruling.*

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The correct value set for table 0399 already exists in THO, ValueSet/v2-notAllCodes-0399. It is the one to use; this guide creates nothing for the ta…</span> | http://terminology.hl7.org/ValueSet/v2-notAllCodes-0399 | 23 other tables |

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0401"></a>

#### 0401 — Government Reimbursement Program

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0402"></a>

#### 0402 — School Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0403"></a>

#### 0403 — Language Ability

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0404"></a>

#### 0404 — Language Proficiency

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0406"></a>

#### 0406 — Participant Organization Unit Type
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0409"></a>

#### 0409 — Application Change Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0411"></a>

#### 0411 — Supplemental Service Information Values
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-0411-concept-domain-only` — Table 0411 _Supplemental Service Information Values_ is concept domain only — *V2 Management, 2026-10-14*<br/><span class="tl-note">Table 0411 should be concept domain only, so no code system and no value set.</span>

<a id="tbl-0415"></a>

#### 0415 — Transfer Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0416"></a>

#### 0416 — Procedure DRG Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0417"></a>

#### 0417 — Tissue Type Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (13).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 13 |

<a id="tbl-0418"></a>

#### 0418 — Procedure Priority
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 1 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0421"></a>

#### 0421 — Severity of Illness Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0422"></a>

#### 0422 — Triage Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0423"></a>

#### 0423 — Case Category Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |

<a id="tbl-0424"></a>

#### 0424 — Gestation Category Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 3 |

<a id="tbl-0425"></a>

#### 0425 — Newborn Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (9).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 4 |

<a id="tbl-0426"></a>

#### 0426 — Blood Product Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (15).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 15 |

<a id="tbl-0427"></a>

#### 0427 — Risk Management Incident Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 14 |

<a id="tbl-0428"></a>

#### 0428 — Incident Type Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0429"></a>

#### 0429 — Production Class Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 12 |

<a id="tbl-0430"></a>

#### 0430 — Mode of Arrival Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0431"></a>

#### 0431 — Recreational Drug Use Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 7 |

<a id="tbl-0432"></a>

#### 0432 — Admission Level of Care Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 5 |

<a id="tbl-0433"></a>

#### 0433 — Precaution Code
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.definition` | `N` | "No-code" (i.e., Do not resuscitate) | "No-code" (i.e. Do not resuscitate) | Same words in the same order; only punctuation differs. |

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 6 |

<a id="tbl-0434"></a>

#### 0434 — Patient Condition Code
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: description.
- Value set **4.0.0** — Changed: description.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `description` | — | …utside parties, e.g., family, employer, religious minister, media, etc. Used in HL7 Version 2.x messaging in the PV2 segment. | …utside parties, e.g. family, employer, religious minister, media, etc. Used in HL7 Version 2.x messaging in the PV2 segment. | Same words in the same order; only punctuation differs. |
| `description` | — | …utside parties, e.g., family, employer, religious minister, media, etc. | …utside parties, e.g. family, employer, religious minister, media, etc. | Same words in the same order; only punctuation differs. |

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Translations kept from THO | 6 |

<a id="tbl-0435"></a>

#### 0435 — Advance Directive Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0436"></a>

#### 0436 — Sensitivity to Causative Agent Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 1 |

<a id="tbl-0437"></a>

#### 0437 — Alert Device Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 2 |

<a id="tbl-0438"></a>

#### 0438 — Allergy Clinical Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0440"></a>

#### 0440 — Data Types
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (14).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 5 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `AD` | WITHDRAWN | Replaced by XAD as of v 2.3 | 22 other tables |
| Disagreement | `concept.property` (status) | `AD` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `CE` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `CK` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `CM` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `CN` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `CSU` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `ELD` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `OSD` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `PN` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `SPS` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `TN` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `TQ` | deprecated | active | 25 other tables |
| Disagreement | `concept.property` (status) | `TS` | deprecated | active | 25 other tables |

**Written differently, saying the same thing (5).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `LA1` | deprecated | B | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `LA2` | deprecated | B | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `MOC` | Replaces the CM data type used in sections 4.5.3.23 OBR-23 and 7.4.1.23 - OBR-23 as of v 2.5. | Replaces the CM data type used in sections 4.5.3.23 OBR-23 and 7.4.1.23- OBR-23 as of v 2.5. | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `NDL` | Replaces the CM data type used in sections 4.5.3.32 and 7.4.1.32 - (OBR-32), 4.5.3.33 and 7.4.1.33 - (OBR-33) 4.5.3.34 and 7.4.1.34 - (OBR-34) 4.5.3.… | Replaces the CM data type used in sections 4.5.3.32 and 7.4.1.32-( OBR-32) , 4.5.3.33 and 7.4.1.33 - ( OBR-33) 4.5.3.34 and 7.4.1.34 - ( OBR-34) 4.5.… | Same text; only spacing differs. |
| `concept.property` (v2-concComment) | `NR` | Replaces the CM data type used in sections 8.8.4.6.1 - OM2-6.1, 8.8.4.6.3 - OM2-6.3and 8.8.4.6.4 - OM2-6.4, as of v 2.5. | Replaces the CM data type used in sections 8.8.4.6.1- OM2-6.1, 8.8.4.6.3- OM2-6.3and 8.8.4.6.4- OM2-6.4, as of v 2.5. | Same text; only spacing differs. |

**Kept from THO (154).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 95 |
| Comments-as-published kept from THO | 58 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0441"></a>

#### 0441 — Immunization Registry Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0442"></a>

#### 0442 — Location Service Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0443"></a>

#### 0443 — Provider Role

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (49).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 23 |
| Comments-as-published kept from THO | 15 |
| Translations kept from THO | 11 |

<a id="tbl-0444"></a>

#### 0444 — Name Assembly Order

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Translations kept from THO | 2 |

<a id="tbl-0445"></a>

#### 0445 — Identity Reliability Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0450"></a>

#### 0450 — Event Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0451"></a>

#### 0451 — Substance Identifier
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-domain-example-codes` — Where should a concept domain’s example codes live? — *V2 Management*

<a id="tbl-0456"></a>

#### 0456 — Revenue code
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: concept domain only.*

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">Declared concept domain only. A binding to a domain needs no value set.</span> | http://terminology.hl7.org/ValueSet/v2-0456 | 23 other tables |

**Answered by a committee.**

- `esc-tho-dangling-value-sets` — Withdrawn — the “dangling” value sets are not dangling — *V2 Management, 2026-10-14*<br/><span class="tl-note">The current content logical definitions are right. THO does publish the URIs of these external code systems as `http://terminology.hl7.org/CodeSystem/v2-0350` and `…/v2-0351`, per its external code systems page.</span>

<a id="tbl-0457"></a>

#### 0457 — Overall Claim Disposition Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0458"></a>

#### 0458 — OCE Edit Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

**Open issues.**

- `esc-full-name-copy-paste` — The copy-pasted Full Name is not confined to the UCUM tables — *V2 Management* <span class="tl-note">(the register lists this table as an example; its list is not exhaustive)</span>

**Answered by a committee.**

- `esc-0459-unresolvable-oid` — Tables 0458 and 0459 name a CMS code system by an OID that THO does not yet register — *V2 Management, 2026-11-06*<br/><span class="tl-note">The codes for both tables come from the CMS Integrated Outpatient Code Editor specification, which CMS defines and maintains. Jira tickets have been raised to create external code system records in THO: `CodeSystem/oce-edit-codes` for 0458, and `CodeSystem/oce-reimbursement-action-codes` for 0459. Publish a value set for each over its canonical, with the supplied description. Create no CodeSystem for either, and extract nothing from the I/OCE specification PDF — the canonical from the THO record is all that is needed.</span>

<a id="tbl-0459"></a>

#### 0459 — Reimbursement Action Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

**Answered by a committee.**

- `esc-0459-unresolvable-oid` — Tables 0458 and 0459 name a CMS code system by an OID that THO does not yet register — *V2 Management, 2026-11-06*<br/><span class="tl-note">The codes for both tables come from the CMS Integrated Outpatient Code Editor specification, which CMS defines and maintains. Jira tickets have been raised to create external code system records in THO: `CodeSystem/oce-edit-codes` for 0458, and `CodeSystem/oce-reimbursement-action-codes` for 0459. Publish a value set for each over its canonical, with the supplied description. Create no CodeSystem for either, and extract nothing from the I/OCE specification PDF — the canonical from the THO record is all that is needed.</span>

<a id="tbl-0460"></a>

#### 0460 — Denial or Rejection Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

**Answered by a committee.**

- `esc-0460-oce-realignment` — Table 0460's codes are CMS I/OCE content, and this guide was minting an HL7 code system for them — *V2 Management, 2026-11-06*<br/><span class="tl-note">Align 0460 with the other I/OCE tables. The codes are CMS's Line-item Denial or Rejection Flag. The external metadata record URL is `CodeSystem/oce-denial-or-rejection-flag`. Publish the value set over that canonical with the supplied description, and stop minting a v2 CodeSystem.</span>

<a id="tbl-0465"></a>

#### 0465 — Name/Address Representation

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 1 |

<a id="tbl-0466"></a>

#### 0466 — Ambulatory Payment Classification Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 1 |

**Open issues.**

- `esc-gp2-oce-siblings` — Four more GP2 tables look like CMS I/OCE content and are published as though HL7 owned them — *Financial Management WG*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0467"></a>

#### 0467 — Modifier Edit Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

**Answered by a committee.**

- `esc-0467-oce-modifier-edit` — Table 0467's code system is an OCE arc OID that THO does not yet register — *V2 Management, 2026-11-05*<br/><span class="tl-note">A Jira ticket has been raised to create an external code system record for this code system. Its URL and OID will be the ones Chapter 2C already lists. Publish the value set over that canonical with a content logical definition of all codes from the system.</span>

<a id="tbl-0468"></a>

#### 0468 — Payment Adjustment Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

**Open issues.**

- `esc-gp2-oce-siblings` — Four more GP2 tables look like CMS I/OCE content and are published as though HL7 owned them — *Financial Management WG*

<a id="tbl-0469"></a>

#### 0469 — Packaging Status Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

**Open issues.**

- `esc-gp2-oce-siblings` — Four more GP2 tables look like CMS I/OCE content and are published as though HL7 owned them — *Financial Management WG*

<a id="tbl-0470"></a>

#### 0470 — Reimbursement Type Code
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |

**Open issues.**

- `esc-gp2-oce-siblings` — Four more GP2 tables look like CMS I/OCE content and are published as though HL7 owned them — *Financial Management WG*

<a id="tbl-0472"></a>

#### 0472 — TQ Conjunction ID

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0473"></a>

#### 0473 — Formulary Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0474"></a>

#### 0474 — Practitioner Organization Unit Type
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Codes kept from THO that the chapter does not list | 2 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0475"></a>

#### 0475 — Charge Type Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0477"></a>

#### 0477 — Controlled Substance Schedule

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Comments-as-published kept from THO | 6 |

<a id="tbl-0478"></a>

#### 0478 — Formulary Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0480"></a>

#### 0480 — Pharmacy Order Types

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0482"></a>

#### 0482 — Order Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0483"></a>

#### 0483 — Authorization Mode

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |

<a id="tbl-0484"></a>

#### 0484 — Dispense Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (9).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |

<a id="tbl-0485"></a>

#### 0485 — Extended Priority Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (23).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 13 |
| Comments-as-published kept from THO | 10 |

<a id="tbl-0487"></a>

#### 0487 — Specimen Type
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `WASI` | Washing, e.g., bronchial washing | Washing, e.g. bronchial washing | Same words in the same order; only punctuation differs. |

**Kept from THO (544).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 313 |
| Comments-as-published kept from THO | 228 |
| Codes kept from THO that the chapter does not list | 2 |
| Translations kept from THO | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0488"></a>

#### 0488 — Specimen Collection Method

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (42).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 42 |

<a id="tbl-0489"></a>

#### 0489 — Risk Codes
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (v2-concComment) | `BIO` | The dangers associated with normal biological materials. I.e., potential risk of unknown infections. Routine biological materials from living subject… | The dangers associated with normal biological materials. I.e. potential risk of unknown infections. Routine biological materials from living subjects. | Same words in the same order; only punctuation differs. |

**Kept from THO (22).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |
| Comments-as-published kept from THO | 11 |

<a id="tbl-0490"></a>

#### 0490 — Specimen Reject Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 14 |

<a id="tbl-0491"></a>

#### 0491 — Specimen Quality

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0492"></a>

#### 0492 — Specimen Appropriateness
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0493"></a>

#### 0493 — Specimen Condition

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0494"></a>

#### 0494 — Specimen Child Role

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0495"></a>

#### 0495 — Body Site Modifier

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (17).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 16 |
| Translations kept from THO | 1 |

<a id="tbl-0496"></a>

#### 0496 — Consent Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept, description.
- Value set **4.0.0** — Changed: description.

**Written differently, saying the same thing (3).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `116` | Sterilization - Federally Funded | Sterilization -Federally Funded | Same text; only spacing differs. |
| `description` | — | Code system of concepts specifying to what the subject is consenting, i.e., what type of service, surgical procedure, information access/release or o… | Code system of concepts specifying to what the subject is consenting, i.e. what type of service, surgical procedure, information access/release or ot… | Same words in the same order; only punctuation differs. |
| `description` | — | Value Set of codes that specify to what the subject is consenting, i.e., what type of service, surgical procedure, information access/release or othe… | Value Set of codes that specify to what the subject is consenting, i.e. what type of service, surgical procedure, information access/release or other… | Same words in the same order; only punctuation differs. |

**Kept from THO (273).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Comments-as-published kept from THO | 137 |
| Concept definitions kept from THO | 136 |

<a id="tbl-0497"></a>

#### 0497 — Consent Mode

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0498"></a>

#### 0498 — Consent Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0499"></a>

#### 0499 — Consent Bypass Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0500"></a>

#### 0500 — Consent Disclosure Level

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0501"></a>

#### 0501 — Consent Non-Disclosure Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0502"></a>

#### 0502 — Non-Subject Consenter Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0503"></a>

#### 0503 — Sequence/Results Flag

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0504"></a>

#### 0504 — Sequence Condition Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0505"></a>

#### 0505 — Cyclic Entry/Exit Indicator
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept.property` (v2-concComment) | `#` | Usage Note: Retired March 2016. Use code L instead | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `*` | Usage Note: Retired March 2016. Use code F instead | nothing | 8 other tables |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Usage notes kept from THO | 2 |

**Open issues.**

- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0506"></a>

#### 0506 — Service Request Relationship

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Comments-as-published kept from THO | 5 |

<a id="tbl-0507"></a>

#### 0507 — Observation Result Handling

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0508"></a>

#### 0508 — Blood Product Processing Requirements
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0510"></a>

#### 0510 — Blood Product Dispense Status
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (22).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 11 |
| Comments-as-published kept from THO | 11 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0511"></a>

#### 0511 — BP Observation Status Codes Interpretation
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0513"></a>

#### 0513 — Blood Product Transfusion/Disposition Status
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `TI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0514"></a>

#### 0514 — Transfusion Adverse Reaction

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (19).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 19 |

<a id="tbl-0516"></a>

#### 0516 — Error Severity

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Comments-as-published kept from THO | 4 |
| Translations kept from THO | 3 |

<a id="tbl-0517"></a>

#### 0517 — Inform Person Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0518"></a>

#### 0518 — Override Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0520"></a>

#### 0520 — Message Waiting Priority
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

**Open issues.**

- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0523"></a>

#### 0523 — Computation Type
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

**Open issues.**

- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*

<a id="tbl-0527"></a>

#### 0527 — Calendar Alignment

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (16).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 8 |

<a id="tbl-0528"></a>

#### 0528 — Event Related Period

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (17).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 13 |
| Translations kept from THO | 4 |

<a id="tbl-0530"></a>

#### 0530 — Organization, Agency, Department

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0532"></a>

#### 0532 — Expanded Yes/no Indicator

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (24).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Translations kept from THO | 8 |
| Comments-as-published kept from THO | 7 |

<a id="tbl-0534"></a>

#### 0534 — Notify Clergy Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 3 |

<a id="tbl-0535"></a>

#### 0535 — Signature Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0536"></a>

#### 0536 — Certificate Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (9).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Translations kept from THO | 4 |

<a id="tbl-0538"></a>

#### 0538 — Institution Relationship Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Translations kept from THO | 1 |

<a id="tbl-0540"></a>

#### 0540 — Inactive Reason Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0544"></a>

#### 0544 — Container Condition
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (43).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 21 |
| Comments-as-published kept from THO | 21 |
| Codes kept from THO that the chapter does not list | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*
- `esc-punctuation-codes` — Twenty-three concepts have a code that is nothing but punctuation — *V2 Management + TSMG*
- `esc-truncated-value-set-descriptions` — Sixteen Value Set descriptions stop mid-word, all at about 250 characters — *V2 Management*

<a id="tbl-0547"></a>

#### 0547 — Jurisdictional Breadth

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Translations kept from THO | 2 |

<a id="tbl-0548"></a>

#### 0548 — Signatory's Relationship to Subject
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `7` | Non-Emergent Practitioner (i.e., medical ethics committee) | Non-Emergent Practitioner (i.e. medical ethics committee) | Same words in the same order; only punctuation differs. |

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Translations kept from THO | 1 |

<a id="tbl-0550"></a>

#### 0550 — Body Parts

*Route: code system + value set.*

- Code system **4.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (442).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 442 |

<a id="tbl-0553"></a>

#### 0553 — Invoice Control Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (22).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 17 |
| Comments-as-published kept from THO | 5 |

<a id="tbl-0554"></a>

#### 0554 — Invoice Reason Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0555"></a>

#### 0555 — Invoice Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (v2-concComment) | `NP` | Invoice without a patient. E.g., bulk invoicing for Pharmacy for a care facility. | Invoice without a patient. E.g. bulk invoicing for Pharmacy for a care facility. | Same words in the same order; only punctuation differs. |

**Kept from THO (15).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Comments-as-published kept from THO | 5 |

<a id="tbl-0556"></a>

#### 0556 — Benefit Group

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0557"></a>

#### 0557 — Payee Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0558"></a>

#### 0558 — Payee Relationship to Invoice

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0559"></a>

#### 0559 — Product/Service Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0560"></a>

#### 0560 — Quantity Units
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept, hierarchyMeaning.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `hierarchyMeaning` | — | is-a | nothing | only here |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Resource descriptions kept from THO | 1 |
| Resource names kept from THO | 1 |
| Resource titles kept from THO | 1 |
| Identifiers kept from THO | 1 |

**Open issues.**

- `esc-0560-content` — Table 0560 _Quantity Units_ publishes time units, and THO carries the same error — *V2 Management + TSMG*
- `esc-placeholder-metadata` — Two tables publish literal placeholder text — `noObject` and `noDescription` — *V2 Management*

**Identifiers.**

- Chapter 2C gives no OID for this CodeSystem, so THO's `2.16.840.1.113883.18.455` is kept. Dropping it would be removing a published identifier.
- Chapter 2C also gives the table itself the OID `2.16.840.1.113883.12.560`, which this guide publishes nowhere.

<a id="tbl-0561"></a>

#### 0561 — Product/Services Clarification Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0562"></a>

#### 0562 — Processing Consideration Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0564"></a>

#### 0564 — Adjustment Category Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0565"></a>

#### 0565 — Provider Adjustment Reason Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0566"></a>

#### 0566 — Blood Unit Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0567"></a>

#### 0567 — Weight Units
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: withheld on a ruling.*

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">Tables 0567 and 0568 should never have been created. Their value sets will be retired by a separate Jira ticket against THO, not by this IG, which is…</span> | http://terminology.hl7.org/ValueSet/v2-0567 | 23 other tables |

**Open issues.**

- `esc-duplicate-tables` — Two pairs of tables are duplicates of each other — *V2 Management*
- `esc-ucum-full-name` — All six UCUM-backed tables name the code system “Donation Duration Units Code System” — *V2 Management*

**Answered by a committee.**

- `esc-0567-0568-deprecation` — Chapter 2C deprecates tables 0567 and 0568 — does anything in THO get deprecated with them? — *V2 Management, 2026-09-23*<br/><span class="tl-note">Tables 0567 and 0568 should never have been created. Their value sets will be retired, but not by this IG and not as part of this load: a separate Jira ticket will be raised against THO to retire `ValueSet/v2-0567` and `ValueSet/v2-0568`. This IG is to do nothing with them.</span>
- `esc-0567-0568-representation` — Deprecating a V2 value set in THO has no established representation, and would be a first — *V2 Management, 2026-09-23*<br/><span class="tl-note">Both halves are settled, and neither lands on this IG. The 0567/0568 retirement goes to THO as a separate Jira ticket, so no deprecation needs representing here. For table 0005, the value set stays and the code system is correctly retired already; this IG will not link the value set and should not inform any change to it.</span>

<a id="tbl-0568"></a>

#### 0568 — Volume Units
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: withheld on a ruling.*

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">Tables 0567 and 0568 should never have been created. Their value sets will be retired by a separate Jira ticket against THO, not by this IG, which is…</span> | http://terminology.hl7.org/ValueSet/v2-0568 | 23 other tables |

**Open issues.**

- `esc-duplicate-tables` — Two pairs of tables are duplicates of each other — *V2 Management*
- `esc-ucum-full-name` — All six UCUM-backed tables name the code system “Donation Duration Units Code System” — *V2 Management*

**Answered by a committee.**

- `esc-0567-0568-deprecation` — Chapter 2C deprecates tables 0567 and 0568 — does anything in THO get deprecated with them? — *V2 Management, 2026-09-23*<br/><span class="tl-note">Tables 0567 and 0568 should never have been created. Their value sets will be retired, but not by this IG and not as part of this load: a separate Jira ticket will be raised against THO to retire `ValueSet/v2-0567` and `ValueSet/v2-0568`. This IG is to do nothing with them.</span>
- `esc-0567-0568-representation` — Deprecating a V2 value set in THO has no established representation, and would be a first — *V2 Management, 2026-09-23*<br/><span class="tl-note">Both halves are settled, and neither lands on this IG. The 0567/0568 retirement goes to THO as a separate Jira ticket, so no deprecation needs representing here. For table 0005, the value set stays and the code system is correctly retired already; this IG will not link the value set and should not inform any change to it.</span>

<a id="tbl-0569"></a>

#### 0569 — Adjustment Action

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0570"></a>

#### 0570 — Payment Method Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0571"></a>

#### 0571 — Invoice Processing Results Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Translations kept from THO | 1 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0572"></a>

#### 0572 — Tax status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0615"></a>

#### 0615 — User Authentication Credential Type Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0616"></a>

#### 0616 — Address Expiration Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0617"></a>

#### 0617 — Address Usage

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0618"></a>

#### 0618 — Protection Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0625"></a>

#### 0625 — Item Status Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0626"></a>

#### 0626 — Observation Method (OBX-17)
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-tho-definition-differences` — Five concept domain definitions differ between Chapter 2C and THO — *V2 Management + TSMG*

<a id="tbl-0634"></a>

#### 0634 — Item Importance Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |

<a id="tbl-0642"></a>

#### 0642 — Reorder Theory Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0651"></a>

#### 0651 — Labor Calculation Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0653"></a>

#### 0653 — Date Format

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Comments-as-published kept from THO | 6 |

<a id="tbl-0657"></a>

#### 0657 — Device Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0659"></a>

#### 0659 — Lot Control

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0667"></a>

#### 0667 — Device Data State

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0669"></a>

#### 0669 — Load Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Comments-as-published kept from THO | 4 |

<a id="tbl-0675"></a>

#### 0675 — Country (PDC-2)
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-tho-definition-differences` — Five concept domain definitions differ between Chapter 2C and THO — *V2 Management + TSMG*

<a id="tbl-0682"></a>

#### 0682 — Device Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0685"></a>

#### 0685 — Item Code - External (RQD-3)
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-heading-styles` — Two table headings are styled `Normal` instead of `Heading 3` — *V2 Management*

<a id="tbl-0702"></a>

#### 0702 — Cycle Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (47).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 32 |
| Comments-as-published kept from THO | 15 |

<a id="tbl-0717"></a>

#### 0717 — Access Restriction Value
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 65 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.definition` | `PersLDS` | Personal policy on collection, access, use, or disclosure of information in a limited data set by the information subject. | Personal policy personal policy on collection, access, use, or disclosure of information in a limited data set by the information subject. | 4 other tables |

**Written differently, saying the same thing (65).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `42CFRPart2` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `42CFRPart2CD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `COMMONRULE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CompoundResearchCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `EMRGONLY` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRCONSENT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRCONTRACT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRHLTHSOCSY` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRLEGALCLAIM` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRLEGALOBL` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRLEGITINTEREST` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRPUBLICHEALTH` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRPUBLICINTEREST` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRRESEARCH` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRResearchCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GDPRVITALINTEREST` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `GRANTORCHOICE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAAuth` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAAuthCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAConsent` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAConsentCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `HIPAANOPP` | …-vol1-sec164-506.pdf, which is considered the “norm”, assign the HL7 Confidentiality code “N” (normal). | …-vol1-sec164-506.pdf , which is considered the “norm”, assign the HL7 Confidentiality code “N” (normal). | Same text; only spacing differs. |
| `concept.property` (status) | `HIPAANOPP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `HIPAAPsyNotes` | …-vol1-sec164-506.pdf, use “HIPAAPsyNotes” as the security label policy code. Since information governed by a HIPAA 45 CFR 164.508 (2) has a level of… | …-vol1-sec164-506.pdf , use “HIPAAPsyNotes” as the security label policy code. Since information governed by a HIPAA 45 CFR 164.508 (2) has a level of… | Same text; only spacing differs. |
| `concept.property` (status) | `HIPAAPsyNotes` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAROA` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAROACD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAAResearchAuthCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `HIPAASelfPay` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `IMPLIED` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `IMPLIEDD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisCUI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisDEID` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisIP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisLDS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisNSI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisPI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisSP-CUI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `JurisUUI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `MDHHS-5515` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `NOCONSENT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (v2-concComment) | `NOPP` | Map: An “implied” consent directive maps to ISO/TS 17975:2015(E) definition for “Implied: Consent to Collect, Use and Disclose personal health inform… | Map - An “implied” consent directive maps to ISO/TS 17975:2015(E) definition for “Implied: Consent to Collect, Use and Disclose personal health infor… | Same words in the same order; only punctuation differs. |
| `concept.property` (status) | `NOPP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OIC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OIS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OOC` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OOS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OPTIN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OPTINR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OPTOUT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OPTOUTE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgCUI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgDEID` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgIP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgLDS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgNSI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgPI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgSP-CUI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OrgUUI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PersIP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PersLDS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PersNSI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PersPI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `Title38Section7332` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (13).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 13 |

<a id="tbl-0719"></a>

#### 0719 — Access Restriction Reason Code
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item · OID conflict with THO</p>

*Route: retired on a ruling, superseded.*

- Value set **4.0.0** — Changed: compose.include, description.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `description` | — | **This value set has been retired. The correct value set to use is [v3-ActInformationSensitivityPolicy](http://terminology.hl7.org/ValueSet/v3-ActInf… | Value Set of codes that specify the reason for the restricted access. Sensitivity codes are not useful for interoperability outside of a policy domai… | 2 other tables |
| Disagreement | `identifier` | — | 2.16.840.1.113883.1.11.20429 | 2.16.840.1.113883.1.11.20428 | 1 other table |

**Open issues.**

- `esc-oid-conflicts` — Three artifacts where one OID would end up naming two things, which versioning cannot reconcile — *V2 Management + TSMG*
- `esc-tho-descriptions-say-more` — Two THO descriptions carry text the chapter's do not, including THO documenting its own error — *V2 Management + TSMG*

**Answered by a committee.**

- `esc-0719-superseded-by-v3` — Table 0719's value set is superseded by a v3 one, and this guide was republishing it as active — *V2 Management, 2026-10-15*<br/><span class="tl-note">The correct value set is `v3-ActInformationSensitivityPolicy`. The v2 value set stays retired, and the only thing to do with it is update its text to point at the v3 one.</span>

**Identifiers.**

- **The chapter and THO give different OIDs for this ValueSet.** The chapter says `2.16.840.1.113883.1.11.20429`; THO says `2.16.840.1.113883.1.11.20428`, and THO's is what this guide publishes, because the canonical is THO's and an identifier is identity rather than content. Registered as `esc-oid-conflicts`.
- Chapter 2C also gives the table itself the OID `2.16.840.1.113883.12.719`, which this guide publishes nowhere.

<a id="tbl-0725"></a>

#### 0725 — Mood Codes
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: value set only.*

- Value set **4.0.0** — Changed: compose.include.

**Differences from THO (9).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `APT` | Appointment | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `ARQ` | Appointment Request | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `EVN` | Event | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `EVN.CRT` | Event Criterion | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `INT` | Intent | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `PRMS` | Promise | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `PRP` | Proposal | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `RQO` | Request-Order | — | 6 other tables |
| Added here | `compose.include.concept` | `EXP` | Expectation | nothing | only here |

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Value set members kept from THO | 1 |

**Open issues.**

- `esc-0725-missing-uri` — Table 0725 _Mood Codes_ omits the URI of the v3 code system it draws from — *V2 Management*

<a id="tbl-0728"></a>

#### 0728 — CCL Value

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0731"></a>

#### 0731 — DRG Diagnosis Determination Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0734"></a>

#### 0734 — Grouper Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 10 |

<a id="tbl-0739"></a>

#### 0739 — DRG Status Patient

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0742"></a>

#### 0742 — DRG Status Financial Calculation

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (7).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |

<a id="tbl-0749"></a>

#### 0749 — DRG Grouping Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0755"></a>

#### 0755 — Status Weight At Birth

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0757"></a>

#### 0757 — DRG Status Respiration Minutes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0759"></a>

#### 0759 — Status Admission

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0761"></a>

#### 0761 — DRG Procedure Determination Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0763"></a>

#### 0763 — DRG Procedure Relevance

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0767"></a>

#### 0767 — Bolus Dose Amount Units (RXV-4)
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-heading-styles` — Two table headings are styled `Normal` instead of `Heading 3` — *V2 Management*

<a id="tbl-0776"></a>

#### 0776 — Item Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 3 |

<a id="tbl-0778"></a>

#### 0778 — Item Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |

<a id="tbl-0790"></a>

#### 0790 — Approving Regulatory Agency

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0793"></a>

#### 0793 — Ruling Act

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |

<a id="tbl-0806"></a>

#### 0806 — Sterilization Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0818"></a>

#### 0818 — Package

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0820"></a>

#### 0820 — Gender Harmony Concepts
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

**Open issues.**

- `esc-full-name-copy-paste` — The copy-pasted Full Name is not confined to the UCUM tables — *V2 Management* <span class="tl-note">(the register lists this table as an example; its list is not exhaustive)</span>

**Answered by a committee.**

- `esc-0820-gender-harmony-canonical` — Table 0820's value set is real content, published at a canonical built from the table number — *V2 Management, 2026-11-05*<br/><span class="tl-note">Create the value set, with no code system, since the codes are LOINC's. Publish it at `http://terminology.hl7.org/ValueSet/gender-harmony-attributes` and carry Chapter 2C's value set OID `2.16.840.1.113883.21.480` on it.</span>

<a id="tbl-0821"></a>

#### 0821 — Gender Identity
{: .tl-hd .tl-hd-attention}

<p class="tl-why tl-why-attention">Needs special consideration · Open register item</p>

*Route: withheld on a ruling.*

**Open issues.**

- `esc-0821-blank-grid` — Table 0821 _Gender Identity_ publishes its coded content grid completely blank — *V2 Management*

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0822"></a>

#### 0822 — Personal Pronouns
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0823"></a>

#### 0823 — Sexual Orientation
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

**Open issues.**

- `esc-0823-not-in-tho` — Table 0823 _Sexual Orientation_ draws on three code systems and has no value set in THO — *V2 Management + TSMG*

**Answered by a committee.**

- `esc-0823-multi-system-compose` — Table 0823's value set draws on three code systems, and the chapter says which code comes from which — *V2 Management, 2026-11-05*<br/><span class="tl-note">The content logical definition correctly pulls codes from three code systems and this is fine. A value set is not restricted to one code system.</span>

<a id="tbl-0824"></a>

#### 0824 — Recorded Sex or Gender Type
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0827"></a>

#### 0827 — Source Document Jurisdiction for Recorded Sex or  Gender
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0828"></a>

#### 0828 — Sex Parameter for Clinical Use
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0834"></a>

#### 0834 — MIME Types
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **4.0.0** — Changed: compose.include.

**Differences from THO (7).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `application` | Application data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `audio` | Audio data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `image` | Image data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `model` | Model data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `multipart` | MIME multipart package | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `text` | Text data | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `video` | Video data | — | 6 other tables |

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0868"></a>

#### 0868 — Telecommunication Expiration Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Comments-as-published kept from THO | 5 |

<a id="tbl-0871"></a>

#### 0871 — Supply Risk Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 7 |
| Comments-as-published kept from THO | 7 |

<a id="tbl-0881"></a>

#### 0881 — Role Executing Physician

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0882"></a>

#### 0882 — Medical Role Executing Physician

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0894"></a>

#### 0894 — Side of body

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0895"></a>

#### 0895 — Present On Admission (POA) Indicator
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **4.0.0** — Changed: compose.include.

**Answered by a committee.**

- `esc-0895-wrong-system-url` — THO's ValueSet/v2-0895 composes over the wrong code system URL, and THO's own records say so — *V2 Management, 2026-10-15*<br/><span class="tl-note">THO's value set is wrong about the system URL. The correct one is the CMS coding page, which the external code systems page carries with the v2 code system URL as an additional identifier and the same OID as Chapter 2C. This IG fixes the THO artifact. No CodeSystem is created, because THO's record is already correct.</span>
- `esc-tho-dangling-value-sets` — Withdrawn — the “dangling” value sets are not dangling — *V2 Management, 2026-10-14*<br/><span class="tl-note">The current content logical definitions are right. THO does publish the URIs of these external code systems as `http://terminology.hl7.org/CodeSystem/v2-0350` and `…/v2-0351`, per its external code systems page.</span>

<a id="tbl-0904"></a>

#### 0904 — Security Check Scheme

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0905"></a>

#### 0905 — Shipment Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (6).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |

<a id="tbl-0906"></a>

#### 0906 — ActPriority
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `S` | Stat - With highest priority (e.g., emergency). | Stat - With highest priority (e.g. emergency). | Same words in the same order; only punctuation differs. |
| `concept.display` | `T` | Timing critical - It is critical to come as close as possible to the requested time (e.g., for a through antimicrobial level). | Timing critical - It is critical to come as close as possible to the requested time (e.g. for a through antimicrobial level). | Same words in the same order; only punctuation differs. |

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 14 |

<a id="tbl-0907"></a>

#### 0907 — Confidentiality
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.display` | `R` | Restricted - Restricted access, e.g., only to providers having a current care relationship to the patient. | Restricted - Restricted access, e.g. only to providers having a current care relationship to the patient. | Same words in the same order; only punctuation differs. |

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 12 |

<a id="tbl-0909"></a>

#### 0909 — Patient Results Release Categorization Scheme
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (8).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.display` | `SID` | Share In1 Day - Share result regardless of reference/therapeutic range after 1 or more business day as agreed to by the systems in play. | Share In1 Day -<p>Share result regardless of reference/therapeutic range after 1 or more business day as agreed to by the systems in play. | 14 other tables |
| Disagreement | `concept.display` | `SIDC` | Share in 1 Day Conditionally - Share result in reference ranges/therapeutic with patient after 1 or more business day as agreed to by the systems in… | Share in 1 Day Conditionally -<p>Share result in reference ranges/therapeutic with patient after 1 or more business day as agreed to by the systems i… | 14 other tables |
| Disagreement | `concept.display` | `SIMM` | Share Immediately - Share result with patient immediately | Share Immediately -<p>Share result with patient immediately | 14 other tables |
| Disagreement | `concept.display` | `STBD` | Share To Be Determined - Category to be determined | Share To Be Determined -<p>Category to be determined | 14 other tables |
| Disagreement | `concept.display` | `SWNL` | Share Within Normal Limits - Share result in reference/therapeutic range with patient immediately Share result out of reference/therapeutic ranges wi… | Share Within Normal Limits -<p>Share result in reference/therapeutic range with patient immediately<p>Share result out of reference/therapeutic range… | 14 other tables |
| Disagreement | `concept.display` | `SWTH` | Share Withhold - Withhold result regardless of reference/therapeutic ranges | Share Withhold -<p>Withhold result regardless of reference/therapeutic ranges | 14 other tables |
| Disagreement | `concept.property` (v2-concComment) | `SIDC` | 1 day Withhold | 1 day<p>Withhold | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `SWNL` | immediate 1 day | immediate<p>1 day | 22 other tables |

**Kept from THO (12).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Comments-as-published kept from THO | 6 |

<a id="tbl-0910"></a>

#### 0910 — Acquisition Modality
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-placeholder-metadata` — Two tables publish literal placeholder text — `noObject` and `noDescription` — *V2 Management*

<a id="tbl-0912"></a>

#### 0912 — Participation
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (3).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 16 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `PPH` | …d medication orders. Usage Note: Most likely to be used in ADT messages for outpatient care. | …d medication orders. | 22 other tables |
| Added here | `concept.property` (v2-concComment) | `VPS` | Usage Note: Use of this code is deprecated; depending on the role of the person use either PH or VP. | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `VTS` | Usage Note: Use of this code is deprecated; depending on the role of the person use either PH or VP. | nothing | 8 other tables |

**Written differently, saying the same thing (16).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `AHP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `APO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CLPO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `DIE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `EARI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ED` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `EO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `EPRI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `FL` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OF` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OPO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PPH` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `RHP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `RIE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `RPO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TL` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (48).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 29 |
| Comments-as-published kept from THO | 16 |
| Usage notes kept from THO | 3 |

<a id="tbl-0914"></a>

#### 0914 — Root Cause
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (5).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `AP` | …trumentation failure Usage Note: Enter (AP) when ANALYSIS PROCESS is the reason due to: • Product or supply failure (reagents, calibrators, QC materi… | …trumentation failure | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `IM` | …test results • Other Usage Note: Enter (IM) when INFORMATION MANAGEMENT is the reason due to: • Database or Programming issues • Overriding of test r… | …test results • Other | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `L` | Enter (L) when LABORATORY is the reason due to: • Data Entry error • Testing/Technical error • Repeat testing causing change to test result Usage Not… | Enter (L) when LABORATORY is the reason due to:<p>• Data Entry error<p>• Testing/Technical error<p>• Repeat testing causing change to test result | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `NA` | …orrection (revision) Usage Note: Enter (NA) when NOT-APPLICABLE is the reason due to: • If no revisions performed or • unable to determine reason for… | …orrection (revision) | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `PD` | …ng order entry (i.e., Previous Biopsy Date, Clinical Information, Source, etc...) Usage Note: Enter (PD) when new or changed PLACER DATA information… | …ng order entry (i.e. Previous Biopsy Date, Clinical Information, Source, etc...) | 22 other tables |

**Kept from THO (15).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 5 |
| Comments-as-published kept from THO | 5 |
| Usage notes kept from THO | 5 |

<a id="tbl-0916"></a>

#### 0916 — Relevant Clinicial Information
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: purpose.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `purpose` | — | Underlying Master Code System for V2 table 0916 (Relevant Clinicial Information) | Underlying Master Code System for V2 table 0916 (Relevant Clincial Information) | 2 other tables |

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |
| Deprecation markers kept from THO | 1 |

**Open issues.**

- `esc-deprecation-flag-contradicts-status` — 191 concepts say they are active and deprecated as of 2.9 at the same time — *V2 Management*

<a id="tbl-0917"></a>

#### 0917 — Bolus Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |

<a id="tbl-0918"></a>

#### 0918 — PCA Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0919"></a>

#### 0919 — Exclusive Test

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0920"></a>

#### 0920 — Preferred Specimen/Attribute Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0921"></a>

#### 0921 — Certification Type Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0922"></a>

#### 0922 — Certification Category Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0923"></a>

#### 0923 — Process Interruption

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0924"></a>

#### 0924 — Cumulative Dosage Limit UoM

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (8).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 6 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0925"></a>

#### 0925 — Phlebotomy Issue

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 13 |
| Translations kept from THO | 1 |

<a id="tbl-0926"></a>

#### 0926 — Phlebotomy Status

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0927"></a>

#### 0927 — Arm Stick

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |

<a id="tbl-0929"></a>

#### 0929 — Weight Units
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: value set only.*

- Value set **4.0.0** — Changed: compose.include.

**Differences from THO (4).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `[lb_av]` | Pound | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `[oz_av]` | Ounce | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `g` | Gram | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `kg` | Kilogram | — | 6 other tables |

**Open issues.**

- `esc-0929-0930-enumerated-subset` — Do the UCUM weight and volume value sets mean the handful of codes they list, or the UCUM units for the quantity? — *V2 Management*
- `esc-cld-inconsistent` — “All codes” is used where a value set enumerates a handful of UCUM codes — *V2 Management*
- `esc-duplicate-tables` — Two pairs of tables are duplicates of each other — *V2 Management*
- `esc-ucum-full-name` — All six UCUM-backed tables name the code system “Donation Duration Units Code System” — *V2 Management*

**Answered by a committee.**

- `esc-0567-0568-representation` — Deprecating a V2 value set in THO has no established representation, and would be a first — *V2 Management, 2026-09-23*<br/><span class="tl-note">Both halves are settled, and neither lands on this IG. The 0567/0568 retirement goes to THO as a separate Jira ticket, so no deprecation needs representing here. For table 0005, the value set stays and the code system is correctly retired already; this IG will not link the value set and should not inform any change to it.</span>

<a id="tbl-0930"></a>

#### 0930 — Volume Units
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Changed: compose.include.

**Differences from THO (3).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `compose.include.concept.display` | `[pt_us]` | Pint | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `l` | Liter | — | 6 other tables |
| Disagreement | `compose.include.concept.display` | `ml` | Milliliters | — | 6 other tables |

**Open issues.**

- `esc-0929-0930-enumerated-subset` — Do the UCUM weight and volume value sets mean the handful of codes they list, or the UCUM units for the quantity? — *V2 Management*
- `esc-cld-inconsistent` — “All codes” is used where a value set enumerates a handful of UCUM codes — *V2 Management*
- `esc-duplicate-tables` — Two pairs of tables are duplicates of each other — *V2 Management*
- `esc-ucum-full-name` — All six UCUM-backed tables name the code system “Donation Duration Units Code System” — *V2 Management*

**Answered by a committee.**

- `esc-0567-0568-representation` — Deprecating a V2 value set in THO has no established representation, and would be a first — *V2 Management, 2026-09-23*<br/><span class="tl-note">Both halves are settled, and neither lands on this IG. The 0567/0568 retirement goes to THO as a separate Jira ticket, so no deprecation needs representing here. For table 0005, the value set stays and the code system is correctly retired already; this IG will not link the value set and should not inform any change to it.</span>

<a id="tbl-0931"></a>

#### 0931 — Temperature Units
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Changed: compose.include.

**Open issues.**

- `esc-0931-temperature` — Table 0931 _Temperature Units_ publishes three codes, two of which are the same unit, and one of which is invalid — *V2 Management*
- `esc-cld-inconsistent` — “All codes” is used where a value set enumerates a handful of UCUM codes — *V2 Management*
- `esc-ucum-full-name` — All six UCUM-backed tables name the code system “Donation Duration Units Code System” — *V2 Management*

<a id="tbl-0932"></a>

#### 0932 — Donation Duration Units
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Changed: compose.include.

**Open issues.**

- `esc-cld-inconsistent` — “All codes” is used where a value set enumerates a handful of UCUM codes — *V2 Management*
- `esc-ucum-full-name` — All six UCUM-backed tables name the code system “Donation Duration Units Code System” — *V2 Management*

<a id="tbl-0933"></a>

#### 0933 — Intended Procedure Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (14).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 13 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0935"></a>

#### 0935 — Process Interruption Reason

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (10).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 9 |
| Comments-as-published kept from THO | 1 |

<a id="tbl-0936"></a>

#### 0936 — Observation Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (5).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 3 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0937"></a>

#### 0937 — Observation Sub-Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (5).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `MCS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `MID` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `MIG` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `MIN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `MOD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (16).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 8 |
| Comments-as-published kept from THO | 8 |

<a id="tbl-0938"></a>

#### 0938 — Collection Event/Process Step Limit
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (1).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (v2-concComment) | `DRW` | When the specimen is collected (e.g., fasting status) | When the specimen is collected (e.g. fasting status) | Same words in the same order; only punctuation differs. |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 2 |
| Comments-as-published kept from THO | 2 |

<a id="tbl-0939"></a>

#### 0939 — Communication Location

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (37).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 21 |
| Comments-as-published kept from THO | 16 |

<a id="tbl-0940"></a>

#### 0940 — Limitation Type Codes

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 4 |

<a id="tbl-0942"></a>

#### 0942 — Equipment State Indicator Type Code

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Kept from THO (3).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Concept definitions kept from THO | 1 |
| Resource names kept from THO | 1 |
| Resource titles kept from THO | 1 |

<a id="tbl-0945"></a>

#### 0945 — Auto-Dilution Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (4).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept.property` (v2-concComment) | `D1` | Usage Note: corresponds to ^1^:^1.23 in TCD-2 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `D2` | Usage Note: corresponds to ^1^:^1.45 in TCD-2 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `X2` | Usage Note: corresponds to ^1^:^2 in TCD-2 | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `X5` | Usage Note: corresponds to ^1^:^5 in TCD-2 | nothing | 8 other tables |

**Kept from THO (4).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Usage notes kept from THO | 4 |

<a id="tbl-0946"></a>

#### 0946 — Supplier Type

*Route: code system + value set.*

- Code system **3.0.0** — Nothing the policy counts as a change, so THO's version stands.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

Nothing to report: what this guide publishes matches THO on every element compared.

<a id="tbl-0948"></a>

#### 0948 — Relationship Type
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (9).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `CAUS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `COMP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CONCR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `EVID` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `INTF` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `LIMIT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SUCCD` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SVTGT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TRIG` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

<a id="tbl-0949"></a>

#### 0949 — Order Control Code Reason
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 4 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `ST` | Order placer may accept, cancel and replace, or choose other testing. Usage Note: Recommend testing that can use the submitted specimen type | Order placer may accept, cancel and replace, or choose other testing. | 22 other tables |
| Disagreement | `concept.property` (v2-concComment) | `SV` | …ent subset of tests. Usage Note: Recommend a subset of ordered tests appropriate for volume | …ent subset of tests. | 22 other tables |

**Written differently, saying the same thing (4).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `CO` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `ST` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SV` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `UN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (2).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Usage notes kept from THO | 2 |

<a id="tbl-0950"></a>

#### 0950 — Order Status Modifier
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (1).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 2 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `concept.property` (v2-concComment) | `EOT` | …cessing will resume. Usage Note: Filler Applications: In an order replacement setting, sent in recommendation for order replacement message (OML), wh… | …cessing will resume. | 22 other tables |

**Written differently, saying the same thing (2).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `EOE` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `EOT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Usage notes kept from THO | 1 |

<a id="tbl-0951"></a>

#### 0951 — Reason for Study
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Differences from THO (11).** Everything this guide publishes at THO's canonical that THO does not say, or says differently. A further 12 differ only in how the same content is written; those are listed separately below.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Added here | `concept.property` (v2-concComment) | `CR` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `IN` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `IR` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `IT` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `OP` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `PI` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SI` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `SP` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TP` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `TT` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |
| Added here | `concept.property` (v2-concComment) | `XR` | Usage Note: Used to indicate why review is requested | nothing | 8 other tables |

**Written differently, saying the same thing (12).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `BS` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `CR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `FP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `IN` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `IR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `IT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `OP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `PI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `SI` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TP` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `TT` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `XR` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (11).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Usage notes kept from THO | 11 |

<a id="tbl-0952"></a>

#### 0952 — Confidentiality Classification
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: retired on a ruling, superseded.*

- Value set **4.0.0** — Changed: description, status.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `description` | — | **This value set has been retired. The correct value set to use is [v3-Confidentiality](http://terminology.hl7.org/ValueSet/v3-Confidentiality).** Co… | Concepts drawn from the HL7 V3 Confidentiality code system . Used in Version 2 messaging in the Security Classification elements in the Message Heade… | 2 other tables |
| Disagreement | `status` | — | retired | active | 1 other table |

**Open issues.**

- `esc-tho-definition-differences` — Five concept domain definitions differ between Chapter 2C and THO — *V2 Management + TSMG*

**Answered by a committee.**

- `esc-0952-0959-superseded-by-v3` — Tables 0952 and 0959 duplicate v3 value sets that already exist, and their OIDs say so — *V2 Management, 2026-10-15*<br/><span class="tl-note">The v3 URI for the code system is correct and the v3 resource should be used for the value set too. The v2 value sets have to be kept, because they already exist in THO, but they are to be retired with a note at the top of the description naming the correct v3 value set and linking to it — a link that will keep resolving in future versions of THO, so not a version-specific one.</span>

<a id="tbl-0953"></a>

#### 0953 — Security Label Handling Instructions
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-served-by-existing-tho-value-sets` — Seven tables are already served by a value set THO publishes, and this guide was about to write a second one — *V2 Management, 2026-11-05*<br/><span class="tl-note">For each of these tables the correct value set already exists in THO and should be used. No new value set and no code system is to be created. There is nothing this guide is using them _instead of_, so nothing needs to be retired or pointed away from — the artifacts simply are not written.</span>

<a id="tbl-0954"></a>

#### 0954 — Work Schedule ODH
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Open issues.**

- `esc-0954-cld-exclude` — Table 0954's logical definition would include an abstract concept THO's equivalent excludes — *V2 Management + TSMG*

**Answered by a committee.**

- `esc-0954-0957-duplicate-of-v3` — Tables 0954 and 0957 would have duplicated value sets THO already publishes — *V2 Management, 2026-10-15*<br/><span class="tl-note">This guide should not create value sets for 0954 or 0957. Correct value sets already exist in THO — `v3-WorkScheduleODH` and `v3-employmentStatusODH` — and those are the ones to use.</span>

<a id="tbl-0955"></a>

#### 0955 — Industry

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

Nothing to report: what this guide publishes matches THO on every element compared.

<a id="tbl-0956"></a>

#### 0956 — Job Supervisory Level or Pay Grade
{: .tl-hd .tl-hd-decision}

<p class="tl-why tl-why-decision">Blocked on a decision · Open register item</p>

*Route: blocked on a decision.*

> **This table is blocked on a decision, so this guide publishes no code system and no value set for it.** The Content Logical Definition is not one of the shapes this guide builds — all codes, enumerated per table content, or an is-a filter: 'unspecified'.
>
> Whatever THO already publishes at these canonicals stands untouched in the meantime.
{: .tl-callout}

**Open issues.**

- `esc-0956-no-stable-home` — Table 0956's value set exists only in a withdrawn FHIR draft and a code repository being decommissioned — *V2 Management + TSMG*

<a id="tbl-0957"></a>

#### 0957 — Employment Status (ODH)
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Open issues.**

- `esc-0954-cld-exclude` — Table 0954's logical definition would include an abstract concept THO's equivalent excludes — *V2 Management + TSMG*

**Answered by a committee.**

- `esc-0954-0957-duplicate-of-v3` — Tables 0954 and 0957 would have duplicated value sets THO already publishes — *V2 Management, 2026-10-15*<br/><span class="tl-note">This guide should not create value sets for 0954 or 0957. Correct value sets already exist in THO — `v3-WorkScheduleODH` and `v3-employmentStatusODH` — and those are the ones to use.</span>

<a id="tbl-0958"></a>

#### 0958 — Occupation

*Route: value set only.*

- Value set **1.0.0** — THO publishes no such artifact, so this is a first publication.

Nothing to report: what this guide publishes matches THO on every element compared.

<a id="tbl-0959"></a>

#### 0959 — Work Classification ODH
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Route: retired on a ruling, superseded.*

- Value set **4.0.0** — Changed: description, status.

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Disagreement | `description` | — | **This value set has been retired. The correct value set to use is [v3-WorkClassificationODH](http://terminology.hl7.org/ValueSet/v3-WorkClassificati… | A person’s employment type as defined by compensation and sector (e.g. paid vs. unpaid, self-employed vs. not self-employed, government vs. private,… | 2 other tables |
| Disagreement | `status` | — | retired | active | 1 other table |

**Answered by a committee.**

- `esc-0952-0959-superseded-by-v3` — Tables 0952 and 0959 duplicate v3 value sets that already exist, and their OIDs say so — *V2 Management, 2026-10-15*<br/><span class="tl-note">The v3 URI for the code system is correct and the v3 resource should be used for the value set too. The v2 value sets have to be kept, because they already exist in THO, but they are to be retired with a note at the top of the description naming the correct v3 value set and linking to it — a link that will keep resolving in future versions of THO, so not a version-specific one.</span>

<a id="tbl-0960"></a>

#### 0960 — Data Absent Reason
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: withheld on a ruling.*

**Answered by a committee.**

- `esc-0960-duplicate-of-fhir-core` — Table 0960 would have duplicated the FHIR core data-absent-reason value set — *V2 Management, 2026-10-15*<br/><span class="tl-note">This guide should not create a value set for 0960. Chapter 2C says the correct value set is FHIR core's `data-absent-reason`, and that is correct.</span>

<a id="tbl-0961"></a>

#### 0961 — Device Type

*Route: value set only.*

- Value set **3.0.0** — Changed: compose.include.

Nothing to report: what this guide publishes matches THO on every element compared.

<a id="tbl-0962"></a>

#### 0962 — Device Status
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: value set only.*

- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Open issues.**

- `esc-0962-already-in-tho` — Table 0962 resolved itself when a cached package appeared, which is a reproducibility problem rather than a ruling — *V2 Management*

<a id="tbl-0963"></a>

#### 0963 — Device Safety
{: .tl-hd .tl-hd-decision}

<p class="tl-why tl-why-decision">Blocked on a decision</p>

*Route: blocked on a decision.*

> **This table is blocked on a decision, so this guide publishes no code system and no value set for it.** The Content Logical Definition is not one of the shapes this guide builds — all codes, enumerated per table content, or an is-a filter: 'See content logical definition of the referenced value set'.
>
> Whatever THO already publishes at these canonicals stands untouched in the meantime.
{: .tl-callout}

<a id="tbl-0967"></a>

#### 0967 — Container Form
{: .tl-hd .tl-hd-issue}

<p class="tl-why tl-why-issue">Open register item</p>

*Route: concept domain only.*

**Open issues.**

- `esc-tho-definition-differences` — Five concept domain definitions differ between Chapter 2C and THO — *V2 Management + TSMG*

<a id="tbl-0970"></a>

#### 0970 — Online Verification Result
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (3).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `1` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `2` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `3` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

<a id="tbl-0971"></a>

#### 0971 — Online Verification Result Error Code
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Route: code system + value set.*

- Code system **4.0.0** — Changed: concept.
- Value set **3.0.0** — Nothing the policy counts as a change, so THO's version stands.

**Written differently, saying the same thing (4).** The two sides style the same content differently, or THO carries a V2 status letter where this guide carries the FHIR status it maps to. **Nothing here needs a decision.** Each still counts as a change for versioning, and each is listed so that nothing is hidden.

| Element | Code | This guide publishes | THO has | Why it is not a disagreement |
|---|---|---|---|---|
| `concept.property` (status) | `1` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `2` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `3` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |
| `concept.property` (status) | `4` | active | N | THO carries the V2 status letter; this guide publishes the FHIR status it maps to. The mapping is settled. |

**Kept from THO (1).** Content THO publishes that Chapter 2C says nothing about. None of it changes the artifact relative to THO, so none of it costs a version increment.

| What | Count |
|---|---:|
| Resource descriptions kept from THO | 1 |

### Canonicals with no Chapter 2C table

18 numbers where THO publishes a `v2-NNNN` code system or value set and **Chapter 2C has no section at all**. They are not among the chapter's 798 tables, so they are not counted with them, but they are here because a reviewer asking "what about `v2-0012`?" deserves an answer. This guide publishes nothing at these canonicals and THO's artifacts stand untouched.

<a id="tbl-0012"></a>

#### 0012
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0012 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0012 | 23 other tables |

<a id="tbl-0033"></a>

#### 0033
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0033 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0033 | 23 other tables |

<a id="tbl-0034"></a>

#### 0034
{: .tl-hd .tl-hd-both}

<p class="tl-why tl-why-both">Differs from THO · Open register item</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0034 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0034 | 23 other tables |

**Open issues.**

- `esc-v2tables-siteadministered` — `v2-tables` misspells the concept domain for table 0034 as `SiteAdminstered` — *TSMG / UTG*

<a id="tbl-0048"></a>

#### 0048
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0048 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0048 | 23 other tables |

<a id="tbl-0070"></a>

#### 0070
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0070 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0070 | 23 other tables |

<a id="tbl-0102"></a>

#### 0102
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0102 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0102 | 23 other tables |

<a id="tbl-0106"></a>

#### 0106
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0106 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0106 | 23 other tables |

<a id="tbl-0107"></a>

#### 0107
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0107 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0107 | 23 other tables |

<a id="tbl-0108"></a>

#### 0108
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0108 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0108 | 23 other tables |

<a id="tbl-0109"></a>

#### 0109
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0109 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0109 | 23 other tables |

<a id="tbl-0156"></a>

#### 0156
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0156 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0156 | 23 other tables |

<a id="tbl-0157"></a>

#### 0157
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0157 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0157 | 23 other tables |

<a id="tbl-0158"></a>

#### 0158
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0158 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0158 | 23 other tables |

<a id="tbl-0290"></a>

#### 0290
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0290 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0290 | 23 other tables |

<a id="tbl-0323"></a>

#### 0323
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0323 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0323 | 23 other tables |

<a id="tbl-0524"></a>

#### 0524
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0524 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0524 | 23 other tables |

<a id="tbl-0529"></a>

#### 0529
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-0529 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-0529 | 23 other tables |

<a id="tbl-4000"></a>

#### 4000
{: .tl-hd .tl-hd-diff}

<p class="tl-why tl-why-diff">Differs from THO</p>

*Not a Chapter 2C table — the chapter has no section for this number.*

**Differences from THO (2).** Everything this guide publishes at THO's canonical that THO does not say, or says differently.

| Difference | Element | Code | This guide publishes | THO has | Also affects |
|---|---|---|---|---|---|
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/CodeSystem/v2-4000 | 23 other tables |
| Not published | `resource` | — | nothing<br/><span class="tl-note">The chapter has no section for it.</span> | http://terminology.hl7.org/ValueSet/v2-4000 | 23 other tables |

### The remaining tables

The remaining 344 of the chapter's 798 tables — 454 above and 344 here. This guide authors no code system and no value set for any of them, so the merge had nothing to compare. Most are concept domains, which carry no codes. Their route and their concept domain are on the [table index](table-index.html).

`0018` `0019` `0021` `0022` `0023` `0024` `0032` `0042` `0043` `0044` `0045` `0046` `0049` `0050` `0051` `0055` `0056` `0059` `0064` `0068` `0072` `0073` `0084` `0086` `0087` `0088` `0099` `0110` `0111` `0112` `0113` `0114` `0115` `0117` `0118` `0129` `0132` `0139` `0141` `0143` `0151` `0152` `0153` `0171` `0172` `0182` `0184` `0186` `0212` `0218` `0219` `0222` `0229` `0233` `0244` `0245` `0246` `0249` `0259` `0264` `0285` `0288` `0289` `0293` `0295` `0296` `0297` `0300` `0302` `0303` `0304` `0306` `0307` `0308` `0312` `0313` `0319` `0320` `0327` `0328` `0333` `0341` `0342` `0343` `0345` `0346` `0358` `0361` `0362` `0363` `0378` `0379` `0380` `0381` `0382` `0385` `0386` `0405` `0412` `0413` `0414` `0446` `0447` `0448` `0452` `0453` `0454` `0455` `0461` `0462` `0463` `0464` `0471` `0476` `0479` `0509` `0512` `0515` `0519` `0521` `0522` `0525` `0526` `0531` `0533` `0537` `0539` `0541` `0542` `0543` `0546` `0549` `0551` `0552` `0563` `0573` `0574` `0575` `0576` `0577` `0578` `0579` `0580` `0581` `0582` `0583` `0584` `0585` `0586` `0587` `0588` `0589` `0590` `0591` `0592` `0593` `0594` `0595` `0596` `0597` `0598` `0599` `0600` `0601` `0602` `0603` `0604` `0605` `0606` `0607` `0608` `0609` `0610` `0611` `0612` `0613` `0614` `0619` `0620` `0621` `0622` `0623` `0624` `0627` `0628` `0629` `0630` `0631` `0632` `0633` `0635` `0636` `0637` `0638` `0639` `0640` `0641` `0643` `0644` `0645` `0646` `0647` `0648` `0649` `0650` `0652` `0654` `0655` `0656` `0658` `0660` `0661` `0662` `0663` `0664` `0665` `0666` `0668` `0670` `0671` `0672` `0673` `0674` `0676` `0677` `0678` `0679` `0680` `0681` `0683` `0684` `0686` `0687` `0688` `0689` `0690` `0691` `0692` `0693` `0694` `0695` `0696` `0697` `0698` `0699` `0700` `0701` `0703` `0704` `0705` `0706` `0707` `0708` `0709` `0710` `0711` `0712` `0713` `0714` `0715` `0716` `0718` `0720` `0721` `0722` `0723` `0724` `0726` `0727` `0729` `0730` `0732` `0733` `0735` `0736` `0737` `0738` `0740` `0741` `0743` `0744` `0745` `0746` `0747` `0748` `0750` `0751` `0752` `0753` `0754` `0756` `0758` `0760` `0762` `0764` `0765` `0766` `0768` `0769` `0770` `0771` `0772` `0773` `0774` `0775` `0777` `0779` `0780` `0781` `0782` `0783` `0784` `0785` `0786` `0787` `0788` `0789` `0791` `0792` `0794` `0795` `0809` `0811` `0826` `0832` `0833` `0836` `0838` `0865` `0879` `0880` `0908` `0913` `0915` `0934` `0941` `0943` `0944` `0947` `0964` `0965` `0966` `0968` `0969`
