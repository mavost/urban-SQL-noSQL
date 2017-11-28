/*
#------------------------------------------------------------
# FILENAME: 2017-11-17_ch10_exercises.sql
# VERSION: 1.0 - postgreSQL
# PURPOSE:
# AUTHOR: MVS
# LAST CHANGE: 17/11/2017
#------------------------------------------------------------
*/

--############################################################
--  Chapter 10-01
--	ACID properties of DB transactions
		/* Atomicity
		Atomicity requires that each transaction be "all or nothing": if one part of the transaction fails, then the entire transaction fails, and the database state is left unchanged. An atomic system must guarantee atomicity in each and every situation, including power failures, errors and crashes. To the outside world, a committed transaction appears (by its effects on the database) to be indivisible ("atomic"), and an aborted transaction does not happen.

		Consistency
		The consistency property ensures that any transaction will bring the database from one valid state to another. Any data written to the database must be valid according to all defined rules, including constraints, cascades, triggers, and any combination thereof. This does not guarantee correctness of the transaction in all ways the application programmer might have wanted (that is the responsibility of application-level code), but merely that any programming errors cannot result in the violation of any defined rules.

		Isolation
		The isolation property ensures that the concurrent execution of transactions results in a system state that would be obtained if transactions were executed sequentially, i.e., one after the other. Providing isolation is the main goal of concurrency control. Depending on the concurrency control method (i.e., if it uses strict - as opposed to relaxed - serializability), the effects of an incomplete transaction might not even be visible to another transaction.

		Durability
		The durability property ensures that once a transaction has been committed, it will remain so, even in the event of power loss, crashes, or errors. In a relational database, for instance, once a group of SQL statements execute, the results need to be stored permanently (even if the database crashes immediately thereafter). To defend against power loss, transactions (or their effects) must be recorded in a non-volatile memory.
		 */
		 
--	Transactions can be bundled in the following manner (maintaining atomicity):
BEGIN;
--statement_1
--...
--statement_n
COMMIT;
--		if any statement fails and COMMIT is not called, the whole transaction block can be undone using ROLLBACK
ROLLBACK;

-- Transactions are performed isolated from each other and four levels of isolation are defined (three on postgreSQL)
-->Read uncommitted (not on postgreSQL)
-->Read committed
-->Repeatable read
-->Serializable




--############################################################
--	Exercise 09-01-01
