SELECT * FROM Country;
SELECT * FROM Country WHERE Continent = 'Europe';
SELECT 'Hello, world!';
SELECT 'Hello, world!' AS Result;
SELECT * FROM Country ORDER BY Name;
SELECT Name, LifeExpectancy AS "Life Expectancy" FROM Country ORDER BY Name;
SELECT Name, Continent, Region FROM Country;
SELECT Name, Continent, Region FROM Country WHERE Continent = 'Asia';
SELECT Name, Continent, Region FROM Country WHERE Continent = 'Asia' ORDER BY Name LIMIT 5;
SELECT Name, Continent, Region FROM Country WHERE Continent = 'Asia' ORDER BY Name LIMIT 5 OFFSET 5;
SELECT Name AS Negara, Region AS Wilayah, Continent AS Benua FROM Country;
SELECT COUNT(*) FROM Country WHERE Population > 100000000;
SELECT Name FROM Country WHERE Population > 100000000;
SELECT * FROM Customer;
INSERT INTO Customer (name, address, city, state, zip)
    VALUES ('Fredd Flinstone', '123 Cobblestone Way', 'Bedrock', 'CA', '91234');
INSERT INTO Customer (name, address, city, state, zip)
    VALUES ('Rizky Ashari', '123 Cobblestone Way', 'Bedrock', 'CA', '91234');
SELECT * FROM Customer;
    UPDATE Customer SET address = 'Gang Rasim 8' WHERE id = 6;
SELECT * FROM Customer;
    UPDATE Customer SET address = 'Gang Rasim 8', city = 'Jakarta' WHERE id = 11;
SELECT * FROM Customer;
    UPDATE Customer SET address = 'Gang Rasim 10', city = 'Jakarta' WHERE id = 5;
SELECT * FROM Customer;
    DELETE FROM Customer WHERE id >= 7;
SELECT * FROM Customer;
    UPDATE Customer SET address = 'Pundensari', city = 'Tulungagung', state = 'Jatim', zip = '66293' WHERE id = 4;
CREATE TABLE test (
    a INTEGER,
    b TEXT
);
INSERT INTO test VALUES ( 1,  'Rizky');
INSERT INTO test VALUES ( 2,  'Ashari');
INSERT INTO test VALUES ( 2,  'Ganteng');
SELECT * FROM test;
DELETE FROM test WHERE a = 2;
SELECT * FROM test;
INSERT INTO test VALUES ( 2,  'Ganteng');
SELECT * FROM test;
DROP TABLE test;
DROP TABLE IF EXISTS test;
CREATE TABLE test ( id Integer, Name Text, City Text, Email Text );
INSERT INTO test VALUES ( 1, 'Rizky Ashari', 'Tulungagung', 'muhrizkyashari@gmail.com' );
INSERT INTO test VALUES ( 2, 'Yusuf Arico', 'Jakarta', 'ysfarcp@gmail.com' );
INSERT INTO test VALUES ( 3, 'Tunggul Mirza', 'Sidoarjo', 'tunggulmp@gmail.com' );
INSERT INTO test (id, Name, City) VALUES ( 4, 'Erwin Fernanda', 'Sidoarjo' );
UPDATE test SET City = 'Solo' WHERE id = 4;
UPDATE test SET Email = 'erwinf@zenius.com' WHERE id = 4;
SELECT * FROM test;
DROP TABLE IF EXISTS test;
CREATE TABLE test ( id Integer, Name Text UNIQUE, City Text, Email Text, Citizen Text Default 'Indonesian' );
INSERT INTO test ( id, Name, City, Email ) VALUES ( 1, 'Rizky Ashari', 'Tulungagung', 'muhrizkyashari@gmail.com' );
INSERT INTO test ( id, Name, City, Email ) VALUES ( 2, 'Yusuf Arico', 'Jakarta', 'ysfarcp@gmail.com' );
INSERT INTO test ( id, Name, City, Email ) VALUES ( 2, 'Excobar Arman', 'Makassar', 'excobararman@gmail.com' );
SELECT * FROM test;
ALTER TABLE test ADD Kelamin Text DEFAULT 'Male';
SELECT * FROM test;
DROP TABLE IF EXISTS test;
CREATE TABLE test ( id Integer PRIMARY KEY, Name Text UNIQUE, City Text, Email Text, Citizen Text Default 'Indonesian', Sex Text Default 'Male' );
INSERT INTO test ( Name, City, Email ) VALUES ( 'Rizky Ashari', 'Tulungagung', 'muhrizkyashari@gmail.com' );
INSERT INTO test ( Name, City, Email ) VALUES ( 'Yusuf Arico', 'Jakarta', 'ysfarcp@gmail.com' );
INSERT INTO test ( Name, City, Email ) VALUES ( 'Excobar Arman', 'Makassar', 'excobararman@gmail.com' );
SELECT * FROM test;
SELECT Name, Continent, Population FROM Country
    WHERE Population > 100000000 OR Population IS NULL ORDER BY Population DESC;
