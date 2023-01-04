-- album database
-- sqlite3 version
-- version 1.4 2018-04-04
--

--
-- Table structure for table album
--

DROP TABLE IF EXISTS album;
CREATE TABLE album (
  id INTEGER PRIMARY KEY,
  title TEXT,
  artist TEXT,
  label TEXT,
  released TEXT
);

--
-- Table structure for table track
--

DROP TABLE IF EXISTS track;
CREATE TABLE track (
  id INTEGER PRIMARY KEY,
  album_id INTEGER,
  title TEXT DEFAULT NULL,
  track_number INTEGER DEFAULT NULL,
  duration INTEGER DEFAULT NULL
);

--
-- Insert data for table album
--

BEGIN;
INSERT INTO album (id, title, artist, label, released) VALUES (1,'Two Men with the Blues','Willie Nelson and Wynton Marsalis','Blue Note','2008-07-08');
INSERT INTO album (id, title, artist, label, released) VALUES (11,'Hendrix in the West','Jimi Hendrix','Polydor','1972-01-00');
INSERT INTO album (id, title, artist, label, released) VALUES (12,'Rubber Soul','The Beatles','Parlophone','1965-12-03');
INSERT INTO album (id, title, artist, label, released) VALUES (13,'Birds of Fire','Mahavishnu Orchestra','Columbia','1973-03-00');
INSERT INTO album (id, title, artist, label, released) VALUES (16,'Live And','Johnny Winter','Columbia','1971-05-00');
INSERT INTO album (id, title, artist, label, released) VALUES (17,'Apostrophe','Frank Zappa','DiscReet','1974-04-22');
INSERT INTO album (id, title, artist, label, released) VALUES (18,'Kind of Blue','Miles Davis','Columbia','1959-08-17');

--
-- Insert data for table track
--

INSERT INTO track (id, album_id, title, track_number, duration) VALUES (1,1,'Bright Lights Big City',1,320);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (2,1,'Night Life',2,344);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (3,1,'Basin Street Blues',5,296);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (4,1,'Caldonia',3,205);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (5,1,'Stardust',4,308);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (6,1,'Georgia On My Mind',6,280);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (7,1,'Rainy Day Blues',7,343);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (8,1,'My Bucket''s Got A Hole In It',8,296);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (9,1,'Ain''t Nobody''s Business',9,447);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (10,1,'That''s All',10,368);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (15,11,'Lover Man',2,185);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (14,11,'Johnny B. Goode',1,285);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (16,11,'Blue Suede Shoes',3,266);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (17,11,'Voodoo Chile',4,469);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (18,11,'The Queen',5,160);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (19,11,'Sgt. Pepper''s Lonely Hearts Club Band',6,76);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (20,11,'Little Wing',7,194);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (21,11,'Red House',8,786);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (22,12,'Drive My Car',1,150);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (23,12,'Norwegian Wood (This Bird Has Flown)',2,125);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (24,12,'You Won''t See Me',3,202);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (25,12,'Nowhere Man',4,164);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (26,12,'Think for Yourself',5,139);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (27,12,'The Word',6,163);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (28,12,'Michelle',7,162);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (29,12,'What Goes On',8,170);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (30,12,'Girl',9,153);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (31,12,'I''m Looking Through You',10,147);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (32,12,'In My Life',11,147);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (33,12,'Wait',12,136);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (34,12,'If I Needed Someone',13,143);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (35,12,'Run for Your Life',14,138);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (37,13,'Birds of Fire',1,350);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (38,13,'Miles Beyond',2,287);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (39,13,'Celestial Terrestrial Commuters',3,174);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (40,13,'Sapphire Bullets of Pure Love',4,24);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (41,13,'Thousand Island Park',5,203);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (42,13,'Hope',6,119);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (43,13,'One Word',7,597);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (44,13,'Sanctuary',8,305);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (45,13,'Open Country Joy',9,236);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (46,13,'Resolution',10,129);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (51,16,'It''s My Own Fault',2,734);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (50,16,'Good Morning Little Schoolgirl',1,285);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (52,16,'Jumpin'' Jack Flash',3,266);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (53,16,'Rock And Roll Medley',4,406);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (54,16,'Mean Town Blues',5,539);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (55,16,'Johnny B. Goode',6,202);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (56,17,'Don''t Eat the Yellow Snow',1,127);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (57,17,'Nanook Rubs It',2,278);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (58,17,'St. Alfonzo''s Pancake Breakfast',3,110);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (59,17,'Father O''Blivion',4,138);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (60,17,'Cosmik Debris',5,254);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (61,17,'Excentrifugal Forz',6,93);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (62,17,'Apostrophe',7,350);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (63,17,'Uncle Remus',8,164);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (64,17,'Stink-Foot',9,393);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (65,18,'So What',1,565);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (66,18,'Freddy Freeloader',2,589);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (67,18,'Blue in Green',3,338);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (68,18,'All Blues',4,696);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (69,18,'Flamenco Sketches',5,566);
INSERT INTO track (id, album_id, title, track_number, duration) VALUES (70,11,'Fake Track',9,549);
COMMIT;

