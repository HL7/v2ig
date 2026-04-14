# Structural Inventory: FHIR vs V2.9.1

Comprehensive comparison of all artifact types between FHIR StructureDefinitions and V2.9.1 Word document extractions.

## Overview

| Artifact Type | FHIR | V291 | Matched | FHIR Only | V291 Only |
|---------------|------|------|---------|-----------|-----------|
| Segments | 192 | 191 | 190 | 2 | 1 |
| Complex Data Types | 71 | 71 | 71 | 0 | 0 |
| Message Structures | 418 | 216 | 178 | 240 | 38 |
| Events | 356 | 323 | 312 | 44 | 11 |
| Primitive Data Types | 12 | 0 | — | — | — |
| Messages | 696 | 0 | — | — | — |
| Vocabulary / Value Sets | — | 797 | — | — | — |

## Segments

**FHIR:** 192 | **V291:** 191 | **Matched:** 190

### In FHIR but not V291 (2)

`HXX`, `VARIES`

### In V291 but not FHIR (1)

`ZL7`

---

## Complex Data Types

**FHIR:** 71 | **V291:** 71 | **Matched:** 71

### Component count mismatches

| Data Type | FHIR Components | V291 Components |
|-----------|-----------------|-----------------|
| MA | 4 | 5 |
| NA | 4 | 5 |

---

## Message Structures

**FHIR:** 418 | **V291:** 216 | **Matched:** 178

### In FHIR but not V291 (240)

`ACK_A`, `ACK_AA`, `ACK_AB`, `ACK_AC`, `ACK_AD`, `ACK_AE`, `ACK_AF`, `ACK_AG`, `ACK_AH`, `ACK_AI`
`ACK_AJ`, `ACK_AK`, `ACK_AL`, `ACK_AM`, `ACK_AN`, `ACK_AO`, `ACK_AP`, `ACK_AQ`, `ACK_AR`, `ACK_AS`
`ACK_AT`, `ACK_AU`, `ACK_AV`, `ACK_AW`, `ACK_AX`, `ACK_AY`, `ACK_AZ`, `ACK_B`, `ACK_BA`, `ACK_BB`
`ACK_BC`, `ACK_BD`, `ACK_BE`, `ACK_BF`, `ACK_BG`, `ACK_BH`, `ACK_BI`, `ACK_BJ`, `ACK_BK`, `ACK_BL`
`ACK_BM`, `ACK_BN`, `ACK_BO`, `ACK_BP`, `ACK_BQ`, `ACK_BR`, `ACK_BS`, `ACK_BT`, `ACK_BU`, `ACK_BV`
`ACK_BW`, `ACK_BX`, `ACK_BY`, `ACK_BZ`, `ACK_C`, `ACK_CA`, `ACK_CB`, `ACK_CC`, `ACK_CD`, `ACK_CE`
`ACK_CF`, `ACK_CG`, `ACK_CH`, `ACK_CI`, `ACK_CJ`, `ACK_CK`, `ACK_CL`, `ACK_CM`, `ACK_CN`, `ACK_CO`
`ACK_CP`, `ACK_CQ`, `ACK_CR`, `ACK_CS`, `ACK_CT`, `ACK_CU`, `ACK_CV`, `ACK_CW`, `ACK_CX`, `ACK_CY`
`ACK_CZ`, `ACK_D`, `ACK_DA`, `ACK_DB`, `ACK_DC`, `ACK_DD`, `ACK_DE`, `ACK_DF`, `ACK_DG`, `ACK_DH`
`ACK_DI`, `ACK_DJ`, `ACK_DK`, `ACK_E`, `ACK_F`, `ACK_G`, `ACK_H`, `ACK_I`, `ACK_J`, `ACK_K`
`ACK_L`, `ACK_M`, `ACK_N`, `ACK_O`, `ACK_P`, `ACK_Q`, `ACK_R`, `ACK_S`, `ACK_T`, `ACK_U`
`ACK_V`, `ACK_W`, `ACK_X`, `ACK_Y`, `ACK_Z`, `ADT_A01_A`, `ADT_A01_B`, `ADT_A01_C`, `ADT_A01_D`, `ADT_A05_A`
`ADT_A05_B`, `ADT_A05_C`, `ADT_A05_D`, `ADT_A06_A`, `ADT_A06_B`, `ADT_A09_A`, `ADT_A09_B`, `ADT_A09_C`, `ADT_A21_A`, `ADT_A21_B`
`ADT_A21_C`, `ADT_A21_D`, `ADT_A21_E`, `ADT_A21_F`, `ADT_A21_G`, `ADT_A21_H`, `ADT_A21_I`, `ADT_A39_A`, `ADT_A39_B`, `ADT_A39_C`
`ADT_A43_A`, `ADT_A43_B`, `ADT_A44_A`, `ADT_A44_B`, `ADT_A50_A`, `ADT_A50_B`, `ADT_A52_A`, `ADT_A52_B`, `ADT_A54_A`, `ADT_A54_B`
`ADT_A61_A`, `ADT_A61_B`, `LSU_U12_A`, `LSU_U12_B`, `MDM_T01_A`, `MDM_T01_B`, `MDM_T01_C`, `MDM_T01_D`, `MDM_T01_E`, `MDM_T01_F`
`MDM_T02_A`, `MDM_T02_B`, `MDM_T02_C`, `MDM_T02_D`, `MDM_T02_E`, `MFK_M01_A`, `MFK_M01_B`, `MFK_M01_C`, `MFK_M01_D`, `MFK_M01_E`
`MFK_M01_F`, `MFK_M01_G`, `MFK_M01_H`, `MFK_M01_I`, `MFK_M01_J`, `MFK_M01_K`, `MFK_M01_L`, `MFK_M01_M`, `MFK_M01_N`, `MFK_M01_O`
`MFK_M01_P`, `ORU_R01_A`, `ORU_R01_B`, `ORU_R01_C`, `ORU_R01_D`, `ORU_R30_A`, `ORU_R30_B`, `ORU_R30_C`, `PMU_B01_A`, `PMU_B01_B`
`PMU_B04_A`, `PMU_B04_B`, `PMU_B04_C`, `QBP_Q11_A`, `QBP_Q11_B`, `QBP_Q11_C`, `QBP_Q11_D`, `QBP_Q11_E`, `QBP_Q21_A`, `QBP_Q21_B`
`QBP_Q21_C`, `QBP_Q21_D`, `QBP_Q21_E`, `QBP_Q21_F`, `QCN_J01_A`, `QCN_J01_B`, `QSB_Q16_A`, `QSB_Q16_B`, `RDE_O11_A`, `RDE_O11_B`
`RDY_K15_A`, `RDY_K15_B`, `RDY_K15_C`, `RDY_K15_D`, `RQI_I01_A`, `RQI_I01_B`, `RQI_I01_C`, `RQI_I01_D`, `RRE_O12_A`, `RRE_O12_B`
`RSP_K23_A`, `RSP_K23_B`, `RTB_K13_A`, `RTB_K13_B`, `RTB_K13_C`, `RTB_K13_D`, `RTB_K13_E`, `RTB_K13_F`, `RTB_K13_G`, `SDR_S31_A`
`SDR_S31_B`, `SDR_S32_A`, `SDR_S32_B`, `SLR_S28_A`, `SLR_S28_B`, `SLR_S28_C`, `SLR_S28_D`, `SLR_S28_E`, `TCU_U10_A`, `TCU_U10_B`

