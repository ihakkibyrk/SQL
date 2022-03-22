--- UNION 

--- same number of columns and same data type

SELECT last_name, city
FROM sale.customer
WHERE city = 'Charlotte'
UNION ALL
SELECT last_name, city
FROM sale.customer
WHERE city ='Aurora'
ORDER BY city

SELECT last_name, city
FROM sale.customer
WHERE city = 'Charlotte'
UNION 
SELECT last_name, city
FROM sale.customer
WHERE city ='Aurora'
ORDER BY city

SELECT Distinct last_name, city
FROM sale.customer
WHERE city IN ('Charlotte', 'Aurora')

SELECT first_name, last_name
FROM sale.customer
WHERE last_name = 'Thomas'
UNION ALL
SELECT first_name, last_name
FROM sale.customer
WHERE first_name ='Thomas'

SELECT first_name, last_name
FROM sale.customer
WHERE last_name = 'Thomas' OR first_name = 'Thomas'
ORDER BY last_name


----
---Ayni data type alt alta getirir.

SELECT *
FROM product.brand
UNION
SELECT *
FROM product.category

----
--- Ayni data type farkli column getirmez.

SELECT city, 'CLEAN' AS STREET
FROM sale.store
UNION
SELECT city
FROM sale.store

--- INTERSECT 

SELECT A.brand_id, A.brand_name
FROM product.brand A, product.product B
WHERE A.brand_id = B.brand_id AND model_year = 2018
INTERSECT
SELECT A.brand_id, A.brand_name
FROM product.brand A, product.product B
WHERE A.brand_id = B.brand_id AND model_year = 2019


SELECT A.first_name, A.last_name
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id AND YEAR(B.order_date) = 2018
INTERSECT
SELECT A.first_name, A.last_name
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id AND YEAR(B.order_date) = 2019
INTERSECT
SELECT A.first_name, A.last_name
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id AND YEAR(B.order_date) = 2020

------- Write a query that returns customers who have orders for both 2018, 2019, and 2020
SELECT first_name, last_name
FROM sale.customer
WHERE customer_id IN
(
SELECT customer_id
FROM sale.orders
WHERE order_date BETWEEN '2018-01-01' AND '2018-12-31'
INTERSECT
SELECT customer_id
FROM sale.orders
WHERE order_date BETWEEN '2019-01-01' AND '2019-12-31'
INTERSECT
SELECT customer_id
FROM sale.orders
WHERE order_date BETWEEN '2020-01-01' AND '2020-12-31'
)


--- EXCEPT

SELECT A.brand_id, A.brand_name
FROM product.brand A, product.product B
WHERE A.brand_id = B.brand_id AND model_year = 2018
EXCEPT
SELECT A.brand_id, A.brand_name
FROM product.brand A, product.product B
WHERE A.brand_id = B.brand_id AND model_year = 2019

---- Farkli bir cozum


SELECT *
FROM product.brand
WHERE brand_id IN
(
SELECT brand_id
FROM product.product
WHERE model_year = 2018
EXCEPT
SELECT brand_id
FROM product.product
WHERE model_year = 2019
)



