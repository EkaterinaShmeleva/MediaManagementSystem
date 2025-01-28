USE mmsDB;

-- Erstellen der Tabelle media
CREATE TABLE IF NOT EXISTS media (
    mediaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    title NVARCHAR(255), 
    releaseDate DATE, 
    addedDate DATE, 
    digital BOOL
	);

-- Erstellen der Tabelle locations
CREATE TABLE IF NOT EXISTS locations (
    locationID INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(255) NOT NULL
	);

-- Erstellen der Verknüpfungstabelle med_at_loc
CREATE TABLE IF NOT EXISTS med_at_loc (
    locationID INT NOT NULL,
    mediaID INT NOT NULL,
    FOREIGN KEY (locationID) REFERENCES locations(locationID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID),
    PRIMARY KEY (locationID, mediaID)
	);

-- Erstellen der Tabelle music
CREATE TABLE IF NOT EXISTS music (
    mediaID INT UNIQUE NOT NULL,
    artist NVARCHAR(255) NOT NULL,
    genre NVARCHAR(255),
    album NVARCHAR(255),
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
);

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

-- Einfügen von Daten in die Tabelle media für music
INSERT INTO media (mediaID, title, releaseDate, addedDate, digital) VALUES
(11, 'Bohemian Rhapsody', '1975-10-31', '2025-01-27', TRUE),
(12, 'Imagine', '1971-10-11', '2025-01-27', TRUE),
(13, 'Hotel California', '1976-12-08', '2025-01-27', FALSE),
(14, 'Billie Jean', '1983-01-02', '2025-01-27', TRUE),
(15, 'Smells Like Teen Spirit', '1991-09-10', '2025-01-27', FALSE),
(16, 'Like a Rolling Stone', '1965-07-20', '2025-01-27', TRUE),
(17, 'What a Wonderful World', '1967-10-18', '2025-01-27', FALSE),
(18, 'Hey Jude', '1968-08-26', '2025-01-27', TRUE),
(19, 'Purple Rain', '1984-06-25', '2025-01-27', TRUE),
(20, 'Rolling in the Deep', '2010-11-29', '2025-01-27', TRUE);

-- Erstellen der Tabelle movies
CREATE TABLE IF NOT EXISTS movies (
    mediaID INT UNIQUE NOT NULL,
    length INT NOT NULL,
    director NVARCHAR(255),
    genre NVARCHAR(255),
    rating_imdb DECIMAL(3, 1),
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
);

-- Einfügen von Daten in die Tabelle movies
INSERT INTO movies (mediaID, length, director, genre, rating_imdb) VALUES
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

-- Einfügen von Daten in die Tabelle media für movies
INSERT INTO media (mediaID, title, releaseDate, addedDate, digital) VALUES
(1, 'Inception', '2010-07-16', '2025-01-27', TRUE),
(2, 'The Matrix', '1999-03-31', '2025-01-27', TRUE),
(3, 'Interstellar', '2014-11-07', '2025-01-27', FALSE),
(4, 'The Godfather', '1972-03-24', '2025-01-27', FALSE),
(5, 'Pulp Fiction', '1994-10-14', '2025-01-27', TRUE),
(6, 'The Dark Knight', '2008-07-18', '2025-01-27', TRUE),
(7, 'Fight Club', '1999-10-15', '2025-01-27', FALSE),
(8, 'Forrest Gump', '1994-07-06', '2025-01-27', FALSE),
(9, 'The Shawshank Redemption', '1994-09-23', '2025-01-27', TRUE),
(10, 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', '2025-01-27', TRUE);

-- Erstellen der Tabelle books
CREATE TABLE IF NOT EXISTS books (
    mediaID INT UNIQUE NOT NULL,
    author NVARCHAR(255) NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
	);

-- Einfügen von Daten in die Tabelle books
INSERT INTO books (mediaID, author) VALUES
(21, 'Cho Nam-Joo'),
(22, 'J.R.R. Tolkien'),
(23, 'Ken Follett'),
(24, 'Homer'),
(25, 'Anton Tschechow'),
(26, 'William Shakespeare'),
(27, 'Fjodor M. Dostojewski');

-- Einfügen von Daten in die Tabelle media für books
INSERT INTO media (mediaID, title, releaseDate, addedDate, digital) VALUES
(21, 'Wo ich wohne ist, der Mond ganz nah', '2024-01-11', '2025-01-27', FALSE),
(22, 'Der Herr der Ringe', '2019-08-24', '2025-01-27', FALSE),
(23, 'Die Säulen der Erde', '2000-01-01', '2025-01-27', FALSE),
(24, 'Ilias Odyssee', '2002-09-01', '2025-01-27', FALSE),
(25, 'Dreizehn lustige Erzählungen', '1992-01-01', '2025-01-27', FALSE),
(26, 'Ein Sommernachtstraum', '1998-04-01', '2025-01-27', FALSE),
(27, 'Schuld und Sühne', '1997-07-01', '2025-01-27', FALSE);

-- Erstellen der Tabelle series
CREATE TABLE IF NOT EXISTS series (
    mediaID INT UNIQUE NOT NULL,
    seasons INT NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
	);

-- Einfügen von Daten in die Tabelle series
INSERT INTO series (mediaID, seasons) VALUES
(31, 8),
(32, 5),
(33, 9),
(34, 7),
(35, 6),
(36, 10),
(37, 4),
(38, 3),
(39, 2),
(40, 1);

-- Einfügen von Daten in die Tabelle media für series
INSERT INTO media (mediaID, title, releaseDate, addedDate, digital) VALUES
(31, 'Game of Thrones', '2011-04-17', '2025-01-27', TRUE),
(32, 'Breaking Bad', '2008-01-20', '2025-01-27', TRUE),
(33, 'Friends', '1994-09-22', '2025-01-27', FALSE),
(34, 'The Office', '2005-03-24', '2025-01-27', TRUE),
(35, 'Sherlock', '2010-07-25', '2025-01-27', TRUE),
(36, 'The Simpsons', '1989-12-17', '2025-01-27', FALSE),
(37, 'Stranger Things', '2016-07-15', '2025-01-27', TRUE),
(38, 'The Mandalorian', '2019-11-12', '2025-01-27', TRUE),
(39, 'Fleabag', '2016-07-21', '2025-01-27', TRUE),
(40, 'Chernobyl', '2019-05-06', '2025-01-27', TRUE);