-- Рассчет средней выручки от часа чтения или прослушивания по формуле: выручка (MAU * 399 рублей) / сумма прослушанных часов.
-- Вывод:
-- 1. month — месяц активности;
-- 2. mau — значение MAU;
-- 3. hours — общее количество прослушанных часов;
-- 4. avg_hour_rev — средняя выручка от часа чтения или прослушивания.

WITH month_stats AS (
    SELECT 
        DATE_TRUNC('month', msk_business_dt_str::timestamp)::DATE AS month,
        COUNT(DISTINCT puid) AS mau,
        ROUND(SUM(hours), 2) AS hours
    FROM bookmate.audition 
    GROUP BY 1
)
SELECT *,
    ROUND(mau * 399 / hours, 2) AS avg_hour_rev
FROM month_stats
WHERE month != '2024-12-01'
