USE master
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Northwind_DWH')
BEGIN
    ALTER DATABASE Northwind_DWH SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE Northwind_DWH
END
GO

CREATE DATABASE Northwind_DWH
GO

USE Northwind_DWH
GO

CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Quarter INT,
    MonthNumber INT,
    MonthName NVARCHAR(20),
    DayOfWeek INT,
    DayName NVARCHAR(20),
    IsHoliday BIT DEFAULT 0,
    PersianDate NVARCHAR(20) NULL
)
GO

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID_NK NCHAR(5),
    CompanyName NVARCHAR(40),
    ContactName NVARCHAR(30),
    ContactTitle NVARCHAR(30),
    City NVARCHAR(15),
    Region NVARCHAR(15),
    Country NVARCHAR(15),
    ValidFrom DATE,
    ValidTo DATE DEFAULT '9999-12-31',
    IsCurrent BIT DEFAULT 1
)
GO

CREATE TABLE Dim_Product (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID_NK INT,
    ProductName NVARCHAR(40),
    CategoryName NVARCHAR(15),
    SupplierName NVARCHAR(40),
    QuantityPerUnit NVARCHAR(20),
    UnitPrice MONEY,
    IsDiscontinued BIT
)
GO

CREATE TABLE Dim_Employee (
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID_NK INT,
    FirstName NVARCHAR(10),
    LastName NVARCHAR(20),
    FullName NVARCHAR(31),
    Title NVARCHAR(30),
    City NVARCHAR(15),
    Country NVARCHAR(15)
)
GO

CREATE TABLE Dim_Shipper (
    ShipperKey INT IDENTITY(1,1) PRIMARY KEY,
    ShipperID_NK INT,
    CompanyName NVARCHAR(40)
)
GO

CREATE TABLE Fact_Sales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    OrderDateKey INT FOREIGN KEY REFERENCES Dim_Date(DateKey),
    CustomerKey INT FOREIGN KEY REFERENCES Dim_Customer(CustomerKey),
    ProductKey INT FOREIGN KEY REFERENCES Dim_Product(ProductKey),
    EmployeeKey INT FOREIGN KEY REFERENCES Dim_Employee(EmployeeKey),
    ShipperKey INT FOREIGN KEY REFERENCES Dim_Shipper(ShipperKey),
    OrderID INT,
    Quantity SMALLINT,
    UnitPrice MONEY,
    Discount REAL,
    LineTotal MONEY
)
GO

CREATE NONCLUSTERED INDEX IX_Fact_Sales_Date ON Fact_Sales(OrderDateKey)
GO
CREATE NONCLUSTERED INDEX IX_Fact_Sales_Customer ON Fact_Sales(CustomerKey)
GO
CREATE NONCLUSTERED INDEX IX_Fact_Sales_Product ON Fact_Sales(ProductKey)
GO
CREATE NONCLUSTERED INDEX IX_Fact_Sales_Employee ON Fact_Sales(EmployeeKey)
GO
CREATE INDEX IX_Dim_Customer_IsCurrent ON Dim_Customer(IsCurrent)
GO
CREATE INDEX IX_Dim_Customer_ValidFrom_ValidTo ON Dim_Customer(ValidFrom, ValidTo)
GO
