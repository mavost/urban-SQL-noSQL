/*
#------------------------------------------------------------
# FILENAME: 2017-11-20_ch15_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 20/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 15-01
-- Grouping with GROUP BY is an aggregation form like the pivot table in Excel uses
-- 	some functions which can run on the aggregation:
--		COUNT(entry), SUM(entry), MIN(entry), MAX(entry), AVG(entry): arithmetic mean

-- #examples using COUNT()
	SELECT mitarbeiterid, COUNT(bonusid) AS numberbonus FROM bonus GROUP BY mitarbeiterid;
--		count number of bonus payments by employee (NULL values ignored)
	SELECT mitarbeiterid, COUNT(*) AS numberbonus FROM bonus GROUP BY mitarbeiterid;
--		count number of entries by employee, in case the is no entry free from NULL values

-- in contrast to counting in aggregations by categories one can use COUNT for to count entries like in a set
	SELECT COUNT(DISTINCT mitarbeiterid) AS num_luckyfew FROM bonus;
	
-- get numbers of rows in a table where even a primary key can contain NULL
	SELECT COUNT(*) AS num_rows FROM kreditinstitut;


--############################################################
--	Exercise 15-01-01
	SELECT bankleitzahl, COUNT(bezeichnung) AS num_of_banks FROM kreditinstitut GROUP BY bankleitzahl ORDER BY num_of_banks DESC;
	--in contrast to 
	SELECT COUNT(DISTINCT bankleitzahl) AS num_BLZs FROM kreditinstitut;

--	Exercise 15-01-02
--		important example
	SELECT COUNT(*) AS num_rows FROM kreditinstitut;

--############################################################
--  Chapter 15-02
-- #examples using SUM() analog to count but no DISTINCT or (*)

--	Exercise 15-02-01
	SELECT SUM(bonuszahlung) AS bonusperdate, auszahlungsdatum FROM bonus GROUP BY auszahlungsdatum ORDER BY auszahlungsdatum;
--	Exercise 15-02-02
	SELECT SUM(bonuszahlung) AS bonustotal FROM bonus;

--############################################################
--  Chapter 15-03 to 05
-- noteworthy example, also accounting for empty values in a calculation:
	SELECT AVG(CASE WHEN bonuszahlung IS NULL THEN 0 ELSE bonuszahlung END) AS avg_bonus, mitarbeiterid FROM bonus GROUP BY mitarbeiterid;

--############################################################
--  Chapter 15-06
--		HAVING filters for a particular result of an agregation
--	# list only the banks with one name and no alias	
	SELECT bankleitzahl, COUNT(bankleitzahl) AS num_of_banks FROM kreditinstitut GROUP BY bankleitzahl HAVING COUNT(bankleitzahl) = 1;
--	Exercise 15-06-01
	SELECT bankleitzahl, COUNT(bankleitzahl) AS num_of_banks FROM kreditinstitut GROUP BY bankleitzahl HAVING COUNT(bankleitzahl) > 1;

--############################################################
--  Chapter 15-07
--		it can be grouped by several columns
--	Exercise 15-06-01
	SELECT mitarbeiterid, jahr, monat, SUM(anzahlstunden) AS stunden_pro_monat FROM arbeitszeit GROUP BY mitarbeiterid, jahr, monat ORDER BY mitarbeiterid, jahr, monat;
--	Exercise 15-06-02 with a red flag check
	SELECT mitarbeiterid, jahr, monat, SUM(anzahlstunden) AS stunden_pro_monat FROM arbeitszeit WHERE jahr != 2014 AND monat != 1 GROUP BY mitarbeiterid, jahr, monat ORDER BY mitarbeiterid, jahr, monat HAVING SUM(anzahlstunden) > 176 OR SUM(anzahlstunden) < 150;
