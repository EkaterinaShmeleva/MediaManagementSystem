-- View for all media titles and their types:
USE mmsDB;

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
CREATE VIEW IF NOT EXISTS view_book_details AS
SELECT media.mediaID, media.title, books.author, media.releaseDate, media.digital
FROM media
JOIN books ON media.mediaID = books.mediaID;


-- View for all films with their directors and IMDb ratings:

DROP VIEW IF EXISTS view_film_details; 
CREATE VIEW IF NOT EXISTS view_film_details AS
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