SELECT Name, Continent, Population FROM Country
    WHERE Name LIKE '%sia%' ORDER BY Population;
SELECT Name, Continent, Population FROM Country
    WHERE Continent IN ('Asia') ORDER BY Name;
SELECT Distinct Continent FROM Country;
SELECT Name, Continent, Region FROM Country ORDER BY Continent DESC, Region, Name;
CREATE TABLE booltest ( id INTEGER PRIMARY KEY, Name Text, Age Integer );
INSERT INTO booltest (Name, Age) VALUES ( 'Ashari', 23 );
INSERT INTO booltest (Name, Age)  VALUES ( 'Ucup', 22 );
INSERT INTO booltest (Name, Age)  VALUES ( 'Tunggul', 22 );
SELECT * FROM booltest;
SELECT
    CASE Age WHEN 23 THEN 'Di atas 22' ELSE 'Di bawah 23' END AS Keterangan
    FROM booltest;
SELECT s.id AS sale, s.date, i.description, i.name, s.price
    FROM sale AS s
    JOIN item AS i ON s.item_id = i.id
    ;
SELECT c.name AS Cust, c.zip, i.name AS Item, i.description, s.quantity AS Quan, s.price AS Price
    FROM customer AS c
    LEFT JOIN sale as s ON s.customer_id = c.id
    LEFT JOIN item as i ON s.item_id = i.id
    ORDER BY Cust, Item
    ;
SELECT Name, LENGTH(Name) AS Len FROM City ORDER BY Len DESC, Name;
SELECT released,
    SUBSTR(released, 1, 4) AS Year,
    SUBSTR(released, 6, 2) AS Month,
    SUBSTR(released, 9, 2) AS Day
    FROM album ORDER BY released
    ;
SELECT TRIM('    string    ');
SELECT LTRIM('    string    ');
SELECT RTRIM('    string    ');
SELECT RTRIM('...string...', '.');
SELECT 'StRiNg' = 'string';
SELECT LOWER('StRiNg') = LOWER('string');
SELECT UPPER('StRiNg') = UPPER('string');
SELECT UPPER(Name) FROM City ORDER BY Name;
SELECT LOWER(Name) FROM City ORDER BY Name;
-- 02 typeof

SELECT TYPEOF( 1 + 1 );
SELECT TYPEOF( 1 + 1.0 );
SELECT TYPEOF('panda');
SELECT TYPEOF('panda' + 'koala');

-- 03 INTEGER division

SELECT 1 / 2;
SELECT 1.0 / 2;
SELECT CAST(1 AS REAL) / 2;
SELECT 17 / 5;
SELECT 17 / 5, 17 % 5;


-- 04 ROUND()

SELECT 2.55555;
SELECT ROUND(2.55555);
SELECT ROUND(2.55555, 3);
SELECT ROUND(2.55555, 0);
-- 02 DATE/TIME functions
-- :memory:

SELECT DATETIME('now');
SELECT DATE('now');
SELECT TIME('now');
SELECT DATETIME('now', '+1 day');
SELECT DATETIME('now', '+3 days');
SELECT DATETIME('now', '-1 month');
SELECT DATETIME('now', '+1 year');
SELECT DATETIME('now', '+3 hours', '+27 minutes', '-1 day', '+3 years');
-- 01 Aggregate Data
-- world.db

SELECT COUNT(*) FROM Country;

SELECT Region, COUNT(*)
  FROM Country
  GROUP BY Region
;

SELECT Region, COUNT(*) AS Count
  FROM Country
  GROUP BY Region
  ORDER BY Count DESC, Region
;

-- album.db

SELECT a.title AS Album, COUNT(t.track_number) as Tracks
  FROM track AS t
  JOIN album AS a
    ON a.id = t.album_id
  GROUP BY a.id
  ORDER BY Tracks DESC, Album
;

SELECT a.title AS Album, COUNT(t.track_number) as Tracks
  FROM track AS t
  JOIN album AS a
    ON a.id = t.album_id
  GROUP BY a.id
  HAVING Tracks >= 10
  ORDER BY Tracks DESC, Album
