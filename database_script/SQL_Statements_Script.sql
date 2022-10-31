
--create database
CREATE DATABASE DCE_customer;


--create customer table
CREATE TABLE Customer(
	UserId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Username varchar(30),
	Email varchar(20),
	FirstName varchar(20),
	LastName varchar(20),
	CreateOn datetime,
	IsActive bit
);

select * from Customer;


--create order table
CREATE TABLE Order_(
	OrderId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	ProductId UNIQUEIDENTIFIER,
	OrderStatus tinyint,
	OrderType tinyint,
	OrderBy UNIQUEIDENTIFIER,
	OrderedOn datetime,
	ShippedOn datetime,
	IsActive bit
);

select * from Order_;



--create product table
CREATE TABLE Product(
	ProductId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	ProductName varchar(50),
	UnitPrice decimal,
	SupplierId UNIQUEIDENTIFIER,
	CreateOn datetime,
	IsActive bit
);

select * from Product;


--create supplier table
CREATE TABLE Supplier(
	SupplierId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	SupplierName varchar(50),
	CreateOn datetime,
	IsActive bit
);

select * from Supplier;






--update order table foreign key
ALTER TABLE Order_
   ADD CONSTRAINT FK_order_productID FOREIGN KEY (ProductId)
      REFERENCES Product(ProductId)
      ON DELETE CASCADE
      ON UPDATE CASCADE;

ALTER TABLE Order_
   ADD CONSTRAINT FK_order_orderBy FOREIGN KEY (OrderBy)
      REFERENCES Customer(UserId)
      ON DELETE CASCADE
      ON UPDATE CASCADE;


--update product table foreign key
ALTER TABLE Product
   ADD CONSTRAINT FK_Product_SupplierId FOREIGN KEY (SupplierID)
      REFERENCES Supplier(SupplierId)
      ON DELETE CASCADE
      ON UPDATE CASCADE;





--store procedures for active orders

CREATE PROCEDURE 
GetActiveOrdersByCustomer 
@name varchar(30)
AS
BEGIN




SELECT *
FROM Customer cus,
     Supplier sup,
     Product pro,
     Order_ ord
WHERE cus.UserId = ord.OrderBy
  AND pro.ProductId = ord.ProductId
  AND sup.SupplierId = pro.SupplierId
  AND cus.Username = @name
  AND ord.IsActive = 1;



END;



EXEC GetActiveOrdersByCustomer 'kancchal';
