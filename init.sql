-- Connect to default 'postgres' database to safely drop and create databases
-- (Select the 'postgres' database manually from pgAdmin before running this block)

-- Drop the 'DataWarehouse' database if it exists
DROP DATABASE IF EXISTS "DataWarehouse";

-- Create the 'DataWarehouse' database
CREATE DATABASE "DataWarehouse";

-- After creating, manually select/connect to the 'DataWarehouse' database in pgAdmin

-- Create Schemas inside 'DataWarehouse' database
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
