SELECT * FROM address;

SELECT *
FROM address
WHERE district IN ('Address 3', 'District 3', 'District 7')

SELECT *
FROM payment
WHERE amount BETWEEN 1.99 AND 10.99
ORDER BY amount DESC;

SELECT *
FROM actor 
WHERE first_name LIKE '%A%';

SELECT *
FROM address
WHERE address2 IS NULL

SELECT *
FROM actor
LIMIT 4, 5;

SELECT * FROM address;
