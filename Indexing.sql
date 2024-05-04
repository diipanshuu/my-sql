USE sakila;

-- Create Index
CREATE INDEX idx_title ON film(title);

CREATE INDEX idx_release_year ON film(release_year);

CREATE INDEX idx_title_release_year
ON film(title, release_year);

-- Search movies based upon title and release year
EXPLAIN SELECT *
FROM film
WHERE title = "AFRICAN EGG" AND release_year = 2000;

EXPLAIN ANALYZE SELECT *
FROM film
WHERE title = "AFRICAN EGG" AND release_year = 2000;

-- '-> Filter: ((film.release_year = 2000) and (film.title = \'AFRICAN EGG\'))  
-- (cost=103 rows=10) (actual time=0.0628..0.861 rows=1 loops=1)\n    ->
-- Table scan on film  (cost=103 rows=1000) (actual time=0.0492..0.785 rows=1006 loops=1)\n'


-- After Indexing

-- '-> Index lookup on film using idx_title_release_year (title=\'AFRICAN EGG\', release_year=2000)
--  (cost=0.35 rows=1) (actual time=0.0429..0.0489 rows=1 loops=1)\n'






-- DROP Index
DROP INDEX idx_release_year ON film;

DROP INDEX idx_title_release_year
ON film;

DROP INDEX idx_title ON film;
