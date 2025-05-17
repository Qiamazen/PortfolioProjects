
SELECT * FROM pizza_sales

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

-- Average Order Value
SELECT SUM(total_price) / COUNT (DISTINCT order_id) AS Avergae_Order_Value FROM pizza_sales

-- Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

-- Average Pizzas per Order
SELECT 
CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS Average_Pizzas_per_Order 
FROM pizza_sales

-- Daily Trend for Total Orders
SELECT 
DATENAME(DW, order_date) AS Order_Day,
COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC

-- Hourly Trend for Total Orders
SELECT
	DATEPART(HOUR, order_time) AS Order_Hours,
	COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

-- Percentage of Sales by Pizza Category
SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100.0 / 
        (SELECT SUM(total_price) FROM pizza_sales)
    AS DECIMAL(5,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by Pizza Size
SELECT
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100.0 / 
        (SELECT SUM(total_price) FROM pizza_sales)
    AS DECIMAL(5,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_size

-- Total Pizzas Sold by Pizza Category
SELECT
	pizza_category,
	SUM(quantity) AS pizza_quantity
FROM pizza_sales
GROUP BY pizza_category

-- Top 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- Bottom 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;
