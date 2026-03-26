EXEC silver.load_silver;

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Silver Layer';
		PRINT '==============================================';

		-- silver.customer_dim
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.customer_dim';
		TRUNCATE TABLE silver.customer_dim;
		PRINT '>> Inserting Data Into: silver.customer_dim';
		WITH cleaned AS (
			SELECT
				customer_key,
				name,
				-- safe numeric conversion
				CAST(CAST(contact_no AS FLOAT) AS BIGINT) AS contact_no,
				CAST(CAST(nid AS FLOAT) AS BIGINT) AS nid
			FROM bronze.customer_dim
			WHERE 
				TRY_CAST(contact_no AS FLOAT) IS NOT NULL
				AND TRY_CAST(nid AS FLOAT) IS NOT NULL
		)
		INSERT INTO silver.customer_dim (
			customer_key,
			name,
			contact_no,
			nid
		)
		SELECT
		customer_key,

    -- Capitalize first letter only
		UPPER(LEFT(name,1)) + LOWER(SUBSTRING(name,2,LEN(name))) AS name,

    -- Format contact_no
		STUFF(STUFF(LEFT(CAST(contact_no AS VARCHAR(20)), 9), 4, 0, '-'), 8, 0, '-') AS contact_no,

    -- Format nid
		STUFF(STUFF(LEFT(CAST(nid AS VARCHAR(20)), 9), 4, 0, '-'), 8, 0, '-') AS nid

		FROM cleaned;

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';


		-- silver.fact_table
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.fact_table';
		TRUNCATE TABLE silver.fact_table;
		PRINT '>> Inserting Data Into: ssilver.fact_table';
		INSERT INTO silver.fact_table(
		payment_key,
		customer_key,
		time_key,
		item_key,
		store_key,
		quantity,
		unit,
		unit_price,
		total_price
		)
		SELECT
		payment_key,
		customer_key,
		time_key,
		item_key,
		store_key,
		quantity,
		CASE 
			WHEN unit = 'botlltes' THEN 'Bottles'
			WHEN unit = 'bottles' THEN 'Bottles'
			WHEN unit = 'ct.' THEN 'Cartons'
			WHEN unit = 'ct' THEN 'Cartons'
			WHEN unit = 'cartons' THEN 'Cartons'
			WHEN unit = 'oz.' THEN 'oz'
			WHEN unit = 'bars' THEN 'Bars'
			WHEN unit = 'tubs' THEN 'Tubs'
			WHEN unit = 'tins' THEN 'Tins'
			WHEN unit = 'pk' THEN 'Pack'
			WHEN unit = 'pack' THEN 'Pack'
			WHEN unit = 'cans' THEN 'Cans'
			WHEN unit = 'rolls' THEN 'Rolls'
			ELSE COALESCE(unit, 'N/A')
		END AS unit,
		unit_price,
		total_price
		FROM bronze.fact_table;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';


		-- silver.item_dim
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.item_dim';
		TRUNCATE TABLE silver.item_dim;
		PRINT '>> Inserting Data Into: silver.item_dim';
		INSERT INTO silver.item_dim(
		item_key,
		item_name,
		description,
		man_country,
		supplier
		)
		SELECT
		item_key,
		item_name,
		CASE 
			 WHEN descrip = 'a. Beverage - Soda' THEN 'Beverage - Soda'
			 WHEN descrip = 'a. Beverage Sparkling Water' THEN 'Beverage - Water'
			 WHEN descrip = 'Beverage - Gatorade' THEN 'Beverage - Energy/Protein'
			 WHEN descrip = 'Beverage - Iced Tea' THEN 'Beverage - Juice'
			 WHEN descrip = 'Coffee Cream' THEN 'Coffee Creamer'
			 WHEN descrip = 'Coffee K-Cups' THEN 'Coffee K-Cups Tea'
			 WHEN descrip = 'Dishware - Bowls' THEN 'Dishware - Utensils'
			 WHEN descrip = 'Dishware - Cups Cold' THEN 'Dishware - Utensils'
			 WHEN descrip = 'Dishware - Cups Hot' THEN 'Dishware - Utensils'
			 WHEN descrip = 'Dishware - Plates' THEN 'Dishware - Utensils'
			 WHEN descrip = ' Original Scent "' THEN 'Dishware - Utensils'
			 WHEN descrip = ' nut' THEN 'Food - Nuts'
			 WHEN descrip = ' Sltd"' THEN 'Food - Nuts'
			 WHEN descrip = ' cracker"' THEN 'Food - Chips'
			 WHEN descrip = 'Food - Chocolate' THEN 'Food - Sweets'
			 WHEN descrip = ' Brown Sugar Cinnamon "' THEN 'Food - Sweets'
			 WHEN descrip = ' Strwbry & Berry "' THEN 'Food - Healthy'
			 WHEN descrip = ' Frosted Strawberry"' THEN 'Food - Healthy'
			 WHEN descrip = 'cheddar' THEN 'Food - Cheese'
			 WHEN descrip = ' cheddar' THEN 'Food - Cheese'
			 WHEN descrip = ' Prngls' THEN 'Food - Cheese'  
			 ELSE COALESCE(descrip, 'N/A')
		END AS description,
		REPLACE(man_country, 'poland','Poland') AS country,
		supplier
		FROM bronze.item_dim;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';


		-- silver.store_dim
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.store_dim';
		TRUNCATE TABLE silver.store_dim;
		PRINT '>> Inserting Data Into: silver.store_dim';
		INSERT INTO silver.store_dim(
		store_key,
		division,
		district
		)
		SELECT
		store_key,
		UPPER(LEFT(division,1)) + LOWER(SUBSTRING(division,2,LEN(division))) AS division,
		UPPER(LEFT(district,1)) + LOWER(SUBSTRING(district,2,LEN(district))) AS district
		FROM bronze.store_dim;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';


		-- silver.time_dim
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.time_dim';
		TRUNCATE TABLE silver.time_dim;
		PRINT '>> Inserting Data Into: silver.time_dim';
		INSERT INTO silver.time_dim(
			time_key,
			cleaned_datetime,
			hr,
			day,
			week,
			month,
			quarter,
			year
			)
		SELECT
			time_key,
			COALESCE(
			TRY_CONVERT(datetime2, dt, 101), -- mm/dd/yyyy
			TRY_CONVERT(datetime2, dt, 105)  -- dd-mm-yyyy
			) AS cleaned_datetime,
			hr,
			day,
			week,
			month,
			quarter,
			year
		FROM bronze.time_dim;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		
		-- silver.transport_dim
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.transport_dim';
		TRUNCATE TABLE silver.transport_dim;
		PRINT '>> Inserting Data Into: silver.transport_dim';
		INSERT INTO silver.transport_dim(
			payment_key,
			transport_type,
			bank_name
		)
		SELECT
		payment_key,
		UPPER(LEFT(trans_type,1)) + LOWER(SUBSTRING(trans_type,2,LEN(trans_type))) AS trans_type,
		bank_name
		FROM bronze.transport_dim;

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Silver Layer is Completed';
		PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==============================================';
	END TRY

	-- Script in case of Error in the Silver Layer
	BEGIN CATCH
		PRINT '==============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONCE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==============================================';

	END CATCH
END