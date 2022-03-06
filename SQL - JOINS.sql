---JOINS

SELECT A.product_id, A.product_name, B.category_id, B.category_name
FROM product.product A
INNER JOIN product.category B
ON A.category_id = B.category_id;

SELECT B.first_name, B.last_name, A.store_name
FROM sale.store A
INNER JOIN sale.staff B
ON A.store_id = A.store_id;

--Write a query that returns count of orders of the states by months.

SELECT A.[state], YEAR(B.order_date) [YEAR], MONTH(B.order_date) [MONTH], COUNT(DISTINCT order_id) NUM_COUNT
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id
GROUP BY A.[state], YEAR(B.order_date), MONTH(B.order_date);

SELECT A.[state], YEAR(B.order_date) YEAR1, MONTH(B.order_date) MONTH1, COUNT (DISTINCT B.order_id) NUM_COUNT
FROM sale.customer A
INNER JOIN sale.orders B
ON A.customer_id = B.customer_id
GROUP BY A.[state], YEAR(B.order_date), MONTH(B.order_date)

SELECT A.product_id, A.product_name, B.order_id
FROM product.product A
LEFT JOIN sale.order_item B
ON A.product_id = B.product_id
WHERE order_id IS NULL


SELECT A.product_id, A.product_name, B.store_id, B.quantity
FROM product.product A
LEFT JOIN product.stock B
ON A.product_id = B.product_id
WHERE B.product_id > 310


SELECT A.product_id, A.product_name, B.store_id, B.quantity
FROM product.product A
RIGHT JOIN product.stock B
ON A.product_id = B.product_id
WHERE B.product_id > 310

SELECT A.staff_id, A.first_name,A.last_name, B.*
FROM sale.orders B
RIGHT JOIN sale.staff A
ON A.staff_id = B.staff_id

--- FULL OUTER JOIN

SELECT TOP 100 A.product_id, B.store_id,B.quantity, C.order_id, C.list_price
FROM product.product A
FULL OUTER JOIN product.stock B
ON A.product_id = B.product_id
FULL OUTER JOIN sale.order_item C
ON A.product_id = C.product_id


---SELF JOIN


SELECT a.first_name, B.first_name Manager_Name
FROM sale.staff A
JOIN sale.staff B
ON A.manager_id = B.staff_id

SELECT *
FROM sale.staff A

SELECT a.first_name, B.first_name Manager1_Name, C.first_name Manager2_Name
FROM sale.staff A
JOIN sale.staff B
ON A.manager_id = B.staff_id
JOIN sale.staff C 
ON B.manager_id = C.staff_id


---VIEW OLUSTURMA

CREATE VIEW CUSTOMER_PRODUCT
AS
SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'


SELECT * FROM [dbo].[CUSTOMER_PRODUCT]