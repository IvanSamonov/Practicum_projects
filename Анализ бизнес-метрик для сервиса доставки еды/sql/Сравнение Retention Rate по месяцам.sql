--Сравнение Retention Rate пользователей за май и июнь 
-- Вывод:
-- 1. "Месяц" — месяц первого посещения продукта.
-- 2. day_since_install — срок жизни пользователя в днях.
-- 3. retained_users — количество пользователей, которые вернулись в приложение в конкретный день.
-- 4. retention_rate — коэффициент удержания для вернувшихся пользователей по отношению к общему числу пользователей, которые установили приложение в день установки.

--Рассчет новых пользователей по дате первого посещения продукта
WITH new_users AS
    (SELECT DISTINCT first_date,
                     user_id
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE first_date BETWEEN '2021-05-01' AND '2021-06-24'
         AND city_name = 'Саранск'),

--Рассчет активных пользователей по дате события
active_users AS
    (SELECT DISTINCT log_date,
                     user_id
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE log_date BETWEEN '2021-05-01' AND '2021-06-30'
         AND city_name = 'Саранск'),

daily_retention AS
    (SELECT new_users.user_id,
            first_date,
            log_date::date - first_date::date AS day_since_install
     FROM new_users
     JOIN active_users ON new_users.user_id = active_users.user_id
     AND log_date >= first_date)

SELECT 
    DATE_TRUNC('MONTH', first_date)::date AS "Месяц",
    day_since_install,
    COUNT(DISTINCT user_id) AS retained_users,
    ROUND(1.0 * COUNT(DISTINCT user_id) / MAX(COUNT(DISTINCT user_id)) OVER(PARTITION BY DATE_TRUNC('MONTH', first_date)::date), 2) AS retention_rate
FROM daily_retention
WHERE day_since_install < 8
GROUP BY 1, 2
ORDER BY 1, 2
