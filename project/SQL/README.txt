FINAL 21-ENTITY STRICT 3NF SQL PACKAGE
======================================

Matches: FINAL_21_ENTITY_STRICT_3NF.xlsx

Entities: 21
Total rows: 2288

Strict 3NF design:
- AREA_LEVEL stores administrative-level descriptions.
- MEASUREMENT_UNIT stores units once.
- INDICATOR_DEFINITION stores domain + indicator + unit relationship once.
- POPULATION_CATEGORY stores population categories once.
- Fact tables contain FKs and observation values; unit/indicator descriptions are not repeated.
- Constant/redundant columns from the previous 17-table version were removed.
- CONSUMPTION_PATTERN stores one source fact rather than duplicate value/share columns.

Validation before packaging:
- Duplicate PKs: none
- Broken FKs: none
- Duplicate documented candidate keys: none

Expected rows:
- AREA_LEVEL: 4
- ADMINISTRATIVE_AREA: 55
- MEASUREMENT_UNIT: 10
- INDICATOR_DEFINITION: 42
- POPULATION_CATEGORY: 8
- POPULATION_DEMOGRAPHY: 256
- DEMOGRAPHIC_RATIO: 195
- HOUSEHOLD_STRUCTURE: 232
- MARITAL_STATUS: 45
- RELIGION_DISTRIBUTION: 85
- DISABILITY_PROFILE: 90
- EDUCATION_PROFILE: 180
- MIGRATION_PROFILE: 20
- ETHNICITY_PROFILE: 83
- DIGITAL_ACCESS: 108
- HOUSING_CONDITION: 27
- BASIC_SERVICES_ACCESS: 162
- HOUSEHOLD_EXPENDITURE: 258
- CONSUMPTION_PATTERN: 90
- POVERTY_PROFILE: 254
- INEQUALITY_PROFILE: 84
