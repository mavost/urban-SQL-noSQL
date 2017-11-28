/*
#------------------------------------------------------------
# FILENAME: 2017-11-17_ch11-13_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 17/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 11-01
--	Calculations in tables
--	Binary ops:
SELECT name, vorname, bonus, monatslohn, monatslohn*12+bonus AS jahresgehalt FROM mitarbeiter;
SELECT name, vorname, bonus, monatslohn, monatslohn*12+bonus AS jahresgehalt FROM mitarbeiter WHERE monatslohn*12+bonus >55000 ORDER BY jahresgehalt DESC LIMIT 10;

--############################################################
--	Exercise 11-01-01
SELECT jahr, q1, q2, q3, q4, q1+q2+q3+q4 AS summenquartale FROM umsatzausgaben;
--	Exercise 11-01-02
SELECT jahr, personal, invest, invest-personal AS differenz FROM umsatzausgaben;
--	Exercise 11-01-03
SELECT jahr, q1+q2+q3+q4 AS umsatz, miete+nebkosten+personal+invest AS kosten, q1+q2+q3+q4-(miete+nebkosten+personal+invest) AS gewinn FROM umsatzausgaben;
--	Exercise 11-01-04
SELECT jahr, (miete+nebkosten+personal+invest)*10 AS nebenkosten10jahre FROM umsatzausgaben WHERE jahr=2003;
--	Exercise 11-01-05
SELECT jahr, (miete+nebkosten+personal+invest)/4 AS kostenquartal FROM umsatzausgaben;
--	Exercise 11-01-06
SELECT jahr, (miete+nebkosten+personal+invest)/4 AS kostenquartal FROM umsatzausgaben ORDER BY kostenquartal DESC;

--############################################################
--  Chapter 12-01
--	Functions
--	Textfunctions: 
--		LOWER/UPPER:					case conversion
--		TRIM: 							remove blanks and tabs from beginning/end of entry
--		SUBSTRING(name FROM x FOR y)	extract smaller string of length y from position x in field name
--		CONCAT(str1,' ',str2,' ', ...) 	string concatination / MySQL
--		str1||' '||str2||' ', ...		string concatination / postgreSQL

--############################################################
--	Exercise 12-01-01 to 04 too basic
--	Exercise 12-01-05
SELECT artikelbezeichnung, legierung, '_'||artikelbezeichnung||'_'||legierung||'_' AS merge FROM produktleerzeichen;

--############################################################
--  Chapter 12-02
--	Additional Functions
--		CHAR_LENGTH(name):				returns length of a string entry
--		POSITION(string1 IN string2):	starting position of string1 in string2
--		POWER(Base, Exponent):			return exponential value
--		SQRT(name):						square root
--		... many more

--############################################################
--	Exercise 12-02-01 to 04 too basic

--############################################################
--  Chapter 12-03
--	Chained Functions
--  stuff like SQRT(POWER(2,5)) is possible
--############################################################
--	Exercise 12-03 too basic

--############################################################
--  Chapter 13-01
-- CASE stops with the first satisfying condition it finds
--  CASE clause to create categories
SELECT name, vorname, CASE WHEN austrittsdatum is NULL THEN 'aktiver M.A.' ELSE 'ausgeschieden' END AS status FROM mitarbeiter;

--  CASE clause to create categories for sorting
SELECT name, vorname, austrittsgrund FROM mitarbeiter ORDER BY CASE WHEN austrittsgrund ='ruhestand' THEN 3 WHEN austrittsgrund ='veränderung' THEN 2 WHEN austrittsgrund ='abfindungsprogramm' THEN 1 END, name;

--############################################################
--	Exercise 13-01-01 -- pretty bad/inconsistent problem statement
SELECT quartal, umsatz, CASE WHEN umsatz<5000000 THEN 'rot' WHEN (umsatz>=5000000 AND umsatz<12000000) THEN 'gelb' WHEN umsatz>=12000000 THEN 'gruen' END AS ampel from umsatz;
--	Exercise 13-01-02 -- skipped