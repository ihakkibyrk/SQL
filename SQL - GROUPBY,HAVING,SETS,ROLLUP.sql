--- Advanced Grouping

--- AGG FUNC -- AVG, MIN, MAX, SUM, COUNT

-- ORDER -- FROM -> WHERE  -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT

---Write a query that checks if any product id is repeated in more than one row in the product table.


SELECT product_id, COUNT(product_id) num_product
FROM product.product
GROUP BY product_id
HAVING COUNT(product_id) > 1


SELECT category_id, MAX(list_price) max_price, MIN(list_price) min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500


----

--Find the average product prices of the brands.
--As a result of the query, the average prices should be displayed in descending order.
--Markalara ait ortalama ürün fiyatlarýný bulunuz.
--ortalama fiyatlara göre azalan sýrayla gösteriniz.

SELECT B.brand_name, AVG(A.list_price) avg_list_price
FROM product.product A
INNER JOIN product.brand B
ON A.brand_id = B.brand_id
GROUP BY B.brand_name
ORDER BY AVG(A.list_price) DESC

---
--Write a query that returns BRANDS with an average product price of more than 1000.

SELECT B.brand_name, AVG(A.list_price) avg_list_price
FROM product.product A
INNER JOIN product.brand B
ON A.brand_id = B.brand_id
GROUP BY B.brand_name
HAVING AVG(A.list_price) > 1000
ORDER BY AVG(A.list_price) ASC


---- GROUPING SETS


SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary

FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year

-----

SELECT *
FROM sale.sales_summary


--- 1. Total sales price

SELECT SUM(total_sales_price) Total_Sales
FROM sale.sales_summary 

--- 2. total sales of brand

SELECT Brand, sum(total_sales_price) total_sales
FROM sale.sales_summary
GROUP BY Brand


--- 3. total sales price of categoruies

SELECT Category, SUM(total_sales_price) total_sales
FROM sale.sales_summary
GROUP BY Category


--- 4. by brand and category

SELECT Brand, Category, SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY 
	Brand, Category


SELECT Brand, Category, SUM(total_sales_price) total_sales
FROM sale.sales_summary
GROUP BY 
	GROUPING SETS(
	(),
	(Brand),
	(Category),
	(Brand,Category)
	)
ORDER BY Brand, Category

--- ROLLUP

--Generate different grouping variations that can be produced with the brand and category columns using 'ROLLUP'.
-- Calculate sum total_sales_price
--brand, category, model_year sütunlarý için Rollup kullanarak total sales hesaplamasý yapýn.
--üç sütun için 4 farklý gruplama varyasyonu üretiyor

SELECT brand,category, model_year, sum(total_sales_price)
FROM sale.sales_summary
GROUP BY
	ROLLUP (Brand, Category, Model_Year)
ORDER BY model_year, category

---- CUBE---

SELECT brand,category, model_year, sum(total_sales_price) total_sales
FROM sale.sales_summary
GROUP BY
	CUBE (Brand, Category, Model_Year)
ORDER BY brand, category, Model_Year


---- PIVOT

--- NOT USED BY GROUP BY

SELECT *
FROM
(
SELECT Category, total_sales_price
FROM sale.sales_summary
) A
PIVOT 
(
SUM(total_sales_price)
FOR category
IN ([Audio & Video Accessories]
	,[Bluetooth]
	,[Car Electronics]
	,[Computer Accessories]
	,[Earbud]
	,[gps]
	,[Hi-Fi Systems]
	,[Home Theater]
	,[mp4 player]
	,[Receivers Amplifiers]
	,[Speakers]
	,[Televisions & Accessories]) 
)
AS pivot_category

select distinct '[' + category + '],' from sale.sales_summary


