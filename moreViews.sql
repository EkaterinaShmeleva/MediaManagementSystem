-- View for all media titles and their types:
USE mmsdb;

CREATE VIEW IF NOT EXISTS media_titles AS
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

CREATE VIEW IF NOT EXISTS book_details AS
SELECT media.mediaID, media.title, books.author, media.releaseDate
FROM media
JOIN books ON media.mediaID = books.mediaID;


-- View for all films with their directors and IMDb ratings:

CREATE VIEW IF NOT EXISTS film_details AS
SELECT media.mediaID, media.title, films.director, films.rating_imdb
FROM media
JOIN films ON media.mediaID = films.mediaID;


-- View for all series with their genres and number of seasons:

CREATE VIEW IF NOT EXISTS series_details AS
SELECT media.mediaID, media.title, series.genre, series.seasons
FROM media
JOIN series ON media.mediaID = series.mediaID;

-- View for all music with their artists and albums:

CREATE VIEW IF NOT EXISTS music_details AS
SELECT media.mediaID, media.title, music.artist, music.album
FROM media
JOIN music ON media.mediaID = music.mediaID;