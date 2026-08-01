-- Топ-7 регионов по значению общей выручки(для заказов в рублях). Вывод:
-- 1. название региона region_name;
-- 2. суммарная выручка total_revenue;
-- 3. число заказов total_orders;
-- 4. уникальное число клиентов total_users;
-- 5. количество проданных билетов total_tickets;
-- 6. средняя выручка одного билета one_ticket_cost.
SELECT
	region_name,
	sum(revenue) AS total_revenue,
	count(order_id) AS total_orders,
	count(DISTINCT user_id) AS total_users,
	sum(tickets_count) AS total_tickets,
	sum(revenue) / sum(tickets_count) AS one_ticket_cost
FROM afisha.purchases
JOIN afisha.events USING(event_id)
JOIN afisha.city USING(city_id)
JOIN afisha.regions USING(region_id)
WHERE currency_code = 'rub'
GROUP BY region_name
ORDER BY total_revenue DESC
LIMIT 7
