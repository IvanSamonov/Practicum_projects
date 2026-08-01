-- Распределение выручки и количества заказов по типу устройства. Вывод:
-- тип устройства device_type_canonica;
-- общая выручка с заказов total_revenue;
-- количество заказов total_orders;
-- средняя стоимость заказа avg_revenue_per_order;
-- доля выручки для каждого устройства от общего значения revenue_share, округлённая до трёх знаков после точки.
SELECT
	device_type_canonical,
	sum(revenue) AS total_revenue,
	COUNT(order_id) AS total_orders,
	avg(revenue) AS avg_revenue_per_order,
	round((sum(revenue) / (SELECT sum(revenue) FROM  afisha.purchases WHERE currency_code = 'rub'))::NUMERIC, 3) AS revenue_share
FROM afisha.purchases
WHERE currency_code = 'rub'
GROUP BY 1
ORDER BY 5 DESC
