-- test database
-- sqlite3 version
-- version 1.4 2018-04-04

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
    id              INTEGER PRIMARY KEY, 
    name            TEXT,
    address         TEXT,
    city            TEXT,
    state           TEXT,
    zip             TEXT
);

DROP TABLE IF EXISTS item;
CREATE TABLE item (
    id              INTEGER PRIMARY KEY,
    name            TEXT,
    description     TEXT
);

DROP TABLE IF EXISTS sale;
CREATE TABLE sale (
    id              INTEGER PRIMARY KEY,
    item_id         INTEGER,
    customer_id     INTEGER,
    date            TEXT,
    quantity        INTEGER,
    price           INTEGER     -- in cents
);

BEGIN;
INSERT INTO customer ( id, name, address, city, state, zip ) VALUES ( 1, 'Bill Smith', '123 Main Street', 'Hope', 'CA', '98765' );
INSERT INTO customer ( id, name, address, city, state, zip ) VALUES ( 2, 'Mary Smith', '123 Dorian Street', 'Harmony', 'AZ', '98765' );
INSERT INTO customer ( id, name, address, city, state, zip ) VALUES ( 3, 'Bob Smith', '123 Laugh Street', 'Humor', 'CA', '98765' );

INSERT INTO item ( id, name, description ) VALUES ( 1, 'Box of 64 Pixels', '64 RGB pixels in a decorative box' );
INSERT INTO item ( id, name, description ) VALUES ( 2, 'Sense of Humor', 'Especially dry. Imported from England.' );
INSERT INTO item ( id, name, description ) VALUES ( 3, 'Beauty', 'Inner beauty. No cosmetic surgery required!' );
INSERT INTO item ( id, name, description ) VALUES ( 4, 'Bar Code', 'Unused. In original packaging.' );

INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 1, 1, 2, '2009-02-27', 3, 2995 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 2, 2, 2, '2009-02-27', 1, 1995 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 3, 1, 1, '2009-02-28', 1, 2995 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 4, 4, 3, '2009-02-28', 2, 999 );
INSERT INTO sale ( id, item_id, customer_id, date, quantity, price ) VALUES ( 5, 1, 2, '2009-02-28', 1, 2995 );
COMMIT;


