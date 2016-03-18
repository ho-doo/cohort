DROP TEMPORARY TABLE IF EXISTS revenue_per_film;
CREATE TEMPORARY TABLE revenue_per_film
SELECT
f. film_id,
title,
f. rental_rate * COUNT(*) total_revenue 
FROM
 rental r, film f, inventory i
WHERE
 r. inventory_id = i. inventory_id
 AND i.film_id = f.film_id
 GROUP BY 1
 ;
 
 SELECT
 actor. actor_id,
 CONCAT( actor. first_name," ", actor. last_name ),
 SUM(revenue_per_film. total_revenue)
 FROM
 revenue_per_film, film_actor, actor
 WHERE
 revenue_per_film. film_id = film_actor. film_id
 AND film_actor. actor_id = actor. actor_id 
 GROUP BY 
 actor. actor_id
 ORDER BY total_revenue DESC
 LIMIT 10
 ;