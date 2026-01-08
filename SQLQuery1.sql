SELECT * FROM pizza_sales

-- Retrun Total revenue of the pizza sold
select sum(total_price) AS Total_Revenue from pizza_sales

-- Average order value (dividing the sum of total prices by total number of orders)
SELECT SUM(total_price) / COUNT(DISTINCT order_id) as Avg_order_value from pizza_sales

-- Total pizza sold
SELECT SUM(quantity) AS Total_pizza_sold from pizza_sales

-- Total orders 
SELECT COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales

-- Average pizza per order 
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) as avg_pizza_per_order from pizza_sales

-- Daily trends for total orders
SELECT DATENAME(DW,order_date) AS Order_Day , COUNT(DISTINCT order_id) as Total_orders from pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Montlhly trends for total orders
SELECT DATENAME(MONTH ,order_date) AS Month_Day , COUNT(DISTINCT order_id) as Total_orders from pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_orders DESC

-- % of sales by pizza category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS Total_sales
from pizza_sales
GROUP BY pizza_category

-- % of sales by pizza size
SELECT pizza_size, cast(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter, order_date)=1) AS DECIMAL(10,2)) AS Total_sales
from pizza_sales
where DATEPART(quarter,order_date)=1
GROUP BY pizza_size
ORDER BY Total_sales DESC

-- Top 5 best selling pizza based on revenue
SELECT TOP 5 pizza_name , sum(total_price) as Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

-- Bottom 5 best selling pizza based on revenue
SELECT TOP 5 pizza_name , sum(total_price) as Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 best selling pizza based on quantity
SELECT TOP 5 pizza_name , sum(quantity) as Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Bottom 5 best selling pizza based on quantity
SELECT TOP 5 pizza_name , sum(quantity) as Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- Top 5 best selling pizza based on total orders
SELECT TOP 5 pizza_name , sum(distinct order_id) as Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Bottom 5 best selling pizza based on total orders
SELECT TOP 5 pizza_name , sum(distinct order_id) as Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC