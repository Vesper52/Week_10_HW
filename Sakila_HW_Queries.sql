#1a

Select first_name, last_name from actor;

#1b

Select CONCAT(first_name , ' ', last_name) AS Actor_Name FROM actor;

#2a

SELECT actor_id, first_name, last_name from actor WHERE first_name = 'Joe';

#2b 

SELECT actor_id, first_name, last_name from actor WHERE last_name LIKE '%Gen%';

#2c

SELECT actor_id, first_name, last_name from actor WHERE last_name LIKE '%Li%' ORDER BY last_name, first_name;

#2d
SELECT country_id, country from country WHERE country IN ('Afghanistan','Bangladesh','China');

#3a
ALTER TABLE actor  add middle_name char;

#3b
ALTER TABLE actor MODIFY COLUMN middle_name blob;

#3c
ALTER TABLE actor DROP COLUMN middle_name;

#4a
SELECT last_name, COUNT(last_name) AS `Count of Last Name` FROM actor GROUP BY last_name;


#4b
SELECT DISTINCT last_name, COUNT(last_name) AS `Count of Last Name` FROM actor GROUP BY last_name Having count(last_name) >1;
#4c
Update actor
SET first_name = 'Harpo'
WHERE first_name = 'Groucho';
#4d

#5a
CREATE schema address;
#6a
SELECT staff.first_name, staff.last_name, address.address FROM staff
INNER JOIN address ON  address.address_id = staff.staff_id;
#6b

#6c
#SELECT * FROM film_actor;

SELECT COUNT(film_actor.actor_id) AS 'Count of Actors',film.title AS 'Movie Title' FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id GROUP BY title;
#6d
SELECT COUNT(inventory_id) AS 'Count of Invetory' FROM inventory Where inventory_id = (Select film_id From film where title = 'Hunchback Impossible') ;
#6e
SELECT * FROM payment;

SELECT customer.first_name as 'First Name', customer.last_name as 'Last Name', payment.amount as 'Paid Amount' From customer 
INNER JOIN payment ON payment.customer_id = customer.customer_id GROUP BY customer.last_name;
#7a
SELECT title as 'Movies Starting with K or Q' FROM (SELECT title as 'title' FROM film  where language_id = 1) as title WHERE title LIKE 'Q%' or title LIKE 'K%';
#7b
SELECT first_name, last_name from actor WHERE actor_id IN (SELECT actor_id From film_actor where film_id = (SELECT film_id From film where title = 'Alone Trip') )
GROUP BY last_name;
#7c Canada country id = 20
SELECT * from city;
SELECT * from customer;
SELECT * from address;
SELECT * from country;

SELECT customer.first_name as 'First Name', customer.last_name as 'Last Name' ,customer.email as 'Email' From customer INNER JOIN address ON address.address_id = 
customer.address_id
INNER JOIN city  ON address.address_id = city.city_id 
INNER JOIN country ON country.country_id = city.country_id 
WHERE country.country_id = 20;
#7d
SELECT title as 'Family Friendly Movies' from film WHERE film_id IN (SELECT film_id from film_category where category_id = 8);
#7e
SELECT title as 'Most Rented Films', rental_duration  from  film order by rental_duration DESC;
#7f
SELECT * from inventory;
SELECT * from film;
SELECT * from store;

SELECT inventory.store_id, (SELECT SUM(rental_rate*rental_duration) as 'Total Revenue' From film where film_id  = inventory.film_id ) FROM inventory ;
#7g
SELECT * from address;
SELECT * from store;
SELECT * from city;
SELECT * from  country;

SELECT store.store_id AS 'Store ID' , city.city AS 'City', country.country AS 'Country' from store INNER JOIN address ON 
address.address_id =store.address_id INNER JOIN city on city.city_id = address.city_id INNER JOIN country on country.country_id = city.country_id;

#7h
SELECT * from inventory;
SELECT * from payment;
SELECT * from rental;
SELECT * from film_category;
SELECT * from category;

SELECT category.name AS 'Top 5 Genres',SUM(payment.amount) AS 'Rental Amount' from category INNER JOIN film_category on film_category.category_id = category.category_id 
INNER JOIN inventory on inventory.film_id = film_category.film_id INNER JOIN rental on rental.inventory_id = inventory.inventory_id 
INNER JOIN payment on payment.rental_id = rental.rental_id  GROUP BY category.name Order By SUM(payment.amount) DESC LIMIT 5 ;

#8a
CREATE View Top_5_Grossing_Genres AS
SELECT category.name AS 'Top 5 Genres',SUM(payment.amount) AS 'Rental Amount' from category INNER JOIN film_category on film_category.category_id = category.category_id 
INNER JOIN inventory on inventory.film_id = film_category.film_id INNER JOIN rental on rental.inventory_id = inventory.inventory_id 
INNER JOIN payment on payment.rental_id = rental.rental_id  GROUP BY category.name Order By SUM(payment.amount) DESC LIMIT 5 ;

#8b
SELECT * FROM top_5_grossing_genres;
#8c
Drop View top_5_grossing_genres;