USE DW;
DROP PROCEDURE IF EXISTS fill_dim_campagne;
GO
CREATE PROCEDURE fill_dim_campagne
AS
BEGIN
    UPDATE DW.dbo.DimCampagne
     SET 
        Campagne_ID =  rc.Campagne_ID,
        Campagne_Nr = rc.Campagne_Nr,
        Einddatum = rc.Einddatum,
        Naam = rc.Naam,
        Naam_in_email = rc.Naam_in_email,
        Reden_van_status = rc.Reden_van_status,
        Startdatum = rc.Startdatum,
        Status_Camp = rc.Status_Camp,
        Type_campagne = rc.Type_campagne,
        URL_voka_be = rc.URL_voka_be,
        Soort_Campagne = rc.Soort_Campagne,
        Status = ri.Status,
        Contactfiche_ID = ri.Contactfiche_ID,
        Datum = ri.Datum,
        Inschrijving_ID = ri.Inschrijving_ID,
        Facturatie_bedrag = ri.Facturatie_bedrag
    FROM DW.dbo.DimCampagne dwh
    LEFT JOIN DEP2.dbo.Campagne rc ON dwh.Campagne_ID = rc.Campagne_ID
    LEFT JOIN DEP2.dbo.Inschrijving ri ON dwh.Inschrijving_ID = ri.Inschrijving_ID;
;

    INSERT INTO DW.dbo.DimCampagne
    (Campagne_ID, Campagne_Nr, Einddatum, Naam, Naam_in_email, Reden_van_status, Startdatum, 
    Status_Camp, Type_campagne, URL_voka_be, Soort_Campagne, Status, Contactfiche_ID, Datum, 
    Inschrijving_ID, Facturatie_bedrag)
    SELECT rc.Campagne_ID, rc.Campagne_Nr,rc.Einddatum, rc.Naam, rc.Naam_in_email, rc.Reden_van_status, rc.Startdatum,
    rc.Status_Camp, rc.Type_campagne, rc.URL_voka_be, rc.Soort_Campagne, ri.[Status], ri.Contactfiche_ID,
    ri.Datum, ri.Inschrijving_ID, ri.Facturatie_bedrag
    FROM DEP2.dbo.Campagne rc
    JOIN DEP2.dbo.Inschrijving ri ON rc.Campagne_ID = ri.Bron;
    
END;
