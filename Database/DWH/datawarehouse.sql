-- CREATE DATABASE DW;
-- USE DW;

-- Dimension Tables

-- DimAccount
CREATE TABLE DimAccount (
    Account_ID VARCHAR(255) PRIMARY KEY,
    Adres_Geografische_regio VARCHAR(255),
    Adres_Geografische_subregio VARCHAR(255),
    Plaats VARCHAR(255),
    Postcode VARCHAR(100),
    Provincie VARCHAR(255),
    Industriezone_Naam_ VARCHAR(255),
    Is_Voka_entiteit VARCHAR(10), -- BOOLEAN
    Ondernemingsaard VARCHAR(255),
    Ondernemingstype VARCHAR(255),
    Oprichtingsdatum VARCHAR(255),
    Primaire_activiteit VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Status VARCHAR(255),
    Voka_Nr_ INT,
    Adres_Land VARCHAR(255),
);

-- DimPersoon
CREATE TABLE DimPersoon (
    Persoon_ID VARCHAR(255) PRIMARY KEY,
    Persoonnr INTEGER,
    Status_Persoon VARCHAR(255), -- Actief/Inactief
    Marketing_Communicatie VARCHAR(255) -- Strikt/Flexibel
);

-- DimContactfiche
CREATE TABLE DimContactfiche (
    Contactfiche_ID VARCHAR(255) PRIMARY KEY,
    Persoon_ID VARCHAR(255),
    Account_ID VARCHAR(255), -- FK
    Functie_title VARCHAR(255),
    Status VARCHAR(255),
    Voka_medewerker INTEGER -- BOOLEAN
);

-- DimActiviteitscode
CREATE TABLE DimActiviteitscode (
    Activiteitscode_ID VARCHAR(255) PRIMARY KEY,
    Naam VARCHAR(255),
    Status_Code VARCHAR(255)
);

-- DimCampagne
CREATE TABLE DimCampagne (
    Campagne_ID VARCHAR(255) PRIMARY KEY,
    Campagne_Nr VARCHAR(255),
    Einddatum VARCHAR(255),
    Naam VARCHAR(255),
    Naam_in_email VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Startdatum VARCHAR(255),
    Status_Camp VARCHAR(255),
    Type_campagne VARCHAR(255),
    URL_voka_be VARCHAR(255),
    Soort_Campagne VARCHAR(255)
);

-- DimCDI_Mailing
CREATE TABLE DimCDI_Mailing (
    Mailing_ID VARCHAR(255) PRIMARY KEY,
    Mailing_Name VARCHAR(255),
    Mailing_Sent_On VARCHAR(255),
    Mailing_Subject VARCHAR(255)
);

