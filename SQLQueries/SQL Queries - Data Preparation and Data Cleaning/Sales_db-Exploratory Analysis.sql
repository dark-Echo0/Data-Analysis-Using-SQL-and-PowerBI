USE SalesDB

-- Exploratory Analysis

-- Retrieve data 
-- 1. Top 10 largest and least category by Sales
SELECT TOP 10
    i.description AS Category,
    SUM(f.quantity * f.unit_price) AS Total_Sales
FROM silver.item_dim i
LEFT JOIN silver.fact_table f
    ON i.item_key = f.item_key
GROUP BY i.description
ORDER BY Total_Sales;
-- 2. TOP 10 Product for Largest and Smalles Order Count since (2014-2021)
SELECT TOP 10
    i.item_name AS Products,
    COUNT(f.quantity) AS Number_of_Orders
FROM silver.item_dim i
LEFT JOIN silver.fact_table f
    ON i.item_key = f.item_key
GROUP BY i.item_name
ORDER BY Number_of_Orders;
-- 3. Top & Bottom 10 Customers by Total Expenditure
SELECT TOP 10
    c.name,
    SUM(f.quantity * f.unit_price) AS Total_Sales
FROM silver.customer_dim c
LEFT JOIN silver.fact_table f
    ON c.customer_key = f.customer_key
GROUP BY c.name
ORDER BY Total_Sales DESC;
-- 4. What district have a greatest and least number of orders?
SELECT TOP 10
    s.district AS district,
    COUNT(f.quantity) AS Number_of_Orders
FROM silver.store_dim s
LEFT JOIN silver.fact_table f
    ON s.store_key = f.store_key
GROUP BY s.district
ORDER BY Number_of_Orders;
-- 5. What district have a greatest and least sales?
SELECT TOP 10
    s.district,
    SUM(f.quantity * f.unit_price) AS Total_Sales
FROM silver.store_dim s
LEFT JOIN silver.fact_table f
    ON s.store_key = f.store_key
GROUP BY s.district
ORDER BY Total_Sales;
-- 6. What year should have a largest sale
SELECT TOP 10
    t.year,
    SUM(f.quantity * f.unit_price) AS Total_Sales
FROM silver.time_dim t
LEFT JOIN silver.fact_table f
    ON t.time_key = f.time_key
GROUP BY t.year
ORDER BY Total_Sales;
-- 7. Month Trend analysis for the latest year by Sales
SELECT 
    DATENAME(MONTH, t.cleaned_datetime) AS Month_Name,
    MONTH(t.cleaned_datetime) AS Month_Number,
    YEAR(t.cleaned_datetime) AS Year,
    SUM(f.quantity * f.unit_price) AS Total_Sales
FROM silver.fact_table f
LEFT JOIN silver.time_dim t
    ON f.time_key = t.time_key
WHERE YEAR(t.cleaned_datetime) = (
    SELECT MAX(YEAR(cleaned_datetime)) 
    FROM silver.time_dim
)
GROUP BY 
    DATENAME(MONTH, t.cleaned_datetime),
    MONTH(t.cleaned_datetime),
    YEAR(t.cleaned_datetime)
ORDER BY 
    Total_Sales DESC;
-- 8. What transport is common use to transfer the amount?
SELECT
    tp.transport_type AS Mode_of_Transfer,
    COUNT(f.quantity) AS Number_of_Orders
FROM silver.transport_dim tp
LEFT JOIN silver.fact_table f
    ON tp.payment_key = f.payment_key
GROUP BY tp.transport_type
ORDER BY Number_of_Orders DESC;
-- 9. What country  has the largest sales by each year
SELECT Sales_Year, Country, Total_Sales
FROM (
    SELECT
        t.year AS Sales_Year, -- Use the existing column
        i.man_country AS Country,
        SUM(f.quantity * f.unit_price) AS Total_Sales,
        RANK() OVER (
            PARTITION BY t.year 
            ORDER BY SUM(f.quantity * f.unit_price) DESC
        ) as Sales_Rank
    FROM silver.item_dim i
    JOIN silver.fact_table f ON i.item_key = f.item_key
    JOIN silver.time_dim t ON f.time_key = t.time_key
    GROUP BY 
        t.year,          -- Must match the SELECT above
        i.man_country
) AS RankedSales
WHERE Sales_Rank = 1;
-- 10. Who are the suppliers has the largest sales by year
SELECT Sales_Year, Supplier, Total_Sales
FROM (
    SELECT
        t.year AS Sales_Year, -- Use the existing column
        i.supplier AS Supplier,
        SUM(f.quantity * f.unit_price) AS Total_Sales,
        RANK() OVER (
            PARTITION BY t.year 
            ORDER BY SUM(f.quantity * f.unit_price) DESC
        ) as Sales_Rank
    FROM silver.item_dim i
    JOIN silver.fact_table f ON i.item_key = f.item_key
    JOIN silver.time_dim t ON f.time_key = t.time_key
    GROUP BY 
        t.year,          -- Must match the SELECT above
        i.supplier
) AS RankedSales
WHERE Sales_Rank = 1;
-- Perform aggregations (e.g., total sales, average order value).
-- 1. What is the total orders by year?
-- 2. What are the popular product?
-- 3. What is the total sales?
-- 4. What is the Average order Value?
-- 5. What category had a largest sales?
-- 6. 



