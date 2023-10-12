CREATE DATABASE DEP2;

-- Account Table
CREATE TABLE Account (
    AccountID VARCHAR(255) PRIMARY KEY,
    Adres_Geografische_regio VARCHAR(255),
    Adres_Geografische_subregio VARCHAR(255),
    Plaats VARCHAR(255),
    Postcode VARCHAR(10),
    Provincie VARCHAR(255),
    Industriezone_Naam_ VARCHAR(255),
    Is_Voka_entiteit INTEGER, -- BOOLEAN
    Ondernemingsaard VARCHAR(255),
    Ondernemingstype VARCHAR(255),
    Oprichtingsdatum DATE,
    Primaire_activiteit VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Status VARCHAR(255),
    Voka_Nr_ INT,
    Hoofd_NaCe_Code VARCHAR(255),
    Adres_Land VARCHAR(255)
);

-- Account ActiviteitsCode Table
CREATE TABLE Account_ActiviteitsCode (
    Account_ActiviteitsCode VARCHAR(255) PRIMARY KEY,
    Activiteitscode INT,
    inf_account_inf_activiteitscodeId INT,
    PRIMARY KEY (Account_ActiviteitsCode_Account, Activiteitscode),
    FOREIGN KEY (Account_ActiviteitsCode_Account) REFERENCES Account(AccountID),
    FOREIGN KEY (Activiteitscode) REFERENCES Activiteitscode(Activiteitscode)
);

-- Account Financiele data Table
CREATE TABLE Account_FinancieleData (
    Account_ID VARCHAR(255) PRIMARY KEY,
    Boekjaar INT,
    Aantal_maanden INT,
    Toegevoegde_waarde DECIMAL(10, 2),
    FTE INT,
    Gewijzigd_op DATE,
    FOREIGN KEY (Account_ID) REFERENCES Account(AccountID)
);

CREATE TABLE ActiviteitVereistContact (
    ActivityId VARCHAR(255) PRIMARY KEY,
    ReqAttendee INT,
    FOREIGN KEY (ActivityId) REFERENCES Activiteitscode(Activiteitscode),
    FOREIGN KEY (ReqAttendee) REFERENCES Contact(ContactpersoonID)
);

-- Activiteitscode Table
CREATE TABLE Activiteitscode (
    Naam VARCHAR(255),
    Activiteitscode VARCHAR(255) PRIMARY KEY,
    Status VARCHAR(255)
);

-- Table: Afpsraak Alle
CREATE TABLE Afpsraak_Alle (
    Afspraak_ID VARCHAR(255) PRIMARY KEY
);

-- Table: Campagne
CREATE TABLE Campagne (
    Campagne_ID VARCHAR(255) PRIMARY KEY,
    Campagne_Nr INT,
    Einddatum DATE,
    Naam VARCHAR(255),
    Naam_in_email VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Startdatum DATE,
    Status VARCHAR(255),
    Type_campagne VARCHAR(255),
    URL_voka_be VARCHAR(255),
    Soort_Campagne VARCHAR(255)
);

-- Table: cdi pageviews
CREATE TABLE CDI_PageViews (
    PageView_ID VARCHAR(255) PRIMARY KEY,
    Anonymous BOOLEAN,
    Browser VARCHAR(50),
    Campaign VARCHAR(255),
    Contact VARCHAR(255),
    Duration VARCHAR(255),
    Operating_System VARCHAR(50),
    Referrer_Type VARCHAR(255),
    -- Not sure of this one
    PageView_Time DateTime,
    --
    Title VARCHAR(255),
    Type VARCHAR(255),
    Url VARCHAR(255),
    Viewed_On DATE,
    Visit DATE,
    Visitor_key VARCHAR(255),
    Web_Content VARCHAR(255),
    Made_On DATE,
    Edited_By VARCHAR(255),
    Edited_On DATE,
    Status VARCHAR(255),
    Status_Reason VARCHAR(255)
);

-- Table: cdi web content
CREATE TABLE CDI_WebContent (
    WebContent_ID VARCHAR(255) PRIMARY KEY,
    Web_Content VARCHAR(255),
    Campaign_ID VARCHAR(255),
    Campaign_Name VARCHAR(255),
    Naam VARCHAR(255),
    Made_By_Name VARCHAR(255), 
    Created_On DATE,
    Edited_By_Name VARCHAR(255),
    Modified_On DATE,
    Owner_ID VARCHAR(255),
    Owner_Name VARCHAR(255),
    Owning_Business_Unit BOOLEAN
);