;

SELECT a.title AS Album, COUNT(t.track_number) as Tracks
  FROM track AS t
  JOIN album AS a
    ON a.id = t.album_id
  WHERE a.artist = 'The Beatles'
  GROUP BY a.id
  HAVING Tracks >= 10
  ORDER BY Tracks DESC, Album
;

-- 02 Aggregate functions
-- world.db
SELECT COUNT(*) FROM Country;
SELECT COUNT(Population) FROM Country;
SELECT AVG(Population) FROM Country;
SELECT Region, AVG(Population) FROM Country GROUP BY Region;
SELECT Region, MIN(Population), MAX(Population) FROM Country GROUP BY Region;
SELECT Region, SUM(Population) FROM Country GROUP BY Region;

-- 03 DISTINCT Aggregates
-- world.db

SELECT COUNT(HeadOfState) FROM Country;
SELECT HeadOfState FROM Country ORDER BY HeadOfState;
SELECT COUNT(DISTINCT HeadOfState) FROM Country;
-- 02 transactions
-- test.db

CREATE TABLE widgetInventory (
  id INTEGER PRIMARY KEY,
  description TEXT,
  onhand INTEGER NOT NULL
);

CREATE TABLE widgetSales (
  id INTEGER PRIMARY KEY,
  inv_id INTEGER,
  quan INTEGER,
  price INTEGER
);

INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'rock', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'paper', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'scissors', 25 );

SELECT * FROM widgetInventory;
SELECT * FROM widgetSales;

BEGIN TRANSACTION;
INSERT INTO widgetSales ( inv_id, quan, price ) VALUES ( 1, 5, 500 );
UPDATE widgetInventory SET onhand = ( onhand - 5 ) WHERE id = 1;
END TRANSACTION;

BEGIN TRANSACTION;
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'toy', 25 );
ROLLBACK;
SELECT * FROM widgetInventory;

-- restore database
DROP TABLE IF EXISTS widgetInventory;
DROP TABLE IF EXISTS widgetSales;

-- 03 performance
-- test.db

CREATE TABLE test ( id INTEGER PRIMARY KEY, data TEXT );

-- put this before the 1,000 INSERT statements
BEGIN TRANSACTION;

-- copy / paste 1,000 of these ...
INSERT INTO test ( data ) VALUES ( 'this is a good sized line of text.' );

-- put this after the 1,000 INSERT statements
END TRANSACTION;

SELECT COUNT(*) FROM test;

-- restore database
DROP TABLE test;
-- 01 update triggers
-- test.db

CREATE TABLE widgetCustomer ( id INTEGER PRIMARY KEY, name TEXT, last_order_id INT );
CREATE TABLE widgetSale ( id INTEGER PRIMARY KEY, item_id INT, customer_id INT, quan INT, price INT );

INSERT INTO widgetCustomer (name) VALUES ('Bob');
INSERT INTO widgetCustomer (name) VALUES ('Sally');
INSERT INTO widgetCustomer (name) VALUES ('Fred');

SELECT * FROM widgetCustomer;

CREATE TRIGGER newWidgetSale AFTER INSERT ON widgetSale
    BEGIN
        UPDATE widgetCustomer SET last_order_id = NEW.id WHERE widgetCustomer.id = NEW.customer_id;
    END
;

INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);
SELECT * FROM widgetSale;
SELECT * FROM widgetCustomer;

-- 02 preventing updates
-- test.db

DROP TABLE IF EXISTS widgetSale;

CREATE TABLE widgetSale ( id integer primary key, item_id INT, customer_id INTEGER, quan INT, price INT,
    reconciled INT );
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (1, 3, 5, 1995, 0);
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (2, 2, 3, 1495, 1);
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (3, 1, 1, 2995, 0);
SELECT * FROM widgetSale;

CREATE TRIGGER updateWidgetSale BEFORE UPDATE ON widgetSale
    BEGIN
        SELECT RAISE(ROLLBACK, 'cannot update table "widgetSale"') FROM widgetSale
            WHERE id = NEW.id AND reconciled = 1;
    END
;

BEGIN TRANSACTION;
UPDATE widgetSale SET quan = 9 WHERE id = 2;
END TRANSACTION;

SELECT * FROM widgetSale;

-- 03 timestamps
-- test.db

DROP TABLE IF EXISTS widgetSale;
DROP TABLE IF EXISTS widgetCustomer;

