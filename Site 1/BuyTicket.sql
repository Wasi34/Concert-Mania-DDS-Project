DECLARE
	person_id int;
    Ticket_id int;
    Concert_id int;
	cName varchar(20);
	concert_category varchar(20);
	C_ticket_price int;
	Buying_ticket_quantity int;
	total_amount int;
    c_Date date;
	checks BOOLEAN := FALSE;
	Available_Ticket_Quantity int;

BEGIN
    person_id:='&Person_id';
    Ticket_id:='&Ticket_id';
    Concert_id:='&Concert_id';
	cName:='&Concert_Name';
	concert_category:='&Concert_Category';
    
    FOR R IN (SELECT * from Concert_Registration1 UNION SELECT * from Concert_Registration2@site2 WHERE cId=Concert_id)
	LOOP
	C_ticket_price:=R.ticket_price;
	Available_Ticket_Quantity:=R.available_quantity;
    END LOOP;

	Buying_ticket_quantity:='&ticket_quantity';
	total_amount:=Buying_ticket_quantity*C_ticket_price;
    c_Date :=TO_DATE(sysdate, 'DD-MM-YYYY');


	IF (Available_Ticket_Quantity-Buying_ticket_quantity >0) THEN
	insert into Ticket values (person_id, Ticket_id, Concert_id ,cName, concert_category,C_ticket_price,Buying_ticket_quantity,total_amount, c_Date);
	insert into Ticket@site2 values (person_id, Ticket_id, Concert_id ,cName, concert_category,C_ticket_price,Buying_ticket_quantity,total_amount, c_Date);
    update Concert_Registration1 set available_quantity=Concert_Registration1.available_quantity-Buying_ticket_quantity where Concert_Registration1.cId=Concert_id;
    update Concert_Registration2@site2  set available_quantity=Concert_Registration2.available_quantity-Buying_ticket_quantity where Concert_Registration2.cId=Concert_id;
    
	ELSE
	DBMS_OUTPUT.PUT_LINE('No Tickets Available!!');
	END IF;
END;
/
