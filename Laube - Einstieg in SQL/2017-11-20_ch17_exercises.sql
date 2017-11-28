/*
#------------------------------------------------------------
# FILENAME: 2017-11-20_ch17_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 20/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 17
-- Views are common-use queries which have been saved with an alias for purpose of:
--> 	- short hand / simplification
--> 	- encapsulation / permission
--############################################################
--  Chapter 17-01
--	CREATE VIEW statement and a virtual table is generated
--> changes to the database are shown in instant time, where the view is called up
--> best-practice for naming views is "v_" as a prefix
--> Example:
	DROP VIEW v_mitarbeiter;
	CREATE VIEW v_mitarbeiter AS 
		SELECT mitarbeiterid, name, vorname FROM mitarbeiter;
	SELECT * FROM v_mitarbeiter;

--############################################################
--  Chapter 17-02
-->	Views can contain ORDER BY
--> Example:
	DROP VIEW v_mitarbeiterkontakt;
	CREATE VIEW v_mitarbeiterkontakt
		AS SELECT
			m.mitarbeiterid,
			m.name,
			m.vorname,
			k.festnetz,
			k.mobilnetz
		FROM mitarbeiter m INNER JOIN kontakt k ON
			m.mitarbeiterid=k.mitarbeiterid
		ORDER BY
			m.name, m.vorname;
	SELECT * FROM v_mitarbeiterkontakt;
--############################################################
--	Exercise 17-01-01 to 05
--	Exercise 17-02-01 to 02 too simple

--############################################################
--  Chapter 17-03
-->	Views can be used to INSERT datasets 
-->		-even for multi-table views with JOINS in MySQL / MS SQL Server
-->			-->BUT only one table will be updated in those multi-table views
--> Example:
	INSERT INTO v_mitarbeiter VALUES (122,'EBERT','Josef');
	SELECT * FROM v_mitarbeiter;
	--> needs the primary key as part of the view AND the key to be a not auto-increment (non-SERIAL) data type

-->	Views can be used to UPDATE datasets
	UPDATE v_mitarbeiter SET name='Ebert' WHERE mitarbeiterid=122;
	SELECT * FROM v_mitarbeiter;

-->	Views can be used to DELETE datasets
	DELETE FROM v_mitarbeiter WHERE mitarbeiterid=122;
	SELECT * FROM v_mitarbeiter;

--> Edit functions INSERT, UPDATE, DELETE will not work with advanced query results using
--			-aggregates, unions, outer joins, and several more
--############################################################
--	Exercise 17-03-01 to 07 too simple

--############################################################
--  Chapter 17-04
-->	Views can be dropped like tables as seen above already
	DROP VIEW v_mitarbeiterkontakt;