CREATE TABLE widgetCustomer ( id integer primary key, name TEXT, last_order_id INT, stamp TEXT );
CREATE TABLE widgetSale ( id integer primary key, item_id INT, customer_id INTEGER, quan INT, price INT, stamp TEXT );
CREATE TABLE widgetLog ( id integer primary key, stamp TEXT, event TEXT, username TEXT, tablename TEXT, table_id INT);

INSERT INTO widgetCustomer (name) VALUES ('Bob');
INSERT INTO widgetCustomer (name) VALUES ('Sally');
INSERT INTO widgetCustomer (name) VALUES ('Fred');
SELECT * FROM widgetCustomer;

CREATE TRIGGER stampSale AFTER INSERT ON widgetSale
    BEGIN
        UPDATE widgetSale SET stamp = DATETIME('now') WHERE id = NEW.id;
        UPDATE widgetCustomer SET last_order_id = NEW.id, stamp = DATETIME('now')
            WHERE widgetCustomer.id = NEW.customer_id;
        INSERT INTO widgetLog (stamp, event, username, tablename, table_id)
            VALUES (DATETIME('now'), 'INSERT', 'TRIGGER', 'widgetSale', NEW.id);
    END
;

INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);

SELECT * FROM widgetSale;
SELECT * FROM widgetCustomer;
SELECT * FROM widgetLog;

-- restore database
DROP TRIGGER IF EXISTS newWidgetSale;
DROP TRIGGER IF EXISTS updateWidgetSale;
DROP TRIGGER IF EXISTS stampSale;

DROP TABLE IF EXISTS widgetCustomer;
DROP TABLE IF EXISTS widgetSale;
DROP TABLE IF EXISTS widgetLog;
-- 01 simple subselect
-- world.db

CREATE TABLE t ( a TEXT, b TEXT );
INSERT INTO t VALUES ( 'NY0123', 'US4567' );
INSERT INTO t VALUES ( 'AZ9437', 'GB1234' );
INSERT INTO t VALUES ( 'CA1279', 'FR5678' );
SELECT * FROM t;

SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode, 
  SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t;

SELECT co.Name, ss.CCode FROM (
    SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS SCode,
      SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CCode FROM t
  ) AS ss
  JOIN Country AS co
    ON co.Code2 = ss.Country
;

DROP TABLE t;

-- 02 searching within a result set
-- album.db

SELECT DISTINCT album_id FROM track WHERE duration <= 90;

SELECT * FROM album
  WHERE id IN (SELECT DISTINCT album_id FROM track WHERE duration <= 90)
;

SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.duration AS secs
  FROM album AS a
  JOIN track AS t
    ON t.album_id = a.id
  WHERE a.id IN (SELECT DISTINCT album_id FROM track WHERE duration <= 90)
  ORDER BY a.title, t.track_number
;

SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.duration AS secs
  FROM album AS a
  JOIN (
    SELECT DISTINCT album_id, track_number, duration, title
      FROM track
      WHERE duration <= 90
  ) AS t
    ON t.album_id = a.id
  ORDER BY a.title, t.track_number
;

-- 03 Creating a view
-- album.db

SELECT id, album_id, title, track_number, 
  duration / 60 AS m, duration % 60 AS s FROM track;

CREATE VIEW trackView AS
  SELECT id, album_id, title, track_number, 
    duration / 60 AS m, duration % 60 AS s FROM track;
SELECT * FROM trackView;

SELECT a.title AS album, a.artist, t.track_number AS seq, t.title, t.m, t.s
  FROM album AS a
  JOIN trackView AS t
    ON t.album_id = a.id
  ORDER BY a.title, t.track_number
;

DROP VIEW IF EXISTS trackView;

-- 04 Joined view
-- album.db

SELECT a.artist AS artist,
    a.title AS album,
    t.title AS track,
    t.track_number AS trackno,
    t.duration / 60 AS m,
    t.duration % 60 AS s
  FROM track AS t
    JOIN album AS a
      ON a.id = t.album_id
;

CREATE VIEW joinedAlbum AS
  SELECT a.artist AS artist,
      a.title AS album,
      t.title AS track,
      t.track_number AS trackno,
      t.duration / 60 AS m,
      t.duration % 60 AS s
    FROM track AS t
    JOIN album AS a
      ON a.id = t.album_id
;

SELECT * FROM joinedAlbum;
SELECT * FROM joinedAlbum WHERE artist = 'Jimi Hendrix';

SELECT artist, album, track, trackno, 
   m || ':' || substr('00' || s, -2, 2) AS duration
    FROM joinedAlbum;

DROP VIEW IF EXISTS joinedAlbum;







