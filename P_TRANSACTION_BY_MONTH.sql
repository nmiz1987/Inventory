--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View P_TRANSACTION_BY_MONTH
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "HR"."P_TRANSACTION_BY_MONTH" ("MONTH", "T_ADD", "T_SUB") AS 
  select month, sum(t_add) as t_add, sum(t_sub) as t_sub
from (
    select substr(creation_date, 4, 8) as month ,count(type) as t_add, 0 as t_sub
    from p_transaction
    where type = 'ADD'
    group by substr(creation_date, 4, 8)
    union
    select substr(creation_date, 4, 8) as month ,0 as t_add, count(type) as t_sub
    from p_transaction
    where type = 'SUB'
    group by substr(creation_date, 4, 8))
GROUP by month
;
