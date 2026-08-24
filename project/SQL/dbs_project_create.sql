-- ============================================================
-- DBS PROJECT - MariaDB / MySQL Compatible Schema
-- Converted from the provided Oracle schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS dbs_project
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE dbs_project;

-- ============================================================
-- 1. DIVISION
-- ============================================================
CREATE TABLE DIVISION (
    division_id       INT AUTO_INCREMENT,
    division_geocode  VARCHAR(30),
    division_name     VARCHAR(150),

    PRIMARY KEY (division_id),
    UNIQUE KEY uq_division_geocode (division_geocode)
) ENGINE=InnoDB;

-- ============================================================
-- 2. COUNTRY
-- ============================================================
CREATE TABLE COUNTRY (
    country_code  VARCHAR(10),
    country_name  VARCHAR(150),
    region        VARCHAR(150),

    PRIMARY KEY (country_code)
) ENGINE=InnoDB;

-- ============================================================
-- 3. COMMODITY
-- ============================================================
CREATE TABLE COMMODITY (
    commodity_id    INT AUTO_INCREMENT,
    commodity_name  VARCHAR(200),
    category        VARCHAR(150),

    PRIMARY KEY (commodity_id)
) ENGINE=InnoDB;

-- ============================================================
-- 4. PRODUCT
-- ============================================================
CREATE TABLE PRODUCT (
    product_id    INT AUTO_INCREMENT,
    hs_code       VARCHAR(30),
    chapter       VARCHAR(30),
    heading       VARCHAR(50),
    sub_heading   VARCHAR(50),
    description   VARCHAR(1000),
    package_unit  VARCHAR(100),

    PRIMARY KEY (product_id)
) ENGINE=InnoDB;

-- ============================================================
-- 5. DISTRICT
-- DIVISION 1 -------- N DISTRICT
-- ============================================================
CREATE TABLE DISTRICT (
    district_id          INT AUTO_INCREMENT,
    division_id          INT,
    district_geocode     VARCHAR(30),
    district_name        VARCHAR(150),
    population_density   DECIMAL(15,2),

    PRIMARY KEY (district_id),
    UNIQUE KEY uq_district_geocode (district_geocode),

    CONSTRAINT fk_district_division
        FOREIGN KEY (division_id)
        REFERENCES DIVISION(division_id)
) ENGINE=InnoDB;

-- ============================================================
-- 6. POPULATION_CENSUS
-- DISTRICT 1 -------- N POPULATION_CENSUS
-- ============================================================
CREATE TABLE POPULATION_CENSUS (
    census_id             INT AUTO_INCREMENT,
    district_id           INT,
    census_year           SMALLINT,
    household_total       BIGINT,
    population_total      BIGINT,
    population_male       BIGINT,
    population_female     BIGINT,
    population_hijra      BIGINT,
    population_rural      BIGINT,
    population_urban      BIGINT,
    population_slum       BIGINT,
    population_floating   BIGINT,

    PRIMARY KEY (census_id),

    CONSTRAINT fk_census_district
        FOREIGN KEY (district_id)
        REFERENCES DISTRICT(district_id)
) ENGINE=InnoDB;

-- ============================================================
-- 7. HOUSEHOLD_TYPE
-- POPULATION_CENSUS 1 -------- N HOUSEHOLD_TYPE
-- ============================================================
CREATE TABLE HOUSEHOLD_TYPE (
    hh_type_id             INT AUTO_INCREMENT,
    census_id              INT,
    hh_general             BIGINT,
    hh_institutional       BIGINT,
    hh_other               BIGINT,
    pop_general_pct        DECIMAL(7,2),
    pop_institutional_pct  DECIMAL(7,2),

    PRIMARY KEY (hh_type_id),

    CONSTRAINT fk_household_census
        FOREIGN KEY (census_id)
        REFERENCES POPULATION_CENSUS(census_id)
) ENGINE=InnoDB;

-- ============================================================
-- 8. MARITAL_STATUS
-- POPULATION_CENSUS 1 -------- N MARITAL_STATUS
-- ============================================================
CREATE TABLE MARITAL_STATUS (
    marital_id          INT AUTO_INCREMENT,
    census_id           INT,
    age_group           VARCHAR(50),
    never_married       BIGINT,
    currently_married   BIGINT,
    widowed             BIGINT,
    separated           BIGINT,

    PRIMARY KEY (marital_id),

    CONSTRAINT fk_marital_census
        FOREIGN KEY (census_id)
        REFERENCES POPULATION_CENSUS(census_id)
) ENGINE=InnoDB;

