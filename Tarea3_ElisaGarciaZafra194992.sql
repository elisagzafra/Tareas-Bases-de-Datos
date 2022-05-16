-- Elisa Garcia Zafra 194992
-- Tarea 3
-- NOTA: Yuliana, Alejandra y yo (Elisa) compartimos nuestros conocimientos para mejorar la tarea y ayudarnos mutuamente 


--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select concat(c2.first_name, ' ', c2.last_name), c2.email from country c
join city using (country_id) 
join address a using (city_id) 
join store s using (address_id) 
join customer c2 using (store_id) where c.country='Canada'; 

--Qué cliente ha rentado más de nuestra sección de adultos?
select c.customer_id,
	c.first_name || ' ' || c.last_name as nombre_completo,
	count(r.rental_id) AS mas_rentas
from customer c
join rental r using (customer_id)
join inventory i using (inventory_id)
join film f using (film_id) 
	where f.rating = 'NC-17'
group by (c.customer_id, nombre_completo)
	order by mas_rentas desc
		limit 3; 

 

--Qué películas son las más rentadas en todas nuestras stores?
select f.film_id, f.title,
count(r.rental_id) as rented
from rental r
join inventory i using (inventory_id) 
join film f  using (film_id) 
group by (f.film_id, f.title) 
 order by rented desc; 

-- Cuál es nuestro revenue por store?
select store_id,  sum(p.amount) from payment p 
join staff s using (staff_id) 
join store using (store_id) 
group by store_id;



