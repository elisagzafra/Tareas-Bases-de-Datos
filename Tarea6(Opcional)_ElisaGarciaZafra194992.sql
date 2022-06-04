--Elisa Garcia Zafra 194992
--Tarea 6 (Opcional)
--Trabaje con Ale Arredondo para esta tarea

--Una de las métricas para saber si un cliente es bueno, aparte de la suma y el promedio de sus pagos, 
--es si tenemos una progresión consistentemente creciente en los montos.
--Debemos calcular para cada cliente su promedio mensual de deltas en los pagos de sus órdenes 
--en la tabla order_details en la BD de Northwind, es decir, 
--la diferencia entre el monto total de una orden en tiempo t y el anterior en t-1, 
--para tener la foto completa sobre el customer lifetime value de cada miembro de nuestra cartera.



select a.customer_id, to_char(a.order_date,'YYYY-MM') as order_month, avg(delta_order_price) as monthly_average_delta_order_price
from(
	select
		o.customer_id as customer_id,
		o.order_date as order_date,
		(1-od.discount)*(od.unit_price*od.quantity) as order_price,
		(1-od.discount)*(od.unit_price*od.quantity) - lag((1-od.discount)*(od.unit_price*od.quantity)) 
			over (partition by o.customer_id order by o.order_date) as delta_order_price 
	from orders o join order_details od using (order_id)
)as a
group by a.customer_id, order_month
order by a.customer_id, order_month;



