--					LEFT SESSION
USE sakila;

SHOW VARIABLES LIKE "TRANSACTION_ISOLATION";

--					READ UNCOMMITTED
SHOW VARIABLES LIKE "TRANSACTION_ISOLATION"; -- REPEATABLE-READ

begin;
SELECT *
FROM film 
WHERE film_id = 7;

UPDATE film SET title = "Left-Session-2" WHERE film_id = 7;

commit;

-----------------------------------------------------------------

--						LEFT SESSION
--						READ COMMITTED

begin;
SELECT *
FROM film
WHERE film_id = 100;

UPDATE film SET title = "Committed-Left" WHERE film_id = 12;
UPDATE film SET title = "Committed-Left-2" WHERE film_id = 100;

commit;

----------------------------------------------------------------------

--							LEFT SESSION
--							REPEATABLE READS

begin;
SELECT *
FROM film
WHERE film_id = 29; -- ANTITRUST TOMATOES

UPDATE film SET title = "TRUST TOMATOES - LEFT" WHERE film_id = 29;

SELECT *
FROM film
WHERE film_id = 1000; -- ZORRO ARK
UPDATE film SET title = "ZORRO ARK - LEFT" WHERE film_id = 1000;
commit;



