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


