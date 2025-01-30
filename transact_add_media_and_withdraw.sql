--Diese Transaktion fügt ein neues Medium hinzu und aktualisiert die withdrawals-Tabelle.
DELIMITER $$

CREATE PROCEDURE add_media_and_withdraw(
    IN title_ NVARCHAR(255), 
    IN releaseDate_ DATE, 
    IN digital_ BOOL, 
    IN withdrawnBy_ NVARCHAR(255), 
    OUT mediaID_ INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Einfügen eines neuen Mediums
    INSERT INTO media (title, releaseDate, digital)
    VALUES (title_, releaseDate_, digital_);
    
    -- Abrufen der ID des eingefügten Mediums
    SET mediaID_ = LAST_INSERT_ID();

    -- Einfügen in die withdrawals-Tabelle
    INSERT INTO withdrawals (mediaID, withdrawnBy)
    VALUES (mediaID_, withdrawnBy_);

    COMMIT;
END $$

DELIMITER ;