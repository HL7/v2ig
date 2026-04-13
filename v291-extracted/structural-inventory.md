# Structural Inventory: FHIR vs V2.9.1

Comprehensive comparison of all artifact types between FHIR StructureDefinitions and V2.9.1 Word document extractions.

## Overview

| Artifact Type | FHIR | V291 | Matched | FHIR Only | V291 Only |
|---------------|------|------|---------|-----------|-----------|
| Segments | 192 | 175 | 174 | 18 | 1 |
| Complex Data Types | 71 | 71 | 71 | 0 | 0 |
| Message Structures | 418 | 179 | 142 | 276 | 37 |
| Events | 356 | 79 | 78 | 278 | 1 |
| Primitive Data Types | 12 | 0 | — | — | — |
| Messages | 696 | 0 | — | — | — |
| Vocabulary / Value Sets | — | 797 | — | — | — |

## Segments

**FHIR:** 192 | **V291:** 175 | **Matched:** 174

### In FHIR but not V291 (18)

`BPX`, `BTX`, `BUI`, `CNS`, `DST`, `ECD`, `ECR`, `EQP`, `EQU`, `HXX`
`INV`, `ISD`, `NDS`, `SAC`, `SID`, `TCC`, `TCD`, `VARIES`

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

**FHIR:** 418 | **V291:** 179 | **Matched:** 142

### In FHIR but not V291 (276)

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
`ADT_A61_A`, `ADT_A61_B`, `CCR_I16`, `CRM_C01`, `CSU_C09`, `DEL_O46`, `DEO_O45`, `DPR_O48`, `DRC_O47`, `EAC_U07`
`EAN_U09`, `EAR_U08`, `ESR_U02`, `ESU_U01`, `INR_U06`, `INR_U14`, `INU_U05`, `LSU_U12_A`, `LSU_U12_B`, `MDM_T01_A`
`MDM_T01_B`, `MDM_T01_C`, `MDM_T01_D`, `MDM_T01_E`, `MDM_T01_F`, `MDM_T02_A`, `MDM_T02_B`, `MDM_T02_C`, `MDM_T02_D`, `MDM_T02_E`
`MFK_M01_A`, `MFK_M01_B`, `MFK_M01_C`, `MFK_M01_D`, `MFK_M01_E`, `MFK_M01_F`, `MFK_M01_G`, `MFK_M01_H`, `MFK_M01_I`, `MFK_M01_J`
`MFK_M01_K`, `MFK_M01_L`, `MFK_M01_M`, `MFK_M01_N`, `MFK_M01_O`, `MFK_M01_P`, `MFN_ZNN`, `OMI_O23`, `OML_O21`, `OML_O39`
`ORU_R01_A`, `ORU_R01_B`, `ORU_R01_C`, `ORU_R01_D`, `ORU_R30_A`, `ORU_R30_B`, `ORU_R30_C`, `PEX_P07`, `PGL_PC6`, `PMU_B01_A`
`PMU_B01_B`, `PMU_B04_A`, `PMU_B04_B`, `PMU_B04_C`, `PPG_PCG`, `PPP_PCB`, `PPR_PC1`, `QBP_Q11_A`, `QBP_Q11_B`, `QBP_Q11_C`
`QBP_Q11_D`, `QBP_Q11_E`, `QBP_Q21_A`, `QBP_Q21_B`, `QBP_Q21_C`, `QBP_Q21_D`, `QBP_Q21_E`, `QBP_Q21_F`, `QBP_QNN`, `QCN_J01_A`
`QCN_J01_B`, `QSB_Q16_A`, `QSB_Q16_B`, `RDE_O11_A`, `RDE_O11_B`, `RDY_K15_A`, `RDY_K15_B`, `RDY_K15_C`, `RDY_K15_D`, `REF_I12`
`RPA_I08`, `RQA_I08`, `RQI_I01_A`, `RQI_I01_B`, `RQI_I01_C`, `RQI_I01_D`, `RRE_O12_A`, `RRE_O12_B`, `RRI_I12`, `RSP_K23_A`
`RSP_K23_B`, `RSP_ZNN`, `RTB_K13_A`, `RTB_K13_B`, `RTB_K13_C`, `RTB_K13_D`, `RTB_K13_E`, `RTB_K13_F`, `RTB_K13_G`, `RTB_KNN`
`SDR_S31_A`, `SDR_S31_B`, `SDR_S32_A`, `SDR_S32_B`, `SIU_S12`, `SLR_S28_A`, `SLR_S28_B`, `SLR_S28_C`, `SLR_S28_D`, `SLR_S28_E`
`SRM_S01`, `SRR_S01`, `SSR_U04`, `SSU_U03`, `TCU_U10_A`, `TCU_U10_B`