-- ============================================================
-- 9. RELIGION_DIST
-- POPULATION_CENSUS 1 -------- N RELIGION_DIST
-- ============================================================
CREATE TABLE RELIGION_DIST (
    religion_id      INT AUTO_INCREMENT,
    census_id        INT,
    muslim_total     BIGINT,
    hindu_total      BIGINT,
    christian_total  BIGINT,
    buddhist_total   BIGINT,
    other_religion   BIGINT,

    PRIMARY KEY (religion_id),

    CONSTRAINT fk_religion_census
        FOREIGN KEY (census_id)
        REFERENCES POPULATION_CENSUS(census_id)
) ENGINE=InnoDB;

-- ============================================================
-- 10. FOOD_PRICE
-- DISTRICT 1 -------- N FOOD_PRICE
-- COMMODITY 1 -------- N FOOD_PRICE
-- ============================================================
CREATE TABLE FOOD_PRICE (
    price_id      INT AUTO_INCREMENT,
    district_id   INT,
    commodity_id  INT,
    market_name   VARCHAR(200),
    price_date    DATE,
    unit          VARCHAR(100),
    price_type    VARCHAR(100),

    PRIMARY KEY (price_id),

    CONSTRAINT fk_foodprice_district
        FOREIGN KEY (district_id)
        REFERENCES DISTRICT(district_id),

    CONSTRAINT fk_foodprice_commodity
        FOREIGN KEY (commodity_id)
        REFERENCES COMMODITY(commodity_id)
) ENGINE=InnoDB;

-- ============================================================
-- 11. EXPORTER
-- COUNTRY 1 -------- N EXPORTER
-- ============================================================
CREATE TABLE EXPORTER (
    exporter_id    INT AUTO_INCREMENT,
    country_code   VARCHAR(10),
    exporter_name  VARCHAR(250),
    address        VARCHAR(1000),
    city           VARCHAR(150),
    state          VARCHAR(150),
    bank_name      VARCHAR(250),

    PRIMARY KEY (exporter_id),

    CONSTRAINT fk_exporter_country
        FOREIGN KEY (country_code)
        REFERENCES COUNTRY(country_code)
) ENGINE=InnoDB;

-- ============================================================
-- 12. BUYER
-- COUNTRY 1 -------- N BUYER
-- ============================================================
CREATE TABLE BUYER (
    buyer_id             INT AUTO_INCREMENT,
    destination_country  VARCHAR(10),
    buyer_name           VARCHAR(250),
    buyer_address        VARCHAR(1000),

    PRIMARY KEY (buyer_id),

    CONSTRAINT fk_buyer_country
        FOREIGN KEY (destination_country)
        REFERENCES COUNTRY(country_code)
) ENGINE=InnoDB;

-- ============================================================
-- 13. DECLARANT
-- ============================================================
CREATE TABLE DECLARANT (
    declarant_id       INT AUTO_INCREMENT,
    declarant_name     VARCHAR(250),
    declarant_address  VARCHAR(1000),

    PRIMARY KEY (declarant_id)
) ENGINE=InnoDB;

-- ============================================================
-- 14. EXPORT_TRANSACTION
-- EXPORTER  1 -------- N EXPORT_TRANSACTION
-- BUYER     1 -------- N EXPORT_TRANSACTION
-- DECLARANT 1 -------- N EXPORT_TRANSACTION
-- PRODUCT   1 -------- N EXPORT_TRANSACTION
-- COMMODITY 1 -------- N EXPORT_TRANSACTION
-- ============================================================
CREATE TABLE EXPORT_TRANSACTION (
    transaction_id     INT AUTO_INCREMENT,
    exporter_id        INT,
    buyer_id           INT,
    product_id         INT,
    declarant_id       INT,
    commodity_id       INT,
    transaction_date   DATE,
    no_of_packages     BIGINT,
    gross_weight_kg    DECIMAL(20,3),
    net_weight_kg      DECIMAL(20,3),
    quantity           DECIMAL(20,3),
    unit               VARCHAR(100),
    total_value_usd    DECIMAL(20,2),
    total_value_bdt    DECIMAL(20,2),
    currency           VARCHAR(20),
    exchange_rate      DECIMAL(20,6),
    delivery_terms     VARCHAR(250),
    mode_of_transport  VARCHAR(150),
    `MONTH`            TINYINT,
    `YEAR`             SMALLINT,

    PRIMARY KEY (transaction_id),

    CONSTRAINT fk_export_exporter
        FOREIGN KEY (exporter_id)
        REFERENCES EXPORTER(exporter_id),

    CONSTRAINT fk_export_buyer
        FOREIGN KEY (buyer_id)
        REFERENCES BUYER(buyer_id),

    CONSTRAINT fk_export_product
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id),

    CONSTRAINT fk_export_declarant
        FOREIGN KEY (declarant_id)
        REFERENCES DECLARANT(declarant_id),

    CONSTRAINT fk_export_commodity
        FOREIGN KEY (commodity_id)
        REFERENCES COMMODITY(commodity_id)
) ENGINE=InnoDB;

