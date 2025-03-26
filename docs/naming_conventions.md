# Data Warehouse Naming Conventions

## Overview

This document defines standardized naming patterns for database objects across all layers of the data warehouse.

## General Guidelines

- Use snake_case (lowercase with underscores)
- Use English names only
- Avoid SQL reserved words
- Be consistent and descriptive

## Layer-Specific Conventions

### Bronze Layer

```table
| Pattern                  | Example              | Description                    |
|-------------------------|----------------------|--------------------------------|
| <sourcesystem>_<entity> | crm_customer_info   | Raw table from CRM system     |
| <sourcesystem>_<entity> | erp_sales_data      | Raw table from ERP system     |
```

### Silver Layer

```table
| Pattern                  | Example              | Description                    |
|-------------------------|----------------------|--------------------------------|
| <sourcesystem>_<entity> | crm_customer_info   | Cleaned CRM customer data     |
| <sourcesystem>_<entity> | erp_sales_data      | Cleaned ERP sales data        |
```

### Gold Layer

```table
| Pattern              | Example          | Description                |
|---------------------|------------------|----------------------------|
| dim_<entity>        | dim_customers    | Dimension table           |
| fact_<entity>       | fact_sales       | Fact table                |
| agg_<entity>        | agg_daily_sales  | Aggregated table          |
```

## Column Naming

### Keys

```table
| Pattern              | Example          | Usage                     |
|---------------------|------------------|---------------------------|
| <entity>_key        | customer_key     | Surrogate key            |
| <entity>_id         | product_id       | Business/natural key     |
```

### Technical Columns

```table
| Pattern              | Example          | Description              |
|---------------------|------------------|--------------------------|
| dwh_load_date       | dwh_load_date    | Record load timestamp   |
| dwh_update_date     | dwh_update_date  | Last update timestamp   |
| dwh_source          | dwh_source       | Source system identifier|
```

## Stored Procedures

```table
| Pattern              | Example          | Purpose                  |
|---------------------|------------------|--------------------------|
| load_<layer>        | load_bronze      | Bronze layer loader      |
| load_<layer>        | load_silver      | Silver layer loader      |
| load_<layer>        | load_gold        | Gold layer loader        |
```

## Quick Reference

### Valid Examples

- Bronze: `crm_customer_info`, `erp_sales_data`
- Silver: `crm_customer_info`, `erp_sales_data`
- Gold: `dim_customers`, `fact_sales`, `agg_monthly_revenue`
- Keys: `customer_key`, `product_id`
- Technical: `dwh_load_date`, `dwh_source`
- Procedures: `load_bronze`, `load_silver`, `load_gold`

### Invalid Examples

❌ Mixed case: `dimCustomers`
❌ No source prefix in bronze/silver: `customer_info`
❌ Wrong prefix in gold: `customers_dim`
❌ Missing standard prefix: `load_date` (should be `dwh_load_date`)
