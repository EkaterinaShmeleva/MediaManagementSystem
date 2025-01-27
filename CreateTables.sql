CREATE DATABASE mmsDB;
CREATE TABLE media 
(mediaID int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
title nvarchar (255), 
releaseDate date, 
addedDate date, 
digital bool)

CREATE TABLE locations
(locationID int AUTO_INCREMENT PRIMARY KEY,
label varchar(255) NOT NULL)

CREATE TABLE med_at_loc
(locationID int NOT NULL,
mediaID int NOT NULL,
FOREIGN KEY (locationID) REFERENCES (locations.locationID),
FOREIGN KEY (mediaID) REFERENCES (media.mediaID),
PRIMARY KEY (locationID, mediaID)
)





