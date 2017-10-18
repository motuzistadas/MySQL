--
-- 1. Lentelėje UserClicks (clickId, userId, `dateTime`) saugomi vartotojų click’ai. Parašykite užklausą, kuri suskaičiuotų 
-- kiek unikalių vartotojų buvo per mėnesį nuo šių metų pražios.
--

SELECT YEAR(`dateTime`) as year, MONTH(`dateTime`) as month,
       COUNT(DISTINCT userId) as UniqueUsers
FROM  `UserClicks` 
WHERE YEAR(`dateTime`) = YEAR(CURDATE())
GROUP BY year, month
ORDER BY year, month;


--
-- 2. Lentelėje Clients (clientId, birthDate) saugomi klientų gimimo datos. Išrinkite vartotojus, kurie švenčia 
-- šiandiena gimtadienius ir kiek jiems metų.
--

SELECT clientId, TIMESTAMPDIFF(YEAR, birthDate, CURDATE()) AS age 
FROM Clients 
WHERE MONTH(birthDate) = MONTH(NOW()) AND DAY(birthDate) = DAY(NOW());

--
-- 3. Straipsniai saugomi lenteles News (newsId, text, date), straipsnio komentarai saugomi lentelėje 
-- Comments (commentId, text, date, newsId). Išrinkite naujausios 10 straipsnių su paskutiniu parašytu komentaru.
--


-- Sunkiai sekesi sugalvoti sprendimą, be sub-query'io
SELECT n.*, c.text as lastComment
FROM News as n
LEFT JOIN Comments as c ON n.newsId = c.newsId
WHERE c.date = (SELECT MAX(`date`) FROM Comments as c WHERE c.newsId = n.newsId )
ORDER BY n.date DESC
LIMIT 10;