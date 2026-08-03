--Сколько LTV принесли пять самых популярных блюд двух самых популярных ресторанов. 
-- Вывод:
-- "Название сети" — название сети, к которой принадлежит ресторан.
-- "Название блюда" — название блюда, которое оказалось популярным.
-- spicy — логический признак острых блюд. 1 — блюдо острое.
-- fish — логический признак рыбных блюд. 1 — блюдо содержит морепродукты.
-- meat — логический признак мясных блюд. 1 — блюдо содержит мясо.
-- LTV — суммарная комиссия, которая была получена от заказов блюда в ресторане за эти два месяца, округлённая до копеек.

--Рассчет величины комиссии с каждого заказа, отбор заказов по дате и городу
WITH orders AS
    (SELECT analytics_events.rest_id,
            analytics_events.city_id,
            analytics_events.object_id,
            revenue * commission AS commission_revenue
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE revenue IS NOT NULL
         AND log_date BETWEEN '2021-05-01' AND '2021-06-30'
         AND city_name = 'Саранск'), 
--Поиск двух ресторанов с наибольшим LTV
top_ltv_restaurants AS
    (SELECT orders.rest_id,
            chain,
            type,
            ROUND(SUM(commission_revenue)::numeric, 2) AS LTV
     FROM orders
     JOIN partners ON orders.rest_id = partners.rest_id AND orders.city_id = partners.city_id
     GROUP BY 1, 2, 3
     ORDER BY LTV DESC
     LIMIT 2)
SELECT chain AS "Название сети",
    dishes.name AS "Название блюда",
    spicy,
    fish,
    meat,
    ROUND(SUM(orders.commission_revenue)::numeric, 2) AS LTV
FROM top_ltv_restaurants
JOIN orders ON top_ltv_restaurants.rest_id = orders.rest_id 
JOIN dishes ON orders.object_id = dishes.object_id 
GROUP BY 1, 2, 3, 4, 5
ORDER BY LTV DESC 
LIMIT 5
