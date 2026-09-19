- I need to review flagged / shaded rows
  - 0005 - do CS and VS need to be deprecated / retired in THO?  If so, that is a later ticket and not part of this IG I think
  - 0010 - No idea what to do here
  - 0078 - Ch2c claims a VS canonical but it apparently does not exist in THO.  Is there a VS that matches the v3 canonical pattern instead?  If so, this is a technical correction and we just use the existing VS...or we go ahead and make another VS that has the same CLD, which might actually be preferable.
  - 0133 - Why does THO have CS and VS here???
  - 0188 No idea.  Ch2c seems to have dropped the ball here.
  - 0292 - This is PHINVADS (in practice).  Ch2c says concept domain only = yes but I think that is wrong.  This is external code system
  - 


This is a list of things I noted while reviewing the Vocab IG.  You may not be able to address all of these items in a single session.  Please review them and make a systematic plan for addressing each one of them such that they are addressed in a manner that properly groups them into issues that can reasonably be addressed within a single session with a context window cap of 350K tokens.

- Need links from table index rows to ledger pages.
- ugly chars rendering in condept domain column of table-index that appear between the two spans.  Also, why are we saying this guide and in THO -- that's confusing
<td>
  <a target="_blank" rel="noopener" href="CodeSystem-conceptdomains.html#conceptdomains-InventoryNumber">InventoryNumber</a> 
  <span class="ti-dest">
    ::before
    this guide
  </span> 
  <span class="ti-origin">
    ::before
    in THO
  </span>
</td>


- are that many tables in Ch2c really(!) concept-domain-only = yes??  this is surprising
- can we get rid of the v2-tables CS? It was never a "real" code system...
- can we add a column in the index table that indicates what kind of table it was typed as in Ch2c -- HL7, User, HL7 Ext, External, etc..
- regarding tho-merge.html section 5.1 and general questions #2, #3, and #4 -- confirmed that all changes are major version changes.  the comment in the policy was left in by error. revise accordingly and increment versions where appropriate.
- in provenance.html 
  - something is weird here causing the IG publisher to add the same section number to each section instead of properly structuring them.  Every section is simply given the number "2"
  - "definition is never back-filled from display. A concept with no definition in the chapter gets no definition here, and the resulting CODESYSTEM_CONCEPT_NO_DEFINITION warning is accepted. Inventing definitions would be the single easiest way to corrupt this load." -- Get rid of the last sentence.  This type of commentary is unwelcome in this IG.  Is CODESYSTEM_CONCEPT_NO_DEFINITION from the IG publisher or our code?  If it is from our code then strike this sentence as well.  Readers should not be concerned with our code.
  - "This rule decided several cases that looked contentious. Only two tables in the whole chapter (0411 and 0460) need a canonical minted that does not already exist; an earlier report claimed 18, which was an artifact of a crude test that only ever looked for a code system filed under the table's own number." -- clean this up to only state the current situation.  The historical stuff is irrelevant.  Apply this pattern throughout the IG, only focus on the current analysis, do not refer to past differences in conclusions from earlier analysis.
  - "The authority for everything in this guide is the published text of HL7 V2.9.1 Chapter 2C, extracted from the Word originals in v2plus_docx/. It is not a re-derivation from the existing V2+ FHIR resources, and not a copy of THO's current content." --> The authority for everything in this guide is the published text of HL7 V2.9.1 Chapter 2C, extracted from the Word originals. It is not a re-derivation from the existing V2+ FHIR resources, and not a copy of THO's current content.
    - and also, this isn't completely true.  Some content does come from THO where THO had populated values where Ch2c did not, e.g., display, designation, properties, etc.
    - BTW, we should probably review the properties that come from THO and make sure they aren't giving bogus info.
    - Also, I need to re-review what "N" means for status.  that just doesn't make sense.  In fact, we should be using the fhir CS for concept status -- make sure we are doing that and also see what the policy might be on removing properties.  What to do if a property is either totally unfit or superseded by a more proper property to use or when the value of a property is determined to be incorrect.
