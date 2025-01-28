USE mmsdb;

CREATE FUNCTION IF NOT EXISTS countDigitalMedia()
	RETURNS INT DETERMINISTIC
	RETURN (SELECT COUNT(*) FROM mmsdb.media
				WHERE digital);


CREATE FUNCTION IF NOT EXISTS isAvailable(mediaID_ INT)
	RETURNS BOOL DETERMINISTIC
	
	RETURN (SELECT 
		EXISTS( SELECT * 
				FROM mmsdb.withdrawals 
				WHERE withdrawals.mediaID = mediaID_ ));
	
