--- Built in Functions---

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
);

SELECT * FROM t_date_time;

SELECT GETDATE();

INSERT t_date_time 
	VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE());

INSERT t_date_time (A_time, A_date, A_smalldatetime, A_datetime, A_datetime2, A_datetimeoffset)
	VALUES ('12:00:00', '2021-07-17', '2021-07-17','2021-07-17', '2021-07-17', '2021-07-17' );

------

SELECT CONVERT (VARCHAR,GETDATE(),7);

SELECT CONVERT(DATE, '25 OCT 21', 6);

----

SELECT	A_date,
		DATENAME(DW, A_date) [DAY],
		DATENAME(MONTH, A_date) [M_NAME],
		DAY (A_date) [DAY2],
		MONTH(A_date)[MONTH],
		YEAR (A_date)[YEAR],
		A_time,
		DATEPART (NANOSECOND, A_time),
		DATEPART (MONTH, A_date)
FROM	t_date_time;

SELECT DATEDIFF(HOUR,'30 MAR 94',GETDATE());

SELECT	A_date,	
		A_datetime,
		DATEDIFF (DAY, A_date, A_datetime) Diff_day,
		DATEDIFF (MONTH, A_date, A_datetime) Diff_month,
		DATEDIFF (YEAR, A_date, A_datetime) Diff_month,
		DATEDIFF (HOUR, A_smalldatetime, A_datetime) Diff_Hour,
		DATEDIFF (MINUTE, A_smalldatetime, A_datetime) Diff_Hour
FROM	t_date_time;

----

SELECT order_date, 
	   shipped_date,
	   DATEDIFF(DAY,order_date,shipped_date) DIFF_day
FROM sale.orders;

----

SELECT *
FROM sale.orders;


SELECT order_date,
	   DATEADD(YEAR,3, order_date) Year_added,
	   DATEADD(DAY,-5, order_date) Day_pre
FROM sale.orders;

SELECT EOMONTH(order_date) Last_date, order_date, EOMONTH(order_date, 2) last_2month
FROM sale.orders;

-----

SELECT ISDATE('123456');

SELECT ISDATE(GETDATE());


---LEN/CHARINDEX/PATINDEX

SELECT LEN(123456);

SELECT LEN('welcome');

---

SELECT CHARINDEX('C','CHARACTER');

SELECT CHARINDEX('C','CHARACTER',2);

SELECT CHARINDEX('CT','CHARACTER');

---

SELECT PATINDEX('%R', 'CHARACTER');

SELECT PATINDEX('R%', 'CHARACTER')

SELECT PATINDEX('%R%', 'CHARACTER');

SELECT PATINDEX('___R%', 'CHARACTER');

---

SELECT LEFT('CHARACTER', 3)

SELECT LEFT(' CHARACTER', 3)


SELECT RIGHT('CHARACTER', LEN('CHARACTER')-CHARINDEX('A','CHARACTER', 4))

SELECT SUBSTRING('CHARACTER', 3, 5)

SELECT SUBSTRING('CHARACTER', -1, 5) -- CHA returns

--- LOWER - UPPER -- STRING-SPLIT

SELECT LOWER('CHARACTER');

SELECT UPPER(LEFT('CHARACTER', 1))+SUBSTRING('character', 2,9);

SELECT UPPER(LEFT('CHARACTER', 1))+RIGHT('character', LEN('character')-1);

---

SELECT * FROM STRING_SPLIT ('John, Jeremy, Jack, George', ',')

--- TRIM --LTRIM -- RTRIM--

SELECT TRIM('            CHARACTER');

SELECT TRIM('            CHARACTER     ');

SELECT TRIM('            CHARA   CTER     '); -- returns CHARA CTER 

SELECT TRIM('?, ' FROM '    ?SQL Server,    ') AS TrimmedString;

SELECT LTRIM('            CHARACTER     ');


--- REPLACE -- STR

SELECT  REPLACE('CHARACTER STRING',' ','/');

SELECT STR(5454);

SELECT STR(1234565454);

SELECT STR(5454, 10, 5);


SELECT STR(5454.4376386526, 10, 5);

--- CAST --- CONVERT --COALESCE -- NULLIF -- ROUND

SELECT CAST (456123 AS CHAR);

SELECT CAST (456.123 AS INT);

SELECT CONVERT (INT, 30.60);

SELECT CONVERT (VARCHAR(10), '2020-10-10');

---

SELECT COALESCE(NULL, NULL, 'Hi', 'Hello') result;

SELECT NULLIF(10,10);

SELECT NULLIF('Hi', 'Hello');


SELECT ROUND(432.368,2,0)


SELECT ROUND(432.368,1,1)

SELECT ROUND(432.368,1,0)