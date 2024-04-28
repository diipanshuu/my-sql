-- BETWEEN OPERATOR

SELECT * 
FROM film
WHERE rental_duration BETWEEN 0 AND 3;

-- LIKE OPERATOR
SELECT *
FROM film
WHERE description LIKE "%_stunning%";

-- ISNULL FUNCTION
SELECT *
FROM film
WHERE original_language_id IS NOT NULL;


-- ORDER BY CLAUSE

SELECT *
FROM film
ORDER BY length, rental_duration;

-- DISTINCT + ORDER BY
SELECT DISTINCT rental_duration
FROM film
ORDER BY release_year DESC;

-- Throws error because the reference column in ORDER BY
-- CLAUSE should be in the SELECT columns list

SELECT DISTINCT rental_duration, release_year
FROM film
ORDER BY release_year DESC;

-- LIMIT CLAUSE
SELECT *
FROM film
LIMIT 10;  -- FIRST 10 ROWS

SELECT *
FROM film
LIMIT 10, 5;  -- SKIPS FIRST 10 AS OFFSET THEN RETURNS 5

SELECT *
FROM film
LIMIT 10 OFFSET 3;

-- UPDATE QUERIES
-- UPDATE {TABLE NAME} SET {COLUMN NAME} = VALUE WHERE {CONDIITONS}

UPDATE film SET description = "Updated description using UPDATE" 
WHERE film_id = 1006;

-- MULTIPLE COLUMNS UPDATE
UPDATE film SET description = "Updated description using UPDATE" 
, title = "Updated title using multi column UPDATE"
  WHERE film_id = 1005;
  
UPDATE film SET description = "Updated description using UPDATE";	-- SAFE UPDATE is on


-- DELETE QUERIES
-- DELETE A PERTICULAR ROW/TUPLE

-- DELETE FROM {TABLE NAME} WHERE condition
DELETE FROM film WHERE film_id = 1004;

DELETE FROM film WHERE film_id = 1; -- BEING A FK FOR film_actor
-- SO ON DELETE RESTRICT IS BEING CHOSEN 

-- BECAUSE THIS SAKILA-SCHEMA
-- CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) 
-- REFERENCES film (film_id) ON DELETE RESTRICT 
-- ON UPDATE CASCADE

-- TRUNCATE
-- DELETES ALL THE ROWS AND GIVES NEW TABLE
TRUNCATE film; -- BECAUSE IT IS BEING REFERRED IN FK CONSTRAINT

TRUNCATE users; -- WORKED BEACAUSE WE HAVE CREATED IT

-- DROP 
-- DROP MEANS COMPLETELY DROP THE TABVLE ALONG WITH ITS DATA
DROP TABLE users; 
