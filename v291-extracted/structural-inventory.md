# Structural Inventory: FHIR vs V2.9.1

Comprehensive comparison of all artifact types between FHIR StructureDefinitions and V2.9.1 Word document extractions.

## Overview

| Artifact Type | FHIR | V291 | Matched | FHIR Only | V291 Only |
|---------------|------|------|---------|-----------|-----------|
| Segments | 192 | 178 | 177 | 15 | 1 |
| Complex Data Types | 71 | 71 | 71 | 0 | 0 |
| Message Structures | 418 | 195 | 159 | 259 | 36 |
| Events | 356 | 275 | 264 | 92 | 11 |
| Primitive Data Types | 12 | 0 | — | — | — |
| Messages | 696 | 0 | — | — | — |
| Vocabulary / Value Sets | — | 797 | — | — | — |

## Segments

**FHIR:** 192 | **V291:** 178 | **Matched:** 177

### In FHIR but not V291 (15)

`CNS`, `DST`, `ECD`, `ECR`, `EQP`, `EQU`, `HXX`, `INV`, `ISD`, `NDS`
`SAC`, `SID`, `TCC`, `TCD`, `VARIES`

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

**FHIR:** 418 | **V291:** 195 | **Matched:** 159

### In FHIR but not V291 (259)

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
`ADT_A61_A`, `ADT_A61_B`, `DEL_O46`, `DEO_O45`, `DPR_O48`, `DRC_O47`, `EAC_U07`, `EAN_U09`, `EAR_U08`, `ESR_U02`
`ESU_U01`, `INR_U06`, `INR_U14`, `INU_U05`, `LSU_U12_A`, `LSU_U12_B`, `MDM_T01_A`, `MDM_T01_B`, `MDM_T01_C`, `MDM_T01_D`
`MDM_T01_E`, `MDM_T01_F`, `MDM_T02_A`, `MDM_T02_B`, `MDM_T02_C`, `MDM_T02_D`, `MDM_T02_E`, `MFK_M01_A`, `MFK_M01_B`, `MFK_M01_C`
`MFK_M01_D`, `MFK_M01_E`, `MFK_M01_F`, `MFK_M01_G`, `MFK_M01_H`, `MFK_M01_I`, `MFK_M01_J`, `MFK_M01_K`, `MFK_M01_L`, `MFK_M01_M`
`MFK_M01_N`, `MFK_M01_O`, `MFK_M01_P`, `OMI_O23`, `OML_O21`, `OML_O39`, `ORU_R01_A`, `ORU_R01_B`, `ORU_R01_C`, `ORU_R01_D`
`ORU_R30_A`, `ORU_R30_B`, `ORU_R30_C`, `PMU_B01_A`, `PMU_B01_B`, `PMU_B04_A`, `PMU_B04_B`, `PMU_B04_C`, `QBP_Q11_A`, `QBP_Q11_B`
`QBP_Q11_C`, `QBP_Q11_D`, `QBP_Q11_E`, `QBP_Q21_A`, `QBP_Q21_B`, `QBP_Q21_C`, `QBP_Q21_D`, `QBP_Q21_E`, `QBP_Q21_F`, `QCN_J01_A`
`QCN_J01_B`, `QSB_Q16_A`, `QSB_Q16_B`, `RDE_O11_A`, `RDE_O11_B`, `RDY_K15_A`, `RDY_K15_B`, `RDY_K15_C`, `RDY_K15_D`, `RQI_I01_A`
`RQI_I01_B`, `RQI_I01_C`, `RQI_I01_D`, `RRE_O12_A`, `RRE_O12_B`, `RSP_K23_A`, `RSP_K23_B`, `RTB_K13_A`, `RTB_K13_B`, `RTB_K13_C`
`RTB_K13_D`, `RTB_K13_E`, `RTB_K13_F`, `RTB_K13_G`, `SDR_S31_A`, `SDR_S31_B`, `SDR_S32_A`, `SDR_S32_B`, `SIU_S12`, `SLR_S28_A`
`SLR_S28_B`, `SLR_S28_C`, `SLR_S28_D`, `SLR_S28_E`, `SRR_S01`, `SSR_U04`, `SSU_U03`, `TCU_U10_A`, `TCU_U10_B`

### In V291 but not FHIR (36)

`ACK`, `ADT_A01`, `ADT_A05`, `ADT_A06`, `ADT_A09`, `ADT_A21`, `ADT_A39`, `ADT_A43`, `ADT_A44`, `ADT_A50`
`ADT_A52`, `ADT_A54`, `ADT_A61`, `MDM_T01`, `MDM_T02`, `MFK_M01`, `ORU_R01`, `ORU_R30`, `PMU_B01`, `PMU_B04`
`QBP_Q11`, `QBP_Q21`, `QCN_J01`, `QSB_Q16`, `RDE_O11`, `RDY_K15`, `RQI_I01`, `RRE_O12`, `RSP_K23`, `RTB_K13`
`SDR_S31`, `SDR_S32`, `SLR_S28`, `UNKNOWN`, `WRQ_Z01`, `WRQ_Z02`

