Table 0005 - the valueset stays but it will not be linked in v2+. As such, this IG should not inform any changes to the 0005 valueset.  The CS is properly retired already.

The VS for 0567 and 0568 should not ever have been created.  We won't touch them but a separate Jira ticket to retire them will be filed.  This is a separate action from anything in this IG.  This IG will simply not do anything with these VS.  The CS in THO have already been retired and this is the correct action.

Table 10 just goes away and we will remove any terminology bindings to table 10 as we prepare v2+

0078 VS actually already exists, just has a different url: ValueSet-v3-ObservationInterpretation.  We will allow this VS to serve and not create a new one.  We will note this in the ledger.  This passes the fidelity to Ch2c in as much as we are simply not adding it rather than "doing something different"

0133 Manipulate markdown descript to make it jump out that this is a discontinued codesystem as of 2.6 and was replaced.  Also, does IG pub generally make it very visually clear when a CS or VS is retired??

0188 same situation as 0010

0350 and 0351 are NOT conceptdomain only.  The VS CLD points to the appropriate extenal CS (which should be in THO -- need to check).  So, the fix is to the CLDs in the ValueSets...

0411 should be conceptdomain only so no CS or VS

