--Elisa Garcia Zafra
--Ejercicios: Tarea 1 (los 20)

--1.	Qué contactos de proveedores tienen la posición de sales representative? 
select s.contact_name, s.contact_title 
from suppliers s
where s.contact_title = 'Sales Representative';

--2.	Qué contactos de proveedores no son marketing managers?
select s.contact_name, s.contact_title 
from suppliers s
where s.contact_title != 'Marketing Manager';

--3.	Cuales órdenes no vienen de clientes en Estados Unidos?
select o.order_id, o.ship_country 
from orders o 
where o.ship_country !='USA'
order by o.ship_country;

--4.	Qué productos de los que transportamos son quesos? 
select p.product_id, p.product_name
from products p 
where p.category_id = 4;

--5.	Qué ordenes van a Bélgica o Francia?
select o.order_id , o.ship_country
from orders o 
where o.ship_country = 'Belgium' or o.ship_country = 'France'
order by o.ship_country ;

--6.	Qué órdenes van a LATAM? 
select o.order_id, o.ship_country
from orders o 
where o.ship_country = 'Argentina' or o.ship_country = 'Venezuela'
 or o.ship_country = 'Mexico' or o.ship_country = 'Brazil'
group by o.order_id
order by o.ship_country;

--7.	Qué órdenes no van a LATAM?
select o.order_id, o.ship_country
from orders o 
where o.ship_country != 'Argentina' and o.ship_country != 'Venezuela'
 and o.ship_country != 'Mexico' and o.ship_country != 'Brazil'
group by o.order_id 
order by o.ship_country;

--8.	Necesitamos los nombres completos de los empleados, nombres y apellidos unidos en un mismo registro.
select e.employee_id , concat(e.first_name,' ',e.last_name) as full_name
from employees e;

--9.	Cuánta lana tenemos en inventario? 
select sum(p.unit_price*p.units_in_stock) as money_in_inventory 
from products p  ;

--10.	Cuantos clientes tenemos de cada país? 
select c.country , count(c.customer_id) as number_of_costumers
from customers c
group by c.country;

--11.	Obtener un reporte de edades de los empleados para checar su elegibilidad para seguro de gastos médicos menores.
select e.first_name , e.last_name , age(e.birth_date) as employee_age
from employees e
order by e.last_name ;

--12.	Cuál es la orden más reciente por cliente?
select o.customer_id, max(o.order_id) as most_recent_order, max(o.order_date) as most_recent_order_date
from orders o
group by o.customer_id 
order by o.customer_id;

--13.	De nuestros clientes, qué función desempeñan y cuántos son?
select c.contact_title , count(c.contact_title) as how_many
from customers c
group by c.contact_title
order by how_many;

--14.	Cuántos productos tenemos de cada categoría?
select c.category_name , sum(p.units_in_stock) as number_of_products
from categories c 
left join products p on c.category_id = p.category_id
group by c.category_id;

--15.	Cómo podemos generar el reporte de reorder?
select p.product_id, p.product_name, p.units_in_stock, p.reorder_level
from products p
where p.units_in_stock < p.reorder_level;

--16.	A donde va nuestro envío más voluminoso?
select o.ship_country, max(o.ship_city) as city, max(o.ship_address) as address , max(od.quantity) as max_units
from order_details od
inner join orders o on (o.order_id = od.order_id)
group by o.ship_country
order by max_units desc limit 1;

--17.	Cómo creamos una columna en customers que nos diga si un cliente es bueno, regular, o malo?
select t.contact_name, t.total,
 (case
	 when t.total < 10000 then 'malo'
	 when t.total >= 10000 and t.total <100000 then 'regular'
	 else 'bueno'
 end) as categoria
from (
select c.contact_name,
 sum(od.unit_price*od.quantity*(1-od.discount))as total
from customers c
join orders o using (customer_id)
join order_details od using (order_id)
group by c.contact_name) as t
order by categoria, t.contact_name;

--18.	Qué colaboradores chambearon durante las fiestas de navidad? (fiestas de navidad: 24-25 de diciembre)
select o.employee_id
from orders o 
where (extract(month from o.shipped_date) = 12 and (extract(day from o.shipped_date) = 25 or extract(day from o.shipped_date) = 24))
or (extract(month from o.order_date) = 12 and (extract(day from o.order_date) = 25 or extract(day from o.shipped_date) = 24))
intersect
select  e.employee_id 
from employees e 
order by 1;

--19.	Qué productos mandamos en navidad? (navidad: 25 de diciembre)
select p.product_name
from products p 
join order_details od on (p.product_id =od.product_id)
join orders o on (od.order_id = o.order_id)
where (extract(month from o.shipped_date) = 12) and (extract(day from o.shipped_date) = 25)
order by p.product_name ;

--20.	Qué país recibe el mayor volumen de producto?
select o.ship_country , sum(od.quantity) as max_units
from orders o 
join order_details od on (o.order_id = od.order_id)
group by o.ship_country
order by max_units desc limit 1;









