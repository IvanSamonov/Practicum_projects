--MAU определяется как количество уникальных пользователей в месяц, которые читали или слушали конкретного автора.
--Вывод:
-- 1. main_author_name — имя автора контента;
-- 2. mau — значение MAU.

SELECT 
    author.main_author_name,
    COUNT(DISTINCT audition.puid) as mau
FROM bookmate.audition 
JOIN bookmate.content ON audition.main_content_id = content.main_content_id
JOIN bookmate.author ON content.main_author_id = author.main_author_id
WHERE msk_business_dt_str::DATE BETWEEN '2024-11-01' AND '2024-11-30'
GROUP BY author.main_author_name
ORDER BY mau DESC
LIMIT 3
