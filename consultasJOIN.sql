use sakila;

SELECT * FROM customer;
SELECT * FROM payment;

SELECT 
    cus.customer_id, 
    cus.first_name, 
    cus.last_name,
    pay.rental_id,
    pay.amount  
FROM customer cus
JOIN payment pay ON cus.customer_id = pay.payment_id;

SELECT 
    cus.customer_id,
    cus.first_name,
    cus.last_name,
    pay.rental_id,
    pay.amount,
    adr.address,
    flm.title,
    flm.description
FROM customer cus
JOIN payment pay 
    ON cus.customer_id = pay.payment_id
JOIN address adr 
    ON cus.customer_id = adr.address_id
JOIN film flm 
    ON cus.customer_film = film_id;

    select * from customer;
    select * from film;

ALTER TABLE customer
ADD customer_film INT;
UPDATE customer
SET customer_film = FLOOR(RAND() * 5) +1;




