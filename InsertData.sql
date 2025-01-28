USE mmsDB;
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
