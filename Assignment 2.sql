
CREATE VIEW CUSTOMER_PRODUCT
AS
SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD';


CREATE VIEW First_product
AS
SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = 'Polk Audio - 50 W Woofer - Black';

CREATE VIEW Second_product
AS
SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)';

CREATE VIEW Third_product
AS
SELECT	distinct D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)';

SELECT A.*, NULLIF(ISNUMERIC(B.customer_id),2) First_product, NULLIF(ISNUMERIC(C.customer_id),2) Second_product,NULLIF(ISNUMERIC(D.customer_id),2) Third_product
FROM [dbo].[CUSTOMER_PRODUCT] A
LEFT JOIN [dbo].[First_product] B
ON A.customer_id = B.customer_id
LEFT JOIN Second_product C
ON A.customer_id = C.customer_id
LEFT JOIN Third_product D
ON A.customer_id = D.customer_id;