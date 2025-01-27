CREATE DATABASE IF NOT EXISTS mmsDB;
CREATE TABLE IF NOT EXISTS media (
	mediaID int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	title nvarchar (255), 
	releaseDate date, 
	addedDate date, 
	digital BOOL
	);

CREATE TABLE IF NOT EXISTS locations (
	locationID int AUTO_INCREMENT PRIMARY KEY,
	label varchar(255) NOT NULL
	);

CREATE TABLE IF NOT EXISTS med_at_loc (
	locationID int NOT NULL,
	mediaID int NOT NULL,
	FOREIGN KEY (locationID) REFERENCES locations(locationID),
	FOREIGN KEY (mediaID) REFERENCES media(mediaID),
	PRIMARY KEY (locationID, mediaID)
	);










