--Конверсия за каждый день зарегистрированных пользователей, которые посещают приложение, в активных клиентов. Критерий активности — размещение заказа. 
--Вывод:
--1. log_date — дата события.
--2. CR — значение конверсии.
SELECT
    log_date,
    ROUND((COUNT(DISTINCT user_id) FILTER (WHERE event = 'order')) / COUNT(DISTINCT user_id)::numeric, 2) AS CR
FROM analytics_events
WHERE city_id = 6 and log_date BETWEEN '2021-05-01' AND '2021-06-30'
GROUP BY log_date
ORDER BY log_date
