
GO

IF OBJECT_ID('silver.customer_dim', 'U') IS NOT NUll
	DROP TABLE silver.customer_dim; 
GO
  
CREATE TABLE silver.customer_dim(
    customer_key NVARCHAR(25),
    name NVARCHAR(50),	
    contact_no NVARCHAR(50),
    nid NVARCHAR(50),
	current_dt DATETIME DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.fact_table', 'U') IS NOT NUll
	DROP TABLE silver.fact_table; 
GO
  
CREATE TABLE silver.fact_table(
   payment_key NVARCHAR(25),
   customer_key	NVARCHAR(25),
   time_key	NVARCHAR(25),
   item_key	NVARCHAR(25),
   store_key NVARCHAR(25),
   quantity	INT,
   unit NVARCHAR(25),
   unit_price DECIMAL(5, 2),
   total_price DECIMAL(5,2),
   current_dt DATETIME DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.item_dim', 'U') IS NOT NUll
	DROP TABLE silver.item_dim; 
GO
  
CREATE TABLE silver.item_dim(
   item_key	NVARCHAR(25),
   item_name NVARCHAR(50),
   description	NVARCHAR(30),
   man_country NVARCHAR(25),
   supplier	NVARCHAR(35),
   current_dt DATETIME DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.store_dim', 'U') IS NOT NUll
	DROP TABLE silver.store_dim; 
GO
  
CREATE TABLE silver.store_dim(
   store_key NVARCHAR(25),
   division	NVARCHAR(25),
   district	NVARCHAR(25),
   current_dt DATETIME DEFAULT GETDATE()
);

GO

IF OBJECT_ID('silver.time_dim', 'U') IS NOT NUll
	DROP TABLE silver.time_dim; 
GO
  
CREATE TABLE silver.time_dim(
   time_key NVARCHAR(25),
   cleaned_datetime NVARCHAR(50),
   hr INT,	
   day INT,
   week	NVARCHAR(25),
   month INT,
   quarter NVARCHAR(10),
   year INT,
   current_dt DATETIME DEFAULT GETDATE()
);


GO

IF OBJECT_ID('silver.transport_dim', 'U') IS NOT NUll
	DROP TABLE silver.transport_dim; 
GO
  
CREATE TABLE silver.transport_dim(
   payment_key NVARCHAR(25),
   transport_type NVARCHAR(25),
   bank_name NVARCHAR(75),
   current_dt DATETIME DEFAULT GETDATE()
);