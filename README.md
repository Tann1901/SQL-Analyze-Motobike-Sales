# SQL-Analyze-Motobike-Sales

## Introduction:

The provided dataset offers insights into sales transactions recorded within the specified timeframe. The dataset contains information such as the order ID, date of transaction, location, client type, product line, quantity, unit price, total amount, payment method, and payment fee. Leveraging SQL queries, I aim to extract meaningful insights and perform analyses on this dataset to understand various aspects of the sales performance.

## About Dataset
| Column        | Data Type | Description                                                |
|---------------|-----------|------------------------------------------------------------|
| order_number  | VARCHAR   | Unique order number.                                       |
| date          | DATE      | Date of the order, from June to August 2021.               |
| warehouse     | VARCHAR   | The warehouse that the order was made from— North, Central, or West. |
| client_type   | VARCHAR   | Whether the order was Retail or Wholesale.                 |
| product_line  | VARCHAR   | Type of product ordered.                                   |
| quantity      | INT       | Number of products ordered.                                |
| unit_price    | FLOAT     | Price per product (dollars).                                |
| total         | FLOAT     | Total price of the order (dollars).                         |
| payment       | VARCHAR   | Payment method—Credit card, Transfer, or Cash.             |
| payment_fee   | FLOAT     | Percentage of total charged as a result of the payment method. |


## Analyzation
```
USE `202403`;
SELECT * 
FROM sales;
```
```
/*Total Sales Amount by Product Line and Client Type*/
SELECT product_line, client_type, ROUND(SUM(total),2) AS total_sales_amount
FROM sales
GROUP BY product_line, client_type;
```

![image](https://github.com/Tann1901/SQL-Analyze-Motobike-Sales/assets/108020327/6dc9e1b2-1536-4dd0-a0d0-69cc936d16e9)

```
/*Average Price per Unit by Product Line*/
SELECT product_line, ROUND(AVG(unit_price),2) AS avg_price_per_unit
FROM sales
GROUP BY product_line
ORDER BY avg_price_per_unit DESC;
```
![image](https://github.com/Tann1901/SQL-Analyze-Motobike-Sales/assets/108020327/437c0a5a-3cfb-4aa7-be4f-9f1cdab3c532)

```
/*Total Sales by Payment Method*/
SELECT payment AS payment_method, ROUND(SUM(total),2) AS total_sales_amount
FROM sales
GROUP BY payment_method;
```
![image](https://github.com/Tann1901/SQL-Analyze-Motobike-Sales/assets/108020327/d17ca044-86f2-47a8-b81d-cc16e9c5af36)

```
/* Average Total Amount Per Order by Date */
SELECT DATE(date) AS order_date, ROUND(AVG(total),2) AS avg_total_amount_per_order
FROM sales
GROUP BY DATE(date)
ORDER BY avg_total_amount_per_order DESC;
```
![image](https://github.com/Tann1901/SQL-Analyze-Motobike-Sales/assets/108020327/c79c27a9-9cde-4493-abb4-e520413975e5)

```
/*Top 5 Products by Total Sales Amount*/
SELECT product_line, ROUND(SUM(total),2) AS total_sales_amount
FROM sales
GROUP BY product_line
ORDER BY total_sales_amount DESC
LIMIT 5;
```
![image](https://github.com/Tann1901/SQL-Analyze-Motobike-Sales/assets/108020327/5ac4b42d-da7c-4309-9a11-f014f9b067cf)

```
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
```
![image](https://github.com/Tann1901/SQL-Analyze-Motobike-Sales/assets/108020327/9b234b39-97a1-46df-aed4-f0c166773ad6)