### In V291 but not FHIR (37)

`ACK`, `ADT_A01`, `ADT_A05`, `ADT_A06`, `ADT_A09`, `ADT_A21`, `ADT_A39`, `ADT_A43`, `ADT_A44`, `ADT_A50`
`ADT_A52`, `ADT_A54`, `ADT_A61`, `MDM_T01`, `MDM_T02`, `MFK_M01`, `MFN_Z`, `ORU_R01`, `ORU_R30`, `PMU_B01`
`PMU_B04`, `QBP_Q11`, `QBP_Q21`, `QCN_J01`, `QSB_Q16`, `RDE_O11`, `RDY_K15`, `RQI_I01`, `RRE_O12`, `RSP_K23`
`RTB_K13`, `SDR_S31`, `SDR_S32`, `SLR_S28`, `UNKNOWN`, `WRQ_Z01`, `WRQ_Z02`

### V291 duplicates (same key, multiple files)

- **ACK**: ACK_03_105.json, ACK_03_107.json, ACK_03_109.json, ACK_03_11.json, ACK_03_13.json, ACK_03_15.json, ACK_03_17.json, ACK_03_19.json, ACK_03_21.json, ACK_03_23.json, ACK_03_25.json, ACK_03_27.json, ACK_03_29.json, ACK_03_31.json, ACK_03_33.json, ACK_03_35.json, ACK_03_37.json, ACK_03_39.json, ACK_03_41.json, ACK_03_43.json, ACK_03_45.json, ACK_03_47.json, ACK_03_49.json, ACK_03_5.json, ACK_03_51.json, ACK_03_53.json, ACK_03_55.json, ACK_03_57.json, ACK_03_59.json, ACK_03_61.json, ACK_03_63.json, ACK_03_65.json, ACK_03_67.json, ACK_03_69.json, ACK_03_7.json, ACK_03_71.json, ACK_03_73.json, ACK_03_75.json, ACK_03_77.json, ACK_03_79.json, ACK_03_81.json, ACK_03_83.json, ACK_03_85.json, ACK_03_87.json, ACK_03_89.json, ACK_03_9.json, ACK_03_91.json, ACK_03_93.json, ACK_03_95.json, ACK_05_186.json, ACK_05_188.json, ACK_05_190.json, ACK_05_192.json, ACK_06_208.json, ACK_06_210.json, ACK_06_212.json, ACK_06_214.json, ACK_06_216.json, ACK_06_218.json, ACK_06_220.json, ACK_06_222.json, ACK_07_224.json, ACK_07_226.json, ACK_07_228.json, ACK_07_230.json, ACK_09_279.json, ACK_09_281.json, ACK_09_283.json, ACK_09_285.json, ACK_09_287.json, ACK_09_289.json, ACK_09_291.json, ACK_09_293.json, ACK_09_295.json, ACK_09_297.json, ACK_09_299.json, ACK_11_311.json, ACK_15_334.json, ACK_15_336.json, ACK_15_338.json, ACK_15_340.json, ACK_15_342.json, ACK_15_344.json, ACK_15_347.json, ACK_15_349.json, ACK_17_365.json, ACK_17_368.json, ACK_17_371.json, ACK_17_374.json, ACK_17_377.json, ACK_17_380.json, ACK_17_382.json, ACK_17_384.json, ACK_17_386.json, ACK_17_388.json
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
- **RDY_K15**: RDY_K15_05_184.json, RDY_K15_05_203.json
- **RQI_I01**: RQI_I01_11_302.json, RQI_I01_11_304.json, RQI_I01_11_306.json, RQI_I01_11_310.json
- **RRE_O12**: RRE_O12_04A_115.json, RRE_O12_04A_123.json
- **RSP_K23**: RSP_K23_03_101.json, RSP_K23_03_103.json
- **RTB_K13**: RTB_K13_05_182.json, RTB_K13_05_200.json, RTB_K13_05_201.json, RTB_K13_05_202.json, RTB_K13_05_205.json, RTB_K13_05_206.json
- **SDR_S31**: SDR_S31_17_373.json, SDR_S31_17_375.json, SDR_S31_17_385.json
- **SDR_S32**: SDR_S32_17_376.json, SDR_S32_17_378.json, SDR_S32_17_387.json
- **SLR_S28**: SLR_S28_17_364.json, SLR_S28_17_366.json, SLR_S28_17_367.json, SLR_S28_17_369.json, SLR_S28_17_370.json, SLR_S28_17_372.json, SLR_S28_17_381.json, SLR_S28_17_383.json
- **UNKNOWN**: UNKNOWN_02_2.json, UNKNOWN_02_3.json, UNKNOWN_05_174.json, UNKNOWN_05_175.json, UNKNOWN_05_176.json, UNKNOWN_05_177.json, UNKNOWN_05_178.json, UNKNOWN_05_179.json, UNKNOWN_07_240.json, UNKNOWN_07_241.json, UNKNOWN_07_242.json, UNKNOWN_10_300.json, UNKNOWN_10_301.json, UNKNOWN_11_312.json, UNKNOWN_11_313.json, UNKNOWN_11_314.json, UNKNOWN_11_315.json, UNKNOWN_11_317.json, UNKNOWN_12_323.json, UNKNOWN_12_324.json, UNKNOWN_12_325.json, UNKNOWN_12_326.json, UNKNOWN_12_327.json, UNKNOWN_12_328.json, UNKNOWN_12_329.json, UNKNOWN_12_330.json