### In V291 but not FHIR (38)

`ACK`, `ADT_A01`, `ADT_A05`, `ADT_A06`, `ADT_A09`, `ADT_A21`, `ADT_A39`, `ADT_A43`, `ADT_A44`, `ADT_A50`
`ADT_A52`, `ADT_A54`, `ADT_A61`, `LSU_U12`, `MDM_T01`, `MDM_T02`, `MFK_M01`, `ORU_R01`, `ORU_R30`, `PMU_B01`
`PMU_B04`, `QBP_Q11`, `QBP_Q21`, `QCN_J01`, `QSB_Q16`, `RDE_O11`, `RDY_K15`, `RQI_I01`, `RRE_O12`, `RSP_K23`
`RTB_K13`, `SDR_S31`, `SDR_S32`, `SLR_S28`, `TCU_U10`, `UNKNOWN`, `WRQ_Z01`, `WRQ_Z02`

### V291 duplicates (same key, multiple files)

- **ACK**: ACK_02_2.json, ACK_03_105.json, ACK_03_107.json, ACK_03_109.json, ACK_03_11.json, ACK_03_13.json, ACK_03_15.json, ACK_03_17.json, ACK_03_19.json, ACK_03_21.json, ACK_03_23.json, ACK_03_25.json, ACK_03_27.json, ACK_03_29.json, ACK_03_31.json, ACK_03_33.json, ACK_03_35.json, ACK_03_37.json, ACK_03_39.json, ACK_03_41.json, ACK_03_43.json, ACK_03_45.json, ACK_03_47.json, ACK_03_49.json, ACK_03_5.json, ACK_03_51.json, ACK_03_53.json, ACK_03_55.json, ACK_03_57.json, ACK_03_59.json, ACK_03_61.json, ACK_03_63.json, ACK_03_65.json, ACK_03_67.json, ACK_03_69.json, ACK_03_7.json, ACK_03_71.json, ACK_03_73.json, ACK_03_75.json, ACK_03_77.json, ACK_03_79.json, ACK_03_81.json, ACK_03_83.json, ACK_03_85.json, ACK_03_87.json, ACK_03_89.json, ACK_03_9.json, ACK_03_91.json, ACK_03_93.json, ACK_03_95.json, ACK_05_194.json, ACK_05_196.json, ACK_05_198.json, ACK_05_200.json, ACK_06_216.json, ACK_06_218.json, ACK_06_220.json, ACK_06_222.json, ACK_06_224.json, ACK_06_226.json, ACK_06_228.json, ACK_06_230.json, ACK_07_232.json, ACK_07_234.json, ACK_07_236.json, ACK_07_238.json, ACK_09_287.json, ACK_09_289.json, ACK_09_291.json, ACK_09_293.json, ACK_09_295.json, ACK_09_297.json, ACK_09_299.json, ACK_09_301.json, ACK_09_303.json, ACK_09_305.json, ACK_09_307.json, ACK_10_311.json, ACK_11_321.json, ACK_12_334.json, ACK_12_336.json, ACK_12_338.json, ACK_12_340.json, ACK_13_342.json, ACK_13_344.json, ACK_13_346.json, ACK_13_348.json, ACK_13_350.json, ACK_13_352.json, ACK_13_354.json, ACK_13_356.json, ACK_13_358.json, ACK_13_360.json, ACK_13_362.json, ACK_13_364.json, ACK_13_366.json, ACK_13_368.json, ACK_15_372.json, ACK_15_374.json, ACK_15_376.json, ACK_15_378.json, ACK_15_380.json, ACK_15_382.json, ACK_15_385.json, ACK_15_387.json, ACK_17_403.json, ACK_17_406.json, ACK_17_409.json, ACK_17_412.json, ACK_17_415.json, ACK_17_418.json, ACK_17_420.json, ACK_17_422.json, ACK_17_424.json, ACK_17_426.json
- **ADT_A01**: ADT_A01_03_10.json, ADT_A01_03_18.json, ADT_A01_03_28.json, ADT_A01_03_4.json
- **ADT_A05**: ADT_A05_03_12.json, ADT_A05_03_30.json, ADT_A05_03_54.json, ADT_A05_03_58.json
- **ADT_A06**: ADT_A06_03_14.json, ADT_A06_03_16.json
- **ADT_A09**: ADT_A09_03_20.json, ADT_A09_03_22.json, ADT_A09_03_24.json
- **ADT_A21**: ADT_A21_03_40.json, ADT_A21_03_42.json, ADT_A21_03_44.json, ADT_A21_03_48.json, ADT_A21_03_50.json, ADT_A21_03_52.json, ADT_A21_03_56.json, ADT_A21_03_60.json, ADT_A21_03_62.json
- **ADT_A39**: ADT_A39_03_68.json, ADT_A39_03_70.json, ADT_A39_03_72.json
- **ADT_A43**: ADT_A43_03_74.json, ADT_A43_03_82.json
- **ADT_A44**: ADT_A44_03_76.json, ADT_A44_03_80.json
- **ADT_A50**: ADT_A50_03_84.json, ADT_A50_03_86.json
- **ADT_A52**: ADT_A52_03_88.json, ADT_A52_03_90.json
- **ADT_A54**: ADT_A54_03_92.json, ADT_A54_03_94.json
- **ADT_A61**: ADT_A61_03_106.json, ADT_A61_03_108.json
- **LSU_U12**: LSU_U12_13_363.json, LSU_U12_13_365.json
- **MDM_T01**: MDM_T01_09_286.json, MDM_T01_09_290.json, MDM_T01_09_294.json, MDM_T01_09_298.json, MDM_T01_09_302.json, MDM_T01_09_306.json
- **MDM_T02**: MDM_T02_09_288.json, MDM_T02_09_292.json, MDM_T02_09_296.json, MDM_T02_09_300.json, MDM_T02_09_304.json
- **MFK_M01**: MFK_M01_08_253.json, MFK_M01_08_255.json, MFK_M01_08_257.json, MFK_M01_08_259.json, MFK_M01_08_261.json, MFK_M01_08_263.json, MFK_M01_08_265.json, MFK_M01_08_267.json, MFK_M01_08_269.json, MFK_M01_08_271.json, MFK_M01_08_273.json, MFK_M01_08_275.json, MFK_M01_08_277.json, MFK_M01_08_279.json, MFK_M01_08_281.json, MFK_M01_08_283.json, MFK_M01_08_285.json
- **NMD_N02**: NMD_N02_14_369.json, NMD_N02_14_370.json
- **ORU_R01**: ORU_R01_07_231.json, ORU_R01_07_244.json, ORU_R01_07_246.json, ORU_R01_07_247.json
- **ORU_R30**: ORU_R30_07_233.json, ORU_R30_07_235.json, ORU_R30_07_237.json
- **PMU_B01**: PMU_B01_15_371.json, PMU_B01_15_373.json
- **PMU_B04**: PMU_B04_15_377.json, PMU_B04_15_379.json, PMU_B04_15_381.json
- **QBP_Q11**: QBP_Q11_04A_124.json, QBP_Q11_05_185.json, QBP_Q11_05_188.json, QBP_Q11_05_204.json, QBP_Q11_05_206.json
- **QBP_Q21**: QBP_Q21_03_100.json, QBP_Q21_03_102.json, QBP_Q21_03_110.json, QBP_Q21_03_96.json, QBP_Q21_03_98.json
- **QCN_J01**: QCN_J01_05_197.json, QCN_J01_05_199.json
- **QSB_Q16**: QSB_Q16_05_193.json, QSB_Q16_05_201.json
- **RDE_O11**: RDE_O11_04A_114.json, RDE_O11_04A_122.json
- **RDY_K15**: RDY_K15_05_183.json, RDY_K15_05_187.json, RDY_K15_05_192.json, RDY_K15_05_211.json
- **RQI_I01**: RQI_I01_11_312.json, RQI_I01_11_314.json, RQI_I01_11_316.json, RQI_I01_11_320.json
- **RRE_O12**: RRE_O12_04A_115.json, RRE_O12_04A_123.json
- **RSP_K23**: RSP_K23_03_101.json, RSP_K23_03_103.json
- **RTB_K13**: RTB_K13_05_184.json, RTB_K13_05_190.json, RTB_K13_05_208.json, RTB_K13_05_209.json, RTB_K13_05_210.json, RTB_K13_05_213.json, RTB_K13_05_214.json
- **SDR_S31**: SDR_S31_17_411.json, SDR_S31_17_413.json, SDR_S31_17_423.json
- **SDR_S32**: SDR_S32_17_414.json, SDR_S32_17_416.json, SDR_S32_17_425.json
- **SLR_S28**: SLR_S28_17_402.json, SLR_S28_17_404.json, SLR_S28_17_405.json, SLR_S28_17_407.json, SLR_S28_17_408.json, SLR_S28_17_410.json, SLR_S28_17_419.json, SLR_S28_17_421.json
- **TCU_U10**: TCU_U10_13_359.json, TCU_U10_13_361.json