-- DimCDI_PageView
CREATE TABLE DimCDI_PageView (
    PageView_ID VARCHAR(500) PRIMARY KEY,
    Browser VARCHAR(50),
    Campagne_ID VARCHAR(255),
    Contact_ID VARCHAR(255),
    Duration VARCHAR(255),
    Operating_System VARCHAR(50),
    PageView_Time DateTime,
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

-- DimCDI_Visits
CREATE TABLE DimCDI_Visits (
    Visit_ID VARCHAR(255) PRIMARY KEY,
    Adobe_Reader VARCHAR(255),
    Bounce VARCHAR(255),
    Browser VARCHAR(255),
    Campagne_ID VARCHAR(255),
    IP_Stad VARCHAR(255),
    IP_Company VARCHAR(255),
    Contactfiche_ID VARCHAR(255),
    Contact_Naam VARCHAR(255),
    Social_Profile VARCHAR(255),
    IP_Land VARCHAR(255),
    Duration VARCHAR(255),
    Email_Send VARCHAR(255),
    Ended_On VARCHAR(255),
    Entry_page VARCHAR(2500),
    Exit_page VARCHAR(2500),
    First_Visit VARCHAR(255),
    IP_Adress VARCHAR(255),
    IP_Organization VARCHAR(255),
    Keywords VARCHAR(255),
    IP_Latitude VARCHAR(255),
    IP_Longitude VARCHAR(255),
    Operating_System VARCHAR(255),
    IP_Postcode VARCHAR(255),
    Referrer VARCHAR(255),
    Referring_Host VARCHAR(255),
    Score VARCHAR(255),
    Referrer_Type VARCHAR(255),
    Started_On VARCHAR(255),
    IP_Status VARCHAR(255),
    Visit_Time VARCHAR(255),
    Total_Pages VARCHAR(255),
    Aangemaakt_op VARCHAR(255),
    Gewijzigd_op VARCHAR(255)
);

-- DimGebruiker
CREATE TABLE DimGebruiker (
    Gebruiker_ID VARCHAR(255) PRIMARY KEY,
    Business_unit_naam VARCHAR(255)
);

-- DimInfo_en_Klachten
CREATE TABLE DimInfo_en_Klachten (
    Aanvraag VARCHAR(255) PRIMARY KEY,
    Account_ID VARCHAR(255),
    Datum VARCHAR(255),
    Datum_afsluiting VARCHAR(255),
    Status VARCHAR(255), -- Gesloten/actief
    Eigenaar VARCHAR(255)
);

-- DimInschrijving
CREATE TABLE DimInschrijving (
    Inschrijving_ID VARCHAR(255) PRIMARY KEY,
    Facturatie_bedrag INTEGER,
    Datum DateTime,
    Contactfiche_ID VARCHAR(255),
    Bron VARCHAR(255),
    Status VARCHAR(255) -- Aanwezig/Afwezig
);

-- DimLidmaatschap
CREATE TABLE DimLidmaatschap (
    Lidmaatschap_ID VARCHAR(255) PRIMARY KEY,
    Onderneming_ID VARCHAR(255),
    Opzeg VARCHAR(255),
    Reden_Aangroei VARCHAR(255),
    Reden_Verloop VARCHAR(255),
    Start_Datum VARCHAR(255)
);

-- DimSessie
CREATE TABLE DimSessie (
    Sessie_ID VARCHAR(255) PRIMARY KEY,
    Activiteitstype VARCHAR(255),
    Campagne_ID VARCHAR(255), 
    Einddatum VARCHAR(255),
    Product VARCHAR(255),
    Sessie_nr VARCHAR(255),
    Startdatum VARCHAR(255),
    Thema VARCHAR(255)
);

-- DimTeams
CREATE TABLE DimTeams (
    Teams_ID VARCHAR(5) PRIMARY KEY,
    Activiteit_naam VARCHAR(255)
);

-- Fact Table
CREATE TABLE FactTable (
    Fact_ID VARCHAR(255) PRIMARY KEY,
    Account_ID VARCHAR(255),
    Persoon_ID VARCHAR(255),
    Contactfiche_ID VARCHAR(255),
    Activiteitscode_ID VARCHAR(255),
    Campagne_ID VARCHAR(255),
    CDI_Mailing_ID VARCHAR(255),
    CDI_PageView_ID VARCHAR(500),
    CDI_Visits_ID VARCHAR(255),
    Gebruiker_ID VARCHAR(255),
    Info_en_Klachten_Aanvraag VARCHAR(255),
    Inschrijving_ID VARCHAR(255),
    Lidmaatschap_ID VARCHAR(255),
    Sessie_ID VARCHAR(255),
    Teams_ID VARCHAR(5),
    FOREIGN KEY (Account_ID) REFERENCES DimAccount(Account_ID),
    FOREIGN KEY (Persoon_ID) REFERENCES DimPersoon(Persoon_ID),
    FOREIGN KEY (Contactfiche_ID) REFERENCES DimContactfiche(Contactfiche_ID),
    FOREIGN KEY (Activiteitscode_ID) REFERENCES DimActiviteitscode(Activiteitscode_ID),
    FOREIGN KEY (Campagne_ID) REFERENCES DimCampagne(Campagne_ID),
    FOREIGN KEY (CDI_Mailing_ID) REFERENCES DimCDI_Mailing(Mailing_ID),
    FOREIGN KEY (CDI_PageView_ID) REFERENCES DimCDI_PageView(PageView_ID),
    FOREIGN KEY (CDI_Visits_ID) REFERENCES DimCDI_Visits(Visit_ID),
    FOREIGN KEY (Gebruiker_ID) REFERENCES DimGebruiker(Gebruiker_ID),
    FOREIGN KEY (Info_en_Klachten_Aanvraag) REFERENCES DimInfo_en_Klachten(Aanvraag),
    FOREIGN KEY (Inschrijving_ID) REFERENCES DimInschrijving(Inschrijving_ID),
    FOREIGN KEY (Lidmaatschap_ID) REFERENCES DimLidmaatschap(Lidmaatschap_ID),
    FOREIGN KEY (Sessie_ID) REFERENCES DimSessie(Sessie_ID),
    FOREIGN KEY (Teams_ID) REFERENCES DimTeams(Teams_ID)
);
