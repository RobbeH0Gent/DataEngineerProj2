USE DW;
DROP PROCEDURE IF EXISTS fill_dim_financieel;
GO
CREATE PROCEDURE fill_dim_financieel
AS
BEGIN
    UPDATE DW.dbo.DimFinancieel
     SET 
        Boekjaar = rf.Boekjaar,
        Aantal_maanden = rf.Aantal_maanden,
        Toegevoegde_waarde = rf.Toegevoegde_waarde,
        FTE = rf.FTE,
        Gewijzigd_op = rf.Gewijzigd_op
    FROM DW.dbo.DimFinancieel dwh
    LEFT JOIN DEP2.dbo.Account_Financiele_Data rf ON dwh.Boekjaar = rf.Boekjaar;


    INSERT INTO DW.dbo.DimFinancieel
    (Boekjaar, Aantal_maanden, Toegevoegde_waarde, FTE, Gewijzigd_op)
    SELECT DISTINCT rf.Boekjaar, rf.Aantal_maanden, rf.Toegevoegde_waarde, rf.FTE, rf.Gewijzigd_op
    FROM DEP2.dbo.Account_Financiele_Data rf;

END;


