-- Creating a DB for this
-- Create a database
CREATE DATABASE IF NOT EXISTS StudentBatchDB;

-- Switch to the newly created database
USE StudentBatchDB;

-- Create the batches table
CREATE TABLE batches (
    batch_id INT PRIMARY KEY,  -- Batch ID, primary key
    name VARCHAR(50) NOT NULL  -- Batch name
);

-- Create the students table
CREATE TABLE students (
    id INT PRIMARY KEY,        -- Student ID, primary key
    name VARCHAR(100) NOT NULL, -- Student name
    psp FLOAT,                  -- PSP score (float to handle decimals)
    batch_id INT,               -- Foreign key referencing batch_id in batches table
    -- Foreign key constraint to enforce integrity between students and batches
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id)
);

-- Insert data into the batches table
INSERT INTO batches (batch_id, name)
VALUES
    (1, 'Batch A'),
    (2, 'Batch B'),
    (3, 'Batch C'),
    (4, 'Batch D'),
    (5, 'Batch E');
    
INSERT INTO students (id, name, psp, batch_id)
VALUES
    (1, 'Alice', 85.4, 1),
    (2, 'Bob', 78.5, 1),
    (3, 'Charlie', 90.2, 2),
    (4, 'David', 72.3, 2),
    (5, 'Eve', 88.6, 3),
    (6, 'Frank', 79.8, 3),
    (7, 'Grace', 95.0, 4),
    (8, 'Hank', 68.7, 4),
    (9, 'Ivy', 82.1, 5),
    (10, 'Jack', 74.5, 5),
    (11, 'Kara', 76.3, 1),
    (12, 'Leo', 83.9, 1),
    (13, 'Megan', 89.0, 2),
    (14, 'Nate', 80.6, 2),
    (15, 'Olivia', 92.7, 3),
    (16, 'Paul', 77.1, 3),
    (17, 'Quincy', 84.2, 4),
    (18, 'Rita', 81.5, 4),
    (19, 'Sam', 87.8, 5),
    (20, 'Tina', 70.9, 5);
    
-- Q1:
--  Find all students whose psp is greater
-- than psp of student with id = 18
SELECT *
FROM students s
WHERE psp > (
				SELECT psp
                FROM students
                WHERE id = 18
                );


-- Q2: Find films where rental rate was more than average rental
-- rate of film
USE sakila;
SELECT *
FROM film
WHERE rental_rate > (
						SELECT AVG(rental_rate)
                        FROM film
                        );
                        
                        
-- Q3: 
-- Film Table, find out all the years where the average of
-- the rental rate of films of that year was greater
-- than global average of rental_rate (across all films)


SELECT AVG(rental_rate) AS avgRate, release_year 
FROM film
GROUP BY release_year
HAVING avgRate > (
				SELECT AVG(rental_rate)
                FROM film
                );

CREATE TABLE users (
    user_id INT PRIMARY KEY,  -- User ID, primary key
    name VARCHAR(100) NOT NULL, -- User name
    isStudent TINYINT(1) NOT NULL, -- 1 if user is a student, 0 otherwise
    isTA TINYINT(1) NOT NULL -- 1 if user is a teaching assistant, 0 otherwise
);

USE StudentBatchDB;

INSERT INTO users (user_id, name, isStudent, isTA)
VALUES
    (1, 'Alice', 1, 1),
    (2, 'Bob', 1, 0),
    (3, 'Charlie', 1, 0),
    (4, 'David', 0, 1),
    (5, 'Eve', 1, 1),
    (6, 'Frank', 0, 1),
    (7, 'Grace', 1, 0),
    (8, 'Grace', 0, 1),
    (9, 'Ivy', 1, 0),
    (10, 'Jack', 1, 1),
    (11, 'Kara', 0, 1),
    (12, 'Leo', 1, 0),
    (13, 'Megan', 1, 0),
    (14, 'Megan', 0, 1),
    (15, 'Nate', 0, 1),
    (16, 'Olivia', 1, 0),
    (17, 'Paul', 0, 1),
    (18, 'Quincy', 1, 1),
    (19, 'Sam', 1, 0),
    (20, 'Sam', 0, 1);

-- Q4:
-- Find Names(unique) of students that also the names of TA
-- Two Persons to compare - Self Join?
-- Approach 1 

SELECT *
FROM users S
JOIN users T
ON S.isStudent = "1" AND T.isTA = "1" AND T.name = S.name;

-- Approach 2 
-- List of TA Names
-- Filter out students who name matches with any name in TA list 

SELECT *
FROM users S
WHERE S.isStudent = 1 AND
S.name IN(
			SELECT name
            FROM users T
            WHERE T.isTA = 1
            );
            
-- ANOTHER WAY is TO use EXISTS
SELECT *
FROM users S
WHERE S.isStudent = 1 AND
EXISTS(
			SELECT name
            FROM users T
            WHERE T.isTA = 1 AND T.name = S.name
            );
            

            
-- Q5:
-- Find all of the students whose psp is not less than the smallest psp of any batch.
-- Whenever you have a subquery in FROM clause, 
-- it is required to give it a name, hendce, minpsps.

SELECT *
FROM students
WHERE psp > (
			SELECT MAX(psp)
            FROM (
			SELECT MIN(psp) AS psp
            FROM students
            GROUP BY batch_id
            )minPSPBatchWise );
  
-- Q6:
-- Find all students whose psp is greater than 
-- average psp of their batch.

SELECT *
FROM students S
WHERE psp > (
			SELECT AVG(psp)
            FROM students s
            WHERE s.batch_id = S.batch_id
            );
 
-- Q7:
-- -- Find all students who
-- are also TA given the two tables
SELECT *
FROM users u
WHERE u.isStudent = 1 AND u.isTA = 1;


-- SUBQUERIES and JOINS which one to chose
-- Q8: customers who never placed an order

USE classicmodels;

-- JOIN
SELECT * 
FROM customers c
LEFT JOIN orders
USING (customerNumber)
WHERE orderNumber IS NULL;

-- SUBQUERIES
SELECT *
FROM customers c
WHERE customerNumber NOT IN(
							SELECT DISTINCT customerNumber
                            FROM orders
                            );
 