### FHIR-only breakdown

The 276 FHIR-only structures break down as:

| Category | Count | Explanation |
|----------|-------|-------------|
| ACK variants | 115 | FHIR creates one ACK structure per event; V291 has a single ACK |
| Sub-variants | 125 | FHIR splits base structures into lettered sub-variants (e.g. ADT_A01_A/B/C/D) |
| Genuinely missing | 36 | Structures not extracted from V291 Word docs |

**Genuinely missing from V291 extraction:**

`CCR_I16`, `CRM_C01`, `CSU_C09`, `DEL_O46`, `DEO_O45`, `DPR_O48`, `DRC_O47`, `EAC_U07`, `EAN_U09`, `EAR_U08`
`ESR_U02`, `ESU_U01`, `INR_U06`, `INR_U14`, `INU_U05`, `MFN_ZNN`, `OMI_O23`, `OML_O21`, `OML_O39`, `PEX_P07`
`PGL_PC6`, `PPG_PCG`, `PPP_PCB`, `PPR_PC1`, `QBP_QNN`, `REF_I12`, `RPA_I08`, `RQA_I08`, `RRI_I12`, `RSP_ZNN`
`RTB_KNN`, `SIU_S12`, `SRM_S01`, `SRR_S01`, `SSR_U04`, `SSU_U03`

**Genuinely in V291 only (not in FHIR at all):**

- `MFN_Z`
- `WRQ_Z01`
- `WRQ_Z02`

---

## Events

**FHIR:** 356 | **V291:** 79 | **Matched:** 78

### In FHIR but not V291 (278)

