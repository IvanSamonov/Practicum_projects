-- Средний LTV, за все время, для пользователей в Москве и Санкт-Петербурге
-- Подписка Яндекс Плюс стоит 399 рублей в месяц. Пользователь приносит 399 рублей, если хотя бы раз в месяц пользуется Яндекс Книгами.
-- Вывод:
-- city — название города или региона;
-- total_users — суммарное количество пользователей в городе или регионе;
-- ltv — средний LTV пользователей в городе или регионе

WITH month_user_count AS (     
    SELECT 
        usage_geo_id_name,
        DATE_TRUNC('month', msk_business_dt_str::TIMESTAMP) AS month,
        COUNT(DISTINCT puid) AS user_count
    FROM bookmate.audition
    JOIN bookmate.geo USING(usage_geo_id)
    WHERE usage_geo_id_name in ('Москва', 'Санкт-Петербург')
    GROUP BY 1, 2
),
city_revenue AS (
    SELECT 
        usage_geo_id_name,
        SUM(user_count)*399 AS revenue
    FROM month_user_count
    GROUP BY 1
),
total_user_count AS (
    SELECT 
        usage_geo_id_name,
        COUNT(DISTINCT puid) AS total_users
    FROM bookmate.audition
    JOIN bookmate.geo USING(usage_geo_id)
    WHERE usage_geo_id_name in ('Москва', 'Санкт-Петербург')
    GROUP BY 1
)
