--Diese Funktion berechnet die Anzahl der Medien in einer bestimmten Kategorie
DELIMITER //

CREATE FUNCTION count_media_by_category(category_ NVARCHAR(255))
RETURNS INT
BEGIN
    DECLARE media_count INT;
    SELECT COUNT(*)
    INTO media_count
    FROM media
    JOIN med_at_loc ON media.mediaID = med_at_loc.mediaID
    JOIN locations ON med_at_loc.locationID = locations.locationID
    WHERE locations.category = category_;
    RETURN media_count;
END //

DELIMITER ;