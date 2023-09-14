-- 1. How many total orders are there in the dataset?

SELECT COUNT(DISTINCT f.Order_ID) AS TotalOrders FROM fact_table f;

-- 2. What is the total sales revenue for the given period?

SELECT SUM(f.Sales) AS TotalRevenue FROM fact_table f;

-- 3. What are the top 5 best-selling products by quantity ordered?

SELECT p.Product, sum(f.Quantity_Ordered) AS TotalQuantityOrdered
FROM fact_table f
INNER JOIN Product_details p ON f.Order_ID = p.Order_ID
GROUP BY p.Product
ORDER BY TotalQuantityOrdered DESC
LIMIT 5;

-- 4. How many orders were placed in each city?

SELECT f.City, COUNT(DISTINCT f.Order_ID) AS OrdersPlaced
FROM fact_table f
GROUP BY f.City;

-- 5. What is the total quantity ordered for each product in a specific state?

SELECT p.Product, f.State, SUM(f.Quantity_Ordered) AS TotalQuantityOrdered
FROM fact_table f
INNER JOIN Product_details p ON f.Order_ID = p.Order_ID
GROUP BY p.Product, f.State;

-- 6.What is the total sales revenue and quantity ordered for each product category in a specific state?

SELECT p.Product, f.State, SUM(f.Sales) AS TotalCategoryRevenue,
 SUM(f.Quantity_Ordered) AS TotalCategoryQuantityOrdered
FROM fact_table f
INNER JOIN Product_details p ON f.Order_ID = p.Order_ID
GROUP BY p.Product,f.State;

-- 7.which state produced or given more sales?

SELECT f.State, SUM(f.Sales) AS TotalStateSales
FROM fact_table f
GROUP BY f.State
ORDER BY TotalStateSales DESC
LIMIT 1;

-- 8.Top 1 city  produced highest sales from highest sales state?

WITH StateSales AS (
    SELECT f.State, SUM(f.Sales) AS TotalStateSales
    FROM fact_table f
    GROUP BY f.State
    ORDER BY TotalStateSales DESC
    LIMIT 1
)
SELECT f.City, SUM(f.Sales) AS TotalCitySales
FROM fact_table f
INNER JOIN StateSales s ON f.State = s.State
GROUP BY f.City
ORDER BY TotalCitySales DESC
LIMIT 1;