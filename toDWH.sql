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

-- DimFactTable
INSERT INTO DW.dbo.FactTable
SELECT
    Fact_ID,
    Account_ID,
    Persoon_ID,
    Contactfiche_ID,
    Activiteitscode_ID,
    Campagne_ID,
    CDI_Mailing_ID,
    CDI_PageView_ID,
    CDI_Visits_ID,
    Gebruiker_ID,
    Info_en_Klachten_Aanvraag,
    Inschrijving_ID,
    Lidmaatschap_ID,
    Sessie_ID,
    Teams_ID
FROM DEP2.dbo.FactTable;
