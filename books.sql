USE mmsDB;

CREATE TABLE books (
	
	mediaID	INT				UNIQUE NOT NULL,
	author	VARCHAR(255)
	ISBN		VARCHAR(255)
	
	FOREIGN KEY mediaID REFERENCES mmsDB.media(mediaID)

);



BEGIN TRANSACTION;

INSERT INTO media
(mediaID, title, releaseDate, addedDate, digital)
VALUES 
();

DECLARE @IDadded = LAST_INSERT_ID();

INSERT INTO books 
(mediaID, author)
VALUES
(@IDadded, 'Cho Nam-Joo', '0000');


COMMIT;

"Wo ich wohne ist, der Mond ganz nah", "Cho Nam-Joo", 2024-01-11,
"Der Herr der Ringe", "J.R.R. Tolkien", 2019-08-24,
"Die Säulen der Erde", "Ken Follett", 2000-01-01,
"Ilias Odyssee", "Homer", 2002-09-01,
"Dreizehn lustige Erzählungen", "Anton Tschechow", 1992-01-01,
"Ein Sommernachtstraum", "William Shakespeare", 1998-04-01,
"Schuld und Sühne", "Fjodor M. Dostojewski", 1997-07-01,