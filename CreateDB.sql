DROP database IF EXISTS mmsDB;
CREATE database IF NOT EXISTS mmsDB;

USE mmsDB;

-- Erstellen der Tabelle media
DROP TABLE IF EXISTS media;
CREATE TABLE IF NOT EXISTS media (
    mediaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    title NVARCHAR(255), 
    releaseDate DATE, 
    addedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    digital BOOL
	);

-- Erstellen der Tabelle locations
DROP TABLE IF EXISTS locations;
CREATE TABLE IF NOT EXISTS locations (
    locationID INT PRIMARY KEY,
    label NVARCHAR(255) NOT NULL,
    category NVARCHAR(255)
	);

-- Erstellen der Verknüpfungstabelle med_at_loc
DROP TABLE IF EXISTS med_at_loc; 
CREATE TABLE IF NOT EXISTS med_at_loc (
    locationID INT NOT NULL,
    mediaID INT NOT NULL,
    fpath NVARCHAR(255),
    FOREIGN KEY (locationID) REFERENCES locations(locationID)
		ON UPDATE CASCADE,
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE,
    PRIMARY KEY (locationID, mediaID)
	);

-- Erstellen der Tabelle music
DROP TABLE IF EXISTS music; 
CREATE TABLE IF NOT EXISTS music (
    mediaID INT UNIQUE NOT NULL,
    artist NVARCHAR(255) NOT NULL,
    genre NVARCHAR(255),
    album NVARCHAR(255),
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
);

-- Erstellen der Tabelle movies
DROP TABLE IF EXISTS films;
CREATE TABLE IF NOT EXISTS films (
    mediaID INT UNIQUE NOT NULL,
    `length` INT NOT NULL,
    director NVARCHAR(255),
    genre NVARCHAR(255),
    rating_imdb DECIMAL(3, 1),
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
);

-- Erstellen der Tabelle books
DROP TABLE IF EXISTS books; 
CREATE TABLE IF NOT EXISTS books (
    mediaID INT UNIQUE NOT NULL,
    author NVARCHAR(255) NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
	);


-- Erstellen der Tabelle series
DROP TABLE IF EXISTS series;
CREATE TABLE IF NOT EXISTS series (
    mediaID INT UNIQUE NOT NULL,
    genre NVARCHAR(255),
    seasons INT NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
	);


CREATE TABLE IF NOT EXISTS withdrawals (
    mediaID	INT NOT NULL,
    withdrawnAt DATETIME NOT NULL DEFAULT NOW(),
    withdrawnBy NVARCHAR(255) NOT NULL,

    FOREIGN KEY(mediaID) REFERENCES media(mediaID),
    PRIMARY KEY(mediaID)
    );


CREATE TABLE IF NOT EXISTS withdrawals_history (
    id		INT AUTO_INCREMENT,
    mediaID	INT NOT NULL,
    withdrawnAt DATETIME NOT NULL,
    returnedAt 	DATETIME, 
    withdrawnBy NVARCHAR(255) NOT NULL,

    FOREIGN KEY(mediaID) REFERENCES media(mediaID),
    PRIMARY KEY(id)
    );
    
 
 
    
/*===========================================================*/
/* VIEWS */   
/*===========================================================*/
 
 DROP VIEW IF EXISTS view_media_titles;
CREATE VIEW IF NOT EXISTS view_media_titles AS
SELECT media.mediaID, media.title, 
       CASE 
           WHEN music.mediaID IS NOT NULL THEN 'Music'
           WHEN films.mediaID IS NOT NULL THEN 'Film'
           WHEN books.mediaID IS NOT NULL THEN 'Book'
           WHEN series.mediaID IS NOT NULL THEN 'Series'
       END AS media_type
FROM media
LEFT JOIN music ON media.mediaID = music.mediaID
LEFT JOIN films ON media.mediaID = films.mediaID
LEFT JOIN books ON media.mediaID = books.mediaID
LEFT JOIN series ON media.mediaID = series.mediaID;

-- View for all books with their authors:

DROP VIEW IF EXISTS view_book_details; 
CREATE VIEW IF NOT EXISTS book_details AS
SELECT media.mediaID, media.title, books.author, media.releaseDate, media.digital
FROM media
JOIN books ON media.mediaID = books.mediaID;


