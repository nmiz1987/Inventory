--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View P_ITEMS_REPORT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HR"."P_ITEMS_REPORT" ("ID", "ITEM_DESCRIPTION", "WAREHOUSE_ID", "WAREHOUSE_DESCRIPTION", "QTY", "NOTES") AS 
  SELECT p1.id, p1.description as item_description , p2.warehouse_id, p3.description as warehouse_description, p2.qty, (CASE WHEN qty-min_qty < 0 THEN 'Low stock, buy items!'
WHEN qty-min_qty >= 0 THEN ' '
END) as NOTES
FROM P_ITEMS p1, P_ITEMS_STOCK p2, p_warehouses p3
WHERE p1.id = p2.id AND p2.warehouse_id = p3.id
;
