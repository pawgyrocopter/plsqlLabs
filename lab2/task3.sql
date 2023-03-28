CREATE OR REPLACE TRIGGER cascadeDelete
    BEFORE DELETE ON Groups FOR EACH ROW 
BEGIN
    DELETE FROM Students WHERE group_id = :OLD.id;
END;