--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View P_OPEN_ORDERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HR"."P_OPEN_ORDERS" ("PO", "CREATION_DATE", "FULL_NAME", "CUSTUMER_ID") AS 
  select p1.po, p1.creation_date, p2.full_name, p1.custumer_id
from p_client_order_title p1, p_customers p2
where status = 'open' AND p1.custumer_id = p2.customer_id
;
