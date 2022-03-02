--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_UPDATE_CUSTOMER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."P_UPDATE_CUSTOMER" 
  ( c_customer_ID   p_customers.customer_id%type
  , c_full_name      p_customers.full_name%type
   , c_cell      p_customers.cell%type
   , c_city      p_customers.city%type
   , c_address      p_customers.address%type
   , c_email      p_customers.email%type
   )
IS
BEGIN
  UPDATE  p_customers SET  Full_NAME = c_full_name, CELL = c_cell, CITY = c_city, ADDRESS = c_address, EMAIL = c_email
  where customer_ID = c_customer_ID;
END p_update_customer;

/
