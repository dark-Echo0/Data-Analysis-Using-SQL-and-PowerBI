EXEC bronze.load_bronze;
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.customer_dim;'
		TRUNCATE TABLE bronze.customer_dim; 
		PRINT '>> Insert Table: bronze.customer_dim';
		BULK INSERT bronze.customer_dim
		FROM 'C:\Users\Rico Araojo\Desktop\Power BI\sales\customer_dim.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.fact_table;'
		TRUNCATE TABLE bronze.fact_table; 
		PRINT '>> Insert Table: bronze.fact_table';
		BULK INSERT bronze.fact_table
		FROM 'C:\Users\Rico Araojo\Desktop\Power BI\sales\fact_table.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.item_dim;'
		TRUNCATE TABLE bronze.item_dim; 
		PRINT '>> Insert Table: bronze.item_dim';
		BULK INSERT bronze.item_dim
		FROM 'C:\Users\Rico Araojo\Desktop\Power BI\sales\item_dim.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.store_dim;'
		TRUNCATE TABLE bronze.store_dim; 
		PRINT '>> Insert Table: bronze.store_dim';
		BULK INSERT bronze.store_dim
		FROM 'C:\Users\Rico Araojo\Desktop\Power BI\sales\store_dim.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.time_dim;'
		TRUNCATE TABLE bronze.time_dim; 
		PRINT '>> Insert Table: bronze.time_dim';
		BULK INSERT bronze.time_dim
		FROM 'C:\Users\Rico Araojo\Desktop\Power BI\sales\time_dim.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.transport_dim;'
		TRUNCATE TABLE bronze.transport_dim; 
		PRINT '>> Insert Table: bronze.transport_dim';
		BULK INSERT bronze.transport_dim
		FROM 'C:\Users\Rico Araojo\Desktop\Power BI\sales\Trans_dim.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' second';
		PRINT '----------------------------------------------';


		SET @batch_end_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==============================================';
	END TRY

	-- Script in case of Error in the Bronce Layer
	BEGIN CATCH
		PRINT '==============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONCE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==============================================';

	END CATCH
END