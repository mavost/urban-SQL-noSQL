/*
#------------------------------------------------------------
# FILENAME: 2017-11-06_ch03_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 06/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 03-01
--INSERT INTO qualifikationen (qid, bezeichnung, kuerzel, kategorie) VALUES (1,'Word','msw','Office');
--INSERT INTO qualifikationen (bezeichnung, qid, kuerzel, kategorie) VALUES ('Excel',2,'mse','Office');
--INSERT INTO qualifikationen (bezeichnung, qid) VALUES ('Outlook',3);
--INSERT INTO qualifikationen (qid) VALUES (4);
--INSERT INTO qualifikationen (bezeichnung, qid, kuerzel, kategorie) VALUES ('MS Project',5,NULL,NULL);
-- output name and ordering of a table's columns
--SELECT table_name, column_name, ordinal_position FROM information_schema.columns WHERE table_name='qualifikationen' ORDER BY ordinal_position ASC ;
--no order specified
--INSERT INTO qualifikationen VALUES (6,'SAP Basis Know How','SAP','Office');
SELECT * from qualifikationen;

--############################################################
--	Exercise 03-01-01 insert qualifications into table
--INSERT INTO qualifikationen (qid, bezeichnung, kuerzel, kategorie) VALUES (7,'SQL','ITE','Informatik');
--	Exercise 03-01-02 insert qualifications into table
--INSERT INTO qualifikationen (bezeichnung, qid, kategorie, kuerzel) VALUES ('Administrator',8,'Support','ADA');
--	Exercise 03-01-03 insert qualifications into table
--INSERT INTO qualifikationen (bezeichnung, qid) VALUES ('Catering',9);
--	Exercise 03-01-04 insert qualifications into table
--INSERT INTO qualifikationen (bezeichnung, qid, kategorie, kuerzel) VALUES ('Projektleitung',10,NULL,NULL);
--	Exercise 03-01-05 insert qualifications into table
--SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='public' ORDER BY table_name ASC;
--INSERT INTO qualifikationen VALUES (11,'Personalverwaltung','PEV','Personal');
--SELECT * from qualifikationen;

--############################################################
--  Chapter 03-02
UPDATE qualglobal SET kuerzel='SQL' WHERE kuerzel='DAT';
UPDATE qualglobal SET kuerzel='SAP',kategorie='Informatik' WHERE kuerzel='SHD';
UPDATE qualglobal SET kategorie='Informationstechnologie' WHERE kategorie='Informatik';
UPDATE qualglobal SET kuerzel='MSO', kategorie='Microsoft Office' WHERE kategorie='Office';
UPDATE qualglobal SET kategorie='Currently no category selected';
UPDATE qualglobal SET kategorie=NULL;
UPDATE qualglobal SET qid=100 WHERE qid=5;

--############################################################
--	Exercise 03-02-01 update table
UPDATE qualglobal SET bezeichnung='Second Level Helpdesk' WHERE qid=2;
--	Exercise 03-02-02 update table
SELECT * FROM qualglobal WHERE qid=3;
UPDATE qualglobal SET bezeichnung='First Level Helpdesk',kuerzel='FLH' WHERE qid=3;
--	Exercise 03-02-03 update table
SELECT * FROM qualglobal WHERE kuerzel='MSO';
UPDATE qualglobal SET kuerzel=NULL WHERE kuerzel='MSO';
--	Exercise 03-02-04 update table
UPDATE qualglobal SET kategorie='under review' WHERE kategorie IS NULL;
--	Exercise 03-02-05 update table
UPDATE qualglobal SET qid=5 WHERE qid=100;

--############################################################
--  Chapter 03-03
DELETE FROM qualglobal WHERE qid=4;
DELETE FROM qualglobal WHERE kuerzel IS NULL;
DELETE FROM qualglobal;
SELECT * from qualglobal ORDER BY qid;

--############################################################
--	Exercise 03-03-01 delete one row
DELETE FROM qualglobalarchiv WHERE qid=2;
--	Exercise 03-03-01 delete several rows
SELECT * FROM qualglobalarchiv WHERE qid IN (5,6,7);
DELETE FROM qualglobalarchiv WHERE qid IN (5,6,7);
--	Exercise 03-03-01 delete table
DELETE FROM qualglobalarchiv;
SELECT * from qualglobalarchiv ORDER BY qid;

--############################################################
--  Chapter 03-04
--SELECT * from hardwarearchiv ORDER BY hardwareid;
TRUNCATE TABLE hardwarearchiv;
SELECT * from hardwarearchiv ORDER BY hardwareid;

--	Exercise 03-04-01 delete table
SELECT * from hardware ORDER BY hardwareid;
TRUNCATE TABLE hardware;
SELECT * from hardware ORDER BY hardwareid;


SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='public' ORDER BY table_name ASC;






