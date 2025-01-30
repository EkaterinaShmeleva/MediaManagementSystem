USE mmsDB;

DROP FUNCTION IF EXISTS countDigitalMedia;

CREATE FUNCTION IF NOT EXISTS countDigitalMedia()
	RETURNS INT DETERMINISTIC
	RETURN (SELECT COUNT(*) FROM mmsDB.media
				WHERE digital);



DROP FUNCTION IF EXISTS isAvailable;

CREATE FUNCTION IF NOT EXISTS isAvailable(mediaID_ INT)
	RETURNS BOOL DETERMINISTIC
	
	RETURN (SELECT 
		EXISTS( SELECT * 
				FROM mmsDB.withdrawals 
				WHERE withdrawals.mediaID = mediaID_ ));



-- In MySQL no table value functions, so this has to be
-- implemented as a procedure

DROP PROCEDURE IF EXISTS mediaAtLocation;

DELIMITER &&

CREATE PROCEDURE IF NOT EXISTS mediaAtLocation(IN loclabel_ NVARCHAR(255))
	BEGIN
	SELECT * FROM 
		mmsDB.locations AS l
			JOIN mmsDB.med_at_loc AS mal
			ON l.locationID = mal.locationID
				JOIN mmsDB.view_media_titles AS m
				ON mal.mediaID = m.mediaID;	
--		WHERE l.label = loclabel_);
	END&&

DELIMITER ;

-- INSERT INTO med_at_loc VALUES (1, 1);
-- INSERT INTO med_at_loc VALUES (1, 3);


CALL mediaAtLocation('O-SH-1');