/*
Initialization
1. Create Database called SalesDB
2. Create Schemas:
	bronze
	silver
	gold
*/

USE MASTER

CREATE DATABASE SalesDB;
 
USE SalesDB;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO