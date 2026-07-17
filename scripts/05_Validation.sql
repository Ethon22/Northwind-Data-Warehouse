-- ============================================================
-- 05_Validation.sql
-- Purpose: Validate row counts in all tables
-- ============================================================

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
ORDER BY TableName
GO

-- Expected results:
-- Dim_Date      : 4018 rows (1990-01-01 to 2000-12-31)
-- Dim_Customer  : 91 rows
-- Dim_Product   : 77 rows
-- Dim_Employee  : 9 rows
-- Dim_Shipper   : 3 rows
-- Fact_Sales    : 2155 rows
