USE DW;
DROP PROCEDURE IF EXISTS fill_fact_campagne;
GO
CREATE PROCEDURE fill_fact_campagne
AS
BEGIN
    UPDATE DW.dbo.FactCampagne
     SET 
        Customer_ID = rcu.Customer_ID,
        Contact_ID = rc.Contact_ID,
        Campagne_ID =  rca.Campagne_ID,
        Campagne_Nr = rca.Campagne_Nr,
        Einddatum = rca.Einddatum,
        Naam = rca.Naam,
        Naam_in_email = rca.Naam_in_email,
        Reden_van_status = rca.Reden_van_status,
        Startdatum = rca.Startdatum,
        Status_Camp = rca.Status_Camp,
        Type_campagne = rca.Type_campagne,
        Soort_Campagne = rca.Soort_Campagne
    FROM DW.dbo.FactCampagne dwh
    LEFT JOIN DW.dbo.DimCustomer rcu ON dwh.Customer_ID = rcu.Customer_ID
    LEFT JOIN DW.dbo.DimContact dc ON dwh.Contact_ID = dc.Contact_ID
    LEFT JOIN DEP2.dbo.Campagne rca ON dwh.Campagne_ID = rca.Campagne_ID;

    INSERT INTO DW.dbo.FactCampagne
    (Customer_ID, Contact_ID, Campagne_ID, Campagne_Nr, Einddatum, Naam, Naam_in_email, Reden_van_status,
    Startdatum, Status_Camp, Type_campagne, Soort_Campagne)
    SELECT rcu.Customer_ID, dc.Contact_ID, rca.Campagne_ID, rca.Campagne_Nr, rca.Einddatum, rca.Naam,
    rca.Naam_in_email, rca.Reden_van_status, rca.Startdatum, rca.Status_Camp, rca.Type_campagne, rca.Soort_Campagne
    FROM DW.dbo.DimContact dc;

    
END;