-- ============================================================
-- 15. IMPORT_TRANSACTION
-- COUNTRY 1 -------- N IMPORT_TRANSACTION
-- PRODUCT 1 -------- N IMPORT_TRANSACTION
-- ============================================================
CREATE TABLE IMPORT_TRANSACTION (
    import_id          INT AUTO_INCREMENT,
    product_id         INT,
    origin_country     VARCHAR(10),
    import_date        DATE,
    importer_name      VARCHAR(250),
    quantity           DECIMAL(20,3),
    total_value_usd    DECIMAL(20,2),
    delivery_terms     VARCHAR(250),
    mode_of_transport  VARCHAR(150),

    PRIMARY KEY (import_id),

    CONSTRAINT fk_import_product
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id),

    CONSTRAINT fk_import_country
        FOREIGN KEY (origin_country)
        REFERENCES COUNTRY(country_code)
) ENGINE=InnoDB;

-- ============================================================
-- 16. SDG_INDICATOR
-- DISTRICT 1 -------- N SDG_INDICATOR
-- ============================================================
CREATE TABLE SDG_INDICATOR (
    sdg_id          INT AUTO_INCREMENT,
    district_id     INT,
    indicator_code  VARCHAR(100),
    indicator_name  VARCHAR(300),
    sdg_goal        VARCHAR(150),
    `YEAR`          SMALLINT,
    `VALUE`         DECIMAL(20,4),
    unit            VARCHAR(100),
    area            VARCHAR(200),

    PRIMARY KEY (sdg_id),

    CONSTRAINT fk_sdg_district
        FOREIGN KEY (district_id)
        REFERENCES DISTRICT(district_id)
) ENGINE=InnoDB;

-- ============================================================
-- 17. IDP_DATA
-- DISTRICT 1 -------- N IDP_DATA
-- ============================================================
CREATE TABLE IDP_DATA (
    idp_id                INT AUTO_INCREMENT,
    district_id           INT,
    `YEAR`                SMALLINT,
    stock_displacement    BIGINT,
    flow_displacement     BIGINT,
    conflict_displaced    BIGINT,
    disaster_displaced    BIGINT,

    PRIMARY KEY (idp_id),

    CONSTRAINT fk_idp_district
        FOREIGN KEY (district_id)
        REFERENCES DISTRICT(district_id)
) ENGINE=InnoDB;

-- ============================================================
-- 18. DISPLACEMENT_EVENT
-- DISTRICT 1 -------- N DISPLACEMENT_EVENT
-- ============================================================
CREATE TABLE DISPLACEMENT_EVENT (
    event_id            INT AUTO_INCREMENT,
    district_id         INT,
    event_name          VARCHAR(250),
    event_type          VARCHAR(150),
    start_date          DATE,
    end_date            DATE,
    displaced_persons   BIGINT,
    cause               VARCHAR(500),

    PRIMARY KEY (event_id),

    CONSTRAINT fk_event_district
        FOREIGN KEY (district_id)
        REFERENCES DISTRICT(district_id)
) ENGINE=InnoDB;

-- ============================================================
-- 19. EDUCATION_INDICATOR
-- DISTRICT 1 -------- N EDUCATION_INDICATOR
-- ============================================================
CREATE TABLE EDUCATION_INDICATOR (
    edu_id          INT AUTO_INCREMENT,
    district_id     INT,
    indicator_name  VARCHAR(300),
    `YEAR`          SMALLINT,
    `VALUE`         DECIMAL(20,4),
    sex             VARCHAR(50),
    `LEVEL`         VARCHAR(100),
    unit            VARCHAR(100),

    PRIMARY KEY (edu_id),

    CONSTRAINT fk_education_district
        FOREIGN KEY (district_id)
        REFERENCES DISTRICT(district_id)
) ENGINE=InnoDB;

-- ============================================================
-- RELATIONSHIP TABLES
-- ============================================================

