USE Northwind_DWH
GO

SELECT 'Dim_Date' AS TableName, COUNT(*) AS RowCount FROM Dim_Date
UNION ALL
SELECT 'Dim_Customer', COUNT(*) FROM Dim_Customer
UNION ALL
SELECT 'Dim_Product', COUNT(*) FROM Dim_Product
UNION ALL
SELECT 'Dim_Employee', COUNT(*) FROM Dim_Employee
UNION ALL
SELECT 'Dim_Shipper', COUNT(*) FROM Dim_Shipper
UNION ALL
SELECT 'Fact_Sales', COUNT(*) FROM Fact_Sales
GO
