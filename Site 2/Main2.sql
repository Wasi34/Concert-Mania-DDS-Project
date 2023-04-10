clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;


BEGIN 

	DBMS_OUTPUT.PUT_LINE('1 = View Users details, 2 = View Concert Informations');

END;
/


/*

-- ------------------------------------Sign Up---------------------------------------------------
DECLARE
	personid number;
	pName varchar(20);
	GENDERR varchar(20);
	EMAILL varchar(20);
	passs varchar(20);
	userType varchar(20);
	nid varchar(20);
	phoneNo varchar(20);

BEGIN
	personid:=&pidd;
	pName:='&namee';
	GENDERR:='&genderr';
	EMAILL:='&mail';
	passs:='&passwordd';
	userType:='General User';
	nid:='&NID';
	phoneNo:='&Phone';

    --Vertical fragmentation

	insert into person1@site1 values (personid, pName, GENDERR ,EMAILL, passs);
	--insert into person2 values (personid,userType,phoneNo,nid);
END;
/


-- --------------------------------Delete User--------------------------------------------------
DECLARE

	personid person1.pId%TYPE := &DEL_USER;
BEGIN
    delete person1@site1 where person1.pId=personid;
	delete person2 where person2.pId@site2=personid;
END;
/

------------------------------------Update User------------------------------------------------
DECLARE

	personid person1.pId%TYPE := &Update_USER;
BEGIN
    update person1@site1 set email='aaa@gmail.com' where person1.pId=personid;
    update person2 set pass='passtest' where person2.pId@site2=personid;
END;
/
---------------------------------------LogIn-------------------------------------------------
clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;
DECLARE
   namee varchar(20);
   pin varchar(20);
   X varchar(20);
   Y varchar(20);
   
BEGIN
   namee:='&Name';
   pin:='&Pin';
   SELECT  person1.Pname@site1, person1.pass@site1 into X,Y FROM person1@site1 where person1.Pname@site1=namee;

IF X=namee AND Y=pin THEN 
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Login Successful');
ELSIF X=namee AND Y!=pin THEN 
   DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Password is incorrect'); 
END IF;
	  
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Login Failed.');
	
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Other Errors Found.');
END;
/

*/


CREATE OR REPLACE PACKAGE myPack AS
PROCEDURE View_Users_Admin_Info;

PROCEDURE View_Concert_Info;
end myPack;
/

CREATE OR REPLACE PACKAGE Body myPack AS
-------------------------------------------Show Users Info--------------------------- -------

PROCEDURE View_Users_Admin_Info
IS	 
BEGIN
	for R in (SELECT * from person1@site1 join person2 on person1.pId@site1= person2.pId)
	--Vertical fragmentation
	LOOP
	    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Name: ' || R.Pname);
		DBMS_OUTPUT.PUT_LINE('Gender: ' || R.gender);
		DBMS_OUTPUT.PUT_LINE('Email: ' || R.email);
		DBMS_OUTPUT.PUT_LINE('User Type: ' || R.userType);
		DBMS_OUTPUT.PUT_LINE('Phone Number:'|| R.phoneNo );
		DBMS_OUTPUT.PUT_LINE('NID:'|| R.nid);
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');

	END LOOP;
END View_Users_Admin_Info;


--------------------------------View Concert Informations------------------------------------

PROCEDURE View_Concert_Info
IS	 
BEGIN
	for R in (SELECT * from Concert_Registration1@site1 UNION SELECT * from Concert_Registration2)
	--horizontal fragmentation
	LOOP
	    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Concert ID: ' || R.cId);
		DBMS_OUTPUT.PUT_LINE('Concert Name: ' || R.cName);
		DBMS_OUTPUT.PUT_LINE('Location: ' || R.clocation);
		DBMS_OUTPUT.PUT_LINE('Category: ' || R.category);
		DBMS_OUTPUT.PUT_LINE('Ticket Price: ' || R.ticket_price);
		DBMS_OUTPUT.PUT_LINE('No of Availabe Tickets:'|| R.available_quantity );
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');

	END LOOP;
END View_Concert_Info;

END myPack;
/	
	
-----------------------------------------Main File-------------------------------------------------
ACCEPT X NUMBER PROMPT "Choose option = "
DECLARE
    N number;
	input_error EXCEPTION;
Begin

	N := &X;

	IF (N=1) then
	myPack.View_Users_Admin_Info();   --View Users details

	ELSIF (N=2) then
	myPack.View_Concert_Info();   --View Concert
	
	ELSIF (N=3) then
	DBMS_OUTPUT.PUT_LINE('Log in First');   --Buy Ticket
	
	ELSE
    RAISE input_error;
	END IF;
	
	EXCEPTION 
		When input_error THEN
		DBMS_OUTPUT.PUT_LINE('Invalid Option');
END;
/

