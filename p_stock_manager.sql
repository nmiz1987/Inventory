--------------------------------------------------------
--  File created - יום רביעי-ספטמבר-01-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger P_STOCK_MANAGER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "HR"."P_STOCK_MANAGER" 
AFTER UPDATE OF QTY
ON p_items_stock
FOR EACH ROW
BEGIN
    IF ( :NEW.QTY < :NEW.MIN_QTY ) THEN 
        UPDATE  p_inventory_balances SET  QTY = :NEW.MIN_QTY - :NEW.QTY
        where item_id = :NEW.id AND WAREHOUSE_ID = :NEW.WAREHOUSE_ID;
     END IF;
    IF ( :NEW.QTY >= :NEW.MIN_QTY ) THEN 
        UPDATE  p_inventory_balances SET  QTY = 0
        where item_id = :NEW.id AND WAREHOUSE_ID = :NEW.WAREHOUSE_ID;
    END IF;
    IF ( :NEW.QTY < :OLD.QTY ) THEN 
        INSERT INTO p_transaction VALUES ("P_TRAN_SEQUENCE".NEXTVAL, SYSDATE, :NEW.id, ABS(:NEW.QTY-:OLD.QTY), 'SUB',:NEW.WAREHOUSE_ID );
    END IF;
    IF ( :NEW.QTY > :OLD.QTY ) THEN 
        INSERT INTO p_transaction VALUES ("P_TRAN_SEQUENCE".NEXTVAL, SYSDATE, :NEW.id, ABS(:NEW.QTY-:OLD.QTY), 'ADD',:NEW.WAREHOUSE_ID );
    END IF;
END;
/
ALTER TRIGGER "HR"."P_STOCK_MANAGER" ENABLE;
