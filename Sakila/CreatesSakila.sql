-- Criação da tabela 'language'
CREATE TABLE IF NOT EXISTS language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Inserção de dados na tabela 'language'
INSERT INTO language (name) VALUES
('English'),
('Spanish'),
('French'),
('German');

-- Criação da tabela 'actor'
CREATE TABLE IF NOT EXISTS actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Inserção de dados na tabela 'actor'
INSERT INTO actor (first_name, last_name) VALUES
('Johnny', 'Depp'),
('Tom', 'Hanks'),
('Julia', 'Roberts'),
('Brad', 'Pitt'),
('Angelina', 'Jolie');

-- Criação da tabela 'country'
CREATE TABLE IF NOT EXISTS country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Inserção de dados na tabela 'country'
INSERT INTO country (country) VALUES
('USA'),
('UK');

-- Criação da tabela 'city'
CREATE TABLE IF NOT EXISTS city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- Inserção de dados na tabela 'city'
INSERT INTO city (city, country_id) VALUES
('Springfield', 1),
('Riverside', 1),
('Birmingham', 2),
('Manchester', 2),
('London', 2);

-- Criação da tabela 'address'
CREATE TABLE IF NOT EXISTS address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    address2 VARCHAR(255),
    district VARCHAR(50) NOT NULL,
    city_id INT NOT NULL,
    postal_code VARCHAR(10),
    phone VARCHAR(20),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES city (city_id)
);

-- Inserção de dados na tabela 'address'
INSERT INTO address (address, district, city_id, postal_code, phone)
SELECT
    CONCAT('Address ', a.N),
    CONCAT('District ', a.N),
    FLOOR(RAND() * (SELECT COUNT(*) FROM city)) + 1,
    CONCAT(FLOOR(RAND() * 99999) + 10000),
    CONCAT('+1234567890')
FROM
    (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
LIMIT 100;

INSERT INTO address (address, district, city_id, postal_code, phone)
SELECT
    CONCAT('Address ', a.N),
    'District ' || a.N,
    (SELECT city_id FROM city WHERE city = 'Houston'), -- Usando Houston como cidade do Texas
    CONCAT(FLOOR(RAND() * 99999) + 10000),
    CONCAT('+1234567890')
FROM
    (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
LIMIT 100;


-- Criação da tabela 'staff'
CREATE TABLE IF NOT EXISTS staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(20),
    username VARCHAR(45),
    password VARCHAR(45),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Inserção de dados na tabela 'staff'
INSERT INTO staff (first_name, last_name, address, city, country, email, phone, username, password) VALUES
('John', 'Doe', '123 Main St', 'Springfield', 'USA', 'john.doe@example.com', '123-456-7890', 'johndoe', 'password1'),
('Jane', 'Smith', '456 Oak St', 'Riverside', 'USA', 'jane.smith@example.com', '987-654-3210', 'janesmith', 'password2'),
('Michael', 'Johnson', '789 Elm St', 'Birmingham', 'UK', 'michael.johnson@example.com', '456-123-7890', 'michaeljohnson', 'password3'),
('Emily', 'Brown', '321 Pine St', 'Manchester', 'UK', 'emily.brown@example.com', '789-123-4560', 'emilybrown', 'password4'),
('William', 'Jones', '567 Maple St', 'London', 'UK', 'william.jones@example.com', '654-987-3210', 'williamjones', 'password5');

-- Criação da tabela 'store'
CREATE TABLE IF NOT EXISTS store (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    manager_staff_id INT,
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (manager_staff_id) REFERENCES staff (staff_id)
);

-- Inserção de dados na tabela 'store'
INSERT INTO store (manager_staff_id, address, city, country) VALUES
(1, '123 Main St', 'Springfield', 'USA'),
(2, '456 Oak St', 'Riverside', 'USA'),
(3, '789 Elm St', 'Birmingham', 'UK'),
(4, '321 Pine St', 'Manchester', 'UK'),
(5, '567 Maple St', 'London', 'UK');

-- Criação da tabela 'customer'
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(50),
    address VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(20),
    create_date DATETIME NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (store_id) REFERENCES store (store_id)
);

-- Inserção de dados na tabela 'customer'
INSERT INTO customer (store_id, first_name, last_name, email, address, city, country, phone, create_date)
SELECT 
    1, 
    CONCAT('Customer', customer_id), 
    'Doe', 
    CONCAT('customer', customer_id, '@example.com'), 
    CONCAT(customer_id, ' Main St'), 
    'Springfield', 
    'USA', 
    CONCAT('123-456-', FLOOR(RAND() * 10000)), 
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY
FROM 
    (SELECT (a.N + (10 * b.N) + (100 * c.N)) AS customer_id
     FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
     CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
     CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS c
    ) AS numbers
LIMIT 100;

-- Criação da tabela 'film'
CREATE TABLE IF NOT EXISTS film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR,
    language_id INT,
    original_language_id INT,
    rental_duration INT DEFAULT 3,
    rental_rate DECIMAL(4,2) DEFAULT 4.99,
    length SMALLINT,
    replacement_cost DECIMAL(5,2) DEFAULT 19.99,
    rating ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') DEFAULT 'G',
    special_features SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes'),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (language_id) REFERENCES language (language_id),
    FOREIGN KEY (original_language_id) REFERENCES language (language_id)
);

