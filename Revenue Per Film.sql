SELECT
f. film_id,
title,
f. rental_rate * COUNT(*) totla_revenue 
FROM
 rental r, film f, inventory i
WHERE
 r. inventory_id = i. inventory_id
 AND i.film_id = f.film_id
 GROUP BY 1
 ;