--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View P_VIEW_SALES_REPORT_BY_CUSTOMER
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HR"."P_VIEW_SALES_REPORT_BY_CUSTOMER" ("COSTUMER_ID", "INVOICE_NUMBER", "ORDER_DATE", "ITEM_ID", "DESCRIPTION", "LINE_NUMBER", "QUANTITY") AS 
  select t.costumer_id, t.invoice_number, t.order_date, d.item_id,i.description, d.line_number,d.quantity
from p_client_invoice_title t, p_client_invoice_details d, p_items i
where t.invoice_number = d.invoice_number AND t.status = 'close' and i.id = d.item_id
;
