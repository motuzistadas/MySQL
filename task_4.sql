
--
-- 4.
--

--
-- a) Suskirstyti knygas į žanrus.
--

CREATE TABLE IF NOT EXISTS Genres (
	genreId INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	title VARCHAR(40)
);

INSERT INTO Genres (`genreId`, `title`) VALUES 
(NULL, "Drama"), 
(NULL, "Action an Adventure"), 
(NULL, "Romance"), 
(NULL, "Mystery"), 
(NULL, "Horror"), 
(NULL, "Travel"), 
(NULL, "History"), 
(NULL, "Poetry"), 
(NULL, "Fantasy");

--
-- b) Knygos gali turėti vieną ir daugiau autorių.
--

--
-- Norint palaikyti du FOREIGN KEYS pakeičiamas Authors ENGINE į InnoDb
--

ALTER TABLE Authors ENGINE = InnoDB; 

ALTER TABLE Books ADD INDEX `bookId` (`bookId`);	

ALTER TABLE Authors ADD INDEX `authorId` (`authorId`);

CREATE TABLE BookAuthors ( 
	bookId INT(11) NOT NULL,
	authorId INT(11) NOT NULL, 
	PRIMARY KEY (bookId, authorId),
	FOREIGN KEY (bookId) REFERENCES Books (bookId), 
	FOREIGN KEY (authorId) REFERENCES Authors (authorId)
)ENGINE=INNODB;

--
-- c) Sutvarkyti duomenų bazės duomenis, jei reikia papildykite naujais.
--

ALTER TABLE Books DROP COLUMN authorId;

ALTER TABLE Books ADD genreId INT NOT NULL;

UPDATE Books SET genreId = 1 WHERE bookId = 1;
UPDATE Books SET genreId = 9 WHERE bookId = 2;
UPDATE Books SET genreId = 8 WHERE bookId = 3;
UPDATE Books SET genreId = 7 WHERE bookId = 4;
UPDATE Books SET genreId = 3 WHERE bookId = 5;
UPDATE Books SET genreId = 3 WHERE bookId = 10;

INSERT INTO BookAuthors (`bookId`, `authorId`) VALUES 
(1, 2), 
(1, 4), 
(2, 3), 
(3, 2), 
(3, 1), 
(4, 5), 
(5, 6), 
(5, 7), 
(5, 1),
(10, 4);

--
-- d) Išrinkite visas knygas su jų autoriais. (autorius, jei jų daugiau nei vienas atskirkite kableliais)
--

SELECT b.title, GROUP_CONCAT(a.name) AS authors FROM Books as b 
LEFT JOIN BookAuthors AS ba ON b.bookId = ba.bookId 
LEFT JOIN Authors AS a ON ba.authorId = a.authorId 
GROUP BY b.bookId;

--
-- e) Papildykite knygų lentelę, kad galėtumėte išsaugoti originalų knygos pavadinimą. (Pavadinime išsaugokite, lietuviškas raides kaip ą,ė,š ir pan.)
--

ALTER TABLE Books convert to character SET utf8 collate utf8_unicode_ci;

UPDATE Books SET title = "Lietuviškąs šįęčęąęė"  WHERE bookId = 10; 