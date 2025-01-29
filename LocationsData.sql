use mmsDB;

/*
Drei PCs  O-PC-1/2, CH-PC-1
USB-Speichermedien fangen mit USB an
 */
DELETE FROM locations;
INSERT INTO locations (label) VALUES 
( 'O-SH-1' ),
( 'O-SH-2' ),
( 'O-SH-3' ),
( 'O-SH-4' ),
( 'O-PC-1' ),
( 'O-PC-2' ),
( 'O-DRAWER-1' ),
( 'O-DRAWER-2' ),
( 'O-DRAWER-3' ),
( 'O-DRAWER-4' ),
( 'S-SH-1' ),
( 'S-SH-2' ),
( 'S-BOX-1' ),
( 'S-BOX-2' ),
( 'S-BOX-3' ),
( 'S-BOX-4' ),
( 'S-BOX-5' ),
( 'S-BOX-6' ),
( 'S-BOX-7' ),
( 'S-BOX-8' ),
( 'CE-BOX-1' ),
( 'CE-BOX-2' ),
( 'CE-BOX-3' ),
( 'CE-BOX-4' ),
( 'CE-BOX-5' ),
( 'CE-BOX-6' ),
( 'CE-BOX-7' ),
( 'CE-BOX-8' ),
( 'CH-BOX-1' ),
( 'CH-PC-1' ),
( 'CH-SH-1' ),
( 'CH-SH-2' ),
( 'USB-HDD-Toshiba 1TB'),
( 'USB-SSD-Samsung 512GB'),
( 'USB-Stick-Lukas-Blau'),
( 'USB-Stick-Alex-ScanDisk')
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


