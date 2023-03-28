CREATE OR REPLACE TRIGGER groupUpdateByStudentCount 
    AFTER INSERT OR UPDATE OR DELETE ON Students FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE Groups SET c_val = c_val + 1 WHERE id = :NEW.group_id;
    ELSIF UPDATING THEN
            UPDATE Groups SET c_val = c_val - 1 WHERE id = :OLD.group_id;
            UPDATE Groups SET c_val = c_val + 1 WHERE id = :NEW.group_id;
    ELSIF DELETING THEN
            UPDATE Groups SET c_val = c_val - 1 WHERE id = :OLD.group_id;
    END IF;
END;