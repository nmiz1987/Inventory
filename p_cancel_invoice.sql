--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_CANCEL_INVOICE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."P_CANCEL_INVOICE" (
c_invoice_number        p_client_invoice_details.invoice_number%type
)
IS
c_item_id                          p_client_invoice_details.item_id%type;
c_qty                                    p_client_invoice_details.quantity%type;
c_temp_qty                       p_items_stock.qty%type;
c_invoice_status        p_client_invoice_title.status%type;

CURSOR items_to_returne_cursor IS
select ITEM_ID, QUANTITY
from p_client_invoice_details
where p_client_invoice_details.invoice_number = c_invoice_number;

BEGIN
open items_to_returne_cursor;
    LOOP
    fetch items_to_returne_cursor into c_item_id, c_qty;
    EXIT when items_to_returne_cursor%NOTFOUND;

/*c_temp_qty will contain the current stock for each item in every loop until update*/

select p_items_stock.qty into c_temp_qty
from p_items_stock
where p_items_stock.id = c_item_id;

/* will return the items to stock only id the invoice was at status 'close'*/
select p_client_invoice_title.status into c_invoice_status
from p_client_invoice_title
where p_client_invoice_title.invoice_number = c_invoice_number;

IF c_invoice_status = 'close' THEN
    c_temp_qty := c_temp_qty + c_qty;
END IF;

 UPDATE  p_items_stock SET  qty = c_temp_qty
  where id = c_item_id;

    END LOOP;
close items_to_returne_cursor;

/*close order title*/
UPDATE  P_CLIENT_INVOICE_TITLE SET  STATUS = 'cancel'
where invoice_number = c_invoice_number;


END p_cancel_invoice;

/
