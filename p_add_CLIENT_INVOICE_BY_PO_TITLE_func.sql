--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function P_ADD_CLIENT_INVOICE_BY_PO_TITLE_FUNC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "HR"."P_ADD_CLIENT_INVOICE_BY_PO_TITLE_FUNC" (
    c_customer_id      p_customers.customer_id%type,
    c_po      p_client_order_title.po%type
) return number
IS
    v_new_invoice_number  p_client_invoice_title.invoice_number%type := "P_CLIENT_INVOICE_SEQUENCE".NEXTVAL;
    v_shipment_number  p_client_invoice_title.shipment_number%type := "P_SHIPMENT_NUMBER_SEQUENCE".NEXTVAL;
BEGIN
    INSERT INTO P_CLIENT_INVOICE_TITLE (INVOICE_NUMBER, SHIPMENT_NUMBER,PO,ORDER_DATE, COSTUMER_ID, STATUS)
    VALUES (v_new_invoice_number ,v_shipment_number, c_po,   SYSDATE, c_customer_id,  'open');
RETURN v_new_invoice_number;
END p_add_CLIENT_INVOICE_BY_PO_TITLE_func;

/
