# ESP 1 Solution

**Known Bugs:**

- *Fill in this list when you are finished your solution. Enter `No known bugs` if you have completed all the lab requirements successfully*

----

## Customer Details View

### 0NF

After performing Zero-Normal Form, a single table was generated: **`Customer`**.

**Customer**: CustomerNumber(PK), FirstName, LastName, Address, City, Province, PostalCode, HomePhone

### 1NF – 3NF

No changes to the table in 1NF to 3NF.

----

## Customer Orders View

### 0NF

After performing Zero-Normal Form, a single table was generated: **`Order`**.

**Order**: OrderNumber(PK), CustomerNumber, FirstName, LastName, Address, City, Province, PostalCode, Phone, Date, {ItemNumber, Description, Quantity, CurrentPrice, SellingPrice, Amount,} Subtotal, GST, Total

### 1NF

After performing First-Normal Form, a new table was generated: **`OrderDetail`**.

**Order**: OrderNumber(PK), CustomerNumber, FirstName, LastName, Address, City, Province, PostalCode, Phone, Date, Subtotal, GST, Total

**OrderDetail**: OrderNumber(PK|FK), ItemNumber(PK), Description, Quantity, CurrentPrice, SellingPrice, Amount

### 2NF

After performing Second-Normal Form, another new table was generated: **`Item`**.

**OrderDetail**: OrderNumber(PK|FK1), ItemNumber(PK|FK2), Quantity, SellingPrice, Amount

**Item**: ItemNumber(PK), Description, CurrentPrice

### 3NF

After performing Third-Normal Form, another new table was generated: **`Customer`**.

**Order**: OrderNumber(PK), CustomerNumber(FK), Date, Subtotal, GST, Total

**Customer**: CustomerNumber(PK), FirstName, LastName, Address, City, Province, PostalCode, Phone

### Tables after 3rd Normal Form

These are the tables/entities after normalizing the Customer Details View.

**Customer**: CustomerNumber(PK), FirstName, LastName, Address, City, Province, PostalCode, Phone

**Order**: OrderNumber(PK), CustomerNumber(FK), Date, Subtotal, GST, Total

**OrderDetail**: OrderNumber(PK|FK1), ItemNumber(PK|FK2), Quantity, SellingPrice, Amount

**Item**: ItemNumber(PK), Description, CurrentPrice