-- Table: cdi visits
CREATE TABLE CDI_Visits (
    Visit_ID VARCHAR(255) PRIMARY KEY,
    IP_Address VARCHAR(255),
    -- Add other columns as needed
);

-- Table: cdi sent email clicks
CREATE TABLE CDI_SentEmailClicks (
    SentEmailClicks_ID VARCHAR(255) PRIMARY KEY,
    SentEmailClicks_Contact VARCHAR(255),
    -- Add other columns as needed
);

-- Table: CDI mailing
CREATE TABLE CDI_Mailing (
    Mailing_ID VARCHAR(255) PRIMARY KEY,
    Mailing_Name VARCHAR(255),
    Mailing_Sent_On DATE,
    Mailing_Subject VARCHAR(255)
);

-- Table: Contact functie
CREATE TABLE ContactFunctie (
    ContactFunctie_ID VARCHAR(255) PRIMARY KEY,
    Contactpersoon VARCHAR(255)
);

-- Table: Contact
CREATE TABLE Contact (
    Contact_persoon VARCHAR(255),
    Contact_ID VARCHAR(255) PRIMARY KEY,
    Account_ID VARCHAR(255), -- FK
    Functie_title VARCHAR(255),
    Status VARCHAR(255),
    Voka_medewerker INTEGER -- BOOLEAN
);

-- Table: Gebruiker
CREATE TABLE Gebruiker (
    Gebruikers_ID VARCHAR(255) PRIMARY KEY,
    Business_unit_naam VARCHAR(255), -- staat niet in ERD maar hebben wel data
);

-- Not sure about Aanvraag
-- Table: Info en klachten
CREATE TABLE Info_en_Klachten (
    Aanvraag VARCHAR(255) PRIMARY KEY
    Account_ID VARCHAR(255),
    Datum DateTime,
    Datum_afsluiting DateTime,
    Status VARCHAR(255), -- Gesloten/actief
    Eigenaar VARCHAR(255),
    FOREIGN KEY (Eigenaar) REFERENCES Gebruiker(Gebruiker_ID),
    FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID)    
);

-- Table: Inschrijving
CREATE TABLE Inschrijving (
    Inschrijving_ID VARCHAR(255) PRIMARY KEY,
    Facturatie_bedrag INTEGER,
    Datum DateTime,
    Contactfiche VARCHAR(255),
    Bron VARCHAR(255),
    Status VARCHAR(255) -- Aanwezig/Afwezig
);

-- Table: Lidmaatschap
CREATE TABLE Lidmaatschap (
    Lidmaatschap_ID VARCHAR(255) PRIMARY KEY,
    OndernemingID VARCHAR(255),
    Opzeg DateTime,
    Reden_Aangroei VARCHAR(255),
    Reden_Verloop VARCHAR(255),
    Start_Datum Date,
    FOREIGN KEY (OndernemingID) REFERENCES Account(AccountID)
);

-- Table: Persoon
CREATE TABLE Persoon (
    Persoon_ID VARCHAR(255) PRIMARY KEY,
    Persoonnr INTEGER,
    Status VARCHAR(255), -- Actief/Inactief
    Email VARCHAR(255),
    Regio VARCHAR(255), 
    Thema VARCHAR(255),
    Type VARCHAR(255), -- VEEL OPTIES -> best anders aanpakken?
    Marketing_Communicatie VARCHAR(255) -- Strikt/Flexibel
);

-- Table: Sessie inschrijving
CREATE TABLE SessieInschrijving (
    SessieInschrijving_ID VARCHAR(255) PRIMARY KEY,
    Sessie_ID VARCHAR(255),
    Inschrijving_ID VARCHAR(255),
    FOREIGN KEY (Sessie_ID) REFERENCES Sessie(Sessie_ID),
    FOREIGN KEY (Inschrijving_ID) REFERENCES Inschrijving(Inschrijving_ID)
    
);

-- Table: Sessie
CREATE TABLE Sessie (
    Sessie_ID VARCHAR(255) PRIMARY KEY,
    Activiteitstype VARCHAR(255),
    Campagne_ID VARCHAR(255), 
    Einddatum DateTime,
    Product VARCHAR(255),
    Sessie_nr VARCHAR(255),
    Startdatum DateTime,
    Thema VARCHAR(255), 
    FOREIGN KEY (Campagne_ID) REFERENCES Campagne(Campagne_ID),

);

-- Table: Teams
CREATE TABLE Teams (
    Teams_ID VARCHAR(5) PRIMARY KEY,
    Activiteit_naam VARCHAR(255)
);

