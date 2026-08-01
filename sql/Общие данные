-- Расчет ключевых показателей сервиса за весь период (в разрезе каждой валюты):
-- 1. общая выручка с заказов total_revenue;
-- 2. количество заказов total_orders;
-- 3. средняя выручка заказа avg_revenue_per_order;
-- 4. общее число уникальных клиентов total_users.
SELECT
	currency_code,
	sum(revenue) AS total_revenue,
	count(order_id) AS total_orders,
	avg(revenue) AS avg_revenue_per_order,
	count(DISTINCT user_id) AS total_users
FROM afisha.purchases
GROUP BY currency_code
ORDER BY total_revenue DESC
