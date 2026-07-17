USE Northwind_DWH
GO

INSERT INTO Fact_Sales (
    OrderDateKey, CustomerKey, ProductKey, EmployeeKey, ShipperKey,
    OrderID, Quantity, UnitPrice, Discount, LineTotal
)
SELECT
    CAST(FORMAT(O.OrderDate, 'yyyyMMdd') AS INT),
    C.CustomerKey,
    P.ProductKey,
    E.EmployeeKey,
    S.ShipperKey,
    OD.OrderID,
    OD.Quantity,
    OD.UnitPrice,
    OD.Discount,
    CAST(OD.Quantity * OD.UnitPrice * (1 - OD.Discount) AS MONEY)
FROM Northwind.dbo.[Order Details] OD
JOIN Northwind.dbo.Orders O ON OD.OrderID = O.OrderID
JOIN Dim_Customer C ON C.CustomerID_NK = O.CustomerID AND C.IsCurrent = 1
JOIN Dim_Product P ON P.ProductID_NK = OD.ProductID
JOIN Dim_Employee E ON E.EmployeeID_NK = O.EmployeeID
JOIN Dim_Shipper S ON S.ShipperID_NK = O.ShipVia
WHERE O.OrderDate IS NOT NULL
GO
