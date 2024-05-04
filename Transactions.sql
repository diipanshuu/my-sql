-- Commit
SET AUTOCOMMIT = 0;

use sakila;

SELECT *
FROM film
LIMIT 10 OFFSET 50;

UPDATE film SET title = "Commit-EASY" WHERE film_id = 57;

COMMIT;

-- Rollback

UPDATE film SET title = "Rollback-EASY" WHERE film_id = 57;

ROLLBACK;