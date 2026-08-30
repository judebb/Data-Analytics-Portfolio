--More advanced queries (window functions, joins, partitioning)

-- Top 3 best-selling products per category
WITH product_revenue AS (
  SELECT
    p.Product_ID,
    p.Category,
    SUM(s.Total_Amount) AS total_revenue
  FROM `curious-ocean-470707-q6.sql_practice.sales` s
  JOIN `curious-ocean-470707-q6.sql_practice.products` p
    ON s.Product_ID = p.Product_ID
  GROUP BY p.Product_ID, p.Category
),
ranked AS (
  SELECT
    Product_ID,
    Category,
    total_revenue,
    RANK() OVER (PARTITION BY Category ORDER BY total_revenue DESC) AS rank_in_category
  FROM product_revenue
)
SELECT *
FROM ranked
WHERE rank_in_category <= 3;


-- % growth of revenue (Month-to-Month)
WITH monthly AS (
  SELECT
    EXTRACT(YEAR FROM Order_Date) AS yr,
    EXTRACT(MONTH FROM Order_Date) AS mo,
    SUM(Total_Amount) AS revenue
  FROM `curious-ocean-470707-q6.sql_practice.sales`
  GROUP BY yr, mo
)
SELECT
  yr,
  mo,
  revenue,
  LAG(revenue) OVER (ORDER BY yr, mo) AS prev_month_revenue,
  ROUND(
    (revenue - LAG(revenue) OVER (ORDER BY yr, mo))
    / LAG(revenue) OVER (ORDER BY yr, mo) * 100,
    2
  ) AS pct_growth
FROM monthly
ORDER BY yr, mo;


-- Customers whose most recent order was above their usual average order value
WITH customer_orders AS (
  SELECT
    Customer_ID,
    Order_ID,
    Order_Date,
    Total_Amount,
    AVG(Total_Amount) OVER (PARTITION BY Customer_ID) AS customer_avg,
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Order_Date DESC) AS rn
  FROM `curious-ocean-470707-q6.sql_practice.sales`
)
SELECT
  c.Customer_ID,
  c.Customer_Name,
  co.Total_Amount AS most_recent_order_value,
  co.customer_avg
FROM customer_orders co
JOIN `curious-ocean-470707-q6.sql_practice.customers` c
  ON co.Customer_ID = c.Customer_ID
WHERE co.rn = 1
  AND co.Total_Amount > co.customer_avg;
