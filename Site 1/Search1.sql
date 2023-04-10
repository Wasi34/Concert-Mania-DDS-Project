
--------------------------------Search Concert Informations------------------------------------

CREATE OR REPLACE PROCEDURE search5(model IN VARCHAR2)
IS
  found BOOLEAN := FALSE;
BEGIN 
  FOR R IN (SELECT * from Concert_Registration1 UNION SELECT * from Concert_Registration2@site2) LOOP
    IF (lower(R.cName) = lower(model)) THEN
      DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
	  DBMS_OUTPUT.PUT_LINE('Concert ID: ' || R.cId);
	  DBMS_OUTPUT.PUT_LINE('Concert Name: ' || R.cName);
	  DBMS_OUTPUT.PUT_LINE('Location: ' || R.clocation);
	  DBMS_OUTPUT.PUT_LINE('Category: ' || R.category);
	  DBMS_OUTPUT.PUT_LINE('Ticket Price: ' || R.ticket_price);
	  DBMS_OUTPUT.PUT_LINE('No of Availabe Tickets:'|| R.available_quantity );
	  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
      found := TRUE;
    END IF;
  END LOOP;
  IF (NOT found) THEN
    DBMS_OUTPUT.PUT_LINE('No result found!!');
  END IF;
END search5;
/

ACCEPT Y CHAR PROMPT "Enter concert name: "

DECLARE
  Model VARCHAR2(50);
BEGIN
  Model := '&Y';
  search5(Model);
END;
/

