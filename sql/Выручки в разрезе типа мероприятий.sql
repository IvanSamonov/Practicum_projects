-- Распределение количества заказов и их выручки в зависимости от типа мероприятия event_type_main (для заказов в рублях). Вывод:
-- 1. тип мероприятия event_type_main;
-- 2. общая выручка с заказов total_revenue;
-- 3. количество заказов total_orders;
-- 4. средняя стоимость заказа avg_revenue_per_order;
-- 5. уникальное число событий total_event_name (по их коду event_name_code);
-- 6. среднее число билетов в заказе avg_tickets;
-- 7. средняя выручка с одного билета avg_ticket_revenue;
-- 8. доля выручки от общего значения revenue_share
SELECT
	event_type_main,
	sum(revenue) AS total_revenue,
	count(order_id) AS total_orders,
	avg(revenue) AS avg_revenue_per_order,
	count(DISTINCT event_name_code) AS total_event_name,
	avg(tickets_count) AS avg_tickets,
	sum(revenue) / sum(tickets_count) AS avg_ticket_revenue,
	round((sum(revenue) / (SELECT sum(revenue) FROM afisha.purchases WHERE currency_code = 'rub'))::NUMERIC, 3) AS revenue_share
FROM afisha.purchases
JOIN afisha.events USING(event_id)
WHERE currency_code = 'rub'
GROUP BY event_type_main
ORDER BY total_orders DESC
