## RPT.4 - Phase Range End Value (NM)

Used for Calendar aligned repeat patterns to determine the amount of time from the beginning of particular _RPT.2 - Calendar Alignment_ to the end of the phase.

If Phase Range End Value is populated, but Phase Range Begin Value is not populated, then this component defines when the timing period (RPT.5, 6) begins.

If both Phase Range Begin Value and Phase Range End Value are populated, then this component defines the latest point in time at which the period (RPT.5, 6) will begin.

The units of measure for this component are derived from the Calendar Alignment value in RPT.2. See _file:///E:\V2\v2.9%20final%20Nov%20from%20Frank\V29_CH02C_Tables.docx#HL70527[HL7 Table 0527 - Calendar Alignment]_ for the units of measure associated with a particular calendar alignment.
