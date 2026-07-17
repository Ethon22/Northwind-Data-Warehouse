USE Northwind_DWH
GO

DECLARE @StartDate DATE = '1990-01-01'
DECLARE @EndDate DATE = '2000-12-31'

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO Dim_Date (
        DateKey, FullDate, Year, Quarter, MonthNumber, MonthName,
        DayOfWeek, DayName
    )
    SELECT
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate)

    SET @StartDate = DATEADD(DAY, 1, @StartDate)
END
GO

INSERT INTO Dim_Customer (
    CustomerID_NK, CompanyName, ContactName, ContactTitle,
    City, Region, Country, ValidFrom, IsCurrent
)
SELECT
    CustomerID, CompanyName, ContactName, ContactTitle,
    City, Region, Country, '1990-01-01', 1
FROM Northwind.dbo.Customers
GO

INSERT INTO Dim_Product (
    ProductID_NK, ProductName, CategoryName, SupplierName,
    QuantityPerUnit, UnitPrice, IsDiscontinued
)
SELECT
    P.ProductID, P.ProductName, C.CategoryName, S.CompanyName,
    P.QuantityPerUnit, P.UnitPrice, P.Discontinued
FROM Northwind.dbo.Products P
LEFT JOIN Northwind.dbo.Categories C ON P.CategoryID = C.CategoryID
LEFT JOIN Northwind.dbo.Suppliers S ON P.SupplierID = S.SupplierID
GO

INSERT INTO Dim_Employee (
    EmployeeID_NK, FirstName, LastName, FullName, Title, City, Country
)
SELECT
    EmployeeID, FirstName, LastName,
    FirstName + ' ' + LastName,
    Title, City, Country
FROM Northwind.dbo.Employees
GO

INSERT INTO Dim_Shipper (ShipperID_NK, CompanyName)
SELECT ShipperID, CompanyName
FROM Northwind.dbo.Shippers
GO
