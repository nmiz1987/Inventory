--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function P_ADD_CLIENT_ORDER_TITLE_FUNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "HR"."P_ADD_CLIENT_ORDER_TITLE_FUNC" (
    c_customer_id      p_customers.customer_id%type
) return number
IS
    v_new_order_number  p_client_order_details.po%type := "P_CLIENT_ORDER_SEQUENCE".NEXTVAL;
BEGIN
    INSERT INTO P_CLIENT_ORDER_TITLE (PO, CREATION_DATE, CUSTUMER_ID, STATUS)
    VALUES (v_new_order_number , SYSDATE, c_customer_id, 'open');
RETURN v_new_order_number;
END p_add_CLIENT_ORDER_TITLE_func;

/
