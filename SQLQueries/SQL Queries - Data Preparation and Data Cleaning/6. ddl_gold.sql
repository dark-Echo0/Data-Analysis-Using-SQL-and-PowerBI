USE SalesDB

-- Create Dimension: gold.customer_dim
-- =============================================================================
IF OBJECT_ID('gold.customer_dim', 'V') IS NOT NULL
    DROP VIEW gold.customer_dim;
GO

CREATE VIEW gold.customer_dim AS
SELECT
            customer_key AS cust_key,
			name,
			contact_no
FROM silver.customer_dim
GO

-- Create Dimension: gold.fact_table
-- =============================================================================
IF OBJECT_ID('gold.fact_table', 'V') IS NOT NULL
    DROP VIEW gold.fact_table;
GO

CREATE VIEW gold.fact_table AS
SELECT
        payment_key,
		customer_key,
		time_key,
		item_key,
		store_key,
		quantity,
		unit,
		unit_price,
		total_price
FROM silver.fact_table
GO


-- Create Dimension: gold.item_dim
-- =============================================================================
IF OBJECT_ID('gold.item_dim', 'V') IS NOT NULL
    DROP VIEW gold.item_dim;
GO

CREATE VIEW gold.item_dim AS
SELECT
        item_key,
		item_name,
		description,
		man_country AS country,
		supplier
FROM silver.item_dim
GO

-- Create Dimension: gold.store_dim
-- =============================================================================
IF OBJECT_ID('gold.store_dim', 'V') IS NOT NULL
    DROP VIEW gold.store_dim;
GO

CREATE VIEW gold.store_dim AS
SELECT
       store_key,
		division,
		district
FROM silver.store_dim
GO

-- Create Dimension: gold.time_dim
-- =============================================================================
IF OBJECT_ID('gold.time_dim', 'V') IS NOT NULL
    DROP VIEW gold.time_dim;
GO

CREATE VIEW gold.time_dim AS
SELECT
       time_key,
	   cleaned_datetime
FROM silver.time_dim
GO

-- Create Dimension: gold.transport_dim
-- =============================================================================
IF OBJECT_ID('gold.transport_dim', 'V') IS NOT NULL
    DROP VIEW gold.transport_dim;
GO

CREATE VIEW gold.transport_dim AS
SELECT
       payment_key,
	   transport_type,
	   bank_name
FROM silver.transport_dim
GO