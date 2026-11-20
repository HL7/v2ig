Table 0005 - the valueset stays but it will not be linked in v2+. As such, this IG should not inform any changes to the 0005 valueset.  The CS is properly retired already.

The VS for 0567 and 0568 should not ever have been created.  We won't touch them but a separate Jira ticket to retire them will be filed.  This is a separate action from anything in this IG.  This IG will simply not do anything with these VS.  The CS in THO have already been retired and this is the correct action.

Table 10 just goes away and we will remove any terminology bindings to table 10 as we prepare v2+

0078 VS actually already exists, just has a different url: ValueSet-v3-ObservationInterpretation.  We will allow this VS to serve and not create a new one.  We will note this in the ledger.  This passes the fidelity to Ch2c in as much as we are simply not adding it rather than "doing something different"

0133 Manipulate markdown descript to make it jump out that this is a discontinued codesystem as of 2.6 and was replaced.  Also, does IG pub generally make it very visually clear when a CS or VS is retired??

0188 same situation as 0010

0350 and 0351 are NOT conceptdomain only.  The VS CLD points to the appropriate extenal CS (which should be in THO -- need to check).  So, the fix is to the CLDs in the ValueSets...

0411 should be conceptdomain only so no CS or VS

--- NEW --- 

NOT SURE - DO NOT IMPLEMENT - 0820 - Yes, create the VS and ensure that it correctly defines the CLD as just those three codes from LOINC.  Note that the Ch2c Full name for LOINC in the Code System Identification Information table for table 820 is just wrong, it says "Personal Pronoun Codes".  

