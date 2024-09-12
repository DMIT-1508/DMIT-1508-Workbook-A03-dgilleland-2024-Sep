# ESP 3 Solution

## Inventory Control Sheet

### 0NF - Identify Information

**InventoryItem**: ItemNumber(PK), ItemDescription, CurrentSalePrice, { Date, SupplierNumber, PONumber, Quantity, Cost }, InStockQuantity, ReorderLevel

### 1NF - Isolate Repeating Groups

**OrderHistory**: ItemNumber(PK|FK), PONumber(PK), Date, SupplierNumber, Quantity, Cost

**InventoryItem**: ItemNumber(PK), ItemDescription, CurrentSalePrice, InStockQuantity, ReorderLevel

### 2NF - Isolate Partial Dependencies

**PurchaseOrder**: PONumber(PK), Date, SupplierNumber

**OrderHistory**: ItemNumber(PK|FK1), PONumber(PK|FK2), Quantity, Cost

### 3NF - Isolate Transitive Dependencies

*There are NO transitive dependencies and therefore no new entities.*

### Final Entity List

**InventoryItem**: ItemNumber(PK), ItemDescription, CurrentSalePrice, InStockQuantity, ReorderLevel

**PurchaseOrder**: PONumber(PK), Date, SupplierNumber

**OrderHistory**: ItemNumber(PK|FK1), PONumber(PK|FK2), Quantity, Cost

----

## Purchase Order Form

### 0NF - Identify Information

**PurchaseOrder**: PurchaseOrderNumber(PK), SupplierName, SupplierNumber, Address, City, Province, PostalCode, Phone, Date, { ItemNumber, SupplierItemNumber, SupplierDescription, Quantity, Cost, Amount, } SubTotal, GST, Total

### 1NF - Isolate Repeating Groups

**PurchaseOrderItem**: PurchaseOrderNumber(PK|FK), ItemNumber(PK), SupplierItemNumber, SupplierDescription, Quantity, Cost, Amount

**PurchaseOrder**: PurchaseOrderNumber(PK), SupplierName, SupplierNumber, Address, City, Province, PostalCode, Phone, Date, Subtotal, GST, Total

### 2NF - Isolate Partial Dependencies

> After **much** consideration, there are **no** partial dependencies

### 3NF - Isolate Transitive Dependencies

**Supplier**: SupplierNumber(PK), SupplierName, Address, City, Province, PostalCode, Phone

**PurchaseOrder**: PurchaseOrderNumber(PK), SupplierNumber(FK), Date, Subtotal, GST, Total

### Final Entities

**PurchaseOrder**: PurchaseOrderNumber(PK), SupplierNumber(FK), Date, Subtotal, GST, Total

**Supplier**: SupplierNumber(PK), SupplierName, Address, City, Province, PostalCode, Phone

**PurchaseOrderItem**: PurchaseOrderNumber(PK|FK), ItemNumber(PK), SupplierItemNumber, SupplierDescription, Quantity, Cost, Amount

#### Self-Check

> *We want to see if our relationships between the entities is correct (in terms of one-to-many relationships) and we also want to see if the data fits.*

Each **PurchaseOrder** must be placed with one and only one **Supplier**.
Each **Supplier** may be the entity we purchased from on one or more **PurchaseOrders**.