### V291 duplicates (same key, multiple files)

- **ACK**: ACK_02_2.json, ACK_03_105.json, ACK_03_107.json, ACK_03_109.json, ACK_03_11.json, ACK_03_13.json, ACK_03_15.json, ACK_03_17.json, ACK_03_19.json, ACK_03_21.json, ACK_03_23.json, ACK_03_25.json, ACK_03_27.json, ACK_03_29.json, ACK_03_31.json, ACK_03_33.json, ACK_03_35.json, ACK_03_37.json, ACK_03_39.json, ACK_03_41.json, ACK_03_43.json, ACK_03_45.json, ACK_03_47.json, ACK_03_49.json, ACK_03_5.json, ACK_03_51.json, ACK_03_53.json, ACK_03_55.json, ACK_03_57.json, ACK_03_59.json, ACK_03_61.json, ACK_03_63.json, ACK_03_65.json, ACK_03_67.json, ACK_03_69.json, ACK_03_7.json, ACK_03_71.json, ACK_03_73.json, ACK_03_75.json, ACK_03_77.json, ACK_03_79.json, ACK_03_81.json, ACK_03_83.json, ACK_03_85.json, ACK_03_87.json, ACK_03_89.json, ACK_03_9.json, ACK_03_91.json, ACK_03_93.json, ACK_03_95.json, ACK_05_186.json, ACK_05_188.json, ACK_05_190.json, ACK_05_192.json, ACK_06_208.json, ACK_06_210.json, ACK_06_212.json, ACK_06_214.json, ACK_06_216.json, ACK_06_218.json, ACK_06_220.json, ACK_06_222.json, ACK_07_224.json, ACK_07_226.json, ACK_07_228.json, ACK_07_230.json, ACK_09_279.json, ACK_09_281.json, ACK_09_283.json, ACK_09_285.json, ACK_09_287.json, ACK_09_289.json, ACK_09_291.json, ACK_09_293.json, ACK_09_295.json, ACK_09_297.json, ACK_09_299.json, ACK_10_301.json, ACK_11_311.json, ACK_12_324.json, ACK_12_326.json, ACK_12_328.json, ACK_12_330.json, ACK_15_334.json, ACK_15_336.json, ACK_15_338.json, ACK_15_340.json, ACK_15_342.json, ACK_15_344.json, ACK_15_347.json, ACK_15_349.json, ACK_17_365.json, ACK_17_368.json, ACK_17_371.json, ACK_17_374.json, ACK_17_377.json, ACK_17_380.json, ACK_17_382.json, ACK_17_384.json, ACK_17_386.json, ACK_17_388.json
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
- **MDM_T01**: MDM_T01_09_278.json, MDM_T01_09_282.json, MDM_T01_09_286.json, MDM_T01_09_290.json, MDM_T01_09_294.json, MDM_T01_09_298.json
- **MDM_T02**: MDM_T02_09_280.json, MDM_T02_09_284.json, MDM_T02_09_288.json, MDM_T02_09_292.json, MDM_T02_09_296.json
- **MFK_M01**: MFK_M01_08_245.json, MFK_M01_08_247.json, MFK_M01_08_249.json, MFK_M01_08_251.json, MFK_M01_08_253.json, MFK_M01_08_255.json, MFK_M01_08_257.json, MFK_M01_08_259.json, MFK_M01_08_261.json, MFK_M01_08_263.json, MFK_M01_08_265.json, MFK_M01_08_267.json, MFK_M01_08_269.json, MFK_M01_08_271.json, MFK_M01_08_273.json, MFK_M01_08_275.json, MFK_M01_08_277.json
- **NMD_N02**: NMD_N02_14_331.json, NMD_N02_14_332.json
- **ORU_R01**: ORU_R01_07_223.json, ORU_R01_07_236.json, ORU_R01_07_238.json, ORU_R01_07_239.json
- **ORU_R30**: ORU_R30_07_225.json, ORU_R30_07_227.json, ORU_R30_07_229.json
- **PMU_B01**: PMU_B01_15_333.json, PMU_B01_15_335.json
- **PMU_B04**: PMU_B04_15_339.json, PMU_B04_15_341.json, PMU_B04_15_343.json
- **QBP_Q11**: QBP_Q11_04A_124.json, QBP_Q11_05_180.json, QBP_Q11_05_196.json, QBP_Q11_05_198.json
- **QBP_Q21**: QBP_Q21_03_100.json, QBP_Q21_03_102.json, QBP_Q21_03_110.json, QBP_Q21_03_96.json, QBP_Q21_03_98.json
- **QCN_J01**: QCN_J01_05_189.json, QCN_J01_05_191.json
- **QSB_Q16**: QSB_Q16_05_185.json, QSB_Q16_05_193.json
- **RDE_O11**: RDE_O11_04A_114.json, RDE_O11_04A_122.json
- **RDY_K15**: RDY_K15_05_176.json, RDY_K15_05_179.json, RDY_K15_05_184.json, RDY_K15_05_203.json
- **RQI_I01**: RQI_I01_11_302.json, RQI_I01_11_304.json, RQI_I01_11_306.json, RQI_I01_11_310.json
- **RRE_O12**: RRE_O12_04A_115.json, RRE_O12_04A_123.json
- **RSP_K23**: RSP_K23_03_101.json, RSP_K23_03_103.json
- **RTB_K13**: RTB_K13_05_177.json, RTB_K13_05_182.json, RTB_K13_05_200.json, RTB_K13_05_201.json, RTB_K13_05_202.json, RTB_K13_05_205.json, RTB_K13_05_206.json
- **SDR_S31**: SDR_S31_17_373.json, SDR_S31_17_375.json, SDR_S31_17_385.json
- **SDR_S32**: SDR_S32_17_376.json, SDR_S32_17_378.json, SDR_S32_17_387.json
- **SLR_S28**: SLR_S28_17_364.json, SLR_S28_17_366.json, SLR_S28_17_367.json, SLR_S28_17_369.json, SLR_S28_17_370.json, SLR_S28_17_372.json, SLR_S28_17_381.json, SLR_S28_17_383.json

