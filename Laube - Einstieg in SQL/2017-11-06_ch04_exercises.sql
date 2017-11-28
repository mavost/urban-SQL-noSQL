/*
#------------------------------------------------------------
# FILENAME: 2017-11-06_ch04_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 06/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 04-03
SELECT CAST(5 as DECIMAL(6,3)) AS result;
SELECT CAST(3.6 as INTEGER) AS result;

-- Exercise 04-03-01 Casting
SELECT CAST('5.7' as DECIMAL(6,3))+20 AS result;

-- Exercise 04-03-02 Casting # fails in Postgres
--SELECT 10000+'5.8' AS result;

SELECT * FROM mitarbeiter FETCH FIRST 20 ROWS ONLY;

--############################################################
--  Chapter 04-04
DROP TABLE IF EXISTS dienstwagen;
CREATE TABLE dienstwagen(dienstwagenid SMALLSERIAL PRIMARY KEY, kennzeichen CHAR(9), erstzulassung DATE, kostenstelle SMALLINT,
                        	hersteller VARCHAR(200), modell VARCHAR(200), leistung DECIMAL(5,2), motor VARCHAR(100),
                        	getriebe  VARCHAR(100), mitarbeiter VARCHAR(300));

SELECT column_name, data_type, character_maximum_length FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'dienstwagen';

--/*
INSERT INTO dienstwagen VALUES (DEFAULT, 'RA-BB-770', '2015-01-21', 11233,
                               		'Mercedes', 'A', 100, 'Diesel',
                               		'Frontantrieb', 'Mueller, Gerd');
INSERT INTO dienstwagen (kennzeichen, erstzulassung, mitarbeiter) VALUES ('RA-BB-771', '2015-02-11', 'Meier, Wolfgang');
INSERT INTO dienstwagen (kennzeichen, erstzulassung, mitarbeiter) VALUES ('RA-BB-772', '2015-04-05', 'Schulze, Kathrin');
                                  
                                    
SELECT * from dienstwagen;
--*/

--  Exercise 04-04-01 create a table
DROP TABLE IF EXISTS fahrzeugtyp;
CREATE TABLE fahrzeugtyp(typid SMALLSERIAL PRIMARY KEY, hersteller VARCHAR(200), modell VARCHAR(200), leistung DECIMAL(5,2),
                         	motor VARCHAR(100), getriebe VARCHAR(100));
SELECT column_name, data_type, character_maximum_length FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'fahrzeugtyp';

--  Exercise 04-04-02 fill table
INSERT INTO fahrzeugtyp VALUES (DEFAULT, 'Mercedes', 'A', 100, 'Benziner', 'Frontantrieb');
INSERT INTO fahrzeugtyp VALUES (DEFAULT, 'BMW', '502', 150, 'Benziner', 'Heckantrieb');

-- Exercise 04-04-02 delete table
DROP TABLE fahrzeugtyp;
/*
SELECT * from fahrzeugtyp;
*/

--############################################################
--  Chapter 04-05
/*DROP TABLE IF EXISTS dienstwagen;
-- Set columns to be mandatory entries with NOT NULL
CREATE TABLE dienstwagen(dienstwagenid SMALLSERIAL PRIMARY KEY, kennzeichen CHAR(9) NOT NULL, erstzulassung DATE NOT NULL, kostenstelle SMALLINT NULL,
                        	hersteller VARCHAR(200) NULL, modell VARCHAR(200) NULL, leistung DECIMAL(5,2) NULL, motor VARCHAR(100) NULL,
                        	getriebe  VARCHAR(100) NULL, mitarbeiter VARCHAR(300) NULL);

-- Set columns to contain unique entries with UNIQUE
DROP TABLE IF EXISTS dienstwagen;
CREATE TABLE dienstwagen(dienstwagenid SMALLSERIAL PRIMARY KEY, kennzeichen CHAR(9) NOT NULL UNIQUE, erstzulassung DATE NOT NULL, kostenstelle SMALLINT,
                        	hersteller VARCHAR(200), modell VARCHAR(200), leistung DECIMAL(5,2), motor VARCHAR(100),
                        	getriebe  VARCHAR(100), mitarbeiter VARCHAR(300) UNIQUE);

-- Set columns to contain default entries with DEFAULT <value>
DROP TABLE IF EXISTS dienstwagen;
CREATE TABLE dienstwagen(dienstwagenid SMALLSERIAL PRIMARY KEY, kennzeichen CHAR(9) NOT NULL UNIQUE, erstzulassung DATE NOT NULL, kostenstelle SMALLINT DEFAULT 0,
                        	hersteller VARCHAR(200), modell VARCHAR(200), leistung DECIMAL(5,2), motor VARCHAR(100),
                        	getriebe  VARCHAR(100), mitarbeiter VARCHAR(300) UNIQUE);
INSERT INTO dienstwagen (kennzeichen, erstzulassung, mitarbeiter) VALUES ('RA-BB-771', '2015-02-11', 'Meier, Wolfgang');

*/
-- Set columns to be verified for validity using CHECK
DROP TABLE IF EXISTS dienstwagen;
CREATE TABLE dienstwagen(dienstwagenid SMALLSERIAL PRIMARY KEY, kennzeichen CHAR(9) NOT NULL UNIQUE, erstzulassung DATE NOT NULL, kostenstelle SMALLINT DEFAULT 0,
                        	hersteller VARCHAR(200), modell VARCHAR(200), leistung DECIMAL(5,2),
                         	motor VARCHAR(100) CHECK(motor='Diesel' OR motor='Benzin' OR motor='Super'),
                        	getriebe VARCHAR(100) CHECK(getriebe='Automatik' OR getriebe='Schaltung'), 
                         	mitarbeiter VARCHAR(300) UNIQUE);
