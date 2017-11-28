/*
#------------------------------------------------------------
# FILENAME: 2017-11-20_ch16_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 20/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 16
-- Subqueries 
--> 	Subqueries either are correlating or non-correlating with the outer (main) query:
-->		Subqueries have to be enclosed in brackets
--############################################################
--  Chapter 16-01
-->			Correlating Subqueries
	
--############################################################
--	Exercise 16-01-01
--		subquery in SELECT or WHERE block possible:
--			using aliases for table names clears up code ambiguity and improves readability
-- Example for putting it into the SELECT block
--		an INNER JOIN would mostly achieve the same result
	SELECT (
		SELECT anrede FROM anrede a
		WHERE m.geschlecht=a.geschlecht
		) AS anrede,
		name,
		vorname
	FROM mitarbeiter m;
-- Example for putting it into the WHERE block
--		checking whether the parent table contains some outdated values which the child table overrides
	SELECT
		m.mitarbeiterid, m.name, m.vorname, m.bonus
	FROM
		mitarbeiter m
	WHERE
		m.bonus>(
		SELECT MAX(bonuszahlung) FROM bonus b
		WHERE m.mitarbeiterid=b.mitarbeiterid
		GROUP BY mitarbeiterid);

--############################################################
--	Exercise 16-01-01
--		subquery in WHERE clause, employees which have received more than zero gratifications
	SELECT
		m.mitarbeiterid, m.name, m.vorname
	FROM
		mitarbeiter m
	WHERE(
		SELECT COUNT(*) FROM sachpraemie s
		WHERE m.mitarbeiterid=s.mitarbeiterid
		GROUP BY mitarbeiterid)>0;

--	Exercise 16-01-02
--		subquery in SELECT clause, sum cash value of gratifications each employee has received
	SELECT (
		m.name, m.vorname,
		(
			SELECT SUM(s.preis) FROM sachpraemie s
			WHERE m.mitarbeiterid=s.mitarbeiterid
			GROUP BY mitarbeiterid) AS betriebspraemie
	FROM mitarbeiter m;
---> INNER JOIN for more functionality

--############################################################
--  Chapter 16-02
-->			Non-Correlating Subqueries
-->			You can also use subqueries as "return values" to power another query (scalar queries)

	SELECT name, vorname FROM mitarbeiter
	WHERE mitarbeiterid IN (
		SELECT mitarbeiterid FROM bonus
			GROUP BY mitarbeiterid
	);
	
-->		more powerful when coupled with an INNER JOIN
--			create two tables "kind-of" independently and link them up via a common entry
	SELECT
		m.name, m.vorname, b.maxbonus
	FROM
		mitarbeiter m
	INNER JOIN (
		SELECT mitarbeiterid,MAX(bonuszahlung) AS maxbonus FROM bonus
		GROUP BY mitarbeiterid;
	) b
	ON m.mitarbeiterid=b.mitarbeiterid;
	
--	Exercise 16-02-01
--			find people which have received a gratification
	SELECT
		m.name, m.vorname
	FROM
		mitarbeiter m
	WHERE m.mitarbeiterid IN (
		SELECT s.mitarbeiterid FROM sachpraemie s
		GROUP BY s.mitarbeiterid);

--	Exercise 16-02-02
--			find people which have received a gratification and also output the number of gratifications
	SELECT
		m.name, m.vorname, s.grats
	FROM
		mitarbeiter m
	INNER JOIN (
		SELECT mitarbeiterid,COUNT(*) AS grats FROM sachpraemie
		GROUP BY mitarbeiterid
	) s
	ON m.mitarbeiterid=s.mitarbeiterid;

--############################################################
--  Chapter 16-03
-->			ANY, SOME and ALL to reduce a comparison between an entry and results from a subquery to one logical condition
-->				ANY is equivalent to SOME
-->				Example:
-->				bonus > ANY/SOME/ALL(SELECT Many numbers) --> true/false

--############################################################
--  Chapter 16-04
-->			EXISTS(subquery) within a WHERE clause checks whether the subquery returns any lines and validates the main query
-->			NOT EXISTS(subquery) within a WHERE clause does the inverse