-- DECLARANT N -------- 1 COUNTRY
CREATE TABLE DECLARANT_COUNTRY (
    declarant_id  INT,
    country_code  VARCHAR(10),

    PRIMARY KEY (declarant_id),

    CONSTRAINT fk_declarant_country_declarant
        FOREIGN KEY (declarant_id)
        REFERENCES DECLARANT(declarant_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_declarant_country_country
        FOREIGN KEY (country_code)
        REFERENCES COUNTRY(country_code)
) ENGINE=InnoDB;

-- EXPORT_TRANSACTION 1 -------- N SDG_INDICATOR
CREATE TABLE EXPORT_SDG_RECORD (
    sdg_id          INT,
    transaction_id  INT,

    PRIMARY KEY (sdg_id),

    CONSTRAINT fk_export_sdg_sdg
        FOREIGN KEY (sdg_id)
        REFERENCES SDG_INDICATOR(sdg_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_export_sdg_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES EXPORT_TRANSACTION(transaction_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- EXPORT_TRANSACTION 1 -------- N IDP_DATA
CREATE TABLE EXPORT_IDP_RECORD (
    idp_id          INT,
    transaction_id  INT,

    PRIMARY KEY (idp_id),

    CONSTRAINT fk_export_idp_idp
        FOREIGN KEY (idp_id)
        REFERENCES IDP_DATA(idp_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_export_idp_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES EXPORT_TRANSACTION(transaction_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- EXPORT_TRANSACTION 1 -------- N DISPLACEMENT_EVENT
CREATE TABLE EXPORT_DISPLACEMENT_RECORD (
    event_id        INT,
    transaction_id  INT,

    PRIMARY KEY (event_id),

    CONSTRAINT fk_export_displacement_event
        FOREIGN KEY (event_id)
        REFERENCES DISPLACEMENT_EVENT(event_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_export_displacement_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES EXPORT_TRANSACTION(transaction_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- EXPORT_TRANSACTION 1 -------- N EDUCATION_INDICATOR
CREATE TABLE EXPORT_EDUCATION_RECORD (
    edu_id          INT,
    transaction_id  INT,

    PRIMARY KEY (edu_id),

    CONSTRAINT fk_export_education_edu
        FOREIGN KEY (edu_id)
        REFERENCES EDUCATION_INDICATOR(edu_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_export_education_transaction
        FOREIGN KEY (transaction_id)
        REFERENCES EXPORT_TRANSACTION(transaction_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- OPTIONAL INDEXES
-- MariaDB may automatically index FK columns in many cases,
-- but these explicit indexes are kept to match the source schema.
-- ============================================================

CREATE INDEX IDX_DISTRICT_DIVISION
ON DISTRICT(division_id);

CREATE INDEX IDX_CENSUS_DISTRICT
ON POPULATION_CENSUS(district_id);

CREATE INDEX IDX_HH_CENSUS
ON HOUSEHOLD_TYPE(census_id);

CREATE INDEX IDX_MARITAL_CENSUS
ON MARITAL_STATUS(census_id);

CREATE INDEX IDX_RELIGION_CENSUS
ON RELIGION_DIST(census_id);

CREATE INDEX IDX_PRICE_DISTRICT
ON FOOD_PRICE(district_id);

CREATE INDEX IDX_PRICE_COMMODITY
ON FOOD_PRICE(commodity_id);

CREATE INDEX IDX_EXPORTER_COUNTRY
ON EXPORTER(country_code);

CREATE INDEX IDX_BUYER_COUNTRY
ON BUYER(destination_country);

CREATE INDEX IDX_EXPORT_EXPORTER
ON EXPORT_TRANSACTION(exporter_id);

CREATE INDEX IDX_EXPORT_BUYER
ON EXPORT_TRANSACTION(buyer_id);

CREATE INDEX IDX_EXPORT_PRODUCT
ON EXPORT_TRANSACTION(product_id);

CREATE INDEX IDX_EXPORT_DECLARANT
ON EXPORT_TRANSACTION(declarant_id);

CREATE INDEX IDX_EXPORT_COMMODITY
ON EXPORT_TRANSACTION(commodity_id);

CREATE INDEX IDX_IMPORT_PRODUCT
ON IMPORT_TRANSACTION(product_id);

CREATE INDEX IDX_IMPORT_COUNTRY
ON IMPORT_TRANSACTION(origin_country);

CREATE INDEX IDX_SDG_DISTRICT
ON SDG_INDICATOR(district_id);

CREATE INDEX IDX_IDP_DISTRICT
ON IDP_DATA(district_id);

CREATE INDEX IDX_EVENT_DISTRICT
ON DISPLACEMENT_EVENT(district_id);

CREATE INDEX IDX_EDU_DISTRICT
ON EDUCATION_INDICATOR(district_id);

-- ============================================================
-- VERIFY CREATED TABLES
-- ============================================================

SHOW TABLES;
