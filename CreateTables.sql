DROP database  IF EXISTS mmsDB;
CREATE database IF NOT EXISTS mmsDB;

USE mmsDB;

-- Erstellen der Tabelle media
CREATE TABLE IF NOT EXISTS media (
    mediaID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    title NVARCHAR(255), 
    releaseDate DATE, 
    addedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    digital BOOL
	);

-- Erstellen der Tabelle locations
CREATE TABLE IF NOT EXISTS locations (
    locationID INT AUTO_INCREMENT PRIMARY KEY,
    label NVARCHAR(255) NOT NULL
	);

-- Erstellen der Verknüpfungstabelle med_at_loc
CREATE TABLE IF NOT EXISTS med_at_loc (
    locationID INT NOT NULL,
    mediaID INT NOT NULL,
    FOREIGN KEY (locationID) REFERENCES locations(locationID),
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (mediaID) REFERENCES media(mediaID),
		ON UPDATE CASCADE
        ON DELETE CASCADE,
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
		ON UPDATE CASCADE
        ON DELETE CASCADE,
);

-- Erstellen der Tabelle movies
CREATE TABLE IF NOT EXISTS films (
    mediaID INT UNIQUE NOT NULL,
    `length` INT NOT NULL,
    director NVARCHAR(255),
    genre NVARCHAR(255),
    rating_imdb DECIMAL(3, 1),
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
);

-- Erstellen der Tabelle books
CREATE TABLE IF NOT EXISTS books (
    mediaID INT UNIQUE NOT NULL,
    author NVARCHAR(255) NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
	);


-- Erstellen der Tabelle series
CREATE TABLE IF NOT EXISTS series (
    mediaID INT UNIQUE NOT NULL,
    genre NVARCHAR(255),
    seasons INT NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
	);

