USE SalesDB
GO

IF OBJECT_ID('bronze.customer_dim', 'U') IS NOT NUll
	DROP TABLE bronze.customer_dim; 
GO
  
CREATE TABLE bronze.customer_dim(
    customer_key NVARCHAR(25),
    name NVARCHAR(50),	
    contact_no NVARCHAR(50),
    nid NVARCHAR(50)
);

GO

IF OBJECT_ID('bronze.fact_table', 'U') IS NOT NUll
	DROP TABLE bronze.fact_table; 
GO
  
CREATE TABLE bronze.fact_table(
   payment_key NVARCHAR(25),
   customer_key	NVARCHAR(25),
   time_key	NVARCHAR(25),
   item_key	NVARCHAR(25),
   store_key NVARCHAR(25),
   quantity	INT,
   unit NVARCHAR(25),
   unit_price DECIMAL(5, 2),
   total_price DECIMAL(5,2)
);

GO

IF OBJECT_ID('bronze.item_dim', 'U') IS NOT NUll
	DROP TABLE bronze.item_dim; 
GO
  
CREATE TABLE bronze.item_dim(
   item_key	NVARCHAR(25),
   item_name NVARCHAR(50),
   descrip	NVARCHAR(30),
   unit_price VARCHAR(25),
   man_country NVARCHAR(25),
   supplier	NVARCHAR(35),
   unit NVARCHAR(50)
);

GO

IF OBJECT_ID('bronze.store_dim', 'U') IS NOT NUll
	DROP TABLE bronze.store_dim; 
GO
  
CREATE TABLE bronze.store_dim(
   store_key NVARCHAR(25),
   division	NVARCHAR(25),
   district	NVARCHAR(25),
   upazila NVARCHAR(25)
);

GO

IF OBJECT_ID('bronze.time_dim', 'U') IS NOT NUll
	DROP TABLE bronze.time_dim; 
GO
  
CREATE TABLE bronze.time_dim(
   time_key NVARCHAR(25),
   dt NVARCHAR(50),
   hr INT,	
   day INT,
   week	NVARCHAR(25),
   month INT,
   quarter NVARCHAR(10),
   year INT
);


GO

IF OBJECT_ID('bronze.transport_dim', 'U') IS NOT NUll
	DROP TABLE bronze.transport_dim; 
GO
  
CREATE TABLE bronze.transport_dim(
   payment_key NVARCHAR(25),
   trans_type NVARCHAR(25),
   bank_name NVARCHAR(75)
);