- table-ledger.html
  - "Also affects says whether a difference is a one-off or an instance of a class." --> Also affects says whether a difference is a one-off or an instance of a class of problem that is repeated elsewhere.
  - "Open issues — items from the V2 Management / TSMG register (v291-extracted/vocabulary-v2mgmt-items.md) that name this table."  -- we don't need to let anyone know that these issues once existed in a different document.  The IG will now be the vehicle where all of this stuff is reported and recorded.  Remove the parenthetical statement.
  - we have a list of all the tables that map to artifacts that need a second look.  Can we also shade the titles of those entries in the ledger so they are easily identified when scrolling down the page?
- general questions for v2mgmt
  - #5 per the meanings in Ch2c, I am proposing that all instances of status "N" be replaced with "active" -- this should not be controversial.  I am also recommedning that all instances of "B" be replaced with "retired" or "deprecated", though this may require case by case review by v2mgmt for each affected code.
  - #7 these are probably going to fall into the category of technical corrections
  - #8 we almost certainly need to keep the THO version.  Note that table 0719 may need to be retired in THO??
  - #9 the table oid could be captured in an extension on the CS and VS resources.  I don't think the OID belongs on either as an additional identifier
- Known issues page
  - do not reference the smoke test.  do not reference any historical crap like this.  that is information that only you and I need to know, not consumers of the IG.
  - this page also has the IG publisher section numbering problem.  All section numbers added by IG publisher are simply "7"
  - broken links associated with v3-related artifacts.  Why can't we just link to the artifact in THO for these?  We wouldn't be changing them anyway, would we?
  - Fourteen tables with nothing written - again, we need to nicely fold the vocabulary review report into the reporting of that this IG contains.  We want one product that has everything -- issues, changes, and the publication itself.
  - Defects reproduced from the published chapter on purpose
    - Table 821 just needs a whole lot of special consideration!! This needs to be stated clearly in the table ledger and the table index needs to somehow identify it as a table that needs attention if it doesn't already.  
    - "Page-URL defects and missing spaces in published descriptions."  - you lost me here, we need to highlight these because they may be correctable.  Technical corrections are acceptable as long as they don't change the semantics.  I should've given you the text from the hl7 confluence page that describes what is acceptable in terms of technical corrections for errata.  This isn't an errata but the same rules should apply because it sort of acts as an errata in spirit in the cases that we're considering making these types of corrections.
    - "Tables 0567 and 0568, which the chapter deprecates in prose while THO publishes both as live resources with no deprecation marker — and which print their replacement's canonical (v2-0929, v2-0930) as their own URI."  This is probably a case of Tables 0567 and 0568 needing actual CodeSystems and ValueSets that are deprecated or retired.  This is probably a technical question for TSMG people more than v2mgmt.  Please add to list of questions for TSMG.
    - 0350 and 0351 - why does THO publish VS here, especially where there is no CS that corresponds to the system in the CLD.  THO needs a fix here and whether that is part of this IG or not is debatable.
    - 

  
- did we migrate everything that was an issue from the existing standalone markdown file(s)?  I'm not seeing, e.g., any mention of the several (21?) CS descriptions that were truncated in Ch2c (ending mid-sentence).  Frank Oemig has not gotten back to me on this and I haven't had time to examine whatever copy of his database that I might have from my colleagues at NIST.  We need a review of all of the issues in those standalone docs (how many?) against the issues identified in the IG

- I think at one point we had a mapping of all of the fields in all of the docx tables in Ch2c to everywhere they might land in a FHIR resource (VS or CS).  Do we have that?  If not, we need it and we need to include that mapping as an additional page of information in the IG.  This is important.  For anything that does not cleanly map to a FHIR resource data element, we need to decide what gets mapped into properties, extensions and what doesn't.
  - We should be checking the existing THO artifacts against, e.g., steward listed for each table against the steward extension that should be in each THO CS.
  - verify that everything should map to an external code system has a corresponding VS that (if possible) uses the v2 table number in the canonical.  Indentify gaps
  
  
    