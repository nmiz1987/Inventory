--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_CLOSE_INVOICE_TITLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."P_CLOSE_INVOICE_TITLE" (
c_invoice_number        p_client_invoice_details.invoice_number%type
)
IS
c_item_id                          p_client_invoice_details.item_id%type;
c_qty                                    p_client_invoice_details.quantity%type;
c_temp_qty                       p_items_stock.qty%type;

CURSOR items_to_reduce_cursor IS
select ITEM_ID, QUANTITY
from p_client_invoice_details
where p_client_invoice_details.invoice_number = c_invoice_number;

BEGIN
open items_to_reduce_cursor;
    LOOP
    fetch items_to_reduce_cursor into c_item_id, c_qty;
    EXIT when items_to_reduce_cursor%NOTFOUND;

/*c_temp_qty will contain the current stock for each item in every loop until update*/

select p_items_stock.qty into c_temp_qty
from p_items_stock
where p_items_stock.id = c_item_id;

c_temp_qty := c_temp_qty - c_qty;

 UPDATE  p_items_stock SET  qty = c_temp_qty
  where id = c_item_id;

    END LOOP;
close items_to_reduce_cursor;

/*close order title*/
UPDATE  P_CLIENT_INVOICE_TITLE SET  STATUS = 'close'
where invoice_number = c_invoice_number;


END p_close_invoice_title;

/
