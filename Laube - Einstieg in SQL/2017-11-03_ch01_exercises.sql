/*
#------------------------------------------------------------
# FILENAME: 2017-11-03_ch01_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 03/11/2017
#------------------------------------------------------------
*/
--	Exercise 01-01 return full employee table
--select * from mitarbeiter;

--	Exercise 01-02 return full employee working actively in procurement
select name, vorname, abteilung, austrittsdatum from mitarbeiter where abteilung = 'Einkauf' and austrittsdatum is null order by name asc;

--	return all employees' names
--select name, vorname from mitarbeiter order by name asc;




--select stuff
--select name, vorname, austrittsgrund from mitarbeiter where austrittsgrund is not null order by name desc;
