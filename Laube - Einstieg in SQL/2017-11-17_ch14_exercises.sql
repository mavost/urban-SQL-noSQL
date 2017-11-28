/*
#------------------------------------------------------------
# FILENAME: 2017-11-17_ch14_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 17/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 14-01 to 03
-- Time/ Date functions

SELECT CURRENT_DATE ...;
-->following ISO8601 standard
SELECT CURRENT_TIME ...;
SELECT CURRENT_TIMESTAMP ...;


-->Date formatting
--	note that date can refer to CURRENT_DATE / CURRENT_TIMESTAMP or DB values but not CURRENT_TIME
--MySQL
DATE_FORMAT(date, formatting);
-->set output format to language/country specifics
SET LC_TIME_NAMES=de_DE
SET LC_TIME_NAMES=en_US
SET LC_TIME_NAMES=en_UK
--postgreSQL
TO_CHAR(date, formatting);
-->set output format to language/country specifics and add TM to formatter to translate
SET LC_TIME='German_Germany';
SET LC_TIME='English_United States';
--MS SQL SERVER
FORMAT(date, formatting);

-->many options
--#example MySQL
SELECT DATE_FORMAT(CURRENT_DATE, '%d.%m.%Y') AS reportdate;
--#example postgreSQL
--SET LC_TIME='English_United States';
SET LC_TIME='German_Germany';
-->TM in front of variable to translate
SELECT TO_CHAR(CURRENT_DATE, 'DD. TMMonth YYYY') AS reportdate, CURRENT_TIMESTAMP;
SELECT TO_CHAR(CURRENT_DATE, 'DD.MM.YYYY') AS reportdate;

--############################################################
--	Exercise 14-03-01
SELECT TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS') AS time;
--	Exercise 14-03-02
SET LC_TIME='German_Germany';
SELECT name, vorname, TO_CHAR(gebdatum, 'DD. TMMonth YYYY') AS gdatum, TO_CHAR(eintrittsdatum, 'DD.MM.YYYY') AS edatum FROM mitarbeiter;

--############################################################
--  Chapter 14-04
-- parsing parts of a date

--MySQL / postgreSQL
-->using EXTRACT('part of a date descriptor' FROM date)
--	descriptor options a DB dependant as above for formatting
--#example postgreSQL
SELECT name, vorname, EXTRACT(year FROM gebdatum) AS gjahr,  EXTRACT(year FROM eintrittsdatum) AS ejahr FROM mitarbeiter;
--MS SQL Server
-->using DATEPART('part of a date descriptor' FROM date)

--############################################################
--	Exercise 14-04-01
SELECT name, vorname, EXTRACT(year FROM austrittsdatum) AS ajahr FROM mitarbeiter WHERE austrittsdatum IS NOT NULL;
--	Exercise 14-04-02, slightly expanded
SELECT mitarbeiter.name, mitarbeiter.vorname, EXTRACT(month FROM bonus.auszahlungsdatum) AS bonusmonth FROM mitarbeiter INNER JOIN bonus ON mitarbeiter.mitarbeiterid=bonus.mitarbeiterid;

--############################################################
--  Chapter 14-05
-- calculations with dates

--MySQL
SELECT DATE_ADD(date, INTERVAL number unit);
SELECT DATE_SUB(date, INTERVAL number unit);
--postgreSQL
SELECT DATE 'year-month-day' + INTERVAL 'number unit';
SELECT DATE 'year-month-day' - INTERVAL 'number unit';
--MS SQL SERVER
SELECT DATEADD(unit, number, date);
SELECT DATEADD(unit, -number, date);

--############################################################
--############################################################
--	Exercise 14-05-01
SELECT DATE '2017-04-01' + INTERVAL '10 MONTH' AS addition;
--	Exercise 14-05-02
SELECT DATE '2017-04-01' - INTERVAL '10 MONTH' AS subtraction;


