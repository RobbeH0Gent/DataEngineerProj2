USE DW;
DROP PROCEDURE IF EXISTS fill_fact_account;
GO
CREATE PROCEDURE fill_fact_account
AS
BEGIN
    UPDATE DW.dbo.FactAccount
     SET 
        Customer_ID = dc.Customer_ID,
        Boekjaar = raf.Boekjaar,
        Aantal_maanden = raf.Aantal_maanden,
        Toegevoegde_waarde = raf.Toegevoegde_waarde,
        FTE = raf.FTE,
        Gewijzigd_op = raf.Gewijzigd_op 
    FROM DW.dbo.FactAccount dwh
    LEFT JOIN DW.dbo.DimCustomer dc ON dwh.Customer_ID = dc.Customer_ID
    LEFT JOIN DEP2.dbo.Account_Financiele_Data raf ON dwh.Boekjaar = raf.Boekjaar;

    INSERT INTO DW.dbo.FactAccount
    (Customer_ID, Boekjaar, Aantal_maanden, Toegevoegde_waarde, FTE, Gewijzigd_op)
    SELECT dc.Customer_ID, raf.Boekjaar, raf.Aantal_maanden, raf.Toegevoegde_waarde, raf.FTE, raf.Gewijzigd_op
    FROM DW.dbo.DimCustomer dc JOIN DEP2.dbo.Account_Financiele_Data raf ON dc.Customer_ID = raf.Account_ID;
    
END;