### FHIR-only breakdown

The 240 FHIR-only structures break down as:

| Category | Count | Explanation |
|----------|-------|-------------|
| ACK variants | 115 | FHIR creates one ACK structure per event; V291 has a single ACK |
| Sub-variants | 125 | FHIR splits base structures into lettered sub-variants (e.g. ADT_A01_A/B/C/D) |
| Genuinely missing | 0 | Structures not extracted from V291 Word docs |

**Genuinely in V291 only (not in FHIR at all):**

- `WRQ_Z01`
- `WRQ_Z02`

---

## Events

**FHIR:** 356 | **V291:** 323 | **Matched:** 312

### In FHIR but not V291 (44)

`A18`, `A19`, `A30`, `A34`, `A35`, `A36`, `A39`, `A46`, `A48`, `E30`
`E31`, `I05`, `I06`, `M01`, `M03`, `N01`, `O59_A`, `O59_B`, `P04`, `P09`
`PC4`, `PC5`, `PC9`, `PCA`, `PCE`, `PCF`, `PCK`, `PCL`, `R02`, `R04`
`R21`, `S25`, `T12`, `V01`, `V02`, `V03`, `Z85`, `Z95`, `ZNN_A`, `ZNN_B`
`ZNN_C`, `ZNN_D`, `ZNN_E`, `ZNN_F`

