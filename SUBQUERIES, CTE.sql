

---Single Row Subqueries
--- Using with operators <,>,<>, =

SELECT *
FROM sale.staff
WHERE store_id = (
	SELECT store_id
	FROM sale.staff
	WHERE first_name = 'Davis' AND last_name = 'Thomas');

SELECT *
FROM sale.staff
WHERE manager_id = (
	SELECT staff_id
	FROM sale.staff
	WHERE first_name = 'Charles' AND last_name = 'Cussona'
);


SELECT first_name, last_name, city
FROM sale.customer
WHERE city = (
	SELECT city
	FROM sale.store
	WHERE store_name = 'The BFLO Store'
);

SELECT *
FROM product.product
WHERE list_price > (
	SELECT list_price
	FROM product.product
	WHERE product_name = 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
) AND category_id=(SELECT category_id
				  FROM product.product
				  WHERE product_name='Pro-Series 49-Class Full HD Outdoor LED TV (Silver)')
;


---Multiple - rows Subqueries

--Used by IN, NOT IN, ANY, ALL

select b.first_name, b.last_name, a.order_date
from sale.orders a, sale.customer b
Where a.customer_id = b. customer_id AND order_date IN (
select order_date
FROM sale.orders
Where customer_id = (
	select customer_id
	from sale.customer
	where first_name = 'Laurel' AND last_name = 'Goldammer'
))  ;

select	b.first_name, b.last_name, a.order_date
from	sale.orders a, sale.customer b
where	a.customer_id = b.customer_id and
		a.order_date IN (
			select	a.order_date
			from	sale.orders a, sale.customer b
			where	a.customer_id = b.customer_id and
					b.first_name = 'Laurel' and
					b.last_name = 'Goldammer'
		)


select product_name, list_price
from product.product
where model_year = 2021 AND category_id NOT IN (
	select category_id
	from product.category 
	Where category_name IN ('Game', 'gps', 'Home Theater')
	);


select	*
from	product.product
where	model_year = 2021 and
		category_id NOT IN (
			select	category_id
			from	product.category
			where	category_name in ('Game', 'gps', 'Home Theater')
)



select	list_price
from	product.product
where	model_year = 2020 and
		category_id IN (
			select	category_id
			from	product.category
			where	category_name = 'Receivers Amplifiers'
)

---ALL---

select product_name,model_year,list_price
from product.product
where model_year = 2020 AND list_price > ALL (
	select	list_price
	from	product.product
	where	category_id IN (
				select	category_id
				from	product.category
				where	category_name = 'Receivers Amplifiers'
			)
) ORDER BY list_price DESC ;

--- ANY---

select product_name,model_year,list_price
from product.product
where model_year = 2020 AND list_price > ANY (
	select	list_price
	from	product.product
	where	category_id IN (
				select	category_id
				from	product.category
				where	category_name = 'Receivers Amplifiers'
			)
) ORDER BY list_price DESC ;


--- Correlated subqueries---


select distinct state
from sale.customer d
Where  NOT EXISTS (
select e.state
from sale.orders a, sale.order_item b, product.product c, sale.customer e
Where a.order_id = b.order_id and
	  b.product_id = c.product_id and
	  c.product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White' and
	  a.customer_id = e.customer_id and
	  d.state = e.state
  
);


SELECT DISTINCT B.customer_id, B.first_name, B.last_name
FROM sale.orders A, sale.customer B 
WHERE A.customer_id = B.customer_id
    AND NOT EXISTS (
		SELECT *
		FROM sale.orders C
		WHERE order_date < '2020-01-01' AND A.customer_id = C.customer_id);


--- Common Table Expressions--- CTE

-- WITH - Jerald Berray
WITH table_name AS (
		SELECT	MAX(B.order_date) last_order_date
		FROM	sale.customer A, sale.orders B
		WHERE	A.first_name = 'Jerald' AND
					A.last_name = 'Berray' AND
					A.customer_id = B.customer_id
	)
SELECT	*
FROM	table_name

--- Recursive CTE
;
with tablenumber as (
	select 1 number

	union all
	select number + 1
	from tablenumber
	where number < 10
)
select *
from tablenumber;
 