`A18`, `A19`, `A30`, `A34`, `A35`, `A36`, `A39`, `A46`, `A48`, `B01`
`B02`, `B03`, `B04`, `B05`, `B06`, `B07`, `B08`, `C01`, `C02`, `C03`
`C04`, `C05`, `C06`, `C07`, `C08`, `C09`, `C10`, `C11`, `C12`, `E01`
`E02`, `E03`, `E04`, `E10`, `E12`, `E13`, `E15`, `E20`, `E21`, `E22`
`E24`, `E30`, `E31`, `I05`, `I06`, `I08`, `I09`, `I10`, `I11`, `I16`
`I17`, `I18`, `J01`, `J02`, `K11`, `K13`, `K15`, `K25`, `K33`, `K34`
`M01`, `M02`, `M03`, `M04`, `M05`, `M06`, `M07`, `M08`, `M09`, `M10`
`M11`, `M12`, `M13`, `M14`, `M15`, `M16`, `M17`, `M18`, `M19`, `N01`
`N02`, `O03`, `O04`, `O05`, `O06`, `O07`, `O08`, `O09`, `O10`, `O11`
`O12`, `O13`, `O14`, `O15`, `O16`, `O17`, `O18`, `O19`, `O20`, `O21`
`O22`, `O23`, `O24`, `O25`, `O26`, `O27`, `O28`, `O29`, `O30`, `O31`
`O32`, `O33`, `O34`, `O35`, `O36`, `O37`, `O38`, `O39`, `O40`, `O41`
`O42`, `O43`, `O44`, `O45`, `O46`, `O47`, `O48`, `O49`, `O50`, `O51`
`O52`, `O53`, `O54`, `O55`, `O56`, `O57`, `O58`, `O59_A`, `O59_B`, `P04`
`P07`, `P08`, `P09`, `PC1`, `PC2`, `PC3`, `PC4`, `PC5`, `PC6`, `PC7`
`PC8`, `PC9`, `PCA`, `PCB`, `PCC`, `PCD`, `PCE`, `PCF`, `PCG`, `PCH`
`PCJ`, `PCK`, `PCL`, `Q11`, `Q15`, `Q16`, `Q17`, `Q25`, `Q33`, `Q34`
`R01`, `R02`, `R04`, `R21`, `R22`, `R23`, `R24`, `R25`, `R26`, `R30`
`R31`, `R32`, `R33`, `R40`, `R41`, `R42`, `R43`, `S01`, `S02`, `S03`
`S04`, `S05`, `S06`, `S07`, `S08`, `S09`, `S10`, `S11`, `S12`, `S13`
`S14`, `S15`, `S16`, `S17`, `S18`, `S19`, `S20`, `S21`, `S22`, `S23`
`S24`, `S25`, `S26`, `S27`, `S28`, `S29`, `S30`, `S31`, `S32`, `S33`
`S34`, `S35`, `S36`, `S37`, `T01`, `T02`, `T03`, `T04`, `T05`, `T06`
`T07`, `T08`, `T09`, `T10`, `T11`, `T12`, `U01`, `U02`, `U03`, `U04`
`U05`, `U06`, `U07`, `U08`, `U09`, `U10`, `U11`, `U12`, `U13`, `U14`
`V01`, `V02`, `V03`, `V04`, `Z73`, `Z74`, `Z76`, `Z78`, `Z80`, `Z82`
`Z83`, `Z84`, `Z85`, `Z87`, `Z88`, `Z89`, `Z90`, `Z92`, `Z94`, `Z95`
`Z98`, `Z99`, `ZNN_A`, `ZNN_B`, `ZNN_C`, `ZNN_D`, `ZNN_E`, `ZNN_F`

### In V291 but not FHIR (1)

`YYY`

### V291 duplicates (same key, multiple files)

- **A01**: A01_03_1.json, A01_03_2.json
- **A02**: A02_03_3.json, A02_03_4.json
- **A03**: A03_03_5.json, A03_03_6.json
- **A04**: A04_03_7.json, A04_03_8.json
- **A05**: A05_03_10.json, A05_03_9.json
- **A06**: A06_03_11.json, A06_03_12.json
- **A07**: A07_03_13.json, A07_03_14.json
- **A08**: A08_03_15.json, A08_03_16.json
- **A09**: A09_03_17.json, A09_03_18.json
- **A10**: A10_03_19.json, A10_03_20.json
- **A11**: A11_03_21.json, A11_03_22.json
- **A12**: A12_03_23.json, A12_03_24.json
- **A13**: A13_03_25.json, A13_03_26.json
- **A14**: A14_03_27.json, A14_03_28.json
- **A15**: A15_03_29.json, A15_03_30.json
- **A16**: A16_03_31.json, A16_03_32.json
- **A17**: A17_03_33.json, A17_03_34.json
- **A20**: A20_03_35.json, A20_03_36.json
- **A21**: A21_03_37.json, A21_03_38.json
- **A22**: A22_03_39.json, A22_03_40.json
- **A23**: A23_03_41.json, A23_03_42.json
- **A24**: A24_03_43.json, A24_03_44.json
- **A25**: A25_03_45.json, A25_03_46.json
- **A26**: A26_03_47.json, A26_03_48.json
- **A27**: A27_03_49.json, A27_03_50.json
- **A28**: A28_03_51.json, A28_03_52.json
- **A29**: A29_03_53.json, A29_03_54.json
- **A31**: A31_03_55.json, A31_03_56.json
- **A32**: A32_03_57.json, A32_03_58.json
- **A33**: A33_03_59.json, A33_03_60.json
- **A37**: A37_03_61.json, A37_03_62.json
- **A38**: A38_03_63.json, A38_03_64.json
- **A40**: A40_03_65.json, A40_03_66.json
- **A41**: A41_03_67.json, A41_03_68.json
- **A42**: A42_03_69.json, A42_03_70.json
- **A43**: A43_03_71.json, A43_03_72.json
- **A44**: A44_03_73.json, A44_03_74.json
- **A45**: A45_03_75.json, A45_03_76.json
- **A47**: A47_03_77.json, A47_03_78.json
- **A49**: A49_03_79.json, A49_03_80.json
- **A50**: A50_03_81.json, A50_03_82.json
- **A51**: A51_03_83.json, A51_03_84.json
- **A52**: A52_03_85.json, A52_03_86.json
- **A53**: A53_03_87.json, A53_03_88.json
- **A54**: A54_03_89.json, A54_03_90.json
- **A55**: A55_03_91.json, A55_03_92.json
- **A60**: A60_03_101.json, A60_03_102.json
- **A61**: A61_03_103.json, A61_03_104.json
- **A62**: A62_03_105.json, A62_03_106.json
- **I01**: I01_11_127.json, I01_11_128.json
- **I02**: I02_11_129.json, I02_11_130.json
- **I03**: I03_11_131.json, I03_11_132.json
- **I04**: I04_11_133.json, I04_11_134.json
- **I07**: I07_11_135.json, I07_11_136.json
- **I19**: I19_11_139.json, I19_11_140.json
- **I22**: I22_11_141.json, I22_11_142.json
- **P01**: P01_06_111.json, P01_06_112.json
- **P02**: P02_06_113.json, P02_06_114.json
- **P03**: P03_06_115.json, P03_06_116.json
- **P05**: P05_06_117.json, P05_06_118.json
- **P06**: P06_06_119.json, P06_06_120.json
- **P10**: P10_06_121.json, P10_06_122.json
- **P11**: P11_06_123.json, P11_06_124.json
- **P12**: P12_06_125.json, P12_06_126.json

