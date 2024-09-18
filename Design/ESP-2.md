# ESP 2 Solution

## Payment Log

### 0NF - Identify all information

**PaymentsLog**: OrderNumber(PK), OrderDate, OrderTotal, FirstName, LastName, CustomerNumber, {Date, PaymentAmount, PaymentNumber, BalanceOwing, PaymentType, DepositBatchNumber}

### 1NF - Isolate Repeating Groups

> I have generated a new entity called **Payment**

**Payment**: OrderNumber(PK|FK), PaymentNumber(PK), Date, PaymentAmount, BalanceOwing, PaymentType, DepositBathNumber

**PaymentLog**: OrderNumber(PK), OrderDate, OrderTotal, FirstName, LastName, CustomerNumber

### 2NF - Isolate Partial Dependencies

> There were no changes

### 3NF - Isolate Transitive Dependencies

> An entity that I'll call **Customer** exists within the **PaymentLog** entity.

**Customer**: CustomerNumber(PK), FirstName, LastName

**PaymentLog**: OrderNumber(PK), OrderDate, OrderTotal, CustomerNumber(FK)

### Final List of Entities

**PaymentLog**: OrderNumber(PK), OrderDate, OrderTotal, CustomerNumber(FK)

**Payment**: OrderNumber(PK|FK), PaymentNumber(PK), Date, PaymentAmount, BalanceOwing, PaymentType, DepositBathNumber

**Customer**: CustomerNumber(PK), FirstName, LastName

----