INSERT INTO dienstwagen (kennzeichen, erstzulassung, mitarbeiter, getriebe) VALUES ('RA-BB-771', '2015-02-11', 'Meier, Wolfgang', 'Schaltung');
-- Throws error
--INSERT INTO dienstwagen (kennzeichen, erstzulassung, mitarbeiter, getriebe) VALUES ('RA-BB-772', '2015-02-12', 'Meier, Thomas', 'Schaltu');


/*
SELECT column_name, data_type, character_maximum_length FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'dienstwagen';
*/
SELECT * from dienstwagen;
--*/

--  Exercise 04-05-01 Create table with some contraints
DROP TABLE IF EXISTS mitarbeiterjubilaeum;
CREATE TABLE mitarbeiterjubilaeum(geschenkid SMALLSERIAL PRIMARY KEY, artikel VARCHAR(200) NOT NULL,
                                  	preis DECIMAL(5,2) NOT NULL, jahrezugehoerigkeit SMALLINT NOT NULL);
INSERT INTO mitarbeiterjubilaeum VALUES (DEFAULT, 'Uhr', 12.50, 20);
INSERT INTO mitarbeiterjubilaeum VALUES (DEFAULT, 'Blumenstrauß', 12.50, 5);


--  Exercise 04-05-02 Add more contraints UNIQUE
DROP TABLE IF EXISTS mitarbeiterjubilaeum;
CREATE TABLE mitarbeiterjubilaeum(geschenkid SMALLSERIAL PRIMARY KEY, artikel VARCHAR(200) UNIQUE NOT NULL,
                                  	preis DECIMAL(5,2) NOT NULL, jahrezugehoerigkeit SMALLINT NOT NULL);
INSERT INTO mitarbeiterjubilaeum VALUES (DEFAULT, 'Uhr', 12.50, 20);
INSERT INTO mitarbeiterjubilaeum VALUES (DEFAULT, 'Blumenstrauß', 12.50, 5);
--FEHLER:  doppelter Schlüsselwert verletzt Unique-Constraint »mitarbeiterjubilaeum_artikel_key«
--INSERT INTO mitarbeiterjubilaeum VALUES (DEFAULT, 'Uhr', 12.50, 10);

--  Exercise 04-05-03 Add more contraints DEFAULT
DROP TABLE IF EXISTS mitarbeiterjubilaeum;
CREATE TABLE mitarbeiterjubilaeum(geschenkid SMALLSERIAL PRIMARY KEY, artikel VARCHAR(200) UNIQUE NOT NULL,
                                  	preis DECIMAL(5,2) NOT NULL DEFAULT 0.00, jahrezugehoerigkeit SMALLINT NOT NULL);
--call INSERT invoking the DEFAULT
INSERT INTO mitarbeiterjubilaeum (artikel, jahrezugehoerigkeit) VALUES ('Uhr', 20);
INSERT INTO mitarbeiterjubilaeum (artikel, jahrezugehoerigkeit, preis) VALUES ('Blumenstrauß', 5, 12.50);

--  Exercise 04-05-04 Add more contraints CHECK
DROP TABLE IF EXISTS mitarbeiterjubilaeum;
CREATE TABLE mitarbeiterjubilaeum(geschenkid SMALLSERIAL PRIMARY KEY, artikel VARCHAR(200) UNIQUE NOT NULL,
                                  	preis DECIMAL(5,2) NOT NULL DEFAULT 0.00,
                                  	jahrezugehoerigkeit SMALLINT NOT NULL CHECK(jahrezugehoerigkeit IN (5,10,15,20)));
--call INSERT invoking the CHECK
INSERT INTO mitarbeiterjubilaeum (artikel, jahrezugehoerigkeit) VALUES ('Uhr', 20);
--FEHLER:  neue Zeile für Relation »mitarbeiterjubilaeum« verletzt Check-Constraint »mitarbeiterjubilaeum_jahrezugehoerigkeit_check«
--INSERT INTO mitarbeiterjubilaeum (artikel, jahrezugehoerigkeit) VALUES ('Blumenstrauß', 6);

SELECT * FROM mitarbeiterjubilaeum;
--SELECT column_name, data_type, character_maximum_length FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'mitarbeiterjubilaeum';

--############################################################
--  Chapter 04-06 table-spanning constraints using CONSTRAINT statement outside of column definition
DROP TABLE IF EXISTS zweigstellen;
CREATE TABLE zweigstellen(globalid SMALLSERIAL PRIMARY KEY, land VARCHAR(200), zweigstellenid SMALLINT,
                                  	namezwstelle VARCHAR(200), mitarb_pl_anz SMALLINT, mitarb_ist_anz SMALLINT,
                                  	CONSTRAINT ch_mitarb_anz CHECK(mitarb_pl_anz >= mitarb_ist_anz));
INSERT INTO zweigstellen (globalid, mitarb_pl_anz, mitarb_ist_anz) VALUES (DEFAULT, 5, 2);
--INSERT INTO zweigstellen (globalid, mitarb_pl_anz, mitarb_ist_anz) VALUES (DEFAULT, 5, 6);

SELECT * FROM zweigstellen;
--  Exercise 04-05-01/02/03 dropped due to redundancy


