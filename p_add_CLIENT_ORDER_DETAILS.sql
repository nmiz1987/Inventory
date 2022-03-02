--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_ADD_CLIENT_ORDER_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."P_ADD_CLIENT_ORDER_DETAILS" (
c_po                            p_client_order_details.po%type,
c_line_number     p_client_order_details.line_number%type,
c_item_id               p_client_order_details.item_id%type,
c_qty_number       p_client_order_details.qty%type
)
IS
no_item EXCEPTION;
no_stock EXCEPTION;
any_rows_found number;
check_stock number;
BEGIN
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
    IF check_stock < c_qty_number /* if the item in the system*/
        THEN RAISE no_stock;
    end if;

    INSERT INTO P_CLIENT_ORDER_DETAILS (PO, line_number, item_id, qty)
            VALUES (c_po, c_line_number, c_item_id, c_qty_number);

EXCEPTION
    WHEN no_item THEN
        raise_application_error (-20001,'Item is not in the system.');
    WHEN no_stock THEN
        raise_application_error (-20002,'There is not enough stock in the warehouses.');
    WHEN OTHERS THEN
        raise_application_error (-20003,'An error has occurred inserting an order.');
END p_add_CLIENT_ORDER_DETAILS;

/
