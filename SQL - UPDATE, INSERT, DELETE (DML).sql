
CREATE DATABASE LibDatabase;

USE LibDatabase;

CREATE SCHEMA Book;

CREATE SCHEMA Person;

--create Book.Book table
CREATE TABLE [Book].[Book](
	[Book_ID] [int] PRIMARY KEY NOT NULL,
	[Book_Name] [nvarchar](50) NOT NULL,
	Author_ID INT NOT NULL,
	Publisher_ID INT NOT NULL
);

--create Book.Author table
CREATE TABLE [Book].[Author](
	[Author_ID] [int],
	[Author_FirstName] [nvarchar](50) Not NULL,
	[Author_LastName] [nvarchar](50) Not NULL
);

CREATE TABLE Book.Publisher (
	Publisher_ID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Publisher_Name nvarchar(100) NULL
);


CREATE TABLE [Person].[Person](
	[SSN] [bigint] PRIMARY KEY NOT NULL,
	[Person_FirstName] [nvarchar](50) NULL,
	[Person_LastName] [nvarchar](50) NULL
);

--create Person.Loan table
CREATE TABLE [Person].[Loan](
	[SSN] BIGINT NOT NULL,
	[Book_ID] INT NOT NULL,
	PRIMARY KEY ([SSN], [Book_ID])
);

--cretae Person.Person_Phone table
CREATE TABLE [Person].[Person_Phone](
	[Phone_Number] [bigint] PRIMARY KEY NOT NULL,
	[SSN] [bigint] NOT NULL	
	);

	--cretae Person.Person_Mail table
CREATE TABLE [Person].[Person_Mail](
	[Mail_ID] INT PRIMARY KEY IDENTITY (1,1),
	[Mail] NVARCHAR(MAX) NOT NULL,
	[SSN] BIGINT UNIQUE NOT NULL	
	);

-- INSERT --
INSERT INTO Person.Person (SSN, Person_FirstName, Person_LastName)
	VALUES (75056659595,'Zehra', 'Tekin')
;

SELECT * FROM Person.Person;

INSERT INTO Person.Person (SSN, Person_FirstName) 
	VALUES (889623212466,'Kerem');

SELECT * FROM Person.Person;

INSERT Person.Person 
	VALUES (15078893526,'Mert','Yetiþ');

INSERT Person.Person 
	VALUES (55556698752, 'Esra', Null);

INSERT Person.Person 
	VALUES (35532888963,'Ali','Tekin');-- Tüm tablolara deðer atanacaðý varsayýlmýþtýr.
INSERT Person.Person 
	VALUES (88232556264,'Metin','Sakin');

INSERT INTO Person.Person_Mail (Mail, SSN) 
VALUES ('zehtek@gmail.com', 75056659595),
	   ('meyet@gmail.com', 15078893526),
	   ('metsak@gmail.com', 35532558963);

SELECT * FROM Person.Person_Mail;

SELECT @@IDENTITY -- Global variable onlt "@" refers local variable

SELECT @@ROWCOUNT

SELECT * 
--INTO Person.Person2
FROM Person.Person2;

SELECT * FROM Person.Person
WHERE Person_FirstName LIKE 'M%';


INSERT INTO Person.Person2 
SELECT * FROM Person.Person
WHERE Person_FirstName LIKE 'M%';

insert into Book.Publisher
default values;

SELECT * FROM Book.Publisher;

UPDATE Person.Person2 
SET Person_FirstName = 'Default_Name'

SELECT * FROM Person.Person2;

UPDATE Person.Person2
SET Person_FirstName = 'Can'
WHERE SSN = 75056659595

UPDATE Person.Person2
SET Person_FirstName = B.Person_FirstName
FROM Person.Person2 A Inner Join Person.Person B
ON A.SSN=B.SSN
WHERE B.SSN = 75056659595

-- DELETE
SELECT * FROM Book.Publisher;

Delete from Book.Publisher; -- deletes rows in the table

insert Book.Publisher values ('ÝLETÝÞÝM');

insert Book.Publisher values ('BILISIM');

DELETE FROM Book.Publisher WHERE Publisher_Name = 'BILISIM';

TRUNCATE table book.publisher; -- deletes rows in the table - reset IDENTITY incremantation starts 1 again

DROP TABLE Person.Person2;
TRUNCATE TABLE Person.Person_Mail;
TRUNCATE TABLE Person.Person;
TRUNCATE TABLE Book.Publisher;

--ERD--

ALTER TABLE Book.Author
ALTER COLUMN Author_ID
INT NOT NULL;

ALTER TABLE Book.Author
ADD CONSTRAINT pk_author
PRIMARY KEY (Author_ID);

ALTER TABLE Book.Book
ADD CONSTRAINT FK_Author
FOREIGN KEY (Author_ID)
REFERENCES Book.Author (Author_ID);

ALTER TABLE Person.Loan
ADD CONSTRAINT FK_PERSON
FOREIGN KEY (SSN)
REFERENCES Person.Person (SSN);

ALTER TABLE Person.Loan
ADD CONSTRAINT FK_BOOK
FOREIGN KEY (Book_ID)
REFERENCES Book.Book (Book_ID);

Alter table Person.Person_Mail 
add constraint FK_Person4 
Foreign key (SSN) 
References Person.Person(SSN);

Alter table Person.Person_Phone 
add constraint FK_Person5 
Foreign key (SSN) 
References Person.Person(SSN);

Alter table Book.Book 
add constraint FK_Publisherbook 
Foreign key (Publisher_ID) 
References Book.Publisher (Publisher_ID);