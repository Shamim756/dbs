# Socio-Economic Data Integration Model for Bangladesh

## Project Overview

This project was developed as part of the Database Systems Lab course
of the Department of Computer Science and Engineering, University of
Chittagong.

The objective of the project is to collect, organize, transform, and
integrate socio-economic data related to Bangladesh into a structured
relational database model.

The project focuses on multiple socio-economic domains, including:

- Population and demographic information
- Household information
- Food prices
- Education indicators
- Sustainable Development Goal (SDG) indicators
- Internal displacement data
- Import and export transactions
- Geographic information
- Commodities and products

---

## Course Information

- Course: Database Systems Lab
- Department: Computer Science and Engineering
- University: University of Chittagong
- Scrum Level: Level-01
- Group: Group-14
- Project Sector: Socio-Economic Sector

---

## Team Members

| Name | Role |
|------|------|
| Shamim Hosen | Scrum Master |
| Naim Uddin Mohammad Forhan | Team Member |
| Ashfaq Rahman | Team Member |

---

## Project Workflow

The project was developed in three major stages.

### Sprint 1 — Research and Data Collection

The first stage focused on identifying socio-economic data sources,
collecting relevant information, and organizing the collected files.

### Sprint 2 — Data Transformation and Entity Identification

The collected datasets were reviewed and prepared for database
modeling. Activities included:

- Data cleaning
- Handling missing values
- Removing or identifying duplicate records
- Standardizing names
- Standardizing formats
- Identifying entities and attributes
- Preparing data for ETL processing

### Sprint 3 — ER Modeling and Integration

The processed datasets were analyzed to identify entities,
relationships, primary keys, foreign keys, and cardinalities.

The individual data models were then integrated into a unified
Socio-Economic ER model.

---

## Repository Structure

```text
project/
│
├── README.md
│
├── csv/
│   ├── DIVISION.csv
│   ├── DISTRICT.csv
│   ├── POPULATION_CENSUS.csv
│   ├── HOUSEHOLD_TYPE.csv
│   ├── MARITAL_STATUS.csv
│   ├── RELIGION_DIST.csv
│   ├── COMMODITY.csv
│   ├── FOOD_PRICE.csv
│   ├── EXPORT_TRANSACTION.csv
│   ├── EXPORTER.csv
│   ├── BUYER.csv
│   ├── DECLARANT.csv
│   ├── PRODUCT.csv
│   ├── COUNTRY.csv
│   ├── IMPORT_TRANSACTION.csv
│   ├── SDG_INDICATOR.csv
│   ├── IDP_DATA.csv
│   ├── DISPLACEMENT_EVENT.csv
│   └── EDUCATION_INDICATOR.csv
│
├── SQL/
│   ├── database creation scripts
│   └── data insertion scripts
│
├── DBMS_PROJECT.xlsx
│
├── python(base)
│
└── Project Report