### In V291 but not FHIR (11)

`I12`, `I13`, `I14`, `I15`, `O59`, `YYY`, `Z01`, `Z02`, `Z86`, `Z96`
`ZNN`

### V291 duplicates (same key, multiple files)

- **A01**: A01_03_3.json, A01_03_4.json
- **A02**: A02_03_5.json, A02_03_6.json
- **A03**: A03_03_7.json, A03_03_8.json
- **A04**: A04_03_10.json, A04_03_9.json
- **A05**: A05_03_11.json, A05_03_12.json
- **A06**: A06_03_13.json, A06_03_14.json
- **A07**: A07_03_15.json, A07_03_16.json
- **A08**: A08_03_17.json, A08_03_18.json
- **A09**: A09_03_19.json, A09_03_20.json
- **A10**: A10_03_21.json, A10_03_22.json
- **A11**: A11_03_23.json, A11_03_24.json
- **A12**: A12_03_25.json, A12_03_26.json
- **A13**: A13_03_27.json, A13_03_28.json
- **A14**: A14_03_29.json, A14_03_30.json
- **A15**: A15_03_31.json, A15_03_32.json
- **A16**: A16_03_33.json, A16_03_34.json
- **A17**: A17_03_35.json, A17_03_36.json
- **A20**: A20_03_37.json, A20_03_38.json
- **A21**: A21_03_39.json, A21_03_40.json
- **A22**: A22_03_41.json, A22_03_42.json
- **A23**: A23_03_43.json, A23_03_44.json
- **A24**: A24_03_45.json, A24_03_46.json
- **A25**: A25_03_47.json, A25_03_48.json
- **A26**: A26_03_49.json, A26_03_50.json
- **A27**: A27_03_51.json, A27_03_52.json
- **A28**: A28_03_53.json, A28_03_54.json
- **A29**: A29_03_55.json, A29_03_56.json
- **A31**: A31_03_57.json, A31_03_58.json
- **A32**: A32_03_59.json, A32_03_60.json
- **A33**: A33_03_61.json, A33_03_62.json
- **A37**: A37_03_63.json, A37_03_64.json
- **A38**: A38_03_65.json, A38_03_66.json
- **A40**: A40_03_67.json, A40_03_68.json
- **A41**: A41_03_69.json, A41_03_70.json
- **A42**: A42_03_71.json, A42_03_72.json
- **A43**: A43_03_73.json, A43_03_74.json
- **A44**: A44_03_75.json, A44_03_76.json
- **A45**: A45_03_77.json, A45_03_78.json
- **A47**: A47_03_79.json, A47_03_80.json
- **A49**: A49_03_81.json, A49_03_82.json
- **A50**: A50_03_83.json, A50_03_84.json
- **A51**: A51_03_85.json, A51_03_86.json
- **A52**: A52_03_87.json, A52_03_88.json
- **A53**: A53_03_89.json, A53_03_90.json
- **A54**: A54_03_91.json, A54_03_92.json
- **A55**: A55_03_93.json, A55_03_94.json
- **A60**: A60_03_103.json, A60_03_104.json
- **A61**: A61_03_105.json, A61_03_106.json
- **A62**: A62_03_107.json, A62_03_108.json
- **B01**: B01_15_460.json, B01_15_461.json
- **B02**: B02_15_462.json, B02_15_463.json
- **B03**: B03_15_464.json, B03_15_465.json
- **B04**: B04_15_466.json, B04_15_467.json
- **B05**: B05_15_468.json, B05_15_469.json
- **B06**: B06_15_470.json, B06_15_471.json
- **B07**: B07_15_474.json, B07_15_475.json
- **B08**: B08_15_476.json, B08_15_477.json
- **E03**: E03_16_480.json, E03_16_481.json
- **E22**: E22_16_489.json, E22_16_490.json
- **I01**: I01_11_372.json, I01_11_373.json
- **I02**: I02_11_374.json, I02_11_375.json
- **I03**: I03_11_376.json, I03_11_377.json
- **I04**: I04_11_378.json, I04_11_379.json
- **I07**: I07_11_380.json, I07_11_381.json
- **I08**: I08_11_382.json, I08_11_386.json
- **I09**: I09_11_383.json, I09_11_387.json
- **I10**: I10_11_384.json, I10_11_388.json
- **I11**: I11_11_385.json, I11_11_389.json
- **I12**: I12_11_390.json, I12_11_394.json
- **I13**: I13_11_391.json, I13_11_395.json
- **I14**: I14_11_392.json, I14_11_396.json
- **I15**: I15_11_393.json, I15_11_397.json
- **I19**: I19_11_403.json, I19_11_404.json
- **I22**: I22_11_405.json, I22_11_406.json
- **J01**: J01_05_197.json, J01_05_198.json
- **J02**: J02_05_199.json, J02_05_200.json
- **M02**: M02_08_268.json, M02_08_269.json
- **M04**: M04_08_284.json, M04_08_285.json
- **M05**: M05_08_282.json, M05_08_283.json
- **M06**: M06_08_286.json, M06_08_287.json
- **M07**: M07_08_288.json, M07_08_289.json
- **M08**: M08_08_270.json, M08_08_271.json
- **M09**: M09_08_272.json, M09_08_273.json
- **M10**: M10_08_274.json, M10_08_275.json
- **M11**: M11_08_276.json, M11_08_277.json
- **M12**: M12_08_278.json, M12_08_279.json
- **M13**: M13_08_264.json, M13_08_265.json
- **M14**: M14_08_266.json, M14_08_267.json
- **M15**: M15_08_290.json, M15_08_291.json
- **M16**: M16_08_292.json, M16_08_293.json
- **M17**: M17_08_294.json, M17_08_295.json
- **M18**: M18_08_280.json, M18_08_281.json
- **M19**: M19_08_296.json, M19_08_297.json
- **O59**: O59_04A_127.json, O59_04_152.json
- **P01**: P01_06_216.json, P01_06_217.json
- **P02**: P02_06_218.json, P02_06_219.json
- **P03**: P03_06_220.json, P03_06_221.json
- **P05**: P05_06_222.json, P05_06_223.json
- **P06**: P06_06_224.json, P06_06_225.json
- **P10**: P10_06_226.json, P10_06_227.json
- **P11**: P11_06_228.json, P11_06_229.json
- **P12**: P12_06_230.json, P12_06_231.json
- **PC1**: PC1_12_413.json, PC1_12_416.json
- **PC2**: PC2_12_414.json, PC2_12_417.json
- **PC3**: PC3_12_415.json, PC3_12_418.json
- **PC6**: PC6_12_407.json, PC6_12_410.json
- **PC7**: PC7_12_408.json, PC7_12_411.json
- **PC8**: PC8_12_409.json, PC8_12_412.json
- **PCB**: PCB_12_419.json, PCB_12_422.json
- **PCC**: PCC_12_420.json, PCC_12_423.json
- **PCD**: PCD_12_421.json, PCD_12_424.json
- **PCG**: PCG_12_425.json, PCG_12_428.json
- **PCH**: PCH_12_426.json, PCH_12_429.json
- **PCJ**: PCJ_12_427.json, PCJ_12_430.json
- **Q16**: Q16_05_193.json, Q16_05_194.json
- **Q17**: Q17_05_195.json, Q17_05_196.json
- **R01**: R01_07_232.json, R01_07_233.json
- **R30**: R30_07_234.json, R30_07_235.json
- **R31**: R31_07_236.json, R31_07_237.json
- **R32**: R32_07_238.json, R32_07_239.json
- **S01**: S01_10_320.json, S01_10_331.json
- **S02**: S02_10_321.json, S02_10_332.json
- **S03**: S03_10_322.json, S03_10_333.json
- **S04**: S04_10_323.json, S04_10_334.json
- **S05**: S05_10_324.json, S05_10_335.json
- **S06**: S06_10_325.json, S06_10_336.json
- **S07**: S07_10_326.json, S07_10_337.json
- **S08**: S08_10_327.json, S08_10_338.json
- **S09**: S09_10_328.json, S09_10_339.json
- **S10**: S10_10_329.json, S10_10_340.json
- **S11**: S11_10_330.json, S11_10_341.json
- **S12**: S12_10_342.json, S12_10_357.json
- **S13**: S13_10_343.json, S13_10_358.json
- **S14**: S14_10_344.json, S14_10_359.json
- **S15**: S15_10_345.json, S15_10_360.json
- **S16**: S16_10_346.json, S16_10_361.json
- **S17**: S17_10_347.json, S17_10_362.json
- **S18**: S18_10_348.json, S18_10_363.json
- **S19**: S19_10_349.json, S19_10_364.json
- **S20**: S20_10_350.json, S20_10_365.json
- **S21**: S21_10_351.json, S21_10_366.json
- **S22**: S22_10_352.json, S22_10_367.json
- **S23**: S23_10_353.json, S23_10_368.json
- **S24**: S24_10_354.json, S24_10_369.json
- **S26**: S26_10_355.json, S26_10_370.json
- **S27**: S27_10_356.json, S27_10_371.json
- **S28**: S28_17_492.json, S28_17_493.json, S28_17_494.json
- **S29**: S29_17_495.json, S29_17_496.json, S29_17_497.json
- **S30**: S30_17_498.json, S30_17_499.json, S30_17_500.json
- **S31**: S31_17_501.json, S31_17_502.json, S31_17_503.json
- **S32**: S32_17_504.json, S32_17_505.json, S32_17_506.json
- **S33**: S33_17_507.json, S33_17_508.json
- **S34**: S34_17_509.json, S34_17_510.json
- **S35**: S35_17_511.json, S35_17_512.json
- **S36**: S36_17_513.json, S36_17_514.json
- **S37**: S37_17_515.json, S37_17_516.json
- **T01**: T01_09_298.json, T01_09_299.json
- **T02**: T02_09_300.json, T02_09_301.json
- **T03**: T03_09_302.json, T03_09_303.json
- **T04**: T04_09_304.json, T04_09_305.json
- **T05**: T05_09_306.json, T05_09_307.json
- **T06**: T06_09_308.json, T06_09_309.json
- **T07**: T07_09_310.json, T07_09_311.json
- **T08**: T08_09_312.json, T08_09_313.json
- **T09**: T09_09_314.json, T09_09_315.json
- **T10**: T10_09_316.json, T10_09_317.json
- **T11**: T11_09_318.json, T11_09_319.json
- **U01**: U01_13_431.json, U01_13_432.json
- **U02**: U02_13_433.json, U02_13_434.json
- **U03**: U03_13_435.json, U03_13_436.json
- **U04**: U04_13_437.json, U04_13_438.json
- **U05**: U05_13_439.json, U05_13_440.json
- **U06**: U06_13_441.json, U06_13_442.json
- **U07**: U07_13_443.json, U07_13_444.json
- **U08**: U08_13_445.json, U08_13_446.json
- **U09**: U09_13_447.json, U09_13_448.json
- **U10**: U10_13_449.json, U10_13_450.json
- **U11**: U11_13_451.json, U11_13_452.json
- **U12**: U12_13_453.json, U12_13_454.json
- **U13**: U13_13_455.json, U13_13_456.json
- **U14**: U14_13_457.json, U14_13_458.json
- **V04**: V04_04A_128.json, V04_04A_129.json
- **ZNN**: ZNN_05_201.json, Znn_05_181.json, Znn_05_182.json, Znn_05_183.json, Znn_05_184.json, Znn_05_185.json, Znn_05_186.json, Znn_05_187.json

