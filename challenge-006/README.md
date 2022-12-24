# SQL Code Challenges

## Introduction

- DB files

  - restaurant.db
  - library.db

- We will be using `DB Browser for SQLite`

## 1. In the Restaurant

### 1.1: Create invitations for a party

- Email template:
  To: Steffie Kleis
  At: skleis7@wisdompets.com

  "Hello Steffie- We'd love to see you at the five year anniversary for Nadia's Garden..."

- Challenge

  - Generate a list of customer information.
    - First Name
    - Last Name
    - Email
    - Alphabetical Order on Last Name

- Solution:

  ```
  SELECT FirstName, LastName, Email FROM Customers ORDER BY LastName;
  ```

### 1.2: Create a table to store information

- Email template:

  To: Steffie Kleis
  At: skleis7@wisdompets.com

  "Hi- I'd love to be there! There will be 4 of us attending."

- Challenge:

  - Create a table to store response info.

    - CustomerID
    - PartySize

  - Just focus on creating the table.

- Solution:

  ```
  CREATE TABLE AnniversaryAttendees ("CustomerID" INT, "PartySize" INT);
  ```

### 1.3: Print a menu

- Challenge

  - Create three menus

    - All items sorted by price, low to high
    - Appetizers and beverages, by type
    - All items except beverage, by type

- Solution:

  ```
  SELECT * FROM Dishes ORDER BY Price;
  ```

  ```
  SELECT * FROM Dishes WHERE Type="Appetizer" OR Type="Beverage" ORDER BY Type;
  ```

  ```
  SELECT * FROM Dishes WHERE Type != "Beverage" ORDER BY Type;
  ```

### 1.4: Sign a customer up for your loyalty program

- Challenge:

  - Add customer information into our database

  - INSERT
  - Our table already creates new unique Customer IDs

  - Customers
    - FirstName
    - LastName
    - Email
    - Address
    - City
    - State
    - Phone
    - Birthday

- Solution:

  ```
  INSERT INTO Customers
    (FirstName, LastName, Email, Address, City, State, Phone, Birthday)
    VALUES
    ("Anna", "Smith", "asmith@kinetecoinc.com", "47u9 Lapis Dr.", "Memphis", "TN", "(555) 555-1212", "1973-07-21");
  ```

### 1.5: Update a customer's personal information

- Email tempalte:

  Talyor Jenkins
  Old: 27170 6th Ave., Washington, DC
  New: 74 Pine St., New York, NY

- UPDATE
- Challenge:

  - Update the customer's address.

- Solution:

  ```
  SELECT CustomerID, FirstName, LastName, Address
  FROM Custoemrs
  WHERE FirstName = "Taylor" AND LastName = "Jenkins";
  ```

  ```
  UPDATE Customers SET
    Address="74 Pine St.",
    City="New York",
    State="NY"
  WHERE CustomerID="26"
  ```

### 1.6: Remove a customer's record

- Email template:
  To: you@example.com
  From: tjenkins@rouxacademy.org
  Subject: I'm moving! :(

  Body: Hi! I've loved your restaurant for years, but I'm moving out of the area and would like to be removed from your email list. Thanks for all the great meals and memories! I'll miss the Salmon Caesar Salad the most!

  Sincerely,
  Taylor Jenkins
  954-555-7424

- DELETE

- Challenge:

  - Delete this customer form the Customers table.

- Solution:

  ```
  SELECT * FROM Customers WHERE FirstName="Taylor" AND LastName="Jenkins";
  ```

  ```
  DELETE FROM Customers WHERE CustomerID="4";
  ```

### 1.7: Log customer responses

- Email template:

  To: you@example.com
  From: atapley2j@kinetecoinc.com
  Subject: I'm moving!:(

  Body: Hi! I was so happy to hear it's already been five years! How time flies!

  I plan to attend the celebration, and I'll bring three friends, too!

  Best,
  Asher Tapley

