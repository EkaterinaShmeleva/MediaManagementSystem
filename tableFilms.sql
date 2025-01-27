use mmsdb;
CREATE TABLE films (
    mediaID INT UNIQUE NOT NULL,
    length int NOT NULL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
);

INSERT INTO films (mediaID, title, releaseDate, addedDate, digital) VALUES
(1, 'Inception', '2010-07-16', '2025-01-27', TRUE),
(2, 'The Matrix', '1999-03-31', '2025-01-27', TRUE),
(3, 'Interstellar', '2014-11-07', '2025-01-27', FALSE),
(4, 'The Godfather', '1972-03-24', '2025-01-27', FALSE),
(5, 'Pulp Fiction', '1994-10-14', '2025-01-27', TRUE),
(6, 'The Dark Knight', '2008-07-18', '2025-01-27', TRUE),
(7, 'Fight Club', '1999-10-15', '2025-01-27', FALSE),
(8, 'Forrest Gump', '1994-07-06', '2025-01-27', FALSE),
(9, 'The Shawshank Redemption', '1994-09-23', '2025-01-27', TRUE),
(10, 'The Lord of the Rings: The Fellowship of the Ring', '2001-12-19', '2025-01-27', TRUE);