SELECT *
FROM nigerian_retail_and_ecommerce_point_of_sale_records

-- DATA CLEANING
--CHECK FOR DUPLICATES

SELECT transaction_id, COUNT(*)
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY transaction_id 
HAVING COUNT(*) > 1;

--CHECK FOR MISSING VALUES
SELECT *
FROM nigerian_retail_and_ecommerce_point_of_sale_records
WHERE total_amount_ngn IS NULL
   OR transaction_date IS NULL
   OR store_name IS NULL;

--CHECK FOR NEGATIVE OR ZERO VALUES
SELECT *
FROM nigerian_retail_and_ecommerce_point_of_sale_records
WHERE total_amount_ngn <= 0;


--DATA ANALYSIS
-- ANALYSIS OF THE TOTAL REVENUE
SELECT 
    SUM(total_amount_ngn) AS total_revenue
FROM nigerian_retail_and_ecommerce_point_of_sale_records;

-- TOTAL REVENUE BY STORES
SELECT 
    store_name,
    SUM(total_amount_ngn) AS store_revenue
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY store_name
ORDER BY store_revenue DESC;

--TOTAL REVENUES BY CITIES
SELECT 
    city,
    SUM(total_amount_ngn) AS city_revenue
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY city
ORDER BY city_revenue DESC;

--ANALYSIS OF TOTAL REVENUE PER MONTH
SELECT 
    FORMAT(transaction_date, 'yyyy-MM') AS month,
    SUM(total_amount_ngn) AS monthly_sales
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY FORMAT(transaction_date, 'yyyy-MM')
ORDER BY month;

--TOTAL REVENUE OF EACH STORE BY MONTH

SELECT store_name, FORMAT(transaction_date, 'yyyy-MM') AS month, SUM(total_amount_ngn) AS monthly_sales
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY FORMAT(transaction_date, 'yyyy-MM'), store_name
ORDER BY store_name, month

--TOTAL REVENUE OF EACH CITY BY MONTH

SELECT city, FORMAT(transaction_date, 'yyyy-MM') AS month, SUM(total_amount_ngn) AS monthly_sales
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY FORMAT(transaction_date, 'yyyy-MM'), city
ORDER BY city, month

-- ANALYSIS OF TOTAL REVENUE WITH AND WITHOUT DISCOUNT

SELECT 
    COUNT(discount_applied), discount_applied
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY discount_applied;

SELECT 
    discount_applied,
    COUNT(*) AS transactions,
    SUM(total_amount_ngn) AS revenue
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY discount_applied;

--ANALYSIS OF AVERAGE REVENUE WITH AND WITHOUT DISCOUNT
SELECT 
    discount_applied,
    AVG(total_amount_ngn) AS avg_transaction_value
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY discount_applied;

--ANALYSIS ON THE TOTAL AND AVERAGE REVENUE ON PAYMENT METHODS

SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(total_amount_ngn) AS total_revenue, AVG(total_amount_ngn) AS avg_payment_value
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY payment_method
ORDER BY transaction_count DESC;

--ANALYSIS ON THE CASHIER PERFORMANCE BY REVENUE

SELECT 
    cashier_id,
    COUNT(*) AS transactions_handled,
    SUM(total_amount_ngn) AS total_sales
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY cashier_id
ORDER BY total_sales DESC;

--ANALYSIS ON THE LOYALTY POINTS EARNED
-- Loyalty points earned by stores
SELECT 
    store_name,
    SUM(loyalty_points_earned) AS total_loyalty_points
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY store_name
ORDER BY total_loyalty_points DESC;

-- loyalty points earned by city
SELECT 
    city,
    SUM(loyalty_points_earned) AS total_loyalty_points
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY city
ORDER BY total_loyalty_points DESC;

-- if loyalty points is affected by the discount applied
SELECT 
    discount_applied,
    SUM(loyalty_points_earned) AS total_loyalty_points, AVG(loyalty_points_earned) as avg_loyalty_points
FROM nigerian_retail_and_ecommerce_point_of_sale_records
GROUP BY discount_applied
ORDER BY total_loyalty_points DESC;

-- CREATE VIEWS FOR VISUALIZATION
CREATE VIEW 
sales_summary AS
SELECT
    store_name,
    city,
    transaction_date,
    total_amount_ngn,
    discount_applied,
    payment_method
FROM nigerian_retail_and_ecommerce_point_of_sale_records;
