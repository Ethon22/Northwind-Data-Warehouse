# 🏢 Northwind Data Warehouse

## 📌 Project Overview
This project implements a **Star Schema Data Warehouse** for the Northwind database, following **Kimball's dimensional modeling methodology**. The goal is to provide a scalable and optimized analytical layer for business intelligence queries.

## 🎯 Business Process
- **Process:** Sales (Order Details)
- **Grain:** One row per order line item
- **Source System:** Northwind OLTP Database (Microsoft SQL Server)

## 📊 Schema Design

### Fact Table: `Fact_Sales`
| Column | Type | Description |
|--------|------|-------------|
| SalesKey | INT | Surrogate Key |
| OrderDateKey | INT | FK to Dim_Date |
| CustomerKey | INT | FK to Dim_Customer |
| ProductKey | INT | FK to Dim_Product |
| EmployeeKey | INT | FK to Dim_Employee |
| ShipperKey | INT | FK to Dim_Shipper |
| OrderID | INT | Business Key |
| Quantity | SMALLINT | Additive metric |
| UnitPrice | MONEY | Semi-additive metric |
| Discount | REAL | Non-additive metric |
| LineTotal | MONEY | Calculated additive metric |

### Dimension Tables (SCD Types)
- **Dim_Date** (SCD Type 0 - Static)
- **Dim_Customer** (SCD Type 2 - Full History)
- **Dim_Product** (SCD Type 1 - Overwrite)
- **Dim_Employee** (SCD Type 1)
- **Dim_Shipper** (SCD Type 1)

## 🏗️ Architecture
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ OLTP │────▶│ Staging │────▶│ Core DWH │
│ Northwind │ │ (Bronze) │ │ (Gold) │
└─────────────┘ └─────────────┘ └─────────────┘
│
▼
┌─────────────┐
│ OLAP / │
│ Reports │
└─────────────┘

## 📁 File Structure
.
├── README.md
├── diagrams/
│ └── Northwind_Star_Schema.png (Coming soon)
├── scripts/
│ ├── 01_Create_DWH.sql
│ ├── 02_Load_Dimensions.sql
│ ├── 03_Load_Fact.sql
│ ├── 04_Queries_Analytical.sql
│ └── 05_Validation.sql
└── docs/
└── Project_Report.md 

## 🛠️ Technologies Used
- **Database:** Microsoft SQL Server 2022
- **Modeling:** Kimball Star Schema
- **Tools:** SQL Server Management Studio (SSMS), diagrams.net
- **Version Control:** GitHub

## 📈 Sample Analytical Queries

### Total Sales by Category
```sql
SELECT 
    P.CategoryName,
    SUM(F.LineTotal) AS TotalSales
FROM Fact_Sales F
JOIN Dim_Product P ON F.ProductKey = P.ProductKey
GROUP BY P.CategoryName
ORDER BY TotalSales DESC;
Sales Trend by Month
SELECT 
    D.Year,
    D.MonthName,
    SUM(F.LineTotal) AS MonthlySales
FROM Fact_Sales F
JOIN Dim_Date D ON F.OrderDateKey = D.DateKey
GROUP BY D.Year, D.MonthName, D.MonthNumber
ORDER BY D.Year, D.MonthNumber;
📊 Business Questions Answered

    Total orders by customer

    Top customer by purchase amount

    Best selling season (Quarter/Month)

    Top employee by total sales

    Top employee selling low-performing products

    Shipper with most shipments

    Shipper with highest freight cost

    Top 3 products per customer

    Top 10 best-selling products

    Best selling day of week
Author

[Ehsan Etesami]
GitHub: @Ethon22
📅 Date

July 2026
📝 License

MIT


