clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
set linesize 32767;

DROP TABLE Person2 CASCADE CONSTRAINTS;
DROP TABLE Ticket CASCADE CONSTRAINTS;
DROP TABLE Concert_Registration2 CASCADE CONSTRAINTS;

CREATE TABLE Person2(
    pId int, 
    userType VARCHAR2(20),
	phoneNo VARCHAR2(20), 
    nid VARCHAR2(20),
	PRIMARY KEY(pId)
    );
	
CREATE OR REPLACE TRIGGER trig7 
AFTER INSERT 
ON person2
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Value inserted on Person2 Database');
END;
/

    INSERT INTO Person2 VALUES (1, 'Admin','01969484230','12345678910');
    INSERT INTO Person2 VALUES (2, 'Admin', '01969484203','12345678911');
	INSERT INTO Person2 VALUES (3, 'General User','01969484231','12345678922');
    INSERT INTO Person2 VALUES (4, 'General User', '01969484205','12345678933');
	INSERT INTO Person2 VALUES (5, 'General User','01969484267','12345678944');

	
	COMMIT;
	SELECT * FROM Person2;


CREATE TABLE Concert_Registration2(
	cId int,
	cName VARCHAR2(30),
	clocation VARCHAR2(20),
	category VARCHAR2(20),
	ticket_price int,
	available_quantity int,
	cDate date,
	PRIMARY KEY(cId)
	);
	
CREATE OR REPLACE TRIGGER trig8 
AFTER INSERT 
ON Concert_Registration1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('New Concert Added');
END;
/
CREATE OR REPLACE TRIGGER trig9
AFTER Update
ON Concert_Registration1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Concert Details Updated.');
END;
/

CREATE OR REPLACE TRIGGER trig10 
AFTER DELETE 
ON Concert_Registration1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Concert Removed.');
END;
/	
	INSERT INTO Concert_Registration2 VALUES(1001,'Bijoy Dibosh Concert', 'Banani-Dhaka', 'Patriotic Song', 300, 6000,'16-dec-2023');
	INSERT INTO Concert_Registration2 VALUES(1002,'Idenpendence Day Concert', 'Police Stadium', 'Patriotic Song', 200, 10000,'26-mar-2023');

	COMMIT;
	SELECT * FROM Concert_Registration2;


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

CREATE OR REPLACE TRIGGER trig11 
AFTER INSERT 
ON Ticket
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('Buying Ticket Successful.');
END;
/
CREATE OR REPLACE TRIGGER trig12
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