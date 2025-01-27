CREATE DATABASE IF NOT EXISTS mmsDB;

CREATE TABLE IF NOT EXISTS media (

	mediaID INT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	releaseDate DATE, 
	addedAt DATETIME NOT NULL,
	digital BOOL
	
	);

CREATE TABLE IF NOT EXISTS locations (
	
	locationID INT AUTO_INCREMENT PRIMARY KEY,
	label VARCHAR(255) NOT NULL
	
	);

CREATE TABLE IF NOT EXISTS med_at_loc (
	
	locationID INT NOT NULL,
	mediaID INT NOT NULL,
	FOREIGN KEY (locationID) REFERENCES locations(locationID),
	FOREIGN KEY (mediaID) REFERENCES media(mediaID),
	PRIMARY KEY (locationID, mediaID)
	
	);










