CREATE TABLE studentsLogs ( 
    id NUMBER PRIMARY KEY NOT NULL, 
    date_time TIMESTAMP NOT NULL, 
    description VARCHAR2(100) NOT NULL,
    new_id NUMBER, 
    old_id NUMBER, 
    new_name VARCHAR2(20), 
    old_name VARCHAR2(20), 
    new_group_id NUMBER, 
    old_group_id NUMBER
);

CREATE OR REPLACE TRIGGER studentsLogger 
    AFTER INSERT OR UPDATE OR DELETE ON Students FOR EACH ROW 
DECLARE 
    id NUMBER;
BEGIN
    SELECT COUNT(*) INTO id FROM studentsLogs;
    
    CASE
        WHEN INSERTING THEN
            INSERT INTO studentsLogs VALUES (
                id + 1, TO_TIMESTAMP(TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS AM')), 'INSERTING',
                :NEW.id, NULL, :NEW.name, NULL, :NEW.group_id, NULL);
        WHEN UPDATING THEN
            INSERT INTO studentsLogs VALUES (
                id + 1, TO_TIMESTAMP(TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS AM')), 'UPDATING',
                :NEW.id, :OLD.id, :NEW.name, :OLD.name, :NEW.group_id, :OLD.group_id);
        WHEN DELETING THEN
            INSERT INTO studentsLogs VALUES (
                id + 1, TO_TIMESTAMP(TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MI:SS AM')), 'DELETING',
                NULL, :OLD.id, NULL, :OLD.name, NULL, :OLD.group_id);
    END CASE;
END;