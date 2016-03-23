DROP TEMPORARY TABLE IF EXISTS first_rental;
CREATE TEMPORARY TABLE first_rental
SELECT
	r.customer_id,
	MIN(r.rental_date) first_time
FROM rental r
GROUP BY 1
;

DROP TEMPORARY TABLE IF EXISTS cohort_size;
CREATE TEMPORARY TABLE cohort_size
SELECT
	LEFT(fr. first_time, 7) month,
	COUNT(*) num
FROM
	first_rental fr
GROUP BY 1
;

SELECT
	r.*,
	cs.month cohort,
	p. amount
FROM
	rental r
	JOIN first_rental fr
	ON r.customer_id = fr. customer_id
	JOIN cohort_size cs
	ON cs.month = LEFT(fr. first_time, 7)
	JOIN payment p
	ON p.rental_id = r.rental_id
	;
	
	DROP TEMPORARY TABLE IF EXISTS cohort;
CREATE TEMPORARY TABLE cohort
SELECT
    date_format(fr.first_time, "%Y%m") cohort_formatted,  # cohort month
    date_format(r.rental_date, "%Y%m") rental_date_formated,  # rental month
    cs.num cohort_size,
    SUM(p.amount) month_revenue,
    SUM(p.amount)/cs.num RPU
FROM
    rental r 
        JOIN first_rental fr
            ON r.customer_id = fr.customer_id
        JOIN cohort_size cs
            ON cs.month = LEFT(fr.first_time, 7)
        JOIN payment p
            ON p.rental_id = r.rental_id
GROUP BY 1, 2
;

