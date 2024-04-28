USE sakila;

-- Insert into an existing table

-- INSERT INTO {table_Name} {column_Name} VALUES (row1), (row2), ...);

INSERT INTO film(film_id, title, description, release_year, language_id, 
				original_language_id, rental_duration, rental_rate, length, replacement_cost
                , rating, special_features, last_update) 
                
                VALUES(1,'ACADEMY DINOSAUR','A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies',2006,1,NULL,6,'0.99',86,'20.99','PG','Deleted Scenes,Behind the Scenes','2006-02-15 05:03:42');

                
			
            -- If passing all the values then no need to pass the column names
            
INSERT INTO film
                
                VALUES(DEFAULT,'ACADEMY DINOSAUR-3','A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies',2006,1,NULL,6,'0.99',86,'20.99','PG','Deleted Scenes,Behind the Scenes','2006-02-15 05:03:42'),
                (DEFAULT,'ACADEMY DINOSAUR-4','A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies',2006,1,NULL,6,'0.99',86,'20.99','PG','Deleted Scenes,Behind the Scenes','2006-02-15 05:03:42'),
                (DEFAULT,'ACADEMY DINOSAUR-5','A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies',2006,1,NULL,6,'0.99',86,'20.99','PG','Deleted Scenes,Behind the Scenes','2006-02-15 05:03:42');
                
-- If we do not pass all the values then the columns and values should have 1 to 1 mapping
INSERT INTO film(title, language_id, 
				original_language_id, rental_duration, rental_rate, length, replacement_cost
                , rating, special_features, last_update) 
                
                VALUES('ACADEMY DINOSAUR',1,NULL,6,'0.99',86,'20.99','PG','Deleted Scenes,Behind the Scenes','2006-02-15 05:03:42');
                
-- Read operation
SELECT * FROM film;

-- Read specific columns from the table
SELECT film_id, title AS "Film Name"
FROM film
ORDER BY film_id;

-- Select Distinct values
SELECT DISTINCT release_year, rating
FROM film;

-- Just print something
SELECT "Hello!" AS MSG, title FROM film;

-- Current time stamp
SELECT now();

-- Expressions
SELECT title, rental_duration * 60 AS "Duration in minutes" from film;

-- Create a table named as film copy and have two columnst title and release_year
-- Copyall the data from film

CREATE TABLE film_copy(
	title varchar(255),
    release_year YEAR
    );
    
-- Inserting into a table form another
INSERT INTO film_copy
SELECT title, release_year FROM film;

-- WHERE clause
-- Select the films having rating as PG 13

SELECT * FROM film
WHERE rating = "PG-13";

-- AND or NOT in conditons
SELECT * FROM film
WHERE NOT rating = "PG-13";

SELECT * FROM film
WHERE NOT rating = "PG-13" AND length=73;

SELECT * FROM film
WHERE NOT rating = "PG-13" OR length=73;

SELECT * FROM film
WHERE not rating IN ("G", "R");


-- Practice
-- CREATE Operations
-- Create table schema
CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    age INT
    );
-- 1. Inserting a new record into a table
INSERT INTO users (name, email, age)
VALUES ('Niel', 'niel@nitin.mikesh', 30);

-- 2. Creating a new film record with multiple categories
INSERT INTO film (`title`, `description`, `release_year`, `language_id`, 
				`rental_duration`, `rental_rate`, `length`, `replacement_cost`,
					`rating`)
VALUES ('New Film', 'A new film description', 2024, 1, 5,
		2.99, 120, 19.99, 'PG-13');
        
-- Retrieving the film id of new film
SELECT LAST_INSERT_ID() INTO @new_film_id;

-- Association with multiple categories 
INSERT INTO film_category (film_id, category_id)
VALUES (@new_film_id, 1),
		(@new_film_id, 3);


-- READ Operations
-- 1. Retrieving all records from a table
SELECT * FROM users;

-- 2. Retrieving specific columns from a table
SELECT name, email FROM users;

-- 3. Filtering records based on a condition
SELECT * FROM users
WHERE age > 30;

-- 4. Ordering records
SELECT * FROM users
ORDER BY age DESC;

-- 5. Querying films based on multiple complex criteria
SELECT f.title, f.rating, f.release_year, l.name AS language_name, fc.category_id, AVG(p.amount) AS average_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN payment p ON p.rental_id = r.rental_id
WHERE l.name = "English"
	AND f.rating = "PG-13"
    AND fc.category_id = 3
GROUP BY f.title, f.release_year, l.name
HAVING AVG(p.amount) > 3
ORDER BY average_rental_rate DESC;
