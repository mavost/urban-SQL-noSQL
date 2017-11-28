/*
#------------------------------------------------------------
# FILENAME: 2017-11-16_ch09_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 16/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 09-01
--	Inserting data into tables with relations must follow an such an order that their referential integrity is maintained


--############################################################
--	Exercise 09-01-01
--############################################################
-- Exercise 09-01-01
--fill strong tables first
DELETE FROM verlag;
INSERT INTO verlag VALUES (1,'Rheinwerk Verlag');
INSERT INTO verlag VALUES (2,'Elektro Verlag');
INSERT INTO verlag VALUES (3,'Mechanik Verlag');
INSERT INTO verlag VALUES (4,'Kaufmann Verlag');
INSERT INTO verlag VALUES (5,'Medien Verlag');
DELETE FROM fachbereich;
INSERT INTO fachbereich VALUES (1,'Elektrotechnik');
INSERT INTO fachbereich VALUES (2,'Kaufmann');
INSERT INTO fachbereich VALUES (3,'Mechanik');
INSERT INTO fachbereich VALUES (4,'Pneumatik');
DELETE FROM fachbuch;
-- Exercise 09-01-02
--fill 1:n relation tables
DELETE FROM fachbuch;
INSERT INTO fachbuch VALUES (1,1235,'Mechanik',3);
INSERT INTO fachbuch VALUES (2,9878,'Elektrotechnik',2);
INSERT INTO fachbuch VALUES (3,2323,'Elektronik',2);
INSERT INTO fachbuch VALUES (4,2254,'Pneumatik',3);
INSERT INTO fachbuch VALUES (5,4455,'Mathematik Grundlagen I',2);
INSERT INTO fachbuch VALUES (6,4456,'Mathematik Grundlagen II',2);
INSERT INTO fachbuch VALUES (7,5566,'Mengenlehre',null);
INSERT INTO fachbuch VALUES (8,7766,'Kommunikation 1',null);
INSERT INTO fachbuch VALUES (9,7767,'Kommunikation 2',null);
-- Exercise 09-01-03
--fill m:n relation tables
DELETE FROM fachbereichfachbuch;
INSERT INTO fachbereichfachbuch VALUES (3,1);
INSERT INTO fachbereichfachbuch VALUES (1,3);
INSERT INTO fachbereichfachbuch VALUES (4,4);
INSERT INTO fachbereichfachbuch VALUES (1,5);
INSERT INTO fachbereichfachbuch VALUES (1,6);
INSERT INTO fachbereichfachbuch VALUES (1,7);
INSERT INTO fachbereichfachbuch VALUES (2,8);
INSERT INTO fachbereichfachbuch VALUES (2,9);

--############################################################
--  Chapter 09-02 Joins
--INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN, CROSS JOIN

--INNER JOIN - return only rows with key and matching on both ends
SELECT name, vorname, plz, ort FROM auszubildender_alt INNER JOIN adresse ON id=mitarbeiterid;
--LEFT OUTER JOIN - return only rows with entry existing on left table or matching keys on both ends
SELECT name, vorname, plz, ort FROM auszubildender_alt LEFT OUTER JOIN adresse ON id=mitarbeiterid;
--RIGHT OUTER JOIN - return only rows with entry existing on left table or matching keys on both ends
SELECT name, vorname, plz, ort FROM auszubildender_alt RIGHT OUTER JOIN adresse ON id=mitarbeiterid;
--FULL OUTER JOIN - combines INNER, LEFT OUTER and RIGHT OUTER JOIN in a shortcut sense where MySQL users need to use UNION
SELECT name, vorname, plz, ort FROM auszubildender_alt FULL OUTER JOIN adresse ON id=mitarbeiterid;
--CROSS JOIN - produce a cartesian product of two tables, i.e. all possible combinations of entries
SELECT name, vorname, plz, ort FROM auszubildender_alt CROSS JOIN adresse;

--Joining two m:n tables via a third looks like this
SELECT berufsbezeichnung, lehrfach FROM ausbildungsberuf INNER JOIN beruflehrfach ON berufsid=fk_berufsid INNER JOIN lehrfach ON fk_lehrfachid=lehrfachid;

--->For sake of clarity it is necessary to reference column names with their full address <table>.<column-name>
--		to avoid ambiguity errors
--->Similarly, an alias can assist in providing a clear description of the ambiguous column names in a joined table
SELECT table1.title AS title_t1, table2.title AS title_t2 FROM table1 INNER JOIN table2 ON table1.id=table2.fk_id;

--SELF JOIN for visualizing hierarchies needs a table alias
--		-The previous column alias is absulutely needed in a SELF JOIN for clarity on top of the table alias itself
SELECT m2.mitarbeiterid as id_vg, m2.name as name_vg, m1.name as name_ma, m1.vorname as vorname_ma, m1.mitarbeiterid as id_ma FROM mitarbeiter2 m1 INNER JOIN mitarbeiter2 m2 ON m1.vorgesetzterid=m2.mitarbeiterid ORDER BY id_vg;

--Generally it is possible to join two tables via fields of similar data types (fit for comparison by database standards),
--		 an official key is not necessarily needed

--############################################################
-- Exercise 09-02-01 1:n INNER JOIN
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag INNER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid;

-- Exercise 09-02-02 1:n RIGHT OUTER JOIN
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag RIGHT OUTER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid;

-- Exercise 09-02-03 1:n LEFT OUTER JOIN
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag LEFT OUTER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid;

-- Exercise 09-02-04 1:n FULL OUTER JOIN
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag FULL OUTER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid;
--Alternative using MySQL functions
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag INNER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid UNION 
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag RIGHT OUTER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid WHERE verlag.verlagid IS NULL UNION
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag LEFT OUTER JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid WHERE fachbuch.fk_verlagid IS NULL;

-- Exercise 09-02-05 1:n CROSS JOIN
SELECT verlag.verlag, verlag.verlagid, fachbuch.titel, fachbuch.isbn, fachbuch.fk_verlagid FROM verlag CROSS JOIN fachbuch ON verlag.verlagid=fachbuch.fk_verlagid;

-- Exercise 09-02-06 m:n INNER JOIN
SELECT fachbuch.titel, fachbereich.fachbereich FROM fachbuch INNER JOIN fachbereichfachbuch ON fachbuch.fachbuchid=fachbereichfachbuch.fk_fachbuchid INNER JOIN fachbereich ON fachbereichfachbuch.fk_fachbereichid=fachbereich.fachbereichid;

-- Exercises 09-02-07 to 10 omitted for lack of data

--############################################################
--  Chapter 09-03 Change Relationships
--	Child-parent configuration: change child relations via UPDATE
-- 		switch two entries (fk_ausid was 1 for aid=1 and fk_ausid was 5 for aid=3)
UPDATE adresse SET fk_ausid=5 WHERE aid=1;
UPDATE adresse SET fk_ausid=1 WHERE aid=3;

--	Child-parent configuration: change parent relations via ON UPDATE CASCADE
--		In the child table definition the optional argument ON UPDATE CASCADE/ON DELETE CASCADE
--			is added to the CONSTRAINT part which REFERENCES the parent relation
--		Then an apdate to parent keys is automatically passed to the matching entries in the child table
--...assuming another table auszubildender_neu with ausid key
CREATE TABLE adresse_neu (aid SMALLINT PRIMARY KEY, strasse VARCHAR(200), fk_ausid SMALLINT, CONSTRAINT fk_adresse_auszubildender_neu FOREIGN KEY (fk_ausid) REFERENCES auszubildender_neu (ausid) ON UPDATE CASCADE ON DELETE CASCADE);
UPDATE auszubildender_neu SET ausid=10 WHERE ausid=1;
-- 		Alternatively, firstly set child relations to NULL, secondly make changes in parents and thirdly reconnect the children

-- Exercises 09-03-01 to 03 omitted for lack of data







