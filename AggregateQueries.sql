-- AVG with ROUND
-- calculate avg cost for rental_rate
SELECT ROUND(AVG(rental_rate), 2) AS avgRentalRate
FROM film;

-- Count films which have a description
UPDATE film SET description = null WHERE film_id = 2;

SELECT count(description)
FROM film;

-- GROUP BY 
-- Show no of films for every type of rating
SELECT rating, COUNT(*) AS noOfMovies
FROM film
GROUP BY rating;

-- Show ratings which have atleast 200 movies 
SELECT rating, COUNT(*) AS noOfMovies
FROM film
GROUP BY rating
HAVING noOfMovies >= 200
ORDER BY noOfMovies DESC; 


-- Query 1
-- list the customers who have made at least 30 rentals, 
-- for each customers, display their name and count of rentals

SELECT c.customer_id, 
CONCAT(c.first_name, " ", c.last_name) AS Name,
COUNT(*) AS countOfRentals
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING countOfRentals >= 30
ORDER BY c.customer_id ASC;

-- Query 2
-- retrieve the total revenue by each film category,
-- but only include categories where the total revenue 
-- is greater than 1000 usd. Order the results by revenue in desc order.

SELECT c.category_id, c.name, SUM(amount) AS Revenue
FROM film_category fc
JOIN category c
ON  fc.category_id = c.category_id
JOIN inventory i
ON i.film_id = fc.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id 
JOIN payment p
ON p.rental_id = r.rental_id
GROUP BY category_id
HAVING Revenue > 1000
ORDER BY Revenue DESC
LIMIT 3;


-- Query 3
-- find the actors who have appeared in atleast two films together 
-- (they share at least one film id)
-- display the actor IDs and no of films they done together.

SELECT fa1.actor_id, CONCAT(a1.first_name, " ", a1.last_name) AS NameOf1stActor,
fa2.actor_id,
CONCAT(a2.first_name, " ", a2.last_name) AS NameOf2ndActor, 
COUNT(film_id) AS filmsTogether
FROM actor a1
JOIN film_actor fa1
USING (actor_id)
JOIN film_actor fa2
USING (film_id)
JOIN actor a2
ON a2.actor_id = fa2.actor_id
WHERE a1.actor_id != a2.actor_id
GROUP BY fa1.actor_id, fa2.actor_id
HAVING filmsTogether > 1;


-- Query 4
-- count of orders from from "USA","Japan","Spain"
-- and orders must >=20

SELECT country, COUNT(*) AS NoOfOrders
FROM customers
JOIN orders
USING (customerNumber)
WHERE country IN ("USA", "Japan", "Spain")
GROUP BY country
HAVING NoOfOrders >= 20;

-- Query 5
-- Count of orders from each Country, on each date
SELECT country, orderDate, COUNT(*) AS cntOforders
FROM customers
JOIN orders
USING (customerNumber)
GROUP BY country, orderDate
ORDER BY country, orderDate;