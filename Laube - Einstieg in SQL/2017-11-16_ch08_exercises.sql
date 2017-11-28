/*
#------------------------------------------------------------
# FILENAME: 2017-11-07_ch08_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 07/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 08-01
--	create db in std encoding
--	run as query from postgres db connection
CREATE DATABASE traineedb ENCODING 'UTF-8';

--############################################################
-- Exercise 08-01-01
CREATE DATABASE bibliothek ENCODING 'UTF-8';

--############################################################
--  Chapter 08-02
--		run as query from new db connection
-- 		create a table which the contracts will link 1:1 to
--		NOTE: the order of creating the tables matters greatly to satisfy the constraints
CREATE TABLE trainee (
	tr_id SMALLINT PRIMARY KEY NOT NULL,
	name VARCHAR(120),
	surname VARCHAR(120),
	dob DATE
	);

--##################
--create first 1:1 relation 
--		references links the foreign key to the trainee table
-->	referential integrity maintained:
--		-only entries which satisfy the constraint are valid for saving
--		-however, fk_verlagid allows NULL values as a valid entry which don't have to satisfy the constraint
--		-the NOT NULL condition would completely prohibit entries with no matching entry in a referenced table
CREATE TABLE traineecontract (
	co_id SMALLINT PRIMARY KEY NOT NULL,
	cdate DATE,
	fk_tr_id SMALLINT,
	CONSTRAINT fk_trainee
		FOREIGN KEY (fk_tr_id)
			REFERENCES trainee (tr_id)
	);


--##################EXTRA LOOP
--create another table which the contracts link 1:1 to
--	and later n:m to skills
CREATE TABLE traineeprofessions (
	tp_id SMALLINT PRIMARY KEY NOT NULL,
	jobtitle VARCHAR(200)
	);


--drop previous table and rerun definition with additional contraint
DROP TABLE traineecontract;
CREATE TABLE traineecontract (
	co_id SMALLINT PRIMARY KEY NOT NULL,
	cdate DATE,
	fk_tr_id SMALLINT,
	fk_tp_id SMALLINT,
	CONSTRAINT fk_trainee
		FOREIGN KEY (fk_tr_id)
			REFERENCES trainee (tr_id),
	CONSTRAINT fk_traineeprofessions
		FOREIGN KEY (fk_tp_id)
			REFERENCES traineeprofessions (tp_id)
	);

--##################
--create table with 1:n relation to trainee table big the strong entity
CREATE TABLE address (
	a_id SMALLINT PRIMARY KEY NOT NULL,
	street VARCHAR(200),
	nbr VARCHAR(5),
	zpcd INT,
	town VARCHAR(200),
	fk_tr_id SMALLINT,
	CONSTRAINT fk_add_trainee
		FOREIGN KEY (fk_tr_id)
			REFERENCES trainee (tr_id)
	);

--##################
--setting up a m:n relationship
-- 		create another table (m part) which will link to traineeprofessions (n)
CREATE TABLE jobskill (
	js_id SMALLINT PRIMARY KEY NOT NULL,
	skillname VARCHAR(200)
	);
--create the associated table, doing the linking
--	primary key will be composite
--	unique naming of constraints is relevant in MySQL but not postgreSQL (however, one can try to be nice)
CREATE TABLE professionjobskill (
	fk_tp_id SMALLINT NOT NULL,
	fk_js_id SMALLINT NOT NULL,
	PRIMARY KEY (fk_tp_id,fk_js_id),
	CONSTRAINT fk_trprofessions
		FOREIGN KEY (fk_tp_id)
			REFERENCES traineeprofessions (tp_id),
	CONSTRAINT fk_jobskill
		FOREIGN KEY (fk_js_id)
			REFERENCES jobskill (js_id)
	);
--##################
--setting up a self-reference 1:n relationship
--	foreign key is another primary as a constraint
CREATE TABLE empltraininginstitution (
	empl_id SMALLINT PRIMARY KEY NOT NULL,
	name VARCHAR(120),
	surname VARCHAR(120),
	fk_empl_id SMALLINT,
	CONSTRAINT empltraininginstitution
		FOREIGN KEY (fk_empl_id)
			REFERENCES empltraininginstitution (empl_id)
	);

--############################################################
-- Exercise 08-03-01
--create strong tables
CREATE TABLE verlag (
	verlagid SMALLINT PRIMARY KEY NOT NULL,
	verlag VARCHAR(300)
	);
CREATE TABLE fachbereich (
	fachbereichid SMALLINT PRIMARY KEY NOT NULL,
	fachbereich VARCHAR(200)
	);
--create 1:n with verlag
CREATE TABLE fachbuch (
	fachbuchid SMALLINT PRIMARY KEY NOT NULL,
	isbn VARCHAR(120),
	titel VARCHAR(300),
	fk_verlagid SMALLINT,
	CONSTRAINT fk_verlag
		FOREIGN KEY (fk_verlagid)
			REFERENCES verlag (verlagid)
	);
--create m:n between fachbuch and fachbereich
CREATE TABLE fachbereichfachbuch (
	fk_fachbereichid SMALLINT NOT NULL,
	fk_fachbuchid SMALLINT NOT NULL,
	PRIMARY KEY (fk_fachbereichid,fk_fachbuchid),
	CONSTRAINT fk_fachbereichid
		FOREIGN KEY (fk_fachbereichid)
			REFERENCES fachbereich (fachbereichid),
	CONSTRAINT fk_fachbuchid
		FOREIGN KEY (fk_fachbuchid)
			REFERENCES fachbuch (fachbuchid)
	);
