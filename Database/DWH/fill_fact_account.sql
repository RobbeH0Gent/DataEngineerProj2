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
        Gewijzigd_op = raf.Gewijzigd_op,
        Opzeg = rl.Opzeg,
        Reden_Aangroei = rl.Reden_Aangroei,
        Reden_Verloop = rl.Reden_Verloop,
        Start_Datum = rl.Start_Datum
    FROM DW.dbo.FactAccount dwh
    LEFT JOIN DW.dbo.DimCustomer dc ON dwh.Customer_ID = dc.Customer_ID
    LEFT JOIN DEP2.dbo.Account_Financiele_Data raf ON dwh.Boekjaar = raf.Boekjaar
    LEFT JOIN DEP2.dbo.Lidmaatschap rl ON dwh.Opzeg = rl.Opzeg;

    INSERT INTO DW.dbo.FactAccount
    (Customer_ID, Boekjaar, Aantal_maanden, Toegevoegde_waarde, FTE, Gewijzigd_op,
     Opzeg, Reden_Aangroei, Reden_Verloop, Start_Datum)
    SELECT dc.Customer_ID, raf.Boekjaar, raf.Aantal_maanden, raf.Toegevoegde_waarde, raf.FTE, raf.Gewijzigd_op,
    rl.Opzeg, rl.Reden_Aangroei, rl.Reden_Verloop, rl.Start_Datum
    FROM DW.dbo.DimCustomer dc 
    JOIN DEP2.dbo.Account_Financiele_Data raf ON dc.Customer_ID = raf.Account_ID
    JOIN DEP2.dbo.Lidmaatschap rl ON raf.Account_ID = rl.Onderneming_ID;
    
END;
