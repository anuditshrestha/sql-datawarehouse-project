/*
Creating Database Schemas

Script Purpose: This script creates a new database names 'DataWarehouse'. If the database exists, it is dropped and recreated. 
The script also sets up three schemas: bronze, silver and gold.
The script also checks if the database already exists.
*/




USE master;
GO
--Drop and create the database
if exists(select 1 from sys.databases where name = 'DataWarehouse')
  begin
  alter database DataWarehouse set single_user with rollback immediate;
  drop database DataWarehouse;
End;
GO

--Creating Datawarehouse
create database DataWarehouse;

USE DataWarehouse;


--Create Schemas
Create schema bronze;

Create schema silver;
go
  
Create schema gold;
go