0895 is similar to 350 and 351 with nubc codes.  THO does publish the external code systems with the URI that looks like it should resolve to a v2 code system (but obviously doesn't).  Double check that I'm correct here.

0954 - I don't see a problem here.  This looks okay to me.

0957 - There is already a valueset for this at htp://terminology.hl7.org/ValueSet-v3-employmentStatusODH.html. Why shouldn't we use that???

0960 - There is already a VS published at http://hl7.org/fhir/ValueSet/data-absent-reason and this is the correct VS for use with HL7 v2...I think.  It would be possible to publish a separate VS in THO but I don't know if anyone will think that is a good idea.  For now, assume that the FHIR VS is what we will use (and note as the correct VS in the ledger, etc.)

9999 - Ideally, we don't have to deal with this in this IG.  However, this may hinge on whether any fields in the v2 standard are bound to 9999.  I'd like to know that first...




399 is fine as is

458 use http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets and figure out if we can create a filter for CLD.  Make sure it doesn't expand.  Mary Kay McDaniels (check with)

459 - use same external CS for OCE codes (PDF from last time) -- create VS that points at the right place (or maybe need seperate resource)

467 also HCPCS, use existing Ch2c URL for new VS

821 - CLD correctly pulls codes from three CS -- this looks okay.  This VS can actually be expanded (I think, SNOMED is OK??) maybe check GH IG, also US Core

822 correct VS is https://build.fhir.org/ig/HL7/UTG/en/ValueSet-pronouns.html -- use that and move on

823 see 821

824 correct VS is https://terminology.hl7.org/en/ValueSet-recorded-sex-or-gender-type.html == use and go

827 - use https://terminology.hl7.org/en/ValueSet-jurisdiction.html

828 - use https://terminology.hl7.org/en/ValueSet-sex-parameter-for-clinical-use.html

953 - use htp://terminology.hl7.org/ValueSet-v3-SecurityControlObserva􀆟onValue.html

956 - https://www.hl7.org/fhir/2018May/valueset-supervisory-level-odh-us.html -- keep trying to figure this out


________________
decisions from November 20, 2026

- 0931 Temperature Units and 0932 Donation Duration Units: value sets widened to all of UCUM
If possible, we figure out how to create a usable filter in ValueSet.compose.include that expresses that we only want the relevant units.  If we can't do that we leave the error (i.e., all codes) as is and add this issue to the list of issues that we will address in follow-up Jira tickets.  BTW, I hope that that lists exists and is being well maintained!!

- 0347 State/Province: wrong code system and widened
The VS that is in THO now is wrong (very wrong) -- I made a separate ticket to retire this entire VS: https://jira.hl7.org/browse/UP-901.  This IG will create a new VS that includes the correct uri, a CLD that indicates all codes from ISO 3166-2, and has a new url that ends with ValueSet-v2-0347.html.  Note also that THO already has an external CS record for ISO 3166-2 and that we should use that as the system references in the VS CLD.

- 0725 Mood Codes: EXP is added, and it does not exist in v3-ActMood
The current VS in THO is correct as it stands.  We are going to leave it as is.  We are effectively jettisoning the EXP code.  If need be, we can consider the situation to be that this IG simply does not include any updates to table 0725.  The goal of this IG is to fix what we can fix.  If there are any outstanding problems that are intractable it is acceptable to simply leave those items out of this IG.  The requirement for this IG is that it is a best effort to represent as much of Ch2c as possible in THO.  It is not a requirement that every last detail in Ch2c be injected into THO, just that if we are changing something that is in THO, that change should be consistent with Ch2c.

- The date on the 8 value sets THO has never published is 2019-12-01
Do not change.  Keep the wrong date.  In the spectrum of problems that could cause real world problems, this is extrememly unlikely to impact interoperability or patient safety.

- 191 concepts are flagged deprecated in 2.9 but have status active
In general, if Ch2c says a concept is deprecated, then the status of the concept in the FHIR CS should be 'deprecated' as well.  This also means that the concepts are still active.  I want you to actually review all of these in Ch2c and if any of these codes look like they should actually be inactive, let me know.  I already know of one example -- table 0006 does not include the single letter coded concepts at all, which is an indication that these concepts should actually be inactive so they have the property that indicates that they are inactive with the value true.  In case you need the reference: https://hl7.org/fhir/codesystem-concept-properties.html.  Also, if we have concepts in v2 code systems that still use the 'deprecated' property, use of that property should be removed and replaced with the 'status' property carrying a value of 'deprecated'.  If any of this is unclear or you need guidance on any individual cases, you should ask me.

- 4 concepts carry status B, which is not a defined status value
The value 'B' may safely be interpretted as deprecated.  See the discussion for the previous issue.

- 15 value set descriptions stop mid-word
I am going to try once more to get Frank to see if the complete descriptions exist in his database.  If I don't get an answer from him, they will simply stay as they are now and add fixing the descriptions to the list of Jira tickets that will be submitted AFTER the content of this IG is incorporated into THO.  So, for now, leave them as they are and add to the list of future Jira tickets.  We will backtrack and fix the descriptions if Frank produces answers (which isn't actually likely at this point).

- 0929 Weight Units / 0930 Volume Units: are the short code lists intended?
no, the short lists are wrong.  We should try to ensure that the CLDs properly filter UCUM for the intended values but as described above, this may be difficult.  If you've got ideas about how to do that using what is available in the VS resource, please make suggestions.  Otherwise, we leave them as all codes and defer fixing the CLDs by adding to the list of future Jira tickets.

- Should concept domains carry their example codes?
In general, yes, they should.  See the entry in the conceptdomains CS for the concept with the code 'ActAppointmentType'.  There are examples in the description.  If we have examples that have both codes and concept definitions, that is fine.  Just make it work.  I will want to see a list of all of the entries where you're doing this collated into a single place so I can quickly review them.


- 0963 Device Safety: nothing published
The VS published in FHIR core is correct. HTA has approved the NCI Thesaurus and it is an external CS in THO.  Nothing to add to THO.  We just need to know for future reference that v2+ vocab bindings to this table manifest as bindings to the VS in FHIR core.

- PhinVads
I have information about what the new home(s) for vocab formerly hosted by PhinVads will be but I need to drive it through TSMG before we reflect anything here.  If there's a real hold-up, we can just exclude any tables upon which this relies and address them in later Jira tickets.  In fact, it may be just fine to use the old / existing / likely-to-be-broken url for PhinVads now and just do a follow-up ticket once the other pieces of this puzzle are sorted.