---

## Missing Events by Chapter/Domain

V291 extraction only captured events from chapters 02, 03, 04A, 06, 11. Events from all other chapters are missing. Root cause: extraction regex only matches simple event codes, fails on hyphens/commas/ranges.

| Chapter/Domain | Missing Events |
|----------------|----------------|
| CH03-ADT | 9 |
| CH04-OrderEntry | 2 |
| CH04-Pharmacy | 3 |
| CH05-Query | 8 |
| CH06-Financial | 2 |
| CH07-Observation | 3 |
| CH08-MasterFiles | 2 |
| CH09-DocMgmt | 1 |
| CH10-Scheduling | 1 |
| CH11-Referral | 2 |
| CH12-PatientCare | 8 |
| CH13-Automation | 2 |
| CH14-AppMgmt | 1 |

## Event Details (V291)

V291 events include message type and structure mappings. Multiple entries per event code indicate different message type / structure combinations.

### Events with multiple message type mappings (183)

- **A01**: ADT^A01^ADT_A01, ACK^A01^ACK
- **A02**: ADT^A02^ADT_A02, ACK^A02^ACK
- **A03**: ADT^A03^ADT_A03, ACK^A03^ACK
- **A04**: ACK^A04^ACK, ADT^A04^ADT_A01
- **A05**: ADT^A05^ADT_A05, ACK^A05^ACK
- **A06**: ADT^A06^ADT_A06, ACK^A06^ACK
- **A07**: ADT^A07^ADT_A06, ACK^A07^ACK
- **A08**: ADT^A08^ADT_A01, ACK^A08^ACK
- **A09**: ADT^A09^ADT_A09, ACK^A09^ACK
- **A10**: ADT^A10^ADT_A09, ACK^A10^ACK
- **A11**: ADT^A11^ADT_A09, ACK^A11^ACK
- **A12**: ADT^A12^ADT_A12, ACK^A12^ACK
- **A13**: ADT^A13^ADT_A01, ACK^A13^ACK
- **A14**: ADT^A14^ADT_A05, ACK^A14^ACK
- **A15**: ADT^A15^ADT_A15, ACK^A15^ACK
- **A16**: ADT^A16^ADT_A16, ACK^A16^ACK
- **A17**: ADT^A17^ADT_A17, ACK^A17^ACK
- **A20**: ADT^A20^ADT_A20, ACK^A20^ACK
- **A21**: ADT^A21^ADT_A21, ACK^A21^ACK
- **A22**: ADT^A22^ADT_A21, ACK^A22^ACK
- **A23**: ADT^A23^ADT_A21, ACK^A23^ACK
- **A24**: ADT^A24^ADT_A24, ACK^A24^ACK
- **A25**: ADT^A25^ADT_A21, ACK^A25^ACK
- **A26**: ADT^A26^ADT_A21, ACK^A26^ACK
- **A27**: ADT^A27^ADT_A21, ACK^A27^ACK
- **A28**: ADT^A28^ADT_A05, ACK^A28^ACK
- **A29**: ADT^A29^ADT_A21, ACK^A29^ACK
- **A31**: ADT^A31^ADT_A05, ACK^A31^ACK
- **A32**: ADT^A32^ADT_A21, ACK^A32^ACK
- **A33**: ADT^A33^ADT_A21, ACK^A33^ACK
- **A37**: ADT^A37^ADT_A37, ACK^A37^ACK
- **A38**: ADT^A38^ADT_A38, ACK^A38^ACK
- **A40**: ADT^A40^ADT_A39, ACK^A40^ACK
- **A41**: ADT^A41^ADT_A39, ACK^A41^ACK
- **A42**: ADT^A42^ADT_A39, ACK^A42^ACK
- **A43**: ADT^A43^ADT_A43, ACK^A43^ACK
- **A44**: ADT^A44^ADT_A44, ACK^A44^ACK
- **A45**: ADT^A45^ADT_A45, ACK^A45^ACK
- **A47**: ADT^A47^ADT_A44, ACK^A47^ACK
- **A49**: ADT^A49^ADT_A43, ACK^A49^ACK
- **A50**: ADT^A50^ADT_A50, ACK^A50^ACK
- **A51**: ADT^A51^ADT_A50, ACK^A51^ACK
- **A52**: ADT^A52^ADT_A52, ACK^A52^ACK
- **A53**: ADT^A53^ADT_A52, ACK^A53^ACK
- **A54**: ADT^A54^ADT_A54, ACK^A54^ACK
- **A55**: ADT^A55^ADT_A54, ACK^A55^ACK
- **A60**: ADT^A60^ADT_A60, ACK^A60^ACK
- **A61**: ADT^A61^ADT_A61, ACK^A61^ACK
- **A62**: ADT^A62^ADT_A61, ACK^A62^ACK
- **B01**: PMU^B01^PMU_B01, ACK^B01^ACK
- **B02**: PMU^B02^PMU_B01, ACK^B02^ACK
- **B03**: PMU^B03^PMU_B03, ACK^B03^ACK
- **B04**: PMU^B04^PMU_B04, ACK^B04^ACK
- **B05**: PMU^B05^PMU_B04, ACK^B05^ACK
- **B06**: PMU^B06^PMU_B04, ACK^B06^ACK
- **B07**: PMU^B07^PMU_B07, ACK^B07^ACK
- **B08**: PMU^B08^PMU_B08, ACK^B08^ACK
- **E03**: QBP^E03^QBP_E03, RSP^E03^RSP_E03
- **E22**: QBP^E22^QBP_E22, RSP^E22^RSP_E22
- **I01**: RQI^I01^RQI_I01, RPI^I01^RPI_I01
- **I02**: RQI^I02^RQI_I01, RPL^I02^RPL_I02
- **I03**: RQI^I03^RQI_I01, RPR^I03^RPR_I03
- **I04**: RQP^I04^RQP_I04, RPI^I04^RPI_I04
- **I07**: PIN^I07^RQI_I01, ACK^I07^ACK
- **I08**: RQA^I08^RQA_I08, RPA^I08^RPA_I08
- **I09**: RQA^I09^RQA_I08, RPA^I09^RPA_I08
- **I10**: RQA^I10^RQA_I08, RPA^I10^RPA_I08
- **I11**: RQA^I11^RQA_I08, RPA^I11^RPA_I08
- **I12**: REF^I12^REF_I12, RRI^I12^RRI_I12
- **I13**: REF^I13^REF_I12, RRI^I13^RRI_I12
- **I14**: REF^I14^REF_I12, RRI^I14^RRI_I12
- **I15**: REF^I15^REF_I12, RRI^I15^RRI_I12
- **I19**: CCQ^I19^CCQ_I19, CQU^I19^CQU_I19
- **I22**: CCF^I22^CCF_I22, CCI^I22^CCI_I22
- **J01**: QCN^J01^QCN_J01, ACK^J01^ACK
- **J02**: QSX^J02^QCN_J01, ACK^J02^ACK
- **M02**: MFN^M02^MFN_M02, MFK^M02^MFK_M01
- **M04**: MFN^M04^MFN_M04, MFK^M04^MFK_M01
- **M05**: MFN^M05^MFN_M05, MFK^M05^MFK_M01
- **M06**: MFN^M06^MFN_M06, MFK^M06^MFK_M01
- **M07**: MFN^M07^MFN_M07, MFK^M07^MFK_M01
- **M08**: MFN^M08^MFN_M08, MFK^M08^MFK_M01
- **M09**: MFN^M09^MFN_M09, MFK^M09^MFK_M01
- **M10**: MFN^M10^MFN_M10, MFK^M10^MFK_M01
- **M11**: MFN^M11^MFN_M11, MFK^M11^MFK_M01
- **M12**: MFN^M12^MFN_M12, MFK^M12^MFK_M01
- **M13**: MFN^M13^MFN_M13, MFK^M13^MFK_M01
- **M14**: MFN^M14^MFN_Znn, MFK^M14^MFK_M01
- **M15**: MFN^M15^MFN_M15, MFK^M15^MFK_M01
- **M16**: MFN^M16^MFN_M16, MFK^M16^MFK_M01
- **M17**: MFN^M17^MFN_M17, MFK^M17^MFK_M01
- **M18**: MFN^M18^MFN_M18, MFK^M18^MFK_M01
- **M19**: MFN^M19^MFN_M19, MFK^M19^MFK_M01
- **O59**: RCV^O59^RCV_O59, OML^O59^OML_O59
- **P01**: BAR^P01^BAR_P01, ACK^P01^ACK
- **P02**: BAR^P02^BAR_P02, ACK^P02^ACK
- **P03**: DFT^P03^DFT_P03, ACK^P03^ACK
- **P05**: BAR^P05^BAR_P05, ACK^P05^ACK
- **P06**: BAR^P06^BAR_P06, ACK^P06^ACK
- **P10**: BAR^P10^BAR_P10, ACK^P10^ACK
- **P11**: DFT^P11^DFT_P11, ACK^P11^ACK
- **P12**: BAR^P12^BAR_P12, ACK^P12^ACK
- **PC1**: PPR^PC1^PPR_PC1, ACK^PC1^ACK
- **PC2**: PPR^PC2^PPR_PC1, ACK^PC2^ACK
- **PC3**: PPR^PC3^PPR_PC1, ACK^PC3^ACK
- **PC6**: PGL^PC6^PGL_PC6, ACK^PC6^ACK
- **PC7**: PGL^PC7^PGL_PC6, ACK^PC7^ACK
- **PC8**: PGL^PC8^PGL_PC6, ACK^PC8^ACK
- **PCB**: PPP^PCB^PPP_PCB, ACK^PCB^ACK
- **PCC**: PPP^PCC^PPP_PCB, ACK^PCC^ACK
- **PCD**: PPP^PCD^PPP_PCB, ACK^PCD^ACK
- **PCG**: PPG^PCG^PPG_PCG, ACK^PCG^ACK
- **PCH**: PPG^PCH^PPG_PCG, ACK^PCH^ACK
- **PCJ**: PPG^PCJ^PPG_PCG, ACK^PCJ^ACK
- **Q16**: QSB^Q16^QSB_Q16, ACK^Q16^ACK
- **Q17**: QVR^Q17^QVR_Q17, ACK^Q17^ACK
- **R01**: ORU^R01^ORU_R01, ACK^R01^ACK
- **R30**: ORU^R30^ORU_R30, ACK^R30^ACK
- **R31**: ORU^R31^ORU_R30, ACK^R31^ACK
- **R32**: ORU^R32^ORU_R30, ACK^R32^ACK
- **S01**: SRM^S01^SRM_S01, SRR^S01^SRR_S01
- **S02**: SRM^S02^SRM_S01, SRR^S02^SRR_S01
- **S03**: SRM^S03^SRM_S01, SRR^S03^SRR_S01
- **S04**: SRM^S04^SRM_S01, SRR^S04^SRR_S01
- **S05**: SRM^S05^SRM_S01, SRR^S05^SRR_S01
- **S06**: SRM^S06^SRM_S01, SRR^S06^SRR_S01
- **S07**: SRM^S07^SRM_S01, SRR^S07^SRR_S01
- **S08**: SRM^S08^SRM_S01, SRR^S08^SRR_S01
- **S09**: SRM^S09^SRM_S01, SRR^S09^SRR_S01
- **S10**: SRM^S10^SRM_S01, SRR^S10^SRR_S01
- **S11**: SRM^S11^SRM_S01, SRR^S11^SRR_S01
- **S12**: SIU^S12^SIU_S12, ACK^S12^ACK
- **S13**: SIU^S13^SIU_S12, ACK^S13^ACK
- **S14**: SIU^S14^SIU_S12, ACK^S14^ACK
- **S15**: SIU^S15^SIU_S12, ACK^S15^ACK
- **S16**: SIU^S16^SIU_S12, ACK^S16^ACK
- **S17**: SIU^S17^SIU_S12, ACK^S17^ACK
- **S18**: SIU^S18^SIU_S12, ACK^S18^ACK
- **S19**: SIU^S19^SIU_S12, ACK^S19^ACK
- **S20**: SIU^S20^SIU_S12, ACK^S20^ACK
- **S21**: SIU^S21^SIU_S12, ACK^S21^ACK
- **S22**: SIU^S22^SIU_S12, ACK^S22^ACK
- **S23**: SIU^S23^SIU_S12, ACK^S23^ACK
- **S24**: SIU^S24^SIU_S12, ACK^S24^ACK
- **S26**: SIU^S26^SIU_S12, ACK^S26^ACK
- **S27**: SIU^S27^SIU_S12, ACK^S27^ACK
- **S28**: SLR^S28^SLR_S28, ACK^S28^ACK, SLS^S28^SLR_S28
- **S29**: SLR^S29^SLR_S28, ACK^S29^ACK, SLS^S29^SLR_S28
- **S30**: STI^S30^SLR_S28, ACK^S30^ACK, STS^S30^SLR_S28
- **S31**: SDR^S31^SDR_S31, ACK^S31^ACK, SDS^S31^SDR_S31
- **S32**: SMD^S32^SDR_S32, ACK^S32^ACK, SMS^S32^SDR_S32
- **S33**: STC^S33^STC_S33, ACK^S33^ACK
- **S34**: SLN^S34^SLR_S28, ACK^S34^ACK
- **S35**: SLN^S35^SLR_S28, ACK^S35^ACK
- **S36**: SDN^S36^SDR_S31, ACK^S36^ACK
- **S37**: SCN^S37^SDR_S32, ACK^S37^ACK
- **T01**: MDM^T01^MDM_T01, ACK^T01^ACK
- **T02**: MDM^T02^MDM_T02, ACK^T02^ACK
- **T03**: MDM^T03^MDM_T01, ACK^T03^ACK
- **T04**: MDM^T04^MDM_T02, ACK^T04^ACK
- **T05**: MDM^T05^MDM_T01, ACK^T05^ACK
- **T06**: MDM^T06^MDM_T02, ACK^T06^ACK
- **T07**: MDM^T07^MDM_T01, ACK^T07^ACK
- **T08**: MDM^T08^MDM_T02, ACK^T08^ACK
- **T09**: MDM^T09^MDM_T01, ACK^T09^ACK
- **T10**: MDM^T10^MDM_T02, ACK^T10^ACK
- **T11**: MDM^T11^MDM_T01, ACK^T11^ACK
- **U01**: ESU^U01^ESU_U01, ACK^U01^ACK
- **U02**: ESR^U02^ESR_U02, ACK^U02^ACK
- **U03**: SSU^U03^SSU_U03, ACK^U03^ACK
- **U04**: SSR^U04^SSR_U04, ACK^U04^ACK
- **U05**: INU^U05^INU_U05, ACK^U05^ACK
- **U06**: INR^U06^INR_U06, ACK^U06^ACK
- **U07**: EAC^U07^EAC_U07, ACK^U07^ACK
- **U08**: EAR^U08^EAR_U08, ACK^U08^ACK
- **U09**: EAN^U09^EAN_U09, ACK^U09^ACK
- **U10**: TCU^U10^TCU_U10, ACK^U10^ACK
- **U11**: TCR^U11^TCU_U10, ACK^U11^ACK
- **U12**: LSU^U12^LSU_U12, ACK^U12^ACK
- **U13**: LSR^U13^LSU_U12, ACK^U13^ACK
- **U14**: INR^U14^INR_U14, ACK^U14^ACK
- **V04**: VXU^V04^VXU_V04, VXU^V04^VXU_V04
- **ZNN**: QBP^ZNN^QBP_Qnn, QBP^ZNN^QBP_Qnn, RTB^ZNN^RTB_Knn, RDY^ZNN^RDY_K15, RTB^ZNN^RTB_K13, QBP^ZNN^QBP_Q11, RSP^ZNN^RSP_Znn, RDY^ZNN^RDY_K15

## Notes

- **Primitive data types** (12) exist only in FHIR — not extracted from V291 Word docs
- **Messages** (696) exist only in FHIR — not extracted from V291 Word docs
- **Vocabulary** (797 tables) extracted from V291 — compared separately in vocabulary-comparison-report
- **Query parameters** (24 files) extracted from V291 — no FHIR equivalent yet
- Matching logic: segments by filename, data types by case-insensitive filename, message structures by structureId/filename, events by eventCode
