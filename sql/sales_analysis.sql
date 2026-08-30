--Performed exploratory data analysis and data cleaning on sales data from an online dropshipping business /
--Built summary tables to surface insights on order completion rates and other key performance metrics  /
--Used Google BigQuery for SQL execution


EXPLORATORY ANALYSIS:

-- Total Revenue per Payment Method
SELECT
  Payment_Mode,
  COUNT(*) AS Payment_Mode_Count,
  SUM(Total_Amount) AS total_revenue
FROM `curious-ocean-470707-q6.sql_practice.sales_data`
GROUP BY Payment_Mode
ORDER BY total_revenue DESC;


--Avg delivery time by state
SELECT
  State,
  AVG(DATE_DIFF(Delivery_Date, Order_Date, DAY)) AS avg_delivery_days
FROM `curious-ocean-470707-q6.sql_practice.sales`
GROUP BY State
ORDER BY avg_delivery_days DESC;


-- Data integrity check: does customers.Total_Spent match actual sales sum
SELECT
  c.Customer_ID,
  c.Total_Spent AS stated_spend,
  SUM(s.Total_Amount) AS actual_spend,
  c.Total_Spent - SUM(s.Total_Amount) AS difference
FROM `curious-ocean-470707-q6.sql_practice.customers` c
JOIN `curious-ocean-470707-q6.sql_practice.sales` s
  ON c.Customer_ID = s.Customer_ID
GROUP BY c.Customer_ID, c.Total_Spent
HAVING ABS(c.Total_Spent - SUM(s.Total_Amount)) > 1
ORDER BY difference DESC;


--Monthly revenue trend, 2025 vs 2026
SELECT
  EXTRACT(YEAR FROM Order_Date) AS order_year,
  EXTRACT(MONTH FROM Order_Date) AS order_month,
  SUM(Total_Amount) AS revenue
FROM `curious-ocean-470707-q6.sql_practice.sales`
WHERE EXTRACT(YEAR FROM Order_Date) IN (2025, 2026)
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


--Top 10 customers (total amount spent)
SELECT
  c.Customer_ID,
  c.Customer_Name,
  c.Customer_Tier,
  SUM(s.Total_Amount) AS recalculated_spend
FROM `curious-ocean-470707-q6.sql_practice.sales` s
JOIN `curious-ocean-470707-q6.sql_practice.customers` c
  ON s.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name, c.Customer_Tier
ORDER BY recalculated_spend DESC
LIMIT 10;


--Orders by hour of day
SELECT
  EXTRACT(HOUR FROM Order_Time) AS order_hour,
  COUNT(*) AS num_orders
FROM `curious-ocean-470707-q6.sql_practice.sales`
GROUP BY order_hour
ORDER BY order_hour;