- Approach:

  1. Manually look up a customer in the Customers table.
  2. Write a statement that will look them up for us.

- Challenge:

  - Using the customer's email address, find their ID and enter their party size into the AnniversaryAttendees table.

- Solution:

  ```
  INSERT INTO AnniversaryAttendees
    (CustomerID, PartySize)
    VALUES
    ((SELECT CustomerID FROM Customers WHERE Email="atapley2j@kinetecoinc.com"), "4");
  ```

### 1.8: Look up reservations

- SEARCH FOR:
  STE??????N
  STEVENSON
  STEPHENSON
  STEVENSEN
  STEPHENSEN

- Literal match

  ```
  SELECT ... WHERE FirstName='Stevenson' OR FirstName='Stephenson' OR ...
  ```

  - There's a better way...

- Challenge:

  - Search for a reservation by name, and look for similarity.

- Schema Reminder

  - RESERVATIONS

    - ReservationID
    - CustomerID
    - Date

  - CUSTOMERS
    - CustomerID
    - FirstName
    - LastName

- Solution:

  ```
  SELECT
    Customers.FirstName,
    Customers.LastName,
    Reservations.Date,
    Reservations.PartySize
  FROM Reservations
  JOIN Customers
    ON Customers.CustomerID = Reservations.CustomerID
  WHERE Customers.LastName LIKE "Ste%"
  ```

### 1.9: Take a reservation

- Challenge:

  - Create a Reservation

    - Sam McAdams - 14 July 2020, 6PM (5 people)
    - smac@kinetecoinc.com / (555) 555-1212

  - Don't worry about available times for capacity.

- Solution:

  ```
  SELECT * FROM Customers WHRE Email="smac@kinetecoinc.com"
  ```

  ```
  INSERT INTO Customers
    (FirstName, LastName, Email, Phone)
    VALUES
    ("Sam", "McAdams", 'smac@kinetecoinc.com", "(555) 555-1232");
  ```

  ```
  INSERT INTO Reservations
    (CustomerID, Date, PartySize)
    VALUES
    ("102", "2020-06-14 18:00:00", "5");
  ```

  ```
  SELECT
    Customers.FirstName,
    Customers.LastName,
    Customers.Email,
    Reservations.Date,
    Reservations.PartySize
  FROM Customers
  JOIN Reservations ON Customers.CustomerID=Reservations.CustomerID
  WHERE Customers.Email="smac@kinetecoinc.com";
  ```

### 1.10: Take a delivery order

- Email template:
  For: Loretta Hundey,
  6939 Elka Place
  House Salad
  Mini Cheeseburgers
  Tropical Blue Smoothie

- Schema Reminder:

  - Customers
    - CustomerID|FirstName|LastName|...
  - Dishes
    - DishID|Name|Price
  - Orders
    - OrderID|CustomerID|Order Date
  - OrdersDishes
    - OrderID|DishID

- Challenge:

  - Create an order
  - Find the customer
  - Create the order record
  - Add items to the order
  - Find the total cost

- Solution:

  ```
  SELECT CustomerID, FirstName, LastName, Phone
  FROM Customers
  WHERE Address="6939 Elka Place" AND LastName="Hundey";
  ```

  ```
  INSERT INTO Orders (CustomerID, OrderDate) VALUES (70, "2020-03-20 14:00:00");
  ```

  ```
  SELECT * FROM Orders WHERE CustomerID="70" ORDER BY OrderDate DESC;
  ```

  ```
  INSERT INTO OrdersDishes (OrderID, DishID) VALUES
    ("1001", (SELECT DishID FROM Dishes WHERE Name="House Salad")),
    ("1001", (SELECT DishID FROM Dishes WHERE Name="Mini Cheeseburgers")),
    ("1001", (SELECT DishID FROM Dishes WHERE Name="Tropical Blue Smoothie"));
  ```

  ```
  SELECT SUM(Dishes.Price)
  FROM Dishes
  JOIN OrdersDishes
    ON Dishes.DishID = OrdersDishes.DishID WHERE OrdersDishes.OrderID="1001";
  ```

