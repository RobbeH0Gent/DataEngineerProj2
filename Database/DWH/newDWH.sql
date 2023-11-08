DROP DATABASE IF EXISTS DW;
CREATE DATABASE DW;
USE DW;


-- Dimension Tables
DROP TABLE IF EXISTS DimDate;
CREATE TABLE DimDate (
    date_Key int NOT NULL PRIMARY KEY,
    date date DEFAULT NULL,
    day_num int DEFAULT NULL,
    day_of_year int DEFAULT NULL,
    day_of_week int DEFAULT NULL,
    day_of_week_name varchar(20) DEFAULT NULL,
    week_num int DEFAULT NULL,
    week_begin_date datetime DEFAULT NULL,
    week_end_date datetime DEFAULT NULL,
    last_week_begin_date datetime DEFAULT NULL,
    last_week_end_date datetime DEFAULT NULL,
    last_2_week_begin_date datetime DEFAULT NULL,
    last_2_week_end_date datetime DEFAULT NULL,
    month_num int DEFAULT NULL,
    month_name varchar(20) DEFAULT NULL,
    yearmonth_num int DEFAULT NULL,
    last_month_num int DEFAULT NULL,
    last_month_name varchar(20) DEFAULT NULL,
    last_month_year int DEFAULT NULL,
    last_yearmonth_num int DEFAULT NULL,
    quarter_num int DEFAULT NULL,
    year_num int DEFAULT NULL,
    is_weekday VARCHAR(1)  DEFAULT '1',
    holiday_BE varchar(50) DEFAULT NULL,
    is_holiday_BE VARCHAR(1) DEFAULT '0',
);

-- I merged the tables Account and Persoon as DimCustomer
DROP TABLE IF EXISTS DimCustomer;
CREATE TABLE DimCustomer (
    Customer_ID VARCHAR(255) PRIMARY KEY,
    Geografische_regio VARCHAR(255),
    Geografische_subregio VARCHAR(255),
    Plaats VARCHAR(255),
    Postcode VARCHAR(100),
    Provincie VARCHAR(255),
    Industriezone_Naam_ VARCHAR(255),
    Is_Voka_entiteit VARCHAR(10),
    Ondernemingsaard VARCHAR(255),
    Ondernemingstype VARCHAR(255),
    Oprichtingsdatum VARCHAR(255),
    Primaire_activiteit VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Status VARCHAR(255),
    Voka_Nr_ INT,
    Adres_Land VARCHAR(255),
    Persoon_ID VARCHAR(255),
    Persoonnr INT,
    Status_Persoon VARCHAR(255),
    Marketing_Communicatie VARCHAR(255)
);

-- I merged the tables: Contactfiche and Functie Table as DimContact
DROP TABLE IF EXISTS DimContact;
CREATE TABLE DimContact (
    Contact_ID VARCHAR(255) PRIMARY KEY,
    Account_ID VARCHAR(255),
    Functie_title VARCHAR(255),
    Status VARCHAR(255),
    Voka_medewerker INT,
    Persoon_ID VARCHAR(255),
    Functie_ID VARCHAR(255),
    Gebruiker_ID VARCHAR(255) -- We might need to add more fields, if we need them in the epics.
);

-- I merged the tables: CDI_Mailing and CDI_PageView as DimEmail
DROP TABLE IF EXISTS DimEmail;
CREATE TABLE DimEmail (
    Mailing_ID VARCHAR(255) PRIMARY KEY,
    Mailing_Name VARCHAR(255),
    Mailing_Sent_On VARCHAR(255),
    Mailing_Subject VARCHAR(255),
    Browser VARCHAR(50),
    Campagne_ID VARCHAR(255),
    Contact_ID VARCHAR(255),
    Duration VARCHAR(255),
    Operating_System VARCHAR(50),
    Referrer_Type VARCHAR(255),
    PageView_Time DATETIME,
    Title VARCHAR(255),
    Type VARCHAR(255),
    Url VARCHAR(255),
    Viewed_On DATE,
    Visit DATE,
    Visitor_key VARCHAR(255),
    Web_Content VARCHAR(255),
    Made_On DATE,
    Edited_By VARCHAR(255),
    Edited_On DATE,
    Status VARCHAR(255),
    Status_Reason VARCHAR(255)
);

-- CREATE TABLE DimAfspraak(
-- 
-- );

-- Fact Tables
DROP TABLE IF EXISTS FactContact;
CREATE TABLE FactContact (
    Contact_ID VARCHAR(255),
    Afspraak_ID VARCHAR(255),
    FOREIGN KEY (Contact_ID) REFERENCES DimContact(Contact_ID),
    -- FOREIGN KEY (Afspraak_ID) REFERENCES Afspraak_Alle(Afspraak_ID)
);

DROP TABLE IF EXISTS FactAccount;
CREATE TABLE FactAccount (
    Customer_ID VARCHAR(255),
    Boekjaar INT,
    Aantal_maanden INT,
    Toegevoegde_waarde VARCHAR(255),
    FTE VARCHAR(255),
    Gewijzigd_op VARCHAR(255),
    PRIMARY KEY (Customer_ID, Boekjaar),
    FOREIGN KEY (Customer_ID) REFERENCES DimCustomer(Customer_ID)
);

-- Add if u think we need more dim or fact tables
