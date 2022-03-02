--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function P_ADD_CUSTOMER_FUNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "HR"."P_ADD_CUSTOMER_FUNC" (
    v_full_name      p_customers.full_name%type
   , v_cell                 p_customers.cell%type
   , v_city                  p_customers.city%type
   , v_address          p_customers.address%type
   , v_email               p_customers.email%type
) return number
IS
    v_customer_ID    p_customers.customer_id%type := "p_customers_sequence".NEXTVAL;
BEGIN
 INSERT INTO p_customers (customer_ID, Full_NAME, CELL, CITY, ADDRESS, EMAIL)
    VALUES(v_customer_ID ,v_full_name, v_cell, v_city, v_address, v_email);
RETURN v_customer_ID;
END p_add_customer_func;

/
