BEGIN TRANSACTION;
USE DW
-- Delete existing data from destination tables
DELETE FROM DW.dbo.DimAccount;
DELETE FROM DW.dbo.DimActiviteitscode;
DELETE FROM DW.dbo.DimCampagne;
DELETE FROM DW.dbo.DimCDI_Mailing;
DELETE FROM DW.dbo.DimCDI_PageView;
DELETE FROM DW.dbo.DimCDI_Visits;
DELETE FROM DW.dbo.DimContactfiche;
DELETE FROM DW.dbo.DimGebruiker;
DELETE FROM DW.dbo.DimInfo_en_Klachten;
DELETE FROM DW.dbo.DimInschrijving;
DELETE FROM DW.dbo.DimLidmaatschap;
DELETE FROM DW.dbo.DimPersoon;
DELETE FROM DW.dbo.DimSessie;
DELETE FROM DW.dbo.DimTeams;
DELETE FROM DW.dbo.FactTable;


-- Transfer data from DEP2 to DW

-- DimAccount
INSERT INTO DW.dbo.DimAccount
SELECT
    Account_ID,
    Adres_Geografische_regio,
    Adres_Geografische_subregio,
    Plaats,
    Postcode,
    Provincie,
    Industriezone_Naam_,
    Is_Voka_entiteit,
    Ondernemingsaard,
    Ondernemingstype,
    Oprichtingsdatum,
    Primaire_activiteit,
    Reden_van_status,
    Status,
    Voka_Nr_,
    Hoofd_NaCe_Code,
    Adres_Land
FROM DEP2.dbo.Account;

-- DimActiviteitscode
INSERT INTO DW.dbo.DimActiviteitscode
SELECT
    Activiteitscode_ID,
    Naam,
    Status_Code
FROM DEP2.dbo.Activiteitscode;

-- DimCampagne
INSERT INTO DW.dbo.DimCampagne
SELECT
    Campagne_ID,
    Campagne_Nr,
    Einddatum,
    Naam,
    Naam_in_email,
    Reden_van_status,
    Startdatum,
    Status_Camp,
    Type_campagne,
    URL_voka_be,
    Soort_Campagne
FROM DEP2.dbo.Campagne;

-- DimCDI_Mailing
INSERT INTO DW.dbo.DimCDI_Mailing
SELECT
    Mailing_ID,
    Mailing_Name,
    Mailing_Sent_On,
    Mailing_Subject
FROM DEP2.dbo.CDI_Mailing;

-- DimCDI_PageView
INSERT INTO DW.dbo.DimCDI_PageView
SELECT
    PageView_ID,
    Browser,
    Campagne_ID,
    Contact_ID,
    Duration,
    Operating_System,
    PageView_Time,
    Title,
    Type,
    NULL, --Url,
    Viewed_On,
    Visit,
    Visitor_key,
    Web_Content,
    Made_On,
    Edited_By,
    Edited_On,
    Status,
    Status_Reason
FROM DEP2.dbo.CDI_PageView;

-- DimCDI_Visits
INSERT INTO DW.dbo.DimCDI_Visits
SELECT
    Visit_ID,
    Adobe_Reader,
    Bounce,
    Browser,
    NULL, --Campagne_Code,
    Campagne_ID,
    IP_Stad,
    IP_Company,
    Contactfiche_ID,
    Contact_Naam,
    Social_Profile,
    IP_Land,
    Duration,
    Email_Send,
    Ended_On,
    Entry_page,
    Exit_page,
    First_Visit,
    IP_Adress,
    IP_Organization,
    Keywords,
    IP_Latitude,
    IP_Longitude,
    Operating_System,
    IP_Postcode,
    Referrer,
    Referring_Host,
    Score,
    Referrer_Type,
    Started_On,
    IP_Status,
    Visit_Time,
    Total_Pages,
    Aangemaakt_op,
    Gewijzigd_op
FROM DEP2.dbo.CDI_Visits;

-- DimContactfiche
INSERT INTO DW.dbo.DimContactfiche
SELECT
    Contactfiche_ID,
    Persoon_ID,
    Account_ID,
    Functie_title,
    Status,
    Voka_medewerker
FROM DEP2.dbo.Contactfiche;

-- DimGebruiker
INSERT INTO DW.dbo.DimGebruiker
SELECT
    Gebruiker_ID,
    Business_unit_naam
FROM DEP2.dbo.Gebruiker;

-- DimInfo_en_Klachten
INSERT INTO DW.dbo.DimInfo_en_Klachten
SELECT
    Aanvraag,
    Account_ID,
    Datum,
    Datum_afsluiting,
    Status,
    Eigenaar
FROM DEP2.dbo.Info_en_Klachten;

-- DimInschrijving
INSERT INTO DW.dbo.DimInschrijving
SELECT
    Inschrijving_ID,
    Facturatie_bedrag,
    Datum,
    Contactfiche_ID,
    Bron,
    Status
FROM DEP2.dbo.Inschrijving;

-- DimLidmaatschap
INSERT INTO DW.dbo.DimLidmaatschap
SELECT
    Lidmaatschap_ID,
    Onderneming_ID,
    Opzeg,
    Reden_Aangroei,
    Reden_Verloop,
    Start_Datum
FROM DEP2.dbo.Lidmaatschap;

-- DimPersoon
INSERT INTO DW.dbo.DimPersoon
SELECT
    Persoon_ID,
    Persoonnr,
    NULL, --Status_Persoon,
    NULL, --Email,
    NULL, --Regio,
    NULL, --Thema,
    NULL, --Type_Persoon,
    Marketing_Communicatie
FROM DEP2.dbo.Persoon; 

-- DimSessie
INSERT INTO DW.dbo.DimSessie
SELECT
    Sessie_ID,
    Activiteitstype,
    Campagne_ID,
    Einddatum,
    Product,
    Sessie_nr,
    Startdatum,
    Thema
FROM DEP2.dbo.Sessie;

-- DimTeams
-- INSERT INTO DW.dbo.DimTeams
-- SELECT
   -- Teams_ID,
    -- Activiteit_naam
-- FROM DEP2.dbo.Teams;

--FactTable


COMMIT;
