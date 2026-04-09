# Project : Ecommerce Data Analysis 

-- Total spending for each customer. (using JOIN)
SELECT
	c.customer_id,
    c.customer_name,
    c.email_address,
    c.gender,
    SUM(total_amount) AS Total_spent,
    signup_date,
    country
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY Total_spent DESC;



-- The total spend and average spend For each customer who order more than 1. ( JOIN, CTEs )
WITH  customer_orders AS (
SELECT
	customer_id,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_spend
FROM orders
GROUP BY customer_id)
SELECT 
	c.customer_id,
	c.customer_name,
	co.total_orders,
	co.total_spend,
	ROUND(co.total_spend /co.total_orders,2) AS avg_order_value
FROM customer_orders co
JOIN customers c 
	ON co.customer_id = c.customer_id
WHERE total_orders > 1
ORDER BY avg_order_value DESC,
		 total_orders DESC;	
         
 
 
 -- The member tier according to total_spend ( CASE, CTEs )
WITH customer_total_spend AS (
SELECT 
	customer_id,
    SUM(total_amount) AS total_spend
FROM orders
GROUP BY customer_id
)
SELECT 
	c.customer_id,
    c.customer_name,
    c.gender,
    c.signup_date,
    cts.total_spend,
    CASE 
		WHEN cts.total_spend > 2500 THEN "Gold Member"
        WHEN cts.total_spend > 1000 THEN "Silver Member"
        ELSE "Bronze"
        END AS Member_Tier
FROM customer_total_spend cts
JOIN customers c
	ON cts.customer_id = c.customer_id
ORDER BY total_spend DESC;



-- Customer order ranking and running total by total_amount ( WINDOW FUNCTION , CTEs )
WITH rank_orders AS (
SELECT
	 customer_id,
     order_id,
     order_date,
     total_amount,
     SUM(total_amount) OVER (PARTITION BY customer_id ) AS total_spent_by_customer,
     SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY total_amount DESC) AS running_total,
     RANK() OVER(PARTITION BY customer_id ORDER BY total_amount DESC) AS rank_num
FROM orders)
SELECT * 
FROM rank_orders;



-- The privious order and The next order for each customer ( WINDOW FUNCTION, LEAD/LAG )
SELECT 
	customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order,
    LEAD(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS next_order
FROM orders;



-- The Customer Who order more than 5 quantity. ( SUBQUERY )
SELECT * 
FROM customers 
WHERE customer_id IN ( 
						SELECT customer_id
                        FROM orders
                        WHERE order_id IN (
											SELECT order_id
                                            FROM order_items
                                            WHERE quantity > 5));
							
                    
				
-- The Unit Price For Each Category. ( JOIN , GROUP BY )
SELECT
	p.category,
    SUM(o.unit_price) AS category_unit_price
    FROM product p
JOIN order_items o
	ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY category_unit_price DESC;



-- The count for each gender. ( COUNT , GROUP BY )
SELECT 
	gender,
    COUNT(customer_id) AS gender_count
FROM customers
GROUP BY gender;



-- Top three country where customers live the most ( ORDER BY , GROUP BY )
SELECT
	country AS top_three_country,
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC
LIMIT 3;



-- Question: The customer who signup during 2024.
SELECT *
FROM customers
WHERE signup_date BETWEEN "2024-01-01" AND "2024-12-31";



-- The orders which pay with bank transfer.
SELECT *
FROM orders
WHERE payment_method = "Bank Transfer";



-- Top Three Payment Method. ( GROUP BY, ORDER BY, LIMIT )
SELECT
	payment_method,
    COUNT(order_id) AS payment_count
FROM orders
GROUP BY payment_method
ORDER BY payment_count DESC
LIMIT 3;



-- The number of product in each category. ( COUNT , GROUP BY )
SELECT
	category,
    COUNT(product_name) AS product_quantity
FROM product
GROUP BY category;



-- The produt which stock quantity is blow 30. ( WHERE )
SELECT *
FROM product
WHERE stock_quantity < 30;
