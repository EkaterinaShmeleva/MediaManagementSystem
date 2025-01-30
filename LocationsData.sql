use mmsDB;

/*
Drei PCs  O-PC-1/2, CH-PC-1
USB-Speichermedien fangen mit USB an
 */
DELETE FROM locations;
INSERT INTO locations (locationID, label) VALUES 
( 1, 'O-SH-1' ),
( 2, 'O-SH-2' ),
( 3, 'O-SH-3' ),
( 4, 'O-SH-4' ),
( 5, 'O-PC-1' ),
( 6, 'O-PC-2' ),
( 7, 'O-DRAWER-1' ),
( 8, 'O-DRAWER-2' ),
( 9, 'O-DRAWER-3' ),
( 10,'O-DRAWER-4' ),
( 11, 'S-SH-1' ),
( 12, 'S-SH-2' ),
( 13, 'S-BOX-1' ),
( 14, 'S-BOX-2' ),
( 15, 'S-BOX-3' ),
( 16, 'S-BOX-4' ),
( 17, 'S-BOX-5' ),
( 18, 'S-BOX-6' ),
( 19, 'S-BOX-7' ),
( 20, 'S-BOX-8' ),
( 21, 'CE-BOX-1' ),
( 22, 'CE-BOX-2' ),
( 23, 'CE-BOX-3' ),
( 24, 'CE-BOX-4' ),
( 25, 'CE-BOX-5' ),
( 26, 'CE-BOX-6' ),
( 27, 'CE-BOX-7' ),
( 28, 'CE-BOX-8' ),
( 29, 'CH-BOX-1' ),
( 30, 'CH-PC-1' ),
( 31, 'CH-SH-1' ),
( 32, 'CH-SH-2' ),
( 33, 'USB-HDD-Toshiba 1TB'),
( 34, 'USB-SSD-Samsung 512GB'),
( 35, 'USB-Stick-Lukas-Blau'),
( 36, 'USB-Stick-Alex-ScanDisk')
;


DELETE FROM med_at_loc;
INSERT INTO med_at_loc (mediaID, locationID, fpath) VALUES 
( 1, 5, '/home/xb/films/good_stuff/inception.mp4'),
( 2, 5, '/home/xb/films/good_stuff/matrix/matrix.mov'),
( 5, 6, 'G:\\Filme\Pulp_Fiction\pulp_fiction.mp4'),
( 6, 6, 'G:\\Filme\The_Dark_Knight\dk.mp4'),
( 9, 33, 'Filme\The_Shawshank_Redemption\movie.mp4'),
( 10, 34, 'Filme\The_Lord_of_the_Rings_Complete_Trilogy\lotr-fellowship.mp4'),
( 11, 6, 'F:\\music\bohemian_rhapsody.mp3'),
( 12, 6, 'F:\\music\j.lennon/imagine.mp3'),
( 14, 35, 'm_jackson/track03.wav'),
( 16, 35, 'bob_dylan/track20.wav'),
( 18, 35, 'beatles/hey_jude.mp3'),
( 19, 36, 'prince/album01/purple_rain.mp3'),
( 20, 36, 'adele/track05.mp3')
;


