clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
DECLARE
    Ticket_id number;
	Refund_Money int;
	Buying_Amount int;

BEGIN
    Ticket_id:='&Ticket_id';

 FOR R IN (SELECT * FROM Ticket  WHERE Ticket.tId=Ticket_id)
	LOOP
	Buying_Amount:=R.total_amount;
	Refund_Money:=Buying_Amount*50/100;
    END LOOP;


    delete Ticket where Ticket.tId=Ticket_id;
	delete Ticket@site2 where Ticket.tId@site2=Ticket_id;
	DBMS_OUTPUT.PUT_LINE('You got 50% refund.');
	DBMS_OUTPUT.PUT_LINE('Your buying ticket price was ' || Buying_Amount || 'Tk.');
	DBMS_OUTPUT.PUT_LINE('You got back ' || Refund_Money|| 'Tk.');
	
END;
/

create or replace view myview as
select T.pId, T.tId, T.cId,T.cName,T.category,T.ticket_price,T.ticket_quantity,T.total_amount,T.c_Date
from Ticket T;

select * from myview;

commit;
