# **SQL Queries for Customer Data Analysis
Dit project bevat verschillende SQL-query's voor het analyseren van klantgegevens en het genereren van verschillende statistieken. Deze queries zijn ontworpen om specifieke klantinformatie op te halen uit een database met verschillende tabellen zoals CUSTOMERS, CITIES en DISTRICT. De focus ligt op het extraheren van gegevens op basis van verschillende klantkenmerken, zoals naam, geboortedatum, locatie en telefoonnummers.

## **Inhoud van de repository
Deze repository bevat SQL-query's die verschillende klantinformatie ophalen, inclusief het aantal klanten per stad, het vinden van klanten op basis van geboortejaar, het tonen van klantverdelingen per operator, en meer. De queries maken gebruik van verschillende SQL-technieken, zoals JOIN, GROUP BY, HAVING, CASE, en ROW_NUMBER().

Daarnaast wordt er gebruik gemaakt van een aangepaste SQL-functie, GetOperator, die telefoonnummers analyseert en de bijbehorende telecomoperatoren bepaalt. Deze functie helpt bij het classificeren van klanten op basis van hun operator en kan herhaaldelijk gebruikt worden in verschillende queries. Hieronder volgt een gedetailleerde uitleg van de gebruikte functies en query's.

## **Uitleg van Gebruikte SQL-commando's
De queries in dit project maken gebruik van verschillende SQL-commando's en functies. Hier volgt een kort overzicht van de belangrijkste concepten en commando's die in de queries worden gebruikt:

## **1. SELECT
Het SELECT-commando wordt gebruikt om specifieke kolommen uit de database op te halen. In dit project worden verschillende SELECT-queries gebruikt om klantgegevens op te halen, zoals naam, geboortedatum, geslacht en locatie.

## **2. JOIN
Het JOIN-commando wordt gebruikt om gegevens van verschillende tabellen te combineren. Meestal wordt het gebruikt om de klanteninformatie uit de CUSTOMERS-tabel te koppelen met de CITIES-tabel (voor stadgegevens) en de DISTRICT-tabel (voor wijkinformatie).

## **3. WHERE
Het WHERE-commando filtert de rijen op basis van specifieke voorwaarden. Bijvoorbeeld, klanten die in een bepaalde stad wonen of klanten die geboren zijn in een specifiek jaartal.

## **4. GROUP BY
Het GROUP BY-commando wordt gebruikt om gegevens te groeperen op basis van een of meer kolommen. In dit project wordt het gebruikt om klanten per stad of wijk te groeperen om bijvoorbeeld het aantal klanten per stad te berekenen.

## **5. HAVING
Het HAVING-commando wordt gebruikt in combinatie met GROUP BY om gefilterde resultaten weer te geven na het groeperen van gegevens. Het wordt vaak gebruikt om alleen die groepen weer te geven die voldoen aan bepaalde voorwaarden, zoals het tonen van steden met meer dan 10 klanten.

## **6. CASE
De CASE-expressie wordt gebruikt om voorwaardelijke logica toe te passen binnen een query. Bijvoorbeeld, om het geslacht van klanten te categoriseren of om de leeftijdsgroepen van klanten te berekenen op basis van hun geboortedatum.

## **7. COUNT()
De COUNT()-functie wordt gebruikt om het aantal rijen (bijvoorbeeld het aantal klanten) te tellen binnen een bepaalde groep of voor een bepaalde kolom. Dit is handig voor het berekenen van het aantal klanten in verschillende steden of districten.

## **8. ROW_NUMBER()
De ROW_NUMBER()-functie wordt gebruikt om een rijnummer toe te wijzen aan de resultaten van een query, op basis van een opgegeven volgorde. Dit wordt vaak gebruikt om bijvoorbeeld het district met de meeste klanten binnen elke stad te vinden door de rijen te nummeren en vervolgens de bovenste rij te selecteren.

## **9. SUBSTRING()
De SUBSTRING()-functie wordt gebruikt om een gedeelte van een string op te halen, bijvoorbeeld om het netnummer van een telefoonnummer te extraheren om te bepalen welke operator een klant heeft.

## **10. DATENAME()
De DATENAME()-functie wordt gebruikt om de naam van een dag van de week (zoals "maandag", "dinsdag") te verkrijgen op basis van een datumnotatie.