-- View for all films with their directors and IMDb ratings:

DROP VIEW IF EXISTS view_film_details; 
CREATE VIEW IF NOT EXISTS film_details AS
SELECT media.mediaID, media.title, films.director, films.rating_imdb, media.digital
FROM media
JOIN films ON media.mediaID = films.mediaID;


-- View for all series with their genres and number of seasons:

DROP VIEW IF EXISTS view_series_details; 
CREATE VIEW IF NOT EXISTS view_series_details AS
SELECT media.mediaID, media.title, series.genre, series.seasons, media.digital
FROM media
JOIN series ON media.mediaID = series.mediaID;

-- View for all music with their artists and albums:

DROP VIEW IF EXISTS view_music_details; 
CREATE VIEW IF NOT EXISTS view_music_details AS
SELECT media.mediaID, media.title, music.artist, music.album, media.digital
FROM media
JOIN music ON media.mediaID = music.mediaID;
 
 
DROP VIEW IF EXISTS view_master;
CREATE VIEW IF NOT EXISTS view_master AS
SELECT mt.mediaID, mt.title, mt.media_type, l.label, l.category, m2l.fpath, IFNULL(w.withdrawnAt, 'stored') AS withdrawn, w.withdrawnBy
FROM view_media_titles AS mt
LEFT JOIN med_at_loc AS m2l ON mt.mediaID = m2l.mediaID
LEFT JOIN locations AS l ON m2l.locationID = l.locationID
LEFT JOIN withdrawals AS w ON mt.mediaID = w.mediaID
; 
    
/*===========================================================*/
/* ROUTINES */   
/*===========================================================*/
    
/* WITHDRAWAL TRIGGERS */
DROP TRIGGER IF EXISTS on_withdrawal;
DELIMITER //
CREATE TRIGGER on_withdrawal
AFTER INSERT ON withdrawals
    FOR EACH ROW
	BEGIN
	INSERT INTO withdrawals_history (mediaID, withdrawnAt, withdrawnBy)
	VALUES (NEW.mediaID, NEW.withdrawnAt, NEW.withdrawnBy);
    END//
DELIMITER ; 


DROP TRIGGER IF EXISTS on_return;
DELIMITER //
CREATE TRIGGER on_return
AFTER DELETE ON withdrawals
    FOR EACH ROW
	BEGIN
	UPDATE withdrawals_history 
	SET returnedAt = NOW()
	WHERE id = OLD.mediaID;
    END//
DELIMITER ;


/*----------------------*/
/* InsertProcedures.sql */
/*----------------------*/

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

/*===========================================================*/
/* TEST_DATA */   
/*===========================================================*/

