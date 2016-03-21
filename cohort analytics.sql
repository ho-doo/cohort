DROP TEMPORARY TABLES IF EXISTS first_rental;
CREATE TEMPORARY TABLE first_rental
SELECT
  r. customer_id,
  MIN(r.rental_date) first_time
FROM
  rental r
GROUP BY 1
;

DROP TEMPORARY TABLE IF EXISTS cohort_size;
CREATE TEMPsORARY TABLE cohort_size
SELECT
    LEFT(first_time, 7) Month,
    COUNT(*) num
FROM
    first_rental
GROUP BY 1
;

SELECT 
    r.*,
    LEFT(fr.first_time, 7) cohort,
    p.amount
FROM
    rental r, 
    first_rental fr,
    cohort_size cs,
    payment p
WHERE 
    r.customer_id = fr.customer_id
    AND cs.month = LEFT(fr.first_time, 7)
    AND p.rental_id = r.rental_id
;