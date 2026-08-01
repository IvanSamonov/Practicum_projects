-- Изменение выручки, количества заказов, уникальных клиентов и средней стоимости одного заказа в недельной динамике (для заказов в рублях). Вывод:
-- 1. неделя week;
-- 2. суммарная выручка total_revenue;
-- 3. число заказов total_orders;
-- 4. уникальное число клиентов total_users;
-- 5. средняя стоимость одного заказа revenue_per_order
SELECT
	date_trunc('week', created_dt_msk)::date AS week,
	sum(revenue) AS total_revenue,
	count(order_id) AS total_orders,
	count(DISTINCT user_id) AS total_users,
	sum(revenue) / count(order_id) AS revenue_per_order
FROM afisha.purchases
WHERE currency_code = 'rub'
GROUP BY week
ORDER BY week
