

-- Sakila Lab 8

-- 01 Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, length, RANK() over (order by length)
from sakila.film
where length <> 0 and length <> '' or length <> ' '; 

-- 02 Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
select title, length, rating, DENSE_RANK() over (order by rating)
from sakila.film
where length <> 0 and length <> '' or length <> ' '; 

-- 03 How many films are there for each of the categories in the category table. Use appropriate join to write this query
select a.category_id, a.name, count(b.film_id) amount, dense_rank() over (order by count(b.film_id) desc) as Rank_Film 
from sakila.film_category as b
join category as a
on a.category_id=b.category_id
group by a.category_id, a.name;

-- 04 Which actor has appeared in the most films?
select a.first_name, a.last_name, count(b.film_id) as amount_films
from sakila.film_actor as b
join actor as a
on a.actor_id=b.actor_id
group by a.actor_id
order by count(b.film_id) desc
Limit 1;

-- 05 Most active customer (the customer that has rented the most number of films)
select a.customer_id, a.last_name, count(b.rental_id) as amount_rentals
from sakila.rental as b
join sakila.customer as a
on a.customer_id=b.customer_id
group by a.customer_id
order by count(b.rental_id) desc
Limit 1;

-- Bonus bogus

select f.title, count(i.film_id) as most_rented_film
from sakila.rental as r
join sakila.inventory as i
on r.inventory_id = i.inventory_id
join sakila.film as f
on i.film_id = f.film_id
group by i.film_id
order by count(i.film_id) desc
limit 1;