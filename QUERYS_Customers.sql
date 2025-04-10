

-- 1-Maak een database genaamd 'Customers' aan en voeg het gegeven Excel-bestand als een tabel toe.

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

)  
--*******************************************************************************************   

-- 2-Schrijf een query die personen ophaalt waarvan de voornaam met de letter ‘A’ begint.

select * from CUSTOMERS
where NAMESURNAME like 'A%'
-->>Resultaat 78 Rows
--*******************************************************************************************

-- 3-Haal klanten op die geboren zijn tussen 1990 en 1995 (inclusief).

select * from CUSTOMERS
where year(BIRTHDATE) > 1990 and year(BIRTHDATE) <= 1995
-->>Resultaat 81 Rows
--*******************************************************************************************

-- 4-Schrijf een query met een JOIN om personen op te halen die in Istanbul wonen.

SELECT * 
FROM CUSTOMERS
JOIN CITIES c ON CUSTOMERS.CityID = c.ID
where c.CITY = 'ISTANBUL'
-->>Resultaat 47 Rows
--*******************************************************************************************

-- 5-Schrijf een subquery om personen op te halen die in Istanbul wonen.

SELECT * 
FROM CUSTOMERS
where CITYID in (select ID from CITIES
					where ID = 34)
--*******************************************************************************************

-- 6-Schrijf een query die toont hoeveel klanten we in elke stad hebben.

select ct.CITY, count(c.ID) as AantalKlanten from CUSTOMERS c
join CITIES ct on ct.ID = c.CITYID
group by ct.CITY
--*******************************************************************************************

-- 7- Haal steden op waar we meer dan 10 klanten hebben, inclusief het aantal klanten, en sorteer deze van hoog naar laag op klantenaantal.

select ct.CITY, count(c.ID) as AantalKlanten from CUSTOMERS c
join CITIES ct on ct.ID = c.CITYID
group by ct.CITY
Having count(c.ID) > 10
order by count(c.ID)
-->>Resultaat 36 Rows
--*******************************************************************************************

-- 8-Schrijf een query die toont hoeveel mannelijke en vrouwelijke klanten we per stad hebben.

select ct.CITY, SUM(CASE WHEN c.Gender = 'E' THEN 1 ELSE 0 END) AS MaleCustomers,
    SUM(CASE WHEN c.Gender = 'K' THEN 1 ELSE 0 END) AS FemaleCustomers 
	from CUSTOMERS c
join CITIES ct on ct.ID = c.CITYID
group by ct.CITY


-- 9-Voeg een nieuw veld toe genaamd AGEGROUP aan de Customers-tabel voor leeftijdsgroepen. 
-- Dit moet zowel via SQL-code als via SQL Server Management Studio worden gedaan. 
-- Het datatype moet VARCHAR(50) zijn.

ALTER TABLE CUSTOMERS
ADD AGEGROUP VARCHAR(50) NULL;
--*******************************************************************************************

-- 10-Werk het AGEGROUP-veld bij in leeftijdsgroepen: 20-35 jaar, 36-45 jaar, 46-55 jaar, 55-65 jaar, en ouder dan 65 jaar.

UPDATE CUSTOMERS
SET AGEGROUP = CASE 
    WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35'
    WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '36-45'
    WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '46-55'
    WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 55 AND 65 THEN '55-65'
    WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65+'
    ELSE 'Unknown'  
END
WHERE AGEGROUP IS NULL;

select NAMESURNAME, BIRTHDATE, AGEGROUP from CUSTOMERS
order by AGEGROUP
--*******************************************************************************************

-- 11-Toon klanten die in Istanbul wonen maar niet in het district ‘Kadıköy’.

select * FROM CUSTOMERS 
JOIN CITIES c ON CUSTOMERS.CityID = c.ID
join DISTRICT d on d.CITYID = c.ID
where c.CITY = 'ISTANBUL' and d.DISTRICT <> 'KADIKOY'

--*******************************************************************************************

-- 12-We willen de operator-informatie (zoals 532, 505) van de telefoonnummers TELNR1 en TELNR2 naast het nummer tonen. Schrijf hiervoor de benodigde SQL-query.

SELECT 
    TELNR1,
    SUBSTRING(TELNR1, 2, 3) AS AreaCode1, 
    TELNR2,
    SUBSTRING(TELNR2, 2, 3) AS AreaCode2
FROM CUSTOMERS;

--*******************************************************************************************
/*
 13- We willen operatorinformatie van de telefoonnummers van onze klanten tonen. 
		Bijvoorbeeld: nummers beginnend met “50” of “55” zijn van operator “X”, “54” is operator “Y”, “53” is operator “Z”. Schrijf een query die toont hoeveel klanten we per operator hebben.
*/

SELECT 
    Operator,
    COUNT(ID) AS 'Aantal van Klanten'
