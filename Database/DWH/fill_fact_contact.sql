USE DW;
DROP PROCEDURE IF EXISTS fill_fact_contact;
GO
CREATE PROCEDURE fill_fact_contact
AS
BEGIN
    UPDATE DW.dbo.FactContact
     SET 
        Contact_ID = dc.Contact_ID,
        Afspraak_ID = ra.Afspraak_ID 
    FROM DW.dbo.FactContact dwh
    LEFT JOIN DW.dbo.DimContact dc ON dwh.Contact_ID = dc.Contact_ID
    LEFT JOIN DEP2.dbo.Afspraak_Alle ra ON dwh.Afspraak_ID = ra.Afspraak_ID;

    INSERT INTO DW.dbo.FactContact
    (Contact_ID)
    SELECT dc.Contact_ID
    FROM DW.dbo.DimContact dc;

    INSERT INTO DW.dbo.FactContact
    (Afspraak_ID)
    SELECT ra.Afspraak_ID 
    FROM DEP2.dbo.Afspraak_Alle ra;
    
END;