/*
#------------------------------------------------------------
# FILENAME: 2017-11-07_ch05_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 07/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 05-01 UNION, INTERSECT, EXCEPT across multiple tables

SELECT artikelbezeichnung, kategorie, legierung from produkt
--UNION ALL --allow duplicate rows
UNION --no duplicate rows
SELECT artikelbezeichnung, kategorie, legierung from produktarchiv;

--############################################################
-- Exercise 05-02-01 UNION
SELECT name, vorname FROM niederlassungbelgien
UNION
SELECT name, vorname FROM niederlassungholland ORDER BY name;

-- Exercise 05-02-02 UNION ALL
SELECT name, vorname FROM niederlassungbelgien
UNION ALL
SELECT name, vorname FROM niederlassungholland ORDER BY name;

-- Exercise 05-02-03 UNION with three data streams
SELECT name, vorname FROM niederlassungbelgien
UNION
SELECT name, vorname FROM niederlassungholland
UNION
SELECT name, vorname FROM niederlassungschweiz ORDER BY name;

--############################################################
-- Exercise 05-03-01 INTERSECT
SELECT name, vorname FROM niederlassungbelgien
INTERSECT
SELECT name, vorname FROM niederlassungholland ORDER BY name;

-- Exercise 05-03-02 INTERSECT with three data streams
SELECT name, vorname FROM niederlassungbelgien
INTERSECT
SELECT name, vorname FROM niederlassungholland
INTERSECT
SELECT name, vorname FROM niederlassungschweiz ORDER BY name;

-- Exercise 05-03-03 INTERSECT with increased tables
SELECT name, vorname, status FROM niederlassungbelgien
INTERSECT
SELECT name, vorname, status FROM niederlassungholland ORDER BY name;

--############################################################
-- Exercise 05-05-01 filter before SET operation
SELECT name, vorname, status FROM niederlassungholland WHERE status='aktiv'
UNION
--UNION ALL
--EXCEPT
--INTERSECT
SELECT name, vorname, status FROM niederlassungbelgien WHERE status='aktiv' ORDER BY name;

-- Exercise 05-05-02 filter before SET operation
SELECT name, vorname FROM niederlassungholland
INTERSECT
SELECT name, vorname FROM niederlassungbelgien WHERE status='aktiv' ORDER BY name;

--############################################################
-- Exercise 05-06-01 ordering after SET operation --> see above



