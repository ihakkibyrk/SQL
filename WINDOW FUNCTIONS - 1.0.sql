

---WINDOW FUNCTION---

--- AGG Functions---

select product_id, sum(quantity) total_stock
from product.stock
group by product_id
order by product_id;


select	*, sum(quantity) over (partition by product_id) total_stock
from	product.stock
order by product_id


select brand_id, avg(list_price) over (partition by brand_id) avg_price
from product.product;


select distinct brand_id, avg(list_price) over (partition by brand_id) avg_price
from product.product;

select brand_id, avg(list_price) avg_price
from product.product
group by brand_id
order by brand_id;

select	distinct brand_id, avg(list_price) over(partition by brand_id) avg_price
from	product.product
order by 2 desc



SELECT	category_id, product_id,
		COUNT(*) OVER() NOTHING,
		COUNT(*) OVER(PARTITION BY category_id) countofprod_by_cat,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) whole_rows,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id) countofprod_by_cat_2,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) specified_columns_1,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) specified_columns_2
FROM	product.product
ORDER BY category_id, product_id


select distinct MIN(list_price) over () min_prod
from product.product

select distinct category_id, MIN(list_price) over (PARTITION BY category_id) cheapest_by_cat
from product.product



select	distinct category_id, min(list_price) over(partition by category_id) cheapest_by_cat
from	product.product
;

select	*
from	(
		select	product_id, product_name, list_price, min(list_price) over() cheapest
		from	product.product
		) A
where	A.list_price = A.cheapest
;

select count(product_id) num_of_prod
from product.product


select distinct count(*) over()
from product.product

-- write a query that returns how many products are in each order?

select distinct order_id, count(item_id) over(partition by order_id) cnt_prod
from sale.order_item;


select distinct category_id, brand_id, count(*) over (partition by category_id, brand_id) num_of_catbr
from product.product
order by category_id, brand_id


--- Navigation Functions --


select	distinct first_value(product_name) over (order by list_price) cheapest_product
from	product.product



select	distinct
		first_value(product_name) over (order by list_price, model_year DESC) cheapest_product_name,
		first_value(list_price) over (order by list_price, model_year DESC) cheapest_product_price
from	product.product;


select	b.order_id, a.staff_id, a.first_name, a.last_name, b.order_date,
		lag(b.order_date) over(partition by a.staff_id order by b.order_id) previous_order_date
from	sale.staff a, sale.orders b
where	a.staff_id = b.staff_id
order by a.staff_id, b.order_date

select	b.order_id, a.staff_id, a.first_name, a.last_name, b.order_date,
		lag(b.order_date, 2) over(partition by a.staff_id order by b.order_id) previous_order_date
from	sale.staff a, sale.orders b
where	a.staff_id = b.staff_id
order by a.staff_id, b.order_date
;


--- Analytic Functions---


---Herbir kategori içinde ürünlerin fiyat sýralamasýný yapýnýz (artan fiyata göre 1'den baþlayýp birer birer artacak)

SELECT	category_id, list_price,
		ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY list_price) Row_num
FROM	product.product
;


select	category_id, list_price,
		ROW_NUMBER() OVER(partition by category_id order by list_price ASC) Row_num
from	product.product
order by category_id, list_price


---Herbir kategori içinde ürünlerin fiyat sýralamasýný yapýnýz (artan fiyata göre 1'den baþlayýp birer birer artacak)

select	category_id, list_price,
		ROW_NUMBER() OVER(partition by category_id order by list_price ASC) Row_num,
		RANK() OVER(partition by category_id order by list_price ASC) Rank_num
from	product.product
order by category_id, list_price




select	category_id, list_price,
		ROW_NUMBER() OVER(partition by category_id order by list_price ASC) Row_num,
		RANK() OVER(partition by category_id order by list_price ASC) Rank_num,
		DENSE_RANK() OVER(partition by category_id order by list_price ASC) DenseRank_num
from	product.product
order by category_id, list_price



SELECT brand_id, list_price,
	   ROUND(CUME_DIST() OVER (partition by brand_id order by list_price),3) Cumulative_Dist
FROM product.product


SELECT	brand_id, list_price,
		ROUND (CUME_DIST() OVER (PARTITION BY brand_id ORDER BY list_price) , 3) AS CUM_DIST,
		ROUND (PERCENT_RANK() OVER (PARTITION BY brand_id ORDER BY list_price) , 3) AS PERCENT_RANK,
		NTILE(4) OVER (PARTITION BY brand_id ORDER BY list_price) AS NTILE_NUM,
		COUNT(*) OVER (PARTITION BY brand_id)
FROM	product.product
;

-- 1- Herbir sipariþin toplam fiyatý
-- 2- Ürünler liste fiyatý üzerinden satýlmýþ olsaydý sipariþlerin toplam fiyatý ne olurdur?

select	a.order_id, b.item_id, b.product_id, b.quantity, b.list_price, b.discount
from	sale.orders a, sale.order_item b
where	a.order_id = b.order_id
order by	a.order_id, b.item_id

-- 1- Herbir sipariþin toplam fiyatý
with tbl as (
select	a.order_id, b.item_id, b.product_id, b.quantity, b.list_price, b.discount,
		(b.list_price * (1 - b.discount)) * b.quantity ara_toplam,
		sum((b.list_price * (1 - b.discount)) * b.quantity) over(partition by a.order_id) siparis_toplami,
		sum(b.list_price * b.quantity) over(partition by a.order_id) siparis_toplami_liste_fiyati,
		sum(quantity) over(partition by a.order_id) urun_adedi
from	sale.orders a, sale.order_item b
where	a.order_id = b.order_id
)
select	distinct order_id, siparis_toplami, siparis_toplami_liste_fiyati, urun_adedi,
		1 - (siparis_toplami / siparis_toplami_liste_fiyati) discount_ratio_order
from	tbl
order by discount_ratio_order desc
;


-- Herbir ay için þu alanlarý hesaplayýnýz:
--  O aydaki toplam sipariþ sayýsý
--  Bir önceki aydaki toplam sipariþ sayýsý
--  Bir sonraki aydaki toplam sipariþ sayýsý
--  Aylara göre yýl içindeki kümülatif sipariþ yüzdesi

SELECT CONVERT(NVARCHAR(6), order_date, 112) ay,
		COUNT(*) OVER (PARTITION BY CONVERT(NVARCHAR(6), order_date, 112)) top_satis
FROM sale.orders



WITH tabl AS (
		SELECT DISTINCT YEAR(order_date) yil, 
				CONVERT(NVARCHAR(6), order_date, 112) ay,
			    COUNT(*) OVER (PARTITION BY CONVERT(NVARCHAR(6), order_date, 112)) top_satis
		FROM sale.orders
)

SELECT *,
		LAG (top_satis) OVER (ORDER BY ay) onceli_top_siparis,
		LEAD (top_satis) OVER (ORDER BY ay) onceli_top_siparis,
		CUME_DIST () OVER (PARTITION BY yil ORDER BY top_satis) kumulatif_yuzde
FROM tabl

