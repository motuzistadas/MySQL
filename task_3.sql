
--
-- 3.
--

--
-- a) Papildykite autorių lentelę įrašais.
--

INSERT INTO Authors (`authorId`, `name`) VALUES 
(NULL, "Dan Brown"), 
(NULL, "Stephen King"), 
(NULL, "Emily Bleeker");

--
-- b) Papildykite knygų lentelę, įrašais apie knygas, kurių autorius įrašėte prieš tai.
--

INSERT INTO Books (`bookId`, `authorId`, `title`, `year`) VALUES 
(NULL, 8, "Inferno", 2017), 
(NULL, 8, "The Lost Symbol", 2016), 
(NULL, 9, "The Shining", 2015), 
(NULL, 9, "Sleeping Beuties", 2017), 
(NULL, 10, "When I'm Gone", 2016), 
(NULL, 10, "Wreckage", 2014);

--
-- c) Išrinkite knygų informaciją prijungdami autorius iš autorių lentelės.
--

SELECT b.bookId, b.title, a.name, b.year FROM Books AS b 
LEFT JOIN Authors AS a ON b.authorId = a.authorId;

--
-- d) Pakeiskite vienos knygos autorių į kitą.
--

UPDATE Books 
SET authorId = 7 
WHERE bookId = 10;


--
-- e) Suskaičiuokite kiek knygų kiekvieno autoriaus yra duomenų bazėje (įtraukdami autorius kurie neturi knygų).
--

SELECT a.name, COUNT(b.authorId) as books 
FROM Authors as a 
LEFT JOIN Books as b ON a.authorId = b.authorId 
GROUP BY a.authorId;

--
-- neįtraukdami šių autorių
--

SELECT a.name, COUNT(b.authorId) as books 
FROM Authors as a  
LEFT JOIN Books as b ON a.authorId = b.authorId 
WHERE b.authorId IS NOT NULL 
GROUP BY a.authorId;

--
-- f) Pašalinkite jūsų įrašytus autorius.
--

DELETE FROM Authors 
WHERE authorId IN(8,9,10);

--
-- g) Pašalinkite knygas, kurios neturi autorių.
--

DELETE FROM Books 
WHERE authorId IS NULL OR authorId IN(8,9,10);

