-- Распределение выручки и количества заказов по типу устройства. Вывод:
-- 1. тип устройства device_type_canonica;
-- 2. общая выручка с заказов total_revenue;
-- 3. количество заказов total_orders;
-- 4. средняя стоимость заказа avg_revenue_per_order;
-- 5. доля выручки для каждого устройства от общего значения revenue_share.
SELECT
	device_type_canonical,
	sum(revenue) AS total_revenue,
	COUNT(order_id) AS total_orders,
	avg(revenue) AS avg_revenue_per_order,
	round((sum(revenue) / (SELECT sum(revenue) FROM  afisha.purchases WHERE currency_code = 'rub'))::NUMERIC, 3) AS revenue_share
FROM afisha.purchases
WHERE currency_code = 'rub'
GROUP BY device_type_canonical
ORDER BY revenue_share DESC
