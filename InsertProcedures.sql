USE mmsdb;

DROP PROCEDURE IF EXISTS insert_media;
DROP PROCEDURE IF EXISTS insert_film;

DELIMITER $$

CREATE PROCEDURE insert_media(IN title_ NVARCHAR(255), IN releaseDate_  DATE, digital_ BOOL, OUT mediaID_ INT)
	BEGIN
	
	INSERT INTO mmsdb.media (addedAt, title, releaseDate, digital)
		VALUES (NOW(), title_, releaseDate_, digital_);
	
	SELECT LAST_INSERT_ID() INTO mediaID_;
	
	END$$



CREATE PROCEDURE insert_film(IN title_ NVARCHAR(255), IN releaseDate_ DATE, IN digital_ BOOL, 
		IN length_ INT, IN director_ NVARCHAR(255), IN genre_ NVARCHAR(255), IN rating_imdb_ DECIMAL(3, 1))
	BEGIN
	
	DECLARE generatedID INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
	
	CALL insert_media(title_, releaseDate_, digital_, generatedID);
	
	INSERT INTO mmsdb.films (mediaID, `length`, director, genre, rating_imdb)
		VALUES (generatedID, length_, director_, genre_, rating_imdb_); 
	
	COMMIT;
	END $$



CREATE PROCEDURE insert_book(IN title_ NVARCHAR(255), IN releaseDate_ DATE, IN digital_ BOOL,
	IN author_ NVARCHAR(255))
	BEGIN
	
	DECLARE generatedID INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
	
	CALL insert_media(title_, releaseDate_, digital_, generatedID);
	
	INSERT INTO mmsdb.books (mediaID, author)
		VALUES (generatedID, author_);

	COMMIT;
	END $$



CREATE PROCEDURE insert_music(IN title_ NVARCHAR(255), IN releaseDate_ DATE, IN digital_ BOOL,
	IN artist_ NVARCHAR(255), IN genre_ NVARCHAR(255), IN album_ NVARCHAR(255))
	BEGIN
	
	DECLARE generatedID INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
	
	CALL insert_media(title_, releaseDate_, digital_, generatedID);
	
	INSERT INTO mmsdb.music (mediaID, artist, genre, album)
		VALUES (generatedID, artist_, genre_, album_);

	COMMIT;
	END $$



CREATE PROCEDURE insert_series(IN title_ NVARCHAR(255), IN releaseDate_ DATE, IN digital_ BOOL,
	IN seasons_ int, IN genre_ NVARCHAR(255))
	BEGIN
	
	DECLARE generatedID INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	START TRANSACTION;
	
	CALL insert_media(title_, releaseDate_, digital_, generatedID);
	
	INSERT INTO mmsdb.series (mediaID, seasons, genre)
		VALUES (generatedID, seasons_, genre_);

	COMMIT;
	END $$


DELIMITER ;

-- TEST CALLS
-- CALL insert_film('TEST FILM', CURDATE(), TRUE, 243, 'DIR', 'GENRE', 2.4);
-- CALL insert_book('TEST BOOK', CURDATE(), FALSE, 'AUTHOR');
-- CALL insert_music('TEST MUSIC', CURDATE(), TRUE, 'ARTIST', 'SOMETHING', 'GENRE');
-- CALL insert_series('TEST SERIES', CURDATE(), TRUE, 3, 'DRAMA');