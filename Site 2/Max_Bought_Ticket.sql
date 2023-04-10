set serveroutput on;
set verify off;

Create Or Replace Function MAX1
Return number

IS

p number;

Begin

select Max(ticket_quantity) into p from Ticket;

return p;

end MAX1;
/

DECLARE
P1 number;

BEGIN
	p1 := MAX1;
	DBMS_OUTPUT.PUT_LINE('The Max number of ticket bought is ' || P1);
end;
/