-- Inserção de dados na tabela 'film'
INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features) VALUES
('Pirates of the Caribbean', 'Adventure movie', 2003, 1, 5, 4.99, 143, 19.99, 'PG-13', 'Trailers,Commentaries'),
('Forrest Gump', 'Drama movie', 1994, 1, 7, 4.99, 142, 19.99, 'PG-13', 'Trailers,Commentaries,Deleted Scenes'),
('Pretty Woman', 'Romantic comedy', 1990, 1, 5, 4.99, 119, 19.99, 'R', 'Trailers,Deleted Scenes'),
('Fight Club', 'Drama', 1999, 1, 3, 4.99, 139, 19.99, 'R', 'Trailers,Behind the Scenes'),
('Mr. & Mrs. Smith', 'Action comedy', 2005, 1, 5, 4.99, 120, 19.99, 'PG-13', 'Trailers,Deleted Scenes');


-- Criação da tabela 'inventory'
CREATE TABLE IF NOT EXISTS inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    store_id INT NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (film_id) REFERENCES film (film_id),
    FOREIGN KEY (store_id) REFERENCES store (store_id)
);

-- Inserção de dados na tabela 'inventory'
INSERT INTO inventory (film_id, store_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(1, 4),
(2, 4),
(3, 5),
(4, 5),
(5, 1);

-- Criação da tabela 'rental'
CREATE TABLE IF NOT EXISTS rental (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_date DATETIME NOT NULL,
    inventory_id INT NOT NULL,
    customer_id INT NOT NULL,
    return_date DATETIME,
    staff_id INT NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);

-- Inserção de dados na tabela 'rental'
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT 
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS rental_date, 
    FLOOR(RAND() * (SELECT COUNT(*) FROM inventory)) + 1 AS inventory_id, 
    FLOOR(RAND() * 100) + 1 AS customer_id, 
    IF(RAND() < 0.9, NOW() - INTERVAL FLOOR(RAND() * 30) DAY, NULL) AS return_date, 
    FLOOR(RAND() * 5) + 1 AS staff_id
FROM 
    (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
    CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
LIMIT 100;

-- Criação da tabela 'payment'
CREATE TABLE IF NOT EXISTS payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    staff_id INT NOT NULL,
    rental_id INT,
    amount DECIMAL(5, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id),
    FOREIGN KEY (rental_id) REFERENCES rental (rental_id)
);

-- Inserção de dados na tabela 'payment'
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
SELECT
    FLOOR(RAND() * (SELECT COUNT(*) FROM rental)) + 1 AS customer_id,
    FLOOR(RAND() * 5) + 1 AS staff_id,
    FLOOR(RAND() * (SELECT MAX(rental_id) FROM rental)) + 1 AS rental_id,
    ROUND(RAND() * 100, 2) AS amount,
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY AS payment_date
FROM
    (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS a
    CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS b
LIMIT 100;

-- Criação da tabela 'film_actor' para representar a relação entre 'film' e 'actor'
CREATE TABLE IF NOT EXISTS film_actor (
    actor_id INT,
    film_id INT,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
    FOREIGN KEY (film_id) REFERENCES film (film_id)
);

-- Inserção de dados na tabela 'film_actor'
INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 4),
(5, 4);

-- Exibir as tabelas e seus conteúdos
SHOW TABLES;
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM language;
SELECT * FROM film_actor;
