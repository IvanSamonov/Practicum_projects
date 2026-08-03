-- Три ресторана из Саранска с наибольшим LTV с начала мая до конца июня. LTV в данном контексте считается как суммарная комиссия, которая была получена от заказов в ресторане за эти два месяца.
-- Вывод:
-- 1. rest_id — уникальный идентификатор сети, к которой принадлежит ресторан.
-- 2. "Название сети" — название сети, к которой принадлежит ресторан.
-- 3. "Тип кухни" — тип кухни ресторана.
-- 4. LTV — суммарная комиссия, которая была получена от заказов в ресторане за эти два месяца, округлённая до копеек.

-- Рассчет величины комиссии с каждого заказа, отбор заказов по дате и городу
WITH orders AS
    (SELECT analytics_events.rest_id,
            analytics_events.city_id,
            revenue * commission AS commission_revenue
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE revenue IS NOT NULL
         AND log_date BETWEEN '2021-05-01' AND '2021-06-30'
         AND city_name = 'Саранск')

SELECT 
    o.rest_id,
    chain AS "Название сети",
    type AS "Тип кухни",
    ROUND(SUM(commission_revenue)::numeric, 2) AS LTV
FROM orders o
JOIN partners p ON o.rest_id = p.rest_id AND o.city_id = p.city_id
GROUP BY o.rest_id, chain, type
ORDER BY LTV DESC
LIMIT 3