### 1.11: Track your customer's favorite dishes

- Email template
  `Cleo Goldwater`, it's your birthday!
  To celebrate, use this coupon for 50% off a `Quinoa Salmon Salad`

- Approach:

  - Separate table
  - Unique ID for dish
  - Use that Unique ID, that foreign key, on the Customers table

- Challenge:

  - Set `Cleo Goldwater`'s favorite dish to `Quinoa Salmon Salad`

- Solution:

  ```
  SELECT DishID FROM Dishes WHERE Name="Quinoa Salmon Salad";
  ```

  ```
  SELECT * FROM Customers WHERE FirstName="Cleo" AND LastName="Goldwater";
  ```

  ```
  UPDATE Customers
  SET FavoriteDish=(SELECT DishID FROM Dishes WHERE Name="quinoa Salmon Salad")
  WHERE CustomerID="42";
  ```

  ```
  SELECT
    Customers.FirstName,
    Customers.LastName,
    Customers.FavoriteDish,
    Dishes.Name
    FROM Customers
    JOIN Dishes ON Customers.FavoriteDish=Dishes.DishID
  ```

### 1.12: Prepare a report of your top five customers

- Email template:

  [Customer], you're one of our favorite customers! Enjoy this 15% off coupon for your next order!

- Challenge:

  - Generate a list of the five customers who have placed the most to-go orders.
  - Number of orders
  - First and last name, email
  - Sorted by number of orders

- Use both

  - Customers table
  - Orders table

- Solution:

  ```
  SELECT
    COUNT(Orders.OrderID) AS OrderCount,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email
  FROM Orders
  JOIN Customers
    ON Orders.CustomerID=Customers.CustomerID
  GROUP BY Orders.CustomerID
  ORDER BY OrderCount DESC
  LIMIT 5;
  ```

## 2. At the Library

### 2.1: Check book availability

- Books out on loan
- Books still in the library

- Library Database

  - Books

    - Title
    - Author
    - Publication year
    - Barcode

  - Patrons

    - FirstName
    - LastName
    - Email
    - PatronID

  - Loans
    - LoanID
    - BookID
    - PatronID
    - LoanDate
    - DueDate
    - ReturnedDate

- Loans Table

  - LoanID, BookID, PatronID, LoanDate, DueDate, ReturnedDate

- Challenge:

  - Find the number of available copies of _Dracula_.

- Solution:

  ```
  SELECT COUNT(Title) FROM Books WHERE Title="Dracula";
  ```

  ```
  SELECT
    COUNT(Books.Title)
  FROM Loans
  JOIN Books
    ON Loans.BookID =  Books.BookID
  WHERE Books.Title = "Dracula" AND Loans.ReturnedDate IS NULL
  ```

  ```
  SELECT
    (SELECT COUNT(Books.Title) FROM Books WHERE Title="Dracula")
    -
    (SELECT
      COUNT(Books.Title)
    FROM Loans
    JOIN Books
      ON Loans.BookID =  Books.BookID
    WHERE Books.Title = "Dracula" AND Loans.ReturnedDate IS NULL) AS AvailableBooks;
  ```

### 2.2: Add new books to the library

- Challenge:

  - Add to the Books table

    Title: Dracula
    Author: Bram Stoker
    Year: 1897
    New ID: 4819277482

    Title: Gulliver's Travles
    Author: Jonathan Swift
    Year: 1729
    New ID: 4899254401

- Solution:

  ```
  INSERT INTO Books
    (Title, Author, Published, Barcode)
  VALUES
    ("Dracula", "Bram Stoker", "1897", "4819277482"),
    ("Gulliver's Travels", "Jonathan Swift", "1729", "4899254401");
  ```

### 2.3: Check out books

