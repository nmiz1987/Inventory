--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View P_OREDERS_PER_CUSTUMER
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HR"."P_OREDERS_PER_CUSTUMER" ("CUSTUMER_ID", "FULL_NAME", "PO", "CREATION_DATE", "STATUS") AS 
  select o.custumer_id, c.full_name, o.po, o.creation_date, o.status
from p_client_order_title o, p_customers  c
where o.custumer_id = c.customer_id
;
