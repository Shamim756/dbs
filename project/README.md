# Bangladesh Socio-Economic Database Project

## Project Overview

This project develops a structured relational database for storing and analyzing
socio-economic and demographic data of Bangladesh.

The database integrates data from multiple recognized sources, primarily:

- Bangladesh Bureau of Statistics (BBS)
- Population and Housing Census 2022
- Socio-Economic and Demographic Survey (SEDS) 2023
- Household Income and Expenditure Survey (HIES)
- Humanitarian Data Exchange (HDX)
- Other registered supplementary sources

The main purpose of the project is to collect, organize, normalize, and store
socio-economic information in a relational database so that the data can be
queried and analyzed efficiently.

---

# Repository Structure

```text
project/
│
├── README.md
│
├── data/
│   ├── raw/
│   │   └── Original source files / source references
│   │
│   └── processed/
│       ├── FINAL_21_ENTITY_STRICT_3NF.xlsx
│       └── CSV/
│           ├── AREA_LEVEL.csv
│           ├── ADMINISTRATIVE_AREA.csv
│           ├── MEASUREMENT_UNIT.csv
│           ├── INDICATOR_DEFINITION.csv
│           ├── POPULATION_CATEGORY.csv
│           ├── POPULATION_DEMOGRAPHY.csv
│           ├── DEMOGRAPHIC_RATIO.csv
│           ├── HOUSEHOLD_STRUCTURE.csv
│           ├── MARITAL_STATUS.csv
│           ├── RELIGION_DISTRIBUTION.csv
│           ├── DISABILITY_PROFILE.csv
│           ├── EDUCATION_PROFILE.csv
│           ├── MIGRATION_PROFILE.csv
│           ├── ETHNICITY_PROFILE.csv
│           ├── DIGITAL_ACCESS.csv
│           ├── HOUSING_CONDITION.csv
│           ├── BASIC_SERVICES_ACCESS.csv
│           ├── HOUSEHOLD_EXPENDITURE.csv
│           ├── CONSUMPTION_PATTERN.csv
│           ├── POVERTY_PROFILE.csv
│           └── INEQUALITY_PROFILE.csv
│
├── sql/
│   ├── ORACLE/
│   │   ├── CREATE/
│   │   ├── INSERT/
│   │   ├── ALL_TABLES_CREATE.sql
│   │   ├── ALL_TABLES_INSERT.sql
│   │   ├── DROP_ALL_TABLES.sql
│   │   ├── VERIFY_ROW_COUNTS.sql
│   │   └── RUN_ALL.sql
│   │
│   └── MYSQL_MARIADB/
│       ├── CREATE/
│       ├── INSERT/
│       ├── ALL_TABLES_CREATE.sql
│       ├── ALL_TABLES_INSERT.sql
│       ├── DROP_ALL_TABLES.sql
│       ├── VERIFY_ROW_COUNTS.sql
│       └── RUN_ALL.sql
│
├── documentation/
│   ├── Initial_ER_Diagram_17_Entities.png
│   ├── Final_3NF_Schema_21_Tables.png
│   ├── STRICT_3NF_NORMALIZATION_PROOF.xlsx
│   └── Entity_Attribute_Data_Source_Map.xlsx
│
└── source/
    └── Source catalog and source links
