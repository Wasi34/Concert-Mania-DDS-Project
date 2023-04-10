SET LINESIZE 32767;
SELECT * FROM CONCERT_REGISTRATION1;
SELECT * FROM CONCERT_REGISTRATION2@site2;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

/*
-- ------------------------------------Add New Concert---------------------------------------------------
DECLARE
	cid int;
	cName varchar(20);
	clocation varchar(20);
	category varchar(20);
	ticket_price int;
	available_quantity int;
	cDate date;

BEGIN
	cid:='&Concert_ID';
	cName:='&Concert_Name';
	clocation:='&Location';
	category:='&Category';
	ticket_price:='&Ticket_Price';
	available_quantity:='&Available_Quantity';
	cDate:='&Concert_Date';

    --Horizontal fragmentation

    if (category= 'Pop Music') THEN
	insert into Concert_Registration1 values (cid,cName,clocation,category,ticket_price,available_quantity,cDate);
    ELSIF (category= 'Patriotic Song') THEN
	insert into Concert_Registration2@site2 values (cid,cName,clocation,category,ticket_price,available_quantity,cDate);
	END IF;
END;
/
COMMIT;
*/

/*
------------------------------------Update Concert------------------------------------------------
DECLARE
    cidd int;
	cNamee varchar(20);
	clocationn varchar(20);
	available_quantityy int;
    categoryy varchar(20);

BEGIN
    cidd := '&CID'; 
    cNamee:='&Concert_Name';
	clocationn:='&Location';
	available_quantityy:='&Available_Quantity';
	categoryy:='&Category';

    
    if (categoryy= 'Pop Music') THEN
    update Concert_Registration1 set cName=cNamee,clocation=clocationn,category=categoryy, available_quantity=available_quantityy 
	where Concert_Registration1.cId=cidd;
    
	ELSIF (categoryy= 'Patriotic Song') THEN
	update Concert_Registration2@site2 set cName=cNamee,clocation=clocationn,category=categoryy, available_quantity=available_quantityy 
	where Concert_Registration2.cId@site2=cidd;

    END IF;
END;
/
COMMIT;

*/


------------------------------------Delete Concert--------------------------------------------------
DECLARE
	cidd int; 

BEGIN
    cidd := '&Concert_Id';
    delete Concert_Registration1 where Concert_Registration1.cId=cidd;
	delete Concert_Registration2@site2 where Concert_Registration2.cId@site2=cidd;
END;
/
COMMIT;




