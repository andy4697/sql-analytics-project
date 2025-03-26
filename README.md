# SQL Analytics Project

A data warehouse implementation project that processes data from CRM and ERP sources through bronze, silver, and gold layers, with Tableau dashboard integration.

## Project Structure

```text
sql-analytics-project/
├── scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   └── silver/
│       ├── ddl_silver.sql
│       └── proc_load_silver.sql
├── init.sql
└── README.md
```

## Data Architecture

The project implements a multi-layer data warehouse architecture:

- **Bronze Layer**: Raw data ingestion from source systems
- **Silver Layer**: Cleaned and standardized data
- **Gold Layer**: Business-ready analytical models

## Database Setup

1. Execute `init.sql` to create the database and schemas:

   ```sql
   -- Connect to postgres database first
   -- Run init.sql to create DataWarehouse database
   -- Connect to DataWarehouse database
   ```

2. Run the DDL scripts in order:
   - `scripts/bronze/ddl_bronze.sql`
   - `scripts/silver/ddl_silver.sql`

3. Execute the loading procedures:
   - `CALL bronze.load_bronze()`
   - `CALL silver.load_silver()`

## Connecting to Tableau

### Prerequisites

- Tableau Desktop or Tableau Public
- PostgreSQL database connection details

### Connection Steps

1. Open Tableau Desktop
2. Select "PostgreSQL" under Connect → To a Server
3. Enter connection details:
   - Server: your_server_host
   - Port: 5432
   - Database: DataWarehouse
   - Authentication: Username and Password
   - Username: your_username
   - Password: your_password

### Available Tables for Analysis

#### Silver Layer Tables

- `silver.crm_cust_info`: Customer information
  - Key fields: cst_id, cst_key, cst_firstname, cst_lastname
- `silver.crm_prd_info`: Product information
  - Key fields: prd_id, cat_id, prd_key, prd_nm
- `silver.crm_sales_details`: Sales transactions
  - Key fields: sls_ord_num, sls_prd_key, sls_cust_id
- `silver.erp_loc_a101`: Location data
- `silver.erp_cust_az12`: Additional customer data
- `silver.erp_px_cat_g1v2`: Product categories

### Best Practices for Tableau

1. Use custom SQL when needed for complex joins
2. Create calculated fields in Tableau for common metrics
3. Leverage the cleaned data from silver layer tables
4. Set up data source filters to improve performance
5. Use extracts instead of live connections for better performance

### Sample Analyses

1. Customer Analysis

   ```sql
   SELECT 
       c.cst_id,
       c.cst_firstname,
       c.cst_lastname,
       COUNT(s.sls_ord_num) as total_orders,
       SUM(s.sls_sales) as total_sales
   FROM silver.crm_cust_info c
   LEFT JOIN silver.crm_sales_details s ON c.cst_id = s.sls_cust_id
   GROUP BY c.cst_id, c.cst_firstname, c.cst_lastname
   ```

2. Product Performance

   ```sql
   SELECT 
       p.prd_nm,
       p.prd_line,
       SUM(s.sls_quantity) as total_quantity,
       SUM(s.sls_sales) as total_revenue
   FROM silver.crm_prd_info p
   JOIN silver.crm_sales_details s ON p.prd_key = s.sls_prd_key
   GROUP BY p.prd_nm, p.prd_line
   ```

## Maintenance

- Regular data refreshes are handled by the loading procedures
- Monitor performance using Tableau's performance analyzer
- Optimize frequently used queries by creating appropriate indexes