FROM (
    SELECT 
        ID,
        CASE 
            WHEN SUBSTRING(TELNR1, 2, 2) IN ('50', '55') THEN 'X Telecomoperator'
            WHEN SUBSTRING(TELNR1, 2, 2) = '54' THEN 'Y Telecomoperator'
            WHEN SUBSTRING(TELNR1, 2, 2) = '53' THEN 'Z Telecomoperator'
            ELSE 'Unknown'
        END AS Operator
    FROM CUSTOMERS

    UNION

    SELECT 
        ID,
        CASE 
            WHEN SUBSTRING(TELNR2, 2, 2) IN ('50', '55') THEN 'X Telecomoperator'
            WHEN SUBSTRING(TELNR2, 2, 2) = '54' THEN 'Y Telecomoperator'
            WHEN SUBSTRING(TELNR2, 2, 2) = '53' THEN 'Z Telecomoperator'
            ELSE 'Unknown'
        END AS Operator
    FROM CUSTOMERS
) AS AllNumbers
GROUP BY Operator;

/*
 Een functie die netnummers omzet naar operatornamen kan worden gedefinieerd 
 en vervolgens herhaaldelijk worden gebruikt voor dit soort queries.
*/

CREATE FUNCTION GetOperator(@code VARCHAR(2))
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN (
        CASE @code
            WHEN '50' THEN 'X Telecomoperator'
            WHEN '53' THEN 'Y Telecomoperator'
            WHEN '54' THEN 'Z Telecomoperator'
            WHEN '55' THEN 'K Telecomoperator'
            ELSE 'Unknown'
        END
    )
END
/*
 Daarna kun je het op deze manier in je query gebruiken.
"SQL Server slaat dit standaard op in het 'dbo'-schema. 
 Daarom moet je de functienaam aanroepen met de schemanaam erbij.
 */
SELECT 
    Telecomoperator,
    COUNT(ID) AS AantalKlanten
FROM (
    SELECT 
        ID,
        dbo.GetOperator(SUBSTRING(TELNR1, 2, 2)) AS Telecomoperator
    FROM CUSTOMERS

    UNION

    SELECT 
        ID,
        dbo.GetOperator(SUBSTRING(TELNR2, 2, 2)) AS Telecomoperator
    FROM CUSTOMERS
) AS AllOperators
GROUP BY Telecomoperator;


--*******************************************************************************************
-- 14-Schrijf een query die per provincie het district toont met de meeste klanten, gesorteerd van meest naar minst aantal klanten.
/*
Met de SELECT-instructie wordt een tijdelijke tabel gemaakt waarin de gevraagde gegevens worden opgehaald. 
Deze tijdelijke tabel wordt gesorteerd op basis van de hoogste klantenaantallen per district binnen elke stad door gebruik te maken van de ROW_NUMBER()-functie. 
In de eerste stap wordt de kolom bepaald waarop de bewerking moet worden uitgevoerd. 
De aggregerende functie die op deze kolom wordt toegepast, evenals de sorteervolgorde, worden vastgesteld. 
Daarna wordt er een tijdelijke tabel gecreëerd en gesorteerd op basis van ROW_NUMBER(), waarbij de wijken per stad worden gerangschikt.
Uit deze tijdelijke tabel worden de rijen met de hoogste klantenaantallen gefilterd met de WHERE-clausule. 
Ten slotte worden de gegevens uit deze rijen gebruikt in de uiteindelijke SELECT-instructie.
*/
SELECT CITY, DISTRICT, AantalKlanten
FROM (
    SELECT 
        c.CITY,
        d.DISTRICT,
        COUNT(cs.ID) AS AantalKlanten,
        ROW_NUMBER() OVER (PARTITION BY c.CITY ORDER BY COUNT(cs.ID) DESC) AS RowNum
    FROM CUSTOMERS cs
    JOIN DISTRICT d ON d.ID = cs.DISTRICTID
    JOIN CITIES c ON c.ID = d.CITYID
    GROUP BY c.CITY, d.DISTRICT
) AS RankedDistricts
WHERE RowNum = 1
ORDER BY CITY

-- Alle wijken sorteren op aantalklanten
SELECT
    c.CITY,
    d.DISTRICT,
    COUNT(cs.ID) AS Aantalklanten
FROM CUSTOMERS cs
JOIN DISTRICT d ON d.ID = cs.DISTRICTID
JOIN CITIES c ON c.ID = d.CITYID
GROUP BY c.CITY, d.DISTRICT
ORDER BY c.CITY, COUNT(cs.ID) DESC

-- De wijken sorteren op basis van het aantal per gewenste stad. 
SELECT
    c.CITY,
    d.DISTRICT,
    COUNT(cs.ID) AS AantalKlanten
FROM CUSTOMERS cs
JOIN DISTRICT d ON d.ID = cs.DISTRICTID
JOIN CITIES c ON c.ID = d.CITYID
WHERE c.CITY = 'ADANA'  -- Hier kan de gewenste stad worden ingevuld.
GROUP BY c.CITY, d.DISTRICT
ORDER BY COUNT(cs.ID) DESC, c.CITY, d.DISTRICT;


--Schrijf een query die de geboortedag van de klanten toont als dag van de week (maandag, dinsdag, woensdag, etc.).
SELECT 
    NAMESURNAME, BIRTHDATE,
    DATENAME(WEEKDAY, BIRTHDATE) AS BirthDayOfWeek
FROM CUSTOMERS
