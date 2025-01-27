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





-- Benutzerdefinierte Funktion zur Berechnung der Anzahl digitaler Medien
CREATE FUNCTION CountDigitalMedia()
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*) FROM media WHERE digital = TRUE;
    RETURN @count;
END;

-- Erstellen einer Sicht zur Anzeige von Medien und ihren Standorten
CREATE VIEW MediaWithLocations AS
SELECT m.title, l.room, l.shelf
FROM media m
JOIN mediaLocations ml ON m.mediaID = ml.mediaID
JOIN locations l ON ml.locationID = l.locationID;

-- Transaktion: Löschen aller Medien und ihrer Verknüpfungen
BEGIN TRANSACTION;
DELETE FROM mediaLocations WHERE mediaID IN (SELECT mediaID FROM media);
DELETE FROM media;
COMMIT;




