-- Exploratory Data Analysis
USE SalesDB
-- bronze.customer_dim
SELECT * FROM bronze.customer_dim

-- 1. Show the duplicate in the table
SELECT customer_key, COUNT(*) AS count_number
FROM bronze.customer_dim
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- 2. Show the data types of the column in the table
EXEC SP_HELP 'bronze.transport_dim';

-- 3. Remove Commas
UPDATE bronze.customer_dim
SET 
	contact_no = REPLACE(contact_no, ',', ''),
	nid = REPLACE(nid, ',', '')

-- 4. Remove Spaces
UPDATE bronze.customer_dim
SET 
	contact_no = LTRIM(RTRIM(contact_no)),
	nid = LTRIM(RTRIM(nid))
-- 5. Change Structure of the number from scientific form to General
UPDATE bronze.customer_dim
SET contact_no = CAST(CAST(contact_no AS FLOAT) AS BIGINT),
	nid = CAST(CAST(nid AS FLOAT) AS BIGINT)
WHERE 
	TRY_CAST(contact_no AS FLOAT) IS NOT NULL AND 
	TRY_CAST(nid AS FLOAT) IS NOT NULL;
-- 6. Show the first 9 digits
UPDATE bronze.customer_dim
SET contact_no = LEFT(contact_no, 9),
	nid = LEFT(nid,9)
WHERE LEN(nid) > 9;

-- 7. Format the contact number into xxx-xxx-xxx
  STUFF(STUFF(CAST(contact_no AS VARCHAR(20)), 4, 0, '-'), 8, 0, '-') AS formatted_contact

-- 8. Convert date into standard datetime format
SELECT dt,
    COALESCE(
        TRY_CONVERT(datetime2, dt, 101), -- mm/dd/yyyy
        TRY_CONVERT(datetime2, dt, 105)  -- dd-mm-yyyy
    ) AS cleaned_datetime

FROM bronze.time_dim;

