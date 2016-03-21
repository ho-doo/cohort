DROP TEMPORARY TABLES IF EXISTS first_rental;
CREATE TEMPORARY TABLE first_rental
SELECT
  r. customer_id,
  MIN(r.rental_date) first_time
FROM
  rental r
GROUP BY 1
;

DROP TEMPORARY TABLES IF EXISTS cohort_size
CREATE TEMPORARY TABLES cohort_size
SELECT
	LEFT(first_time, 7) "month",
	COUNT(*) num
FROM first_rental
GROUP BY 1
;