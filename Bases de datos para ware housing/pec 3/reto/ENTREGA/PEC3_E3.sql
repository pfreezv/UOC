--EJERCICIO 3 

CREATE OR REPLACE FUNCTION fn_get_info_by_sponsor(select_date DATE ,sponsor character varying)

RETURNS table (j json)
AS $$

BEGIN
RETURN QUERY
SELECT array_to_json(array_agg(row_to_json(t)))
FROM (
	SELECT c.email , c.name , a.athlete_name, a.discipline_name, a.round_number,a.mark,a.rating,a.info_log_dt
	FROM olympic.tb_athletes_info_log a 
	LEFT JOIN olympic.tb_finance b ON a.athlete_id = b.athlete_id
	LEFT JOIN olympic.tb_sponsor c ON b.sponsor_name = c.name
	WHERE sponsor = c.name 
	AND a.info_log_dt = select_date
) t;
		
END; $$
LANGUAGE plpgsql