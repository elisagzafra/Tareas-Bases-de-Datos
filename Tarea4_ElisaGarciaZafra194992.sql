--Elisa Garcia Zafra 194992
--Tarea 4
--La resolvimos en equipo yo, Alejandra Arredondo y Yulianna Padilla

--1. Cuál es el promedio, en formato human-readable, de tiempo entre cada pago por cliente de la BD Sakila?
select concat(c.first_name,' ',c.last_name) as customer, 
(max(p.payment_date)-min(p.payment_date))/(count(p.payment_date)) as time_average
from payment p join customer c using(customer_id)
group by customer_id
order by time_average;


--2. Sigue una distribución normal?
--Crear funcion de histograma de github:
CREATE OR REPLACE FUNCTION histogram(table_name_or_subquery text, column_name text)
RETURNS TABLE(bucket int, "range" numrange, freq bigint, bar text)
AS $func$
BEGIN
RETURN QUERY EXECUTE format('
  WITH
  source AS (
    SELECT * FROM %s
  ),
  min_max AS (
    SELECT min(%s) AS min, max(%s) AS max FROM source
  ),
  histogram AS (
    SELECT
      width_bucket(%s, min_max.min, min_max.max, 20) AS bucket,
      numrange(min(%s)::numeric, max(%s)::numeric, ''[]'') AS "range",
      count(%s) AS freq
    FROM source, min_max
    WHERE %s IS NOT NULL
    GROUP BY bucket
    ORDER BY bucket
  )
  SELECT
    bucket,
    "range",
    freq::bigint,
    repeat(''*'', (freq::float / (max(freq) over() + 1) * 15)::int) AS bar
  FROM histogram',
  table_name_or_subquery,
  column_name,
  column_name,
  column_name,
  column_name,
  column_name,
  column_name,
  column_name
  );
END
$func$ LANGUAGE plpgsql;

select * from histogram('(select extract(epoch from (max(p.payment_date) - min(p.payment_date))/(count(p.payment_date)) ) as time_average
from payment p 
group by customer_id
order by time_average) as seconds', 'time_average');


--3. Qué tanto difiere ese promedio del tiempo entre rentas por cliente?
select concat(c.first_name,' ',c.last_name) as customer, 
(max(r.rental_date) - min(r.rental_date))/(count(r.rental_date)) as rental_time_average, 
(max(p.payment_date) - min(p.payment_date))/(count(p.payment_date)) as payment_time_average,
(max(r.rental_date) - min(r.rental_date))/(count(r.rental_date)) - (max(p.payment_date) - min(p.payment_date))/(count(p.payment_date)) as difference
from payment p join customer c using(customer_id) join rental r using(customer_id)
group by customer_id 
order by rental_time_average;


