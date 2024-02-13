USE sakila;


-- TASK1
SELECT 
    CONCAT(first_name, ' ', last_name) AS 'full_name'
FROM
    actor;


-- TASK2i
SELECT 
    first_name,COUNT(first_name)
FROM
    actor
    group by first_name;


-- TASK2ii
SELECT 
    COUNT(*) AS unique_name, first_name
FROM
    actor
GROUP BY first_name
HAVING COUNT(*) = 1;


-- TASK3i 
SELECT 
    last_name,COUNT(last_name)
FROM
    actor
    group by last_name;
    

-- TASK3ii
SELECT 
    COUNT(*) AS unique_last_name, last_name
FROM
    actor
GROUP BY last_name
HAVING COUNT(*) = 1;


-- TASK4i
SELECT *
FROM film
WHERE rating = 'R';


-- TASK4ii
SELECT *
FROM film
WHERE NOT rating = 'R';


-- TASK4iii
SELECT *
FROM film
WHERE rating IN ('G', 'PG');


-- TASK5i
SELECT *
FROM film
WHERE replacement_cost <= 11.00;


-- TASK5ii
SELECT *
FROM film
WHERE replacement_cost BETWEEN 11.00 AND 20.00;


-- TASK5iii
SELECT *
FROM film
ORDER BY replacement_cost DESC;


-- TASK6
SELECT film.title, COUNT(actor.actor_id) AS actor_count
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY film.film_id
ORDER BY actor_count DESC
LIMIT 3;


-- TASK7
SELECT title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
ORDER BY title;


-- TASK8
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Agent Truman';

-- TASK9
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film_category
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'family'));
                    

-- TASK10i
SELECT rating,
  MAX(rental_rate) AS max_rental_rate,
  MIN(rental_rate) AS min_rental_rate,
  AVG(rental_rate) AS avg_rental_rate
FROM film
GROUP BY rating
ORDER BY avg_rental_rate DESC;


-- TASK10ii
SELECT 
    f.title, COUNT(f.title) AS rentals
FROM
    film f
        JOIN
    (SELECT 
        r.rental_id, i.film_id
    FROM
        rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id) a ON a.film_id = f.film_id
GROUP BY f.title
ORDER BY rentals DESC;


-- TASK11
SELECT 
    COUNT(*) AS category_count
FROM
    (SELECT 
        category.category_id
    FROM
        category
    JOIN film_category ON category.category_id = film_category.category_id
    JOIN film ON film_category.film_id = film.film_id
    GROUP BY category.category_id
    HAVING AVG(replacement_cost) - AVG(Rental_rate) > 15) AS category_avg_diff;
    
    
-- TASK 12
SELECT category.name, COUNT(film_category.film_id) AS movie_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
HAVING movie_count > 70
ORDER BY movie_count DESC;


