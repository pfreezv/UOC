


--ejercicio 2
--a)
SELECT 
	athlete_id,
	name,
	country,
	substitute_id
FROM 
	tb_athlete
WHERE 
	country LIKE 'ESP' AND
	name LIKE 'PE%'	

--b)

SELECT 
	d.name,a.name,a.athlete_id from tb_athlete a 
LEFT JOIN 
	tb_play p on a.athlete_id = p.athlete_id
LEFT JOIN
	tb_discipline d on p.discipline_id = d.discipline_id
WHERE
	a.country = 'FRA' and d.type = 'JUMP'
ORDER BY
	d.name asc , a.athlete_id desc


--c)

SELECT
d.discipline_id ,d.name , count(p.athlete_id) as conteo_athlete FROM tb_play p NATURAL JOIN tb_discipline d
GROUP BY d.discipline_id
ORDER BY conteo_athlete desc
limit 1

--d)


SELECT a.athlete_id, a.name, a.country , count(*) as total_disciplina 
FROM tb_register r natural join tb_athlete a
group by a.athlete_id
having count(*) >1

--e)


SELECT a.athlete_id, a.name, d.name, r.round_number
FROM tb_register r 
left join tb_athlete a on r.athlete_id = a.athlete_id
left join tb_discipline d  on r.discipline_id = d.discipline_id
where r.round_number =(
   SELECT MAX (round_number)
   FROM tb_round
)





