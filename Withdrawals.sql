USE mmsDB;

CREATE TABLE IF NOT EXISTS withdrawals (
    mediaID	INT NOT NULL,
    withdrawnAt DATETIME NOT NULL DEFAULT NOW(),
    withdrawnBy NVARCHAR(255) NOT NULL,

    FOREIGN KEY(mediaID) REFERENCES media(mediaID),
    PRIMARY KEY(mediaID)
    );


CREATE TABLE IF NOT EXISTS withdrawals_history (
    id		INT AUTO_INCREMENT,
    mediaID	INT NOT NULL,
    withdrawnAt DATETIME NOT NULL,
    returnedAt 	DATETIME, 
    withdrawnBy NVARCHAR(255) NOT NULL,

    FOREIGN KEY(mediaID) REFERENCES media(mediaID),
    PRIMARY KEY(id)
    );


DROP TRIGGER IF EXISTS on_withdrawal;
DELIMITER //
CREATE TRIGGER on_withdrawal
AFTER INSERT ON withdrawals
    FOR EACH ROW
	BEGIN
	INSERT INTO withdrawals_history (mediaID, withdrawnAt, withdrawnBy)
	VALUES (NEW.mediaID, NEW.withdrawnAt, NEW.withdrawnBy);
    END//
DELIMITER ; 


DROP TRIGGER IF EXISTS on_return;
DELIMITER //
CREATE TRIGGER on_return
AFTER DELETE ON withdrawals
    FOR EACH ROW
	BEGIN
	UPDATE withdrawals_history 
	SET returnedAt = NOW()
	WHERE id = OLD.mediaID;
    END//
DELIMITER ;


