--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_ADD_CLIENT_INVOICE_DETAILS_BY_PO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."P_ADD_CLIENT_INVOICE_DETAILS_BY_PO" (
c_po       p_client_order_details.po%type,
c_invoice_number        p_client_invoice_details.invoice_number%type
)
IS
c_line_number                p_client_invoice_details.line_number%type;
c_item_id                          p_client_invoice_details.item_id%type;
c_qty                                    p_client_invoice_details.quantity%type;

no_item EXCEPTION;
no_stock EXCEPTION;
any_rows_found number;
check_stock number;

CURSOR items_to_invoice_cursor IS
select  LINE_NUMBER, ITEM_ID, QTY
from P_CLIENT_ORDER_DETAILS
where PO = c_po;

BEGIN
open items_to_invoice_cursor;
    LOOP
    fetch items_to_invoice_cursor into c_line_number, c_item_id, c_qty;
    EXIT when items_to_invoice_cursor%NOTFOUND;

    /*check if item in stock*/
    SELECT count(*) into any_rows_found
    FROM p_items
    where p_items.id = c_item_id;
    IF any_rows_found = 0
        THEN RAISE no_item;
    end if;

    /*check if there is enough stock*/
    SELECT sum(p_items_stock.qty) into check_stock
    FROM p_items_stock
    where p_items_stock.id = c_item_id;
    IF check_stock < c_qty /* if the item in the system*/
        THEN RAISE no_stock;
    end if;

    INSERT INTO P_CLIENT_INVOICE_DETAILS (INVOICE_NUMBER, LINE_NUMBER, ITEM_ID, QUANTITY)
            VALUES (c_invoice_number, c_line_number, c_item_id, c_qty);
    END LOOP;
close items_to_invoice_cursor;

/*close order title*/
UPDATE  p_client_order_title SET  STATUS = 'close' WHERE po = c_po; /*close PO from title*/

EXCEPTION
    WHEN no_item THEN
        raise_application_error (-20001,'Item is not in the system.');
    WHEN no_stock THEN
        raise_application_error (-20002,'There is not enough stock in the warehouses.');
    WHEN OTHERS THEN
        raise_application_error (-20003,'An error has occurred inserting an order.');
END p_add_CLIENT_INVOICE_DETAILS_BY_PO;

/