### FHIR-only breakdown

The 259 FHIR-only structures break down as:

| Category | Count | Explanation |
|----------|-------|-------------|
| ACK variants | 115 | FHIR creates one ACK structure per event; V291 has a single ACK |
| Sub-variants | 125 | FHIR splits base structures into lettered sub-variants (e.g. ADT_A01_A/B/C/D) |
| Genuinely missing | 19 | Structures not extracted from V291 Word docs |

**Genuinely missing from V291 extraction:**

`DEL_O46`, `DEO_O45`, `DPR_O48`, `DRC_O47`, `EAC_U07`, `EAN_U09`, `EAR_U08`, `ESR_U02`, `ESU_U01`, `INR_U06`
`INR_U14`, `INU_U05`, `OMI_O23`, `OML_O21`, `OML_O39`, `SIU_S12`, `SRR_S01`, `SSR_U04`, `SSU_U03`

**Genuinely in V291 only (not in FHIR at all):**

- `WRQ_Z01`
- `WRQ_Z02`

---

## Events

**FHIR:** 356 | **V291:** 275 | **Matched:** 264

### In FHIR but not V291 (92)

`A18`, `A19`, `A30`, `A34`, `A35`, `A36`, `A39`, `A46`, `A48`, `C01`
`C02`, `C03`, `C04`, `C05`, `C06`, `C07`, `C08`, `C09`, `C10`, `C11`
`C12`, `E30`, `E31`, `I05`, `I06`, `M01`, `M03`, `N01`, `O21`, `O23`
`O39`, `O45`, `O46`, `O47`, `O48`, `O59_A`, `O59_B`, `P04`, `P07`, `P08`
`P09`, `PC1`, `PC2`, `PC3`, `PC4`, `PC5`, `PC6`, `PC7`, `PC8`, `PC9`
`PCA`, `PCB`, `PCC`, `PCD`, `PCE`, `PCF`, `PCG`, `PCH`, `PCJ`, `PCK`
`PCL`, `Q25`, `R02`, `R04`, `R21`, `S25`, `T12`, `U01`, `U02`, `U03`
`U04`, `U05`, `U06`, `U07`, `U08`, `U09`, `U10`, `U11`, `U12`, `U13`
`U14`, `V01`, `V02`, `V03`, `Z85`, `Z95`, `ZNN_A`, `ZNN_B`, `ZNN_C`, `ZNN_D`
`ZNN_E`, `ZNN_F`

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
- **I01**: I01_11_307.json, I01_11_308.json
- **I02**: I02_11_309.json, I02_11_310.json
- **I03**: I03_11_311.json, I03_11_312.json
- **I04**: I04_11_313.json, I04_11_314.json
- **I07**: I07_11_315.json, I07_11_316.json
- **I08**: I08_11_317.json, I08_11_321.json
- **I09**: I09_11_318.json, I09_11_322.json
- **I10**: I10_11_319.json, I10_11_323.json
- **I11**: I11_11_320.json, I11_11_324.json
- **I12**: I12_11_325.json, I12_11_329.json
- **I13**: I13_11_326.json, I13_11_330.json
- **I14**: I14_11_327.json, I14_11_331.json
- **I15**: I15_11_328.json, I15_11_332.json
- **I19**: I19_11_338.json, I19_11_339.json
- **I22**: I22_11_340.json, I22_11_341.json
- **O59**: O59_04A_127.json, O59_04_148.json
- **P01**: P01_06_197.json, P01_06_198.json
- **P02**: P02_06_199.json, P02_06_200.json
- **P03**: P03_06_201.json, P03_06_202.json
- **P05**: P05_06_203.json, P05_06_204.json
- **P06**: P06_06_205.json, P06_06_206.json
- **P10**: P10_06_207.json, P10_06_208.json
- **P11**: P11_06_209.json, P11_06_210.json
- **P12**: P12_06_211.json, P12_06_212.json
- **S01**: S01_10_255.json, S01_10_266.json
- **S02**: S02_10_256.json, S02_10_267.json
- **S03**: S03_10_257.json, S03_10_268.json
- **S04**: S04_10_258.json, S04_10_269.json
- **S05**: S05_10_259.json, S05_10_270.json
- **S06**: S06_10_260.json, S06_10_271.json
- **S07**: S07_10_261.json, S07_10_272.json
- **S08**: S08_10_262.json, S08_10_273.json
- **S09**: S09_10_263.json, S09_10_274.json
- **S10**: S10_10_264.json, S10_10_275.json
- **S11**: S11_10_265.json, S11_10_276.json
- **S12**: S12_10_277.json, S12_10_292.json
- **S13**: S13_10_278.json, S13_10_293.json
- **S14**: S14_10_279.json, S14_10_294.json
- **S15**: S15_10_280.json, S15_10_295.json
- **S16**: S16_10_281.json, S16_10_296.json
- **S17**: S17_10_282.json, S17_10_297.json
- **S18**: S18_10_283.json, S18_10_298.json
- **S19**: S19_10_284.json, S19_10_299.json
- **S20**: S20_10_285.json, S20_10_300.json
- **S21**: S21_10_286.json, S21_10_301.json
- **S22**: S22_10_287.json, S22_10_302.json
- **S23**: S23_10_288.json, S23_10_303.json
- **S24**: S24_10_289.json, S24_10_304.json
- **S26**: S26_10_290.json, S26_10_305.json
- **S27**: S27_10_291.json, S27_10_306.json

