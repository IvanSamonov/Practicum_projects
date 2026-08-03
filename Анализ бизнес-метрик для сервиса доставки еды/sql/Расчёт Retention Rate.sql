-- Рассчитываем новых пользователей по дате первого посещения продукта
WITH new_users AS
    (SELECT DISTINCT first_date,
                     user_id
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE first_date BETWEEN '2021-05-01' AND '2021-06-24'
         AND city_name = 'Саранск'),

-- Рассчитываем активных пользователей по дате события
active_users AS
    (SELECT DISTINCT log_date,
                     user_id
     FROM analytics_events
     JOIN cities ON analytics_events.city_id = cities.city_id
     WHERE log_date BETWEEN '2021-05-01' AND '2021-06-30'
         AND city_name = 'Саранск'),

retention_users AS (
    SELECT 
        new_users.user_id,
        log_date - first_date AS day_since_install
    FROM new_users
    JOIN active_users ON new_users.user_id = active_users.user_id 
    WHERE log_date >= first_date
)

SELECT 
    day_since_install,
    COUNT(DISTINCT user_id) AS retained_users,
    ROUND(1.0 * COUNT(DISTINCT user_id) / MAX(COUNT(DISTINCT user_id)) OVER(), 2) AS retention_rate
FROM retention_users
WHERE day_since_install < 8
GROUP BY day_since_install
ORDER BY day_since_install
