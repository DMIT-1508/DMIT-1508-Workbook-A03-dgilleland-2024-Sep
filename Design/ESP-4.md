# ESP 4 Solution

## Cheque Register

![Cheque Register](.\Images\ESP-4-Cheque-Register-View.png)

### 0NF

**Cheque**: ChequeNumber(PK), Date, ChequeAmount, SupplierNumber, SupplierName, {PurchaseOrderNumber, PurchaseOrderDate}

> Note that there are no attributes/data outside of the tabluar info on the Cheque Register. As such, I can "remove" the outer curly braces and regard each cheque individually.


### 1NF - Isolate Repeating Groups

**Cheque**: ChequeNumber(PK), Date, ChequeAmount, SupplierNumber, SupplierName

**Payment**: ChequeNumber(PK|FK), PurchaseOrderNumber(PK), PurchaseOrderDate

### 2NF - Isolate Partial Dependencies

**Payment**: ChequeNumber(PK|FK1), PurchaseOrderNumber(PK|FK2)

**PurchaseOrder**: PurchaseOrderNumber(PK), PurchaseOrderDate

### 3NF - Isolate Transitive Dependencies

**Cheque**: ChequeNumber(PK), Date, ChequeAmount, SupplierNumber(FK)

**Supplier**: SupplierNumber(PK), SupplierName

### Final Entities

**Payment**: ChequeNumber(PK|FK1), PurchaseOrderNumber(PK|FK2)

**PurchaseOrder**: PurchaseOrderNumber(PK), PurchaseOrderDate

**Cheque**: ChequeNumber(PK), Date, ChequeAmount, SupplierNumber(FK)

**Supplier**: SupplierNumber(PK), SupplierName