---

## Missing Events by Chapter/Domain

V291 extraction only captured events from chapters 02, 03, 04A, 06, 11. Events from all other chapters are missing. Root cause: extraction regex only matches simple event codes, fails on hyphens/commas/ranges.

| Chapter/Domain | Missing Events |
|----------------|----------------|
| CH03-ADT | 9 |
| CH04-OrderEntry | 9 |
| CH04-Pharmacy | 3 |
| CH05-Query | 9 |
| CH06-Financial | 4 |
| CH07-Observation | 15 |
| CH08-MasterFiles | 2 |
| CH09-DocMgmt | 1 |
| CH10-Scheduling | 1 |
| CH11-Referral | 2 |
| CH12-PatientCare | 20 |
| CH13-Automation | 16 |
| CH14-AppMgmt | 1 |

## Event Details (V291)

V291 events include message type and structure mappings. Multiple entries per event code indicate different message type / structure combinations.

### Events with multiple message type mappings (99)

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
- **O59**: RCV^O59^RCV_O59, OML^O59^OML_O59
- **P01**: BAR^P01^BAR_P01, ACK^P01^ACK
- **P02**: BAR^P02^BAR_P02, ACK^P02^ACK
- **P03**: DFT^P03^DFT_P03, ACK^P03^ACK
- **P05**: BAR^P05^BAR_P05, ACK^P05^ACK
- **P06**: BAR^P06^BAR_P06, ACK^P06^ACK
- **P10**: BAR^P10^BAR_P10, ACK^P10^ACK
- **P11**: DFT^P11^DFT_P11, ACK^P11^ACK
- **P12**: BAR^P12^BAR_P12, ACK^P12^ACK
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

## Notes

- **Primitive data types** (12) exist only in FHIR — not extracted from V291 Word docs
- **Messages** (696) exist only in FHIR — not extracted from V291 Word docs
- **Vocabulary** (797 tables) extracted from V291 — compared separately in vocabulary-comparison-report
- **Query parameters** (24 files) extracted from V291 — no FHIR equivalent yet
- Matching logic: segments by filename, data types by case-insensitive filename, message structures by structureId/filename, events by eventCode
