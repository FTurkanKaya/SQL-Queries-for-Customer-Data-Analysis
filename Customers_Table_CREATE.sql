CREATE TABLE CUSTOMERS
(
ID INT IDENTITY(1,1) PRIMARY KEY,     -- Unieke ID voor de persoon (Kan niet NULL zijn)
NAMESURNAME VARCHAR(100) NULL,       -- Naam van de klant, kan NULL zijn
TCNUMBER VARCHAR(100) NOT NULL,         -- Burgerlijke ID nummer (Uniek), kan geen NULL zijn
GENDER VARCHAR(1) NULL,               -- Geslacht ('E' voor man, 'K' voor vrouw), kan NULL zijn
EMAIL VARCHAR(100) NULL,              -- E-mailadres van de persoon, kan NULL zijn
BIRTHDATE DATE NULL,                  -- Geboortedatum van de persoon, kan NULL zijn
CITYID INT NULL,                      -- Stad ID, kan NULL zijn (als de persoon geen functie heeft)
DISTRICTID INT NULL,                  -- District ID, kan NULL zijn (als er geen hogere functie is)
TELNR1 VARCHAR(15) NULL,              -- Telefoonnummer 1, kan NULL zijn (als de persoon geen telefoonnummer heeft)
TELNR2 VARCHAR(15) NULL               -- Telefoonnummer 2, kan NULL zijn (als de persoon geen tweede telefoonnummer heeft)

CONSTRAINT FK_CITY FOREIGN KEY (CITYID) REFERENCES CITY(ID), -- Verwijzing naar de CITY
CONSTRAINT FK_DISTRICTID FOREIGN KEY (DISTRICTID) REFERENCES DISTRICT(ID), -- Verwijzing naar de DISTRICT


)  
        
CREATE TABLE CITY
(
ID INT IDENTITY(1,1) PRIMARY KEY,     -- Unieke ID voor de stad (Kan niet NULL zijn)
CITY VARCHAR(100) NULL,       	     -- Naam van de stad, kan NULL zijn
)

CREATE TABLE DISTRICT
(
ID INT IDENTITY(1,1) PRIMARY KEY,     -- Unieke ID voor de wijk (Kan niet NULL zijn)
CITYID INT NULL,		              -- Unieke ID voor de stad
DISTRICT VARCHAR(100) NULL,       	     -- Naam van de wijk, kan NULL zijn

CONSTRAINT FK_CITY FOREIGN KEY (CITYID) REFERENCES CITY(ID), -- Verwijzing naar de CITY
)
