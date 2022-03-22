

--- Generate a report including product IDs and discount effects on whether the increase in the discount rate positively impacts the number of orders for the products.


;
WITH tbl AS (
SELECT product_id, discount,
		COUNT(order_id) OVER (PARTITION BY product_id) num_orders_prod,
		COUNT(order_id) OVER (PARTITION BY product_id, discount) num_orders_prod_dis
								
FROM sale.order_item

), tbl2 as (
SELECT DISTINCT product_id, discount, num_orders_prod, num_orders_prod_dis,
				STDEV(discount) OVER (partition by product_id) AS Stdev_dis,
				STDEV(num_orders_prod_dis) OVER (partition by product_id) AS Stdev_dis_prod,
				( discount - AVG(discount) over(partition by product_id)) * ( num_orders_prod_dis - AVG(num_orders_prod_dis) over(partition by product_id)) AS ExpectedValue

FROM tbl

) 
SELECT product_id,
	(SUM(ExpectedValue) over(partition by product_id) / (num_orders_prod - 1 )) / ( Stdev_dis * Stdev_dis_prod ) AS Correlation,
	CASE 
		WHEN (SUM(ExpectedValue) over(partition by product_id) / (num_orders_prod - 1 )) / ( Stdev_dis * Stdev_dis_prod ) > 0 THEN 'Positive'
		WHEN (SUM(ExpectedValue) over(partition by product_id) / (num_orders_prod - 1 )) / ( Stdev_dis * Stdev_dis_prod ) < 0 THEN 'Negative'
		ELSE 'Neutral'
	END discount_effect
FROM tbl2
WHERE Stdev_dis IS NOT NULL AND Stdev_dis <> 0 AND Stdev_dis_prod IS NOT NULL AND Stdev_dis_prod <> 0




