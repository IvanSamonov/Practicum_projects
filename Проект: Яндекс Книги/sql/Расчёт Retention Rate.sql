-- Команда маркетинга сервиса Яндекс Книги провела рекламную кампанию, которая 2 декабря привлекла множество пользователей. 
-- Ниже представлен ежедневный Retention Rate всех пользователей, которые были активны 2 декабря.
-- Вывод:
-- 1. day_since_install — срок жизни пользователя в днях;
-- 2. retained_users — количество пользователей, которые вернулись в приложение в конкретный день;
-- 3. retention_rate — коэффициент удержания для вернувшихся пользователей по отношению к общему числу пользователей, которые установили приложение.

WITH users_start_group AS (    
    SELECT DISTINCT puid
    FROM bookmate.audition
    WHERE msk_business_dt_str::DATE = '2024-12-02'
),
active_users AS (
    SELECT DISTINCT msk_business_dt_str,
        puid
    FROM bookmate.audition
    WHERE msk_business_dt_str::DATE >= '2024-12-02'
),
daily_retention AS (
    SELECT puid,
         msk_business_dt_str::DATE - '2024-12-02' AS day_since_install
    FROM active_users 
    JOIN users_start_group USING(puid)
)
SELECT day_since_install,
    COUNT(DISTINCT puid) AS retained_users,
    ROUND(1.0 * COUNT(DISTINCT puid) / MAX(COUNT(DISTINCT puid)) OVER(ORDER BY day_since_install), 2) AS retention_rate
FROM daily_retention
GROUP BY day_since_install
ORDER BY day_since_install