-- Einfügen von Daten in die Tabelle media für films
INSERT INTO media (mediaID, title, releaseDate, addedAt, digital) VALUES
(1, 'Inception', '2010-07-16', '2025-01-27 09:00:00', TRUE),
(2, 'The Matrix', '1999-03-31', '2025-01-27 09:00:00', TRUE),
(3, 'Interstellar', '2014-11-07', '2025-01-27 09:00:00', FALSE),
(4, 'The Godfather', '1972-03-24', '2025-01-27 09:00:00', FALSE),
(5, 'Pulp Fiction', '1994-10-14', '2025-01-27 09:00:00', TRUE),
(6, 'The Dark Knight', '2008-07-18', '2025-01-27 09:00:00', TRUE),
(7, 'Fight Club', '1999-10-15', '2025-01-27 09:00:00', FALSE),
(8, 'Forrest Gump', '1994-07-06', '2025-01-27 09:00:00', FALSE),
(9, 'The Shawshank Redemption', '1994-09-23', '2025-01-27 09:00:00', TRUE),
(10, 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', '2025-01-27 09:00:00', TRUE);

-- Einfügen von Daten in die Tabelle films
INSERT INTO films (mediaID, length, director, genre, rating_imdb) VALUES
(1, 148, 'Christopher Nolan', 'Sci-Fi', 8.8),
(2, 136, 'Lana Wachowski, Lilly Wachowski', 'Sci-Fi', 8.7),
(3, 169, 'Christopher Nolan', 'Sci-Fi', 8.6),
(4, 175, 'Francis Ford Coppola', 'Crime', 9.2),
(5, 154, 'Quentin Tarantino', 'Crime', 8.9),
(6, 152, 'Christopher Nolan', 'Action', 9.0),
(7, 139, 'David Fincher', 'Drama', 8.8),
(8, 142, 'Robert Zemeckis', 'Drama', 8.8),
(9, 142, 'Frank Darabont', 'Drama', 9.3),
(10, 178, 'Peter Jackson', 'Fantasy', 8.8);

-- Einfügen von Daten in die Tabelle media für music
INSERT INTO media (mediaID, title, releaseDate, addedAt, digital) VALUES
(11, 'Bohemian Rhapsody', '1975-10-31', '2025-01-27 09:00:00', TRUE),
(12, 'Imagine', '1971-10-11', '2025-01-27 09:00:00', TRUE),
(13, 'Hotel California', '1976-12-08', '2025-01-27 09:00:00', FALSE),
(14, 'Billie Jean', '1983-01-02', '2025-01-27 09:00:00', TRUE),
(15, 'Smells Like Teen Spirit', '1991-09-10', '2025-01-27 09:00:00', FALSE),
(16, 'Like a Rolling Stone', '1965-07-20', '2025-01-27 09:00:00', TRUE),
(17, 'What a Wonderful World', '1967-10-18', '2025-01-27 09:00:00', FALSE),
(18, 'Hey Jude', '1968-08-26', '2025-01-27 09:00:00', TRUE),
(19, 'Purple Rain', '1984-06-25', '2025-01-27 09:00:00', TRUE),
(20, 'Rolling in the Deep', '2010-11-29', '2025-01-27 09:00:00', TRUE);

-- Einfügen von Daten in die Tabelle music
INSERT INTO music (mediaID, artist, genre, album) VALUES
(11, 'Queen', 'Rock', 'A Night at the Opera'),
(12, 'John Lennon', 'Rock', 'Imagine'),
(13, 'Eagles', 'Rock', 'Hotel California'),
(14, 'Michael Jackson', 'Pop', 'Thriller'),
(15, 'Nirvana', 'Grunge', 'Nevermind'),
(16, 'Bob Dylan', 'Folk', 'Highway 61 Revisited'),
(17, 'Louis Armstrong', 'Jazz', 'What a Wonderful World'),
(18, 'The Beatles', 'Rock', 'Hey Jude'),
(19, 'Prince', 'Pop', 'Purple Rain'),
(20, 'Adele', 'Pop', '21');

-- Einfügen von Daten in die Tabelle media für books
INSERT INTO media (mediaID, title, releaseDate, addedAt, digital) VALUES
(21, 'Wo ich wohne ist, der Mond ganz nah', '2024-01-11', '2025-01-27 09:00:00', FALSE),
(22, 'Der Herr der Ringe', '2019-08-24', '2025-01-27 09:00:00', FALSE),
(23, 'Die Säulen der Erde', '2000-01-01', '2025-01-27 09:00:00', FALSE),
(24, 'Ilias Odyssee', '2002-09-01', '2025-01-27 09:00:00', FALSE),
(25, 'Dreizehn lustige Erzählungen', '1992-01-01', '2025-01-27 09:00:00', FALSE),
(26, 'Ein Sommernachtstraum', '1998-04-01', '2025-01-27 09:00:00', FALSE),
(27, 'Schuld und Sühne', '1997-07-01', '2025-01-27 09:00:00', FALSE);

-- Einfügen von Daten in die Tabelle books
INSERT INTO books (mediaID, author) VALUES
(21, 'Cho Nam-Joo'),
(22, 'J.R.R. Tolkien'),
(23, 'Ken Follett'),
(24, 'Homer'),
(25, 'Anton Tschechow'),
(26, 'William Shakespeare'),
(27, 'Fjodor M. Dostojewski');

-- Einfügen von Daten in die Tabelle media für series
INSERT INTO media (mediaID, title, releaseDate, addedAt, digital) VALUES
(31, 'Game of Thrones', '2011-04-17', '2025-01-27 09:00:00', TRUE),
(32, 'Breaking Bad', '2008-01-20', '2025-01-27 09:00:00', TRUE),
(33, 'Friends', '1994-09-22', '2025-01-27 09:00:00', FALSE),
(34, 'The Office', '2005-03-24', '2025-01-27 09:00:00', TRUE),
(35, 'Sherlock', '2010-07-25', '2025-01-27 09:00:00', TRUE),
(36, 'The Simpsons', '1989-12-17', '2025-01-27 09:00:00', FALSE),
(37, 'Stranger Things', '2016-07-15', '2025-01-27 09:00:00', TRUE),
(38, 'The Mandalorian', '2019-11-12', '2025-01-27 09:00:00', TRUE),
(39, 'Fleabag', '2016-07-21', '2025-01-27 09:00:00', TRUE),
(40, 'Chernobyl', '2019-05-06', '2025-01-27 09:00:00', TRUE);

-- Einfügen von Daten in die Tabelle series
INSERT INTO series (mediaID, seasons, genre) VALUES
(31, 8, 'Fantasy'),
(32, 5, 'Crime'),
(33, 9, 'Comedy'),
(34, 7, 'Comedy'),
(35, 6, 'Crime'),
(36, 10, 'Animation'),
(37, 4, 'Sci-Fi'),
(38, 3, 'Sci-Fi'),
(39, 2, 'Comedy'),
(40, 1, 'Drama');


/*
Drei PCs  O-PC-1/2, CH-PC-1
USB-Speichermedien fangen mit USB an
 */
DELETE FROM locations;
INSERT INTO locations (locationID, label) VALUES 
( 1, 'O-SH-1' ),
( 2, 'O-SH-2' ),
( 3, 'O-SH-3' ),
( 4, 'O-SH-4' ),
( 5, 'O-PC-1' ),
( 6, 'O-PC-2' ),
( 7, 'O-DRAWER-1' ),
( 8, 'O-DRAWER-2' ),
( 9, 'O-DRAWER-3' ),
( 10,'O-DRAWER-4' ),
( 11, 'S-SH-1' ),
( 12, 'S-SH-2' ),
( 13, 'S-BOX-1' ),
( 14, 'S-BOX-2' ),
( 15, 'S-BOX-3' ),
( 16, 'S-BOX-4' ),
( 17, 'S-BOX-5' ),
( 18, 'S-BOX-6' ),
( 19, 'S-BOX-7' ),
( 20, 'S-BOX-8' ),
( 21, 'CE-BOX-1' ),
( 22, 'CE-BOX-2' ),
( 23, 'CE-BOX-3' ),
( 24, 'CE-BOX-4' ),
( 25, 'CE-BOX-5' ),
( 26, 'CE-BOX-6' ),
( 27, 'CE-BOX-7' ),
( 28, 'CE-BOX-8' ),
( 29, 'CH-BOX-1' ),
( 30, 'CH-PC-1' ),
( 31, 'CH-SH-1' ),
( 32, 'CH-SH-2' ),
( 33, 'USB-HDD-Toshiba 1TB'),
( 34, 'USB-SSD-Samsung 512GB'),
( 35, 'USB-Stick-Lukas-Blau'),
( 36, 'USB-Stick-Alex-ScanDisk')
;


DELETE FROM med_at_loc;
INSERT INTO med_at_loc (mediaID, locationID, fpath) VALUES 
( 1, 5, '/home/xb/films/good_stuff/inception.mp4'),
( 2, 5, '/home/xb/films/good_stuff/matrix/matrix.mov'),
( 5, 6, 'G:\\Filme\Pulp_Fiction\pulp_fiction.mp4'),
( 6, 6, 'G:\\Filme\The_Dark_Knight\dk.mp4'),
( 9, 33, 'Filme\The_Shawshank_Redemption\movie.mp4'),
( 10, 34, 'Filme\The_Lord_of_the_Rings_Complete_Trilogy\lotr-fellowship.mp4'),
( 11, 6, 'F:\\music\bohemian_rhapsody.mp3'),
( 12, 6, 'F:\\music\j.lennon/imagine.mp3'),
( 14, 35, 'm_jackson/track03.wav'),
( 16, 35, 'bob_dylan/track20.wav'),
( 18, 35, 'beatles/hey_jude.mp3'),
( 19, 36, 'prince/album01/purple_rain.mp3'),
( 20, 36, 'adele/track05.mp3')
;
