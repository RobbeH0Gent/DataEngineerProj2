USE DW;
DROP PROCEDURE IF EXISTS fill_dim_afspraak;
GO
CREATE PROCEDURE fill_dim_afspraak
AS
BEGIN
    UPDATE DW.dbo.DimAfspraak
     SET 
        Afspraak_ID = ra.Afspraak_ID,
        Thema = ra.Thema,
        Subthema = ra.Subthema,
        Onderwerp = ra.Onderwerp,
        Eindtijd = ra.Eindtijd,
        KeyPhrases = ra.KeyPrhases,
        Account_ID = ra.Account_ID
    FROM DW.dbo.DimAfspraak dwh
    LEFT JOIN DEP2.dbo.Afspraak_Account_Gelinkt ra ON dwh.Afspraak_ID = ra.Afspraak_ID;

    INSERT INTO DW.dbo.DimAfspraak
    (Afspraak_ID, Thema, Subthema, Onderwerp, Eindtijd, Keyphrases, Account_ID)
    SELECT ra.Afspraak_ID, ra.Thema, ra.Subthema, ra.Onderwerp, ra.Eindtijd, ra.KeyPrhases, ra.Account_ID
    FROM DEP2.dbo.Afspraak_Account_Gelinkt ra;
    
END;
