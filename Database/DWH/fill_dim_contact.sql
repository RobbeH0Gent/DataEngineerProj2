USE DW;
DROP PROCEDURE IF EXISTS fill_dim_contact;
GO
CREATE PROCEDURE fill_dim_contact
AS
BEGIN
    UPDATE DW.dbo.DimContact
     SET 
        Contact_ID = rc.Contactfiche_ID,
        Account_ID = rc.Account_ID,
        Functie_title = rc.Functie_title,
        Status = rc.Status,
        Voka_medewerker = rc.Voka_medewerker,
        Persoon_ID = rc.Persoon_ID,
        Functie_ID = rf.Functie_ID
    FROM DW.dbo.DimContact dwh
    LEFT JOIN DEP2.dbo.Contactfiche rc on dwh.Contact_ID = rc.Contactfiche_ID
    -- LEFT JOIN DEP2.dbo.Gebruiker rg ON dwh.Gebruiker_ID = rg.Gebruiker_ID
    LEFT JOIN DEP2.dbo.Functie rf on dwh.Functie_ID = rf.Functie_ID;
    -- WHERE CLAUSE

    INSERT INTO DW.dbo.DimContact
    (Contact_ID, Account_ID, Functie_title, Status, Voka_medewerker, Persoon_ID, Functie_ID)
    SELECT DISTINCT rc.Contactfiche_ID, rc.Account_ID, rc.Functie_title, rc.Status, rc.Voka_medewerker,  rc.Persoon_ID,  rf.Functie_ID
    FROM DEP2.dbo.Contactfiche rc JOIN DEP2.dbo.Functie rf on rc.Functie_title = rf.Functie_Naam;

END;