- Loans

  - LoanID (Auto-generated)
  - BookID (FK from Books table)
  - PatronID (FK from Patrons table)
  - LoanDate
  - DueDate
  - ReturnedDate

- Books

  - BookID
  - ...
  - Barcode

- Challenge:

  - Check out these books to this customer.

    The Picture of Dorian Gray, 2855934983
    Great Expectations, 4043822646

    Jack Vaan, jvaan@wisdompets.com

    August 25, 2020

    September 8, 2020

- Solution:

  ```
  INSERT INTO Loans
    (BookID, PatronID, LoanDate, DueDate)
  VALUES
    (
      (SELECT BookID FROM Books WHERE Barcode="2855934983"),
      (SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com"),
      "2020-08-25",
      "2020-09-08"
    );
  INSERT INTO Loans
    (BookID, PatronID, LoanDate, DueDate)
  VALUES
    (
      (SELECT BookID FROM Books WHERE Barcode="4043822646"),
      (SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com"),
      "2020-08-25",
      "2020-09-08"
    );
  ```

  - Confirm:

    ```
    SELECT *
    FROM Loans
    JOIN Books
      ON Loans.BookID = Books.BookID
    WHERE PatronID=(SELECT PatronID FROM Patrons WHERE Email="jvaan@wisdompets.com")
    ```

### 2.4: Check for books due back

- Challenge:

  - Generate a report of books due back on July 13, 2020, with patron contact information.
  - Tables to use:
    - Loans
    - Patrons
    - Books

- Solution:

  ```
  SELECT
    Loans.DueDate,
    Books.Title,
    Patrons.Email,
    Patrons.FirstName
  FROM Loans
  JOIN Books
    ON Loans.BookID = Books.BookID
  JOIN Patrons
    ON Loans.PatronID = Patrons.PatronID
  WHERE Loans.DueDate = "2020-07-13" AND Loans.ReturnedDate IS NULL;
  ```

### 2.5: Return books to the library

- Challenge:

  - Return these books to the Library on July 5, 2020.

- Solution:

  ```
  UPDATE Loans
    SET ReturnedDate = "2020-07-05"
    WHERE BookId = (SELECT BookID FROM Books WHERE Barcode = "6435968624")
      AND ReturnedDate IS NULL;
  ```

### 2.6: Encourage patrons to check out books

- Challenge:

  - Create a report showing the 10 patrons who have checked out the fewest books.

- Solution:

  ```
  SELECT
    COUNT(Loans.LoanID) AS loanCount,
    Patrons.FirstName,
    Patrons.Email
  FROM Loans
  JOIN Patrons ON Loans.PatronID = Patrons.PatronID
  GROUP BY Loans.PatronID
  ORDER BY loancount ASC
  LIMIT 10;
  ```

### 2.7: Find books to feature for an event

- Challenge:

  - Create a list of books from the 1890s that are currently available.

- Solution:

  ```
  SELECT
    Books.Title,
    Books.BookID,
    Books.Author,
    Books.Published
  FROM Books
  JOIN Loans
    ON Books.BookID = Loans.BookID
  WHERE Published > 1889 AND Published < 1900
  AND Loans.ReturnedDate IS NOT NULL
  GROUP BY Books.BookID
  ORDER BY Books.Title;
  ```

### 2.8: Book statistics

- Challenge

  - 1. Create a report showing how many books were published each year.
  - 2. Create a report showing the five most popular books to check out.

- Solution:

  ```
  SELECT
    Published,
    COUNT(DISTINCT(Title)) AS pubcount
  FROM Books
  GROUP BY Published
  ORDER BY pubcount DESC;
  ```

  ```
  SELECT
    COUNT(Loans.LoanID) AS loancount,
    Books.Title
  FROM Loans
  JOIN Books
    ON Loans.BookID = Books.BookID
  GROUP BY Books.Title
  ORDER BY loancount DESC
  LIMIT 5;
  ```
