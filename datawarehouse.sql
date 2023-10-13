-- Dimension Tables
CREATE TABLE Dim_Account (
    AccountID VARCHAR(255) PRIMARY KEY,
    Adres_Geografische_regio VARCHAR(255),
    Adres_Geografische_subregio VARCHAR(255),
    Plaats VARCHAR(255),
    Postcode VARCHAR(10),
    Provincie VARCHAR(255),
    Industriezone_Naam_ VARCHAR(255),
    Is_Voka_entiteit INTEGER,
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

CREATE TABLE Dim_Activiteitscode (
    Activiteitscode VARCHAR(255) PRIMARY KEY,
    Naam VARCHAR(255),
    Status VARCHAR(255)
);

CREATE TABLE Dim_Contact (
    Contact_ID VARCHAR(255) PRIMARY KEY,
    Contact_persoon VARCHAR(255),
    Account_ID VARCHAR(255),
    Functie_title VARCHAR(255),
    Status VARCHAR(255),
    Voka_medewerker INTEGER
);

CREATE TABLE Dim_Gebruiker (
    Gebruikers_ID VARCHAR(255) PRIMARY KEY,
    Business_unit_naam VARCHAR(255)
);

CREATE TABLE Dim_Sessie (
    Sessie_ID VARCHAR(255) PRIMARY KEY,
    Activiteitstype VARCHAR(255),
    Campagne_ID VARCHAR(255),
    Einddatum DATE,
    Product VARCHAR(255),
    Sessie_nr VARCHAR(255),
    Startdatum DATE,
    Thema VARCHAR(255),
    FOREIGN KEY (Campagne_ID) REFERENCES Dim_Campagne(Campagne_ID)
);

CREATE TABLE Dim_Campagne (
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

CREATE TABLE Dim_Persoon (
    Persoon_ID VARCHAR(255) PRIMARY KEY,
    Persoonnr INTEGER,
    Status VARCHAR(255),
    Email VARCHAR(255),
    Regio VARCHAR(255),
    Thema VARCHAR(255),
    Type VARCHAR(255),
    Marketing_Communicatie VARCHAR(255)
);

CREATE TABLE Dim_Teams (
    Teams_ID VARCHAR(5) PRIMARY KEY,
    Activiteit_naam VARCHAR(255)
);

-- Fact Tables
CREATE TABLE Fact_Account_ActiviteitsCode (
    Account_ActiviteitsCode VARCHAR(255),
    Activiteitscode VARCHAR(255),
    PRIMARY KEY (Account_ActiviteitsCode, Activiteitscode),
    FOREIGN KEY (Account_ActiviteitsCode) REFERENCES Dim_Account(AccountID),
    FOREIGN KEY (Activiteitscode) REFERENCES Dim_Activiteitscode(Activiteitscode)
);

CREATE TABLE Fact_Account_FinancieleData (
    Account_ID VARCHAR(255),
    Boekjaar INT,
    Aantal_maanden INT,
    Toegevoegde_waarde DECIMAL(10, 2),
    FTE INT,
    Gewijzigd_op DATE,
    PRIMARY KEY (Account_ID),
    FOREIGN KEY (Account_ID) REFERENCES Dim_Account(AccountID)
);

CREATE TABLE Fact_ActiviteitVereistContact (
    ActivityId VARCHAR(255),
    ReqAttendee VARCHAR(255),
    PRIMARY KEY (ActivityId),
    FOREIGN KEY (ActivityId) REFERENCES Dim_Activiteitscode(Activiteitscode),
    FOREIGN KEY (ReqAttendee) REFERENCES Dim_Contact(Contact_ID)
);

CREATE TABLE Fact_CDI_PageViews (
    PageView_ID VARCHAR(255),
    Anonymous BOOLEAN,
    Browser VARCHAR(50),
    Campaign VARCHAR(255),
    Contact VARCHAR(255),
    Duration VARCHAR(255),
    Operating_System VARCHAR(50),
    Referrer_Type VARCHAR(255),
    PageView_Time DATETIME,
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
    Status_Reason VARCHAR(255),
    PRIMARY KEY (PageView_ID),
    FOREIGN KEY (Contact) REFERENCES Dim_Persoon(Persoon_ID)
);