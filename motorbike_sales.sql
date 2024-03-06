USE `202403`;
SELECT * 
FROM sales;

/*Total Sales Amount by Product Line and Client Type*/
SELECT product_line, client_type, ROUND(SUM(total),2) AS total_sales_amount
FROM sales
GROUP BY product_line, client_type;

/*Average Price per Unit by Product Line*/
SELECT product_line, ROUND(AVG(unit_price),2) AS avg_price_per_unit
FROM sales
GROUP BY product_line
ORDER BY avg_price_per_unit DESC;

/*Total Sales by Payment Method*/
SELECT payment AS payment_method, ROUND(SUM(total),2) AS total_sales_amount
FROM sales
GROUP BY payment_method;

/* Average Total Amount Per Order by Date */
SELECT DATE(date) AS order_date, ROUND(AVG(total),2) AS avg_total_amount_per_order
FROM sales
GROUP BY DATE(date)
ORDER BY avg_total_amount_per_order DESC;

/*Top 5 Products by Total Sales Amount*/
SELECT product_line, ROUND(SUM(total),2) AS total_sales_amount
FROM sales
GROUP BY product_line
ORDER BY total_sales_amount DESC
LIMIT 5;


/* Create a query to return product_line, the month from date, displayed as 'June', 'July', and 'August', the warehouse, and net_revenue*/
SELECT product_line,
    CASE WHEN MONTH(date) = 6 THEN 'June'
         WHEN MONTH(date) = 7 THEN 'July'
         WHEN MONTH(date) = 8 THEN 'August'
    END as month
    ,warehouse
    ,ROUND(SUM(total * (1 - payment_fee)), 2) AS net_revenue
FROM sales
WHERE client_type = 'Wholesale'
GROUP BY product_line, warehouse, month
ORDER BY product_line, month, net_revenue DESC;
