use mmsdb;
CREATE TABLE music (
    mediaID INT UNIQUE NOT NULL,
    title NVARCHAR(255) NOT NULL,
    artist NVARCHAR(255) NOT NULL,
    releaseDate DATE,
    addedDate DATE,
    digital BOOL,
    PRIMARY KEY (mediaID),
    FOREIGN KEY (mediaID) REFERENCES media(mediaID)
);

INSERT INTO music (mediaID, title, artist, releaseDate, addedDate, digital) VALUES
(11, 'Bohemian Rhapsody', 'Queen', '1975-10-31', '2025-01-27', TRUE),
(12, 'Imagine', 'John Lennon', '1971-10-11', '2025-01-27', TRUE),
(13, 'Hotel California', 'Eagles', '1976-12-08', '2025-01-27', FALSE),
(14, 'Billie Jean', 'Michael Jackson', '1983-01-02', '2025-01-27', TRUE),
(15, 'Smells Like Teen Spirit', 'Nirvana', '1991-09-10', '2025-01-27', FALSE),
(16, 'Like a Rolling Stone', 'Bob Dylan', '1965-07-20', '2025-01-27', TRUE),
(17, 'What a Wonderful World', 'Louis Armstrong', '1967-10-18', '2025-01-27', FALSE),
(18, 'Hey Jude', 'The Beatles', '1968-08-26', '2025-01-27', TRUE),
(19, 'Purple Rain', 'Prince', '1984-06-25', '2025-01-27', TRUE),
(20, 'Rolling in the Deep', 'Adele', '2010-11-29', '2025-01-27', TRUE);