---

## Missing Events by Chapter/Domain

V291 extraction only captured events from chapters 02, 03, 04A, 06, 11. Events from all other chapters are missing. Root cause: extraction regex only matches simple event codes, fails on hyphens/commas/ranges.

| Chapter/Domain | Missing Events |
|----------------|----------------|
| CH03-ADT | 9 |
| CH04-OrderEntry | 58 |
| CH04-Pharmacy | 4 |
| CH05-Query | 39 |
| CH06-Financial | 4 |
| CH07-Observation | 29 |
| CH08-MasterFiles | 19 |
| CH09-DocMgmt | 12 |
| CH10-Scheduling | 37 |
| CH11-Referral | 9 |
| CH12-PatientCare | 20 |
| CH13-Automation | 28 |
| CH14-AppMgmt | 2 |
| CH15-Personnel | 8 |

## Event Details (V291)

V291 events include message type and structure mappings. Multiple entries per event code indicate different message type / structure combinations.

### Events with multiple message type mappings (64)

- **A01**: ADT^A01^ADT_A01, ACK^A01^ACK
- **A02**: ADT^A02^ADT_A02, ACK^A02^ACK
- **A03**: ADT^A03^ADT_A03, ACK^A03^ACK
- **A04**: ADT^A04^ADT_A01, ACK^A04^ACK
- **A05**: ACK^A05^ACK, ADT^A05^ADT_A05
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
- **I19**: CCQ^I19^CCQ_I19, CQU^I19^CQU_I19
- **I22**: CCF^I22^CCF_I22, CCI^I22^CCI_I22
- **P01**: BAR^P01^BAR_P01, ACK^P01^ACK
- **P02**: BAR^P02^BAR_P02, ACK^P02^ACK
- **P03**: DFT^P03^DFT_P03, ACK^P03^ACK
- **P05**: BAR^P05^BAR_P05, ACK^P05^ACK
- **P06**: BAR^P06^BAR_P06, ACK^P06^ACK
- **P10**: BAR^P10^BAR_P10, ACK^P10^ACK
- **P11**: DFT^P11^DFT_P11, ACK^P11^ACK
- **P12**: BAR^P12^BAR_P12, ACK^P12^ACK

## Notes

- **Primitive data types** (12) exist only in FHIR — not extracted from V291 Word docs
- **Messages** (696) exist only in FHIR — not extracted from V291 Word docs
- **Vocabulary** (797 tables) extracted from V291 — compared separately in vocabulary-comparison-report
- **Query parameters** (24 files) extracted from V291 — no FHIR equivalent yet
- Matching logic: segments by filename, data types by case-insensitive filename, message structures by structureId/filename, events by eventCode
