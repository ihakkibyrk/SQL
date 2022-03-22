
CREATE TABLE Actions
	(Visitor_ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	Adv_Type VARCHAR(255) NULL,
	[Action] VARCHAR(255) NULL);


INSERT Actions
	VALUES ('A', 'LEFT');

INSERT Actions
	VALUES ('A', 'ORDER'),
		   ('B', 'LEFT');

INSERT Actions
	VALUES ('A', 'ORDER'),
		   ('A', 'REVIEW'),
		   ('A', 'LEFT'),
		   ('B', 'LEFT'),
		   ('B', 'ORDER'),
		   ('B', 'REVIEW'),
		   ('A', 'REVIEW');


SELECT *
FROM Actions;


SELECT Adv_Type ,COUNT([Action]) num_action, 
	COUNT(CASE [Action]
		WHEN 'ORDER' THEN 1
		ELSE NULL
	END) num_order, ROUND(CAST(COUNT(CASE [Action]
										WHEN 'ORDER' THEN 1
										ELSE NULL
										END) AS FLOAT) / CAST(COUNT([Action]) AS FLOAT),2) conversion_rate
FROM Actions 
GROUP BY Adv_Type;


 