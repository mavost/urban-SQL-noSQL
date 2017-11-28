/*
#------------------------------------------------------------
# FILENAME: 201-11-20_ch18_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 20/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 18
-- Indexing facilitates the query time of a table/view in a db with many entries
--		-->Indexes can be made for unique and non-unique entries
	CREATE INDEX index_<table> ON <table> (<row>);
	CREATE INDEX index_<table> ON <table> (<row1>,<row2>,<row3>,etc.);
--	Example	
	CREATE INDEX index_kreditinstitut ON kreditinstitut (bankleitzahl);
-- 		-->checking for uniqueness of an entry:
	SELECT <row> FROM <table> GROUP BY <row> HAVING COUNT(<row>)>1;
	CREATE UNIQUE INDEX index_<table> ON <table> (<row>);
	
-- 	Dropping an index: (postgreSQL)
	DROP INDEX <indexname>
