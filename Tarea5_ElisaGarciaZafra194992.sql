--Elisa Garcia Zafra 194992
--Tarea 5

--Parte de la infraestructura es diseñar contenedores cilíndricos giratorios para facilitar 
--la colocación y extracción de discos por brazos automatizados. 
--Cada cajita de Blu-Ray mide 20cm x 13.5cm x 1.5cm, y para que el brazo pueda manipular adecuadamente 
--cada cajita, debe estar contenida dentro de un arnés que cambia las medidas a 30cm x 21cm x 8cm 
--para un espacio total de 5040 centímetros cúbicos y un peso de 500 gr por película.
--Se nos ha encargado formular la medida de dichos cilindros de manera tal que quepan 
--todas las copias de los Blu-Rays de cada uno de nuestros stores. 
--Las medidas deben ser estándar, es decir, la misma para todas nuestras stores, 
--y en cada store pueden ser instalados más de 1 de estos cilindros. 
--Cada cilindro aguanta un peso máximo de 50kg como máximo. 

--Sacamos datos necesarios para resolver el problema
with 
	films_per_store as( 
	select i.store_id as store_id, count(i.film_id) as num_films
	from inventory i
	group by i.store_id),
	
	max_films_per_cyl as (
	select 50/0.5 as films_per_cyl),
	
	cyl_height as (
	select (2.5*mf.films_per_cyl) as cyl_height 
	from max_films_per_cyl mf),
	
	cyl_radius as (
	select (sqrt(power(30/2,2) + power(21/2,2))) as cyl_radius),
	
	cyl_volume as(
	select (pi()*power(r.cyl_radius,2)*h.cyl_height) as cyl_volume 
	from cyl_height h, cyl_radius r)
	
--Ahora podemos saber cuantos cilindros necesitamos
	select f.store_id, ceil(f.num_films/100) as cyl_per_store 
	from films_per_store f;

	
	
	
	
	

	