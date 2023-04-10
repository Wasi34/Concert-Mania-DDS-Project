Clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
set linesize 32767;

DROP TABLE Person1 CASCADE CONSTRAINTS;
DROP TABLE Ticket CASCADE CONSTRAINTS;
DROP TABLE Concert_Registration1 CASCADE CONSTRAINTS;

CREATE TABLE Person1 (
    pId int, 
    Pname VARCHAR2(20), 
    gender VARCHAR2(20), 
    email VARCHAR2(20), 
    pass VARCHAR2(20) ,
    PRIMARY KEY(pId)
	); 

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER trig1 
AFTER INSERT 
ON person1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Value inserted on Person1 Database');
END;
/
    INSERT INTO Person1 VALUES (1, 'Sinan', 'MALE', 'Sinan@gmail.com','sinan123');
    INSERT INTO Person1 VALUES (2, 'Tareq', 'MALE', 'Tareq@gmail.com','tareq456');
    INSERT INTO Person1 VALUES (3, 'Ahnaf', 'MALE', 'Ahnaf@gmail.com','ahnaf789');
    INSERT INTO Person1 VALUES (4, 'Jannat', 'FEMALE', 'Jannat@gmail.com','jannat123');
    INSERT INTO Person1 VALUES (5, 'Tamjid', 'MALE', 'Tamjid@gmail.com','tamjid456');

    COMMIT;
    SELECT * FROM PERSON1;


CREATE TABLE Concert_Registration1(
	cId int,
	cName VARCHAR2(30),
	clocation VARCHAR2(20),
	category VARCHAR2(20),
	ticket_price int,
	available_quantity int,
	cDate date,
	PRIMARY KEY(cId)
	);

CREATE OR REPLACE TRIGGER trig2 
AFTER INSERT 
ON Concert_Registration1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('New Concert Added');
END;
/

CREATE OR REPLACE TRIGGER trig3
AFTER Update
ON Concert_Registration1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Concert Details Updated.');
END;
/

CREATE OR REPLACE TRIGGER trig4 
AFTER DELETE 
ON Concert_Registration1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Concert Removed.');
END;
/	
	INSERT INTO Concert_Registration1 VALUES(1003,'Boishakhi Rong', 'M A Aziz Stadium', 'Pop Music', 200, 5000,'15-feb-2023');
	INSERT INTO Concert_Registration1 VALUES(1004,'Artcellism', 'ICCB Expo Zone', 'Pop Music', 350, 7000,'12-mar-2023');

	COMMIT;
	SELECT * FROM Concert_Registration1;


CREATE TABLE Ticket(
	pId int,
	tId int,
	cId int,
	cName VARCHAR2(30),
	category VARCHAR2(20),
	ticket_price int,
	ticket_quantity int,
	total_amount int,
	c_Date date,
	PRIMARY KEY(tId),
	FOREIGN KEY(pId) REFERENCES Person1(pId),
	FOREIGN KEY(cId) REFERENCES Concert_Registration1(cId)); 

CREATE OR REPLACE TRIGGER trig5 
AFTER INSERT 
ON Ticket
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Buying Ticket Successful.');
END;
/
CREATE OR REPLACE TRIGGER trig6 
AFTER DELETE 
ON Ticket
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Cancellation of ticket successful.');
END;
/

	INSERT INTO Ticket VALUES(1,101,1003, 'Boishakhi Rong', 'Pop Music', 200, 5, 1000,'15-feb-2023');
	INSERT INTO Ticket VALUES(2,102,1004, 'Bijoy Dibosh Concert', 'Patriotic Song', 300, 3, 900,'12-aug-2019');


	COMMIT;
	SELECT * FROM Ticket;
	


