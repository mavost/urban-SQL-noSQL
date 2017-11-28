/*
#------------------------------------------------------------
# FILENAME: 2017-11-03_ch02_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 03/11/2017
#------------------------------------------------------------
*/
--	Exercise 02-01-01 return employee activity period
SELECT name, vorname, eintrittsdatum, austrittsdatum FROM mitarbeiter ORDER BY name ASC;
--	Exercise 02-01-02 return employee activity period and reason for leaving
SELECT name, vorname, eintrittsdatum, austrittsdatum, austrittsgrund FROM mitarbeiter ORDER BY name ASC;
--	Exercise 02-01-03 return all employees' details
SELECT * FROM mitarbeiter ORDER BY name ASC;

--############################################################
--	Exercise 02-02-01 return employees working in sales department
SELECT * FROM mitarbeiter WHERE abteilung='Vertrieb' ORDER BY name ASC;
--	Exercise 02-02-02 return employees having used up their vacation
SELECT name, vorname, urlaubgenommen FROM mitarbeiter WHERE urlaubgenommen=30 ORDER BY name ASC;
--	Exercise 02-02-03 return employees hired on a certain date
SELECT name, vorname, eintrittsdatum FROM mitarbeiter WHERE eintrittsdatum='1978-05-22' ORDER BY name ASC;
--	Exercise 02-02-04 return employees without certain bank details
SELECT name, vorname, bankinstitut FROM mitarbeiter WHERE bankinstitut NOT LIKE 'St%öln' ORDER BY name ASC;
--	Exercise 02-02-05 return employees without overtime
SELECT name, vorname, ueberstunden FROM mitarbeiter WHERE ueberstunden<=0 ORDER BY name ASC;
--	Exercise 02-02-06 return employees with overtime
SELECT name, vorname, ueberstunden FROM mitarbeiter WHERE ueberstunden>0 ORDER BY name ASC;
--	Exercise 02-02-07 return employees hired since a certain date
SELECT name, vorname, eintrittsdatum FROM mitarbeiter WHERE eintrittsdatum>='2000-01-01' ORDER BY name ASC;
--	Exercise 02-02-08 return employees with kids
SELECT name, vorname, anzahlkinder FROM mitarbeiter WHERE NOT anzahlkinder=0 ORDER BY name ASC;
--	Exercise 02-02-09 return employees hired within a certain date range
SELECT name, vorname, eintrittsdatum FROM mitarbeiter WHERE eintrittsdatum BETWEEN '1990-01-01' AND '2000-01-01' ORDER BY name ASC;
--	Exercise 02-02-10 return employees hired with a certain gender
SELECT name, vorname, geschlecht FROM mitarbeiter WHERE geschlecht LIKE '_' ORDER BY name ASC;

--############################################################
--	Exercise 02-03-01 return male/female employees working in sales department
SELECT name, vorname, geschlecht, abteilung FROM mitarbeiter WHERE geschlecht='m' AND abteilung='Vertrieb' ORDER BY name ASC;
SELECT name, vorname, geschlecht, abteilung FROM mitarbeiter WHERE geschlecht='w' AND abteilung='Vertrieb' ORDER BY name ASC;

--	Exercise 02-03-02 return employees having certain health insurance
SELECT name, vorname, geschlecht, krankenversicherung FROM mitarbeiter WHERE krankenversicherung LIKE 'MH Plus%' OR krankenversicherung LIKE 'IKK%' ORDER BY name ASC;

--	Exercise 02-03-03 return employees before a certain date and not retired
SELECT name, vorname, gebdatum, austrittsgrund FROM mitarbeiter WHERE gebdatum<'1955-01-01' AND austrittsgrund IS NULL ORDER BY name ASC;

--	Exercise 02-03-04 return employees which are female, have kids and are not married
SELECT name, vorname, verheiratet, geschlecht, anzahlkinder, 5000 AS gratifikation FROM mitarbeiter WHERE geschlecht='w' AND verheiratet='nein' AND anzahlkinder>0 ORDER BY name ASC;

--	Exercise 02-04-02 return list of bank institutes truncated
SELECT * FROM kreditinstitut FETCH FIRST 1000 ROWS ONLY;

--############################################################
--	Exercise 02-05-01 return multi-sorted list
SELECT name, vorname, abteilung FROM mitarbeiter ORDER BY abteilung ASC, name ASC;

--	Exercise 02-05-02 return multi-sorted list
SELECT name, vorname, abteilung FROM mitarbeiter ORDER BY abteilung DESC, name ASC;

--	Exercise 02-05-03 return multi-sorted list
SELECT name, vorname, abteilung, bonus FROM mitarbeiter ORDER BY abteilung ASC, bonus ASC;

--	Exercise 02-05-04 return multi-sorted list
SELECT name, vorname, austrittsdatum FROM mitarbeiter WHERE austrittsdatum IS NOT NULL ORDER BY austrittsdatum;
SELECT name, vorname, austrittsdatum FROM mitarbeiter ORDER BY austrittsdatum ASC NULLS LAST;
SELECT name, vorname, austrittsdatum FROM mitarbeiter ORDER BY austrittsdatum ASC NULLS FIRST;
SELECT name, vorname, austrittsdatum FROM mitarbeiter ORDER BY CASE WHEN austrittsdatum IS NULL THEN 0 ELSE 1 END, austrittsdatum ASC;

--	Exercise 02-05-05 return multi-sorted list
SELECT name, vorname, austrittsdatum, austrittsgrund FROM mitarbeiter WHERE austrittsdatum IS NOT NULL AND austrittsgrund='ruhestand' ORDER BY austrittsdatum ASC;

--############################################################
--  Chapter 02-06-01
SELECT 'Happy Birthday!!', 'Happy Birthday!!' AS title;

--	Exercise 02-06-01 return constants
SELECT 'Hello', 'Friend';

--	Exercise 02-06-02 blend database entries and constants
SELECT vorname, name, 'celebrates his birthday on', gebdatum, '.' FROM mitarbeiter;

--	Exercise 02-06-03 blend database entries and more constants
SELECT vorname, name, 'has', 120, 'bonus points.' FROM mitarbeiter;

--############################################################
--	Exercise 02-07-01 using aliases
SELECT name AS Name, vorname AS Vorname, strasse AS Strasse, hausnummer AS Hausnummer, plz AS Postleitzahl, ort AS Ort FROM mitarbeiter;

--	Exercise 02-07-02 using aliases and case
SELECT 'Hello' AS greeting, CASE WHEN geschlecht='m' THEN 'Mr.' WHEN geschlecht='w' AND verheiratet='nein' THEN 'Ms.' ELSE 'Mrs.' END AS title, vorname AS Vorname, name AS Name FROM mitarbeiter;

--############################################################
--  Chapter 02-08-01
SELECT DISTINCT * FROM mitarbeitergleich;

--	Exercise 02-08-01 using distinct # does not exist
--SELECT produkt, beschreibung, marktbewertung FROM produktgleich;



--SELECT * FROM mitarbeiter ORDER BY name ASC FETCH FIRST 2 ROWS ONLY;
--SELECT name, vorname, verheiratet, geschlecht, anzahlkinder FROM mitarbeiter ORDER BY name ASC;
--SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='public' ORDER BY table_name ASC;






