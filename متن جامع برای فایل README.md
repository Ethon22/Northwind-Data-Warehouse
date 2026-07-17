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
