-- Нормализация данных для удобной проверки гипотезы
-- Вывод:
-- 1. city — город пользователя;
-- 2. puid — идентификатор пользователя;
-- 3. hours — общее количество часов активности.

SELECT 
    usage_geo_id_name AS city,
    puid,
    SUM(hours) AS hours
FROM bookmate.audition
JOIN bookmate.geo USING(usage_geo_id)
WHERE usage_geo_id_name in ('Москва', 'Санкт-Петербург')
GROUP BY 1, 2
