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
	
	SET @generatedID = NULL;	
	
	CALL insert_media(title_, releaseDate_, digital_, generatedID);
	
	INSERT INTO mmsdb.films (mediaID, `length`, director, genre, rating_imdb)
		VALUES (generatedID, length_, director_, genre_, rating_imdb_); 
	
	COMMIT;
	END $$

DELIMITER ;