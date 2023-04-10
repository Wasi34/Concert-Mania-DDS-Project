
set serveroutput on;
set verify off;
SET LINESIZE 32767;
SELECT * FROM Concert_Registration2;
SELECT * FROM Concert_Registration1@site1;

CREATE OR REPLACE PROCEDURE Descending
IS

BEGIN
DBMS_OUTPUT.PUT_LINE('Descending ticket price.');
for R in (SELECT * FROM (SELECT * FROM Concert_Registration2 UNION SELECT * FROM Concert_Registration1@site1)ORDER BY ticket_price DESC) Loop 

	  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
	  DBMS_OUTPUT.PUT_LINE('Concert ID: ' || R.cId);
	  DBMS_OUTPUT.PUT_LINE('Concert Name: ' || R.cName);
	  DBMS_OUTPUT.PUT_LINE('Location: ' || R.clocation);
	  DBMS_OUTPUT.PUT_LINE('Category: ' || R.category);
	  DBMS_OUTPUT.PUT_LINE('Ticket Price: ' || R.ticket_price);
	  DBMS_OUTPUT.PUT_LINE('No of Availabe Tickets:'|| R.available_quantity );
	  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
End loop;

end Descending;
/

Begin 
Descending;
End;
/