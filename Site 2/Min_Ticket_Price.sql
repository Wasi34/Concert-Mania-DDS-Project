
set serveroutput on;
set verify off;

Create Or Replace Function MIN1
Return number

IS

p number;

Begin

  SELECT MIN(ticket_price)
  INTO p
  FROM Concert_Registration2
  UNION
  SELECT MIN(ticket_price)
  FROM Concert_Registration1@site1;

return p;

end MIN1;
/

DECLARE
P1 number;

BEGIN
	p1 := MIN1;
	DBMS_OUTPUT.PUT_LINE('The MIN price of concert is ' || P1);
end;
/