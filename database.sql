CREATE DATABASE DEP2;

-- Account Table
CREATE TABLE Account (
    AccountID INT PRIMARY KEY,
    Adres_Geografische_regio VARCHAR(255),
    Adres_Geografische_subregio VARCHAR(255),
    Plaats VARCHAR(255),
    Postcode VARCHAR(10),
    Provincie VARCHAR(255),
    Industriezone_Naam_ VARCHAR(255),
    Is_Voka_entiteit BOOLEAN,
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
    Account_ActiviteitsCode_Account INT,
    Activiteitscode INT,
    inf_account_inf_activiteitscodeId INT,
    PRIMARY KEY (Account_ActiviteitsCode_Account, Activiteitscode),
    FOREIGN KEY (Account_ActiviteitsCode_Account) REFERENCES Account(AccountID),
    FOREIGN KEY (Activiteitscode) REFERENCES Activiteitscode(Activiteitscode)
);

-- Account Financiele data Table
CREATE TABLE Account_FinancieleData (
    OndernemingID INT PRIMARY KEY,
    Boekjaar INT,
    Aantal_maanden INT,
    Toegevoegde_waarde DECIMAL(10, 2),
    FTE INT,
    Gewijzigd_op DATE,
    FOREIGN KEY (OndernemingID) REFERENCES Account(AccountID)
);

CREATE TABLE ActiviteitVereistContact (
    ActivityId INT PRIMARY KEY,
    ReqAttendee INT,
    FOREIGN KEY (ActivityId) REFERENCES Activiteitscode(Activiteitscode),
    FOREIGN KEY (ReqAttendee) REFERENCES Contact(ContactpersoonID)
);

-- Activiteitscode Table
CREATE TABLE Activiteitscode (
    Naam VARCHAR(255),
    Activiteitscode INT PRIMARY KEY,
    Status VARCHAR(255)
);

-- Table: Afpsraak Alle
CREATE TABLE Afpsraak_Alle (
    Afspraak_ID INT PRIMARY KEY,
);

-- Table: Campagne
CREATE TABLE Campagne (
    Campagne_ID INT PRIMARY KEY,
    Campagne_Nr INT,
    Einddatum DATE,
    Naam VARCHAR(255),
    Naam_in_email VARCHAR(255),
    Reden_van_status VARCHAR(255),
    Startdatum DATE,
    Status VARCHAR(255),
    Type_campagne VARCHAR(255),
    URL_voka_be VARCHAR(255),
    Soort_Campagne VARCHAR(255),
);

-- Table: cdi pageviews
CREATE TABLE CDI_PageViews (
    PageView_ID INT PRIMARY KEY,
    Page_Title VARCHAR(255),
    -- Add other columns as needed
);

-- Table: cdi web content
CREATE TABLE CDI_WebContent (
    WebContent_ID INT PRIMARY KEY,
    Web_Content VARCHAR(255),
    -- Add other columns as needed
);

-- Table: cdi visits
CREATE TABLE CDI_Visits (
    Visit_ID INT PRIMARY KEY,
    IP_Address VARCHAR(255),
    -- Add other columns as needed
);

-- Table: cdi sent email clicks
CREATE TABLE CDI_SentEmailClicks (
    SentEmailClicks_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: CDI mailing
CREATE TABLE CDI_Mailing (
    Mailing_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Contact functie
CREATE TABLE ContactFunctie (
    ContactFunctie_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Contact
CREATE TABLE Contact (
    Contact_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Gebruikers
CREATE TABLE Gebruikers (
    Gebruikers_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Info en klachten
CREATE TABLE Info_en_Klachten (
    Info_en_Klachten_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Inschrijving
CREATE TABLE Inschrijving (
    Inschrijving_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Lidmaatschap
CREATE TABLE Lidmaatschap (
    Lidmaatschap_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Persoon
CREATE TABLE Persoon (
    Persoon_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Sessie inschrijving
CREATE TABLE SessieInschrijving (
    SessieInschrijving_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Sessie
CREATE TABLE Sessie (
    Sessie_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

-- Table: Teams
CREATE TABLE Teams (
    Teams_ID INT PRIMARY KEY,
    -- Add other columns as needed
);

