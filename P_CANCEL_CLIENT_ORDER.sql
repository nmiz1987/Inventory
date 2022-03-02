--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_CANCEL_CLIENT_ORDER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."P_CANCEL_CLIENT_ORDER" (c_po p_client_order_details.po%type)
IS
no_po EXCEPTION;
check_po number;
BEGIN
    /*check if PO in the system*/
    SELECT count(*) into check_po
    FROM p_client_order_title
    where p_client_order_title.po = c_po;
    IF check_po = 0
        THEN RAISE no_po;
    end if;

UPDATE  p_client_order_title SET  STATUS = 'cancel' WHERE po = c_po; /*delete PO from title*/
DELETE FROM p_client_order_details WHERE p_client_order_details.po = c_po; /*delete PO from details*/
  EXCEPTION
    WHEN no_po THEN
        raise_application_error (-20004,'PO is not in the system.');
    WHEN OTHERS THEN
        raise_application_error (-20003,'An error has occurred inserting an order.');
END P_CANCEL_CLIENT_ORDER;

/
