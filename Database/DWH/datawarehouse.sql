-- DROP DATABASE IF EXISTS DW;
-- CREATE DATABASE DW;
-- USE DW;

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

-- Tables account, persoon, lidmaatschap
DROP TABLE IF EXISTS DimCustomer;
CREATE TABLE DimCustomer (
    Customer_ID VARCHAR(255),
    Geografische_regio VARCHAR(255),
    Geografische_subregio VARCHAR(255),
    Plaats VARCHAR(255),
    Postcode VARCHAR(100),
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
    Marketing_Communicatie VARCHAR(255),
    Lidmaatschap_ID VARCHAR(255),
    Opzeg VARCHAR(255),
    Reden_Aangroei VARCHAR(255),
    Reden_Verloop VARCHAR(255),
    Start_Datum VARCHAR(255),
    PRIMARY KEY(Customer_ID, Persoon_ID)
);

-- Tables Functie, Contactfiche, inschrijving
DROP TABLE IF EXISTS DimContact;
CREATE TABLE DimContact (
    Contact_ID VARCHAR(255),
    Account_ID VARCHAR(255),
    Functie_title VARCHAR(255),
    Contact_status VARCHAR(255),
    Voka_medewerker INT,
    Persoon_ID VARCHAR(255),
    Functie_ID VARCHAR(255),
    Inschrijving_status VARCHAR(255),
    Bron VARCHAR(255),
    Datum VARCHAR(255),
    Inschrijving_ID VARCHAR(255),
    Facturatie_bedrag VARCHAR(255),
    PRIMARY KEY(Contact_ID, Inschrijving_ID)
);

-- Tables CDI_email, CDI_pageviews, CDI_visits
DROP TABLE IF EXISTS DimEmail;
CREATE TABLE DimEmail (
    Mailing_ID VARCHAR(255)  ,
    Mailing_Name VARCHAR(255),
    Mailing_Sent_On VARCHAR(255),
    Mailing_Subject VARCHAR(255),
    Browser VARCHAR(50),
    Campagne_ID VARCHAR(255),
    Contact_ID VARCHAR(255),
    Duration VARCHAR(255),
    Operating_System VARCHAR(50),
    Referrer_Type VARCHAR(255),
    PageView_Time VARCHAR(255),--DATETIME,
    Title VARCHAR(255),
    Type VARCHAR(255),
    Viewed_On VARCHAR(255),-- DATE,
    Visitor_key VARCHAR(255),
    Web_Content VARCHAR(255),
    Made_On VARCHAR(255),-- DATE,
    Edited_By VARCHAR(255),
    Edited_On VARCHAR(255),-- DATE,
    Status VARCHAR(255),
    Status_Reason VARCHAR(255),
    IP_Stad VARCHAR(255),
    IP_Company VARCHAR(255),
    IP_Land VARCHAR(255),
    IP_Adress VARCHAR(255),
    IP_Organization VARCHAR(255),
    Visit_ID VARCHAR(255),
    PRIMARY KEY (Mailing_ID, Visit_ID)
);


DROP TABLE IF EXISTS DimFinancieel;
CREATE TABLE DimFinancieel(
    Financieel_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Boekjaar INT,
    Aantal_maanden INT,
    Toegevoegde_waarde VARCHAR(255),
    FTE VARCHAR(255),
    Gewijzigd_op VARCHAR(255)
);

-- Fact Tables
DROP TABLE IF EXISTS FactCampagne;
CREATE TABLE FactCampagne (
    Fact_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Customer_ID VARCHAR(255),
    Persoon_ID VARCHAR(255),
    Contact_ID VARCHAR(255),
    Inschrijving_ID VARCHAR(255),
    Campagne_ID VARCHAR(255),
    Mailing_ID VARCHAR(255),
    Visit_ID VARCHAR(255),
    Campagne_Nr VARCHAR(255),
    Einddatum VARCHAR(255),
    Naam VARCHAR(255),
    Naam_in_email VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Startdatum VARCHAR(255),
    Status_Camp VARCHAR(255),
    Type_campagne VARCHAR(255),
    Soort_Campagne VARCHAR(255),
    FOREIGN KEY (Mailing_ID, Visit_ID) REFERENCES DimEmail(Mailing_ID, Visit_ID),
    FOREIGN KEY (Customer_ID, Persoon_ID) REFERENCES DimCustomer(Customer_ID, Persoon_ID),
    FOREIGN KEY (Contact_ID, Inschrijving_ID) REFERENCES DimContact(Contact_ID, Inschrijving_ID)    
);
