--Расчет среднего чека как среднее значение комиссии сервиса со всех заказов за месяц
--Вывод:
--1. "Месяц" — месяц события.
--2. "Количество заказов" — количество заказов за месяц.
--3. "Сумма комиссии" — сумма комиссии за месяц.
--4. "Средний чек" — средняя комиссия на одну транзакцию.

-- Рассчет величины комиссии с каждого заказа, отбор заказов по дате и городу
WITH orders AS
    (SELECT *,
            revenue * commission AS commission_revenue
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE revenue IS NOT NULL
         AND log_date BETWEEN '2021-05-01' AND '2021-06-30'
         AND city_name = 'Саранск')

SELECT 
    DATE_TRUNC('month', log_date)::date AS "Месяц",
    COUNT(DISTINCT order_id) AS "Количество заказов",
    ROUND(SUM(commission_revenue)::numeric, 2) AS "Сумма комиссии",
    ROUND(SUM(commission_revenue)::numeric / COUNT(DISTINCT order_id), 2) AS "Средний чек"
FROM orders 
GROUP BY DATE_TRUNC('month', log_date)::date
ORDER BY DATE_TRUNC('month', log_date)::date
