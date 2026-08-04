-- топ-3 произведений с наибольшим MAU в ноябре
-- Вывод:
-- 1. main_content_name — название произведения, или контента;
-- 2. published_topic_title_list — список жанров контента;
-- 3. main_author_name — имя автора контента;
-- 4. mau — значение MAU.

SELECT 
    content.main_content_name,
    content.published_topic_title_list,
    author.main_author_name,
    COUNT(DISTINCT audition.puid) as mau
FROM bookmate.audition 
JOIN bookmate.content ON audition.main_content_id = content.main_content_id
JOIN bookmate.author ON content.main_author_id = author.main_author_id
WHERE msk_business_dt_str::DATE BETWEEN '2024-11-01' AND '2024-11-30'
GROUP BY 1, 2, 3
ORDER BY mau DESC
LIMIT 3
