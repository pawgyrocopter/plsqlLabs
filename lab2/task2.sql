
-- хуета которая генерит автогенерируемый айдишник
DROP SEQUENCE autoStudentId;

DROP SEQUENCE autoGroupId;

CREATE SEQUENCE autoGroupId
    START WITH 1 
    INCREMENT BY 1 
    NOMAXVALUE;

CREATE SEQUENCE autoStudentId 
    START WITH 1 
    INCREMENT BY 1 
    NOMAXVALUE;



-- хуета чтобы брало перед инсертов автогенерируемый айдишник
CREATE OR REPLACE TRIGGER generateStudentId 
    BEFORE INSERT ON Students FOR EACH ROW
BEGIN
    SELECT  autoStudentId.NEXTVAL 
        INTO :NEW.id FROM DUAL;
END;


CREATE OR REPLACE TRIGGER generateGroupId 
    BEFORE INSERT ON Groups FOR EACH ROW
BEGIN
    SELECT  autoGroupId.NEXTVAL 
        INTO :NEW.id FROM DUAL;
END;


--проверка на целостность id + group name

CREATE OR REPLACE TRIGGER studentIdCheck
    BEFORE INSERT OR UPDATE ON Students FOR EACH ROW
DECLARE 
    isExist NUMBER;
BEGIN
    SELECT COUNT(*) INTO isExist FROM Students WHERE id = :NEW.id;
        
    IF isExist > 0 THEN    
        RAISE_APPLICATION_ERROR(-20000, 'id = ' || :new.id || ' has been already added');  
    END IF;
END;


CREATE OR REPLACE TRIGGER groupIdCheck
    BEFORE INSERT OR UPDATE ON Groups FOR EACH ROW
DECLARE 
    isExist NUMBER;
BEGIN
    SELECT COUNT(*) INTO isExist FROM Groups WHERE id = :NEW.id;
        
    IF isExist > 0 THEN    
        RAISE_APPLICATION_ERROR(-20000, 'id = ' || :new.id || ' has veen already added');  
    END IF;
END;

CREATE OR REPLACE TRIGGER groupNameCheck 
    BEFORE INSERT OR UPDATE OF NAME ON Groups FOR EACH ROW 
DECLARE 
    isExist NUMBER;
BEGIN
    SELECT COUNT(*) INTO isExist FROM Groups WHERE name = :NEW.name;
                
    IF isExist > 0 THEN    
        RAISE_APPLICATION_ERROR(-20000, 'name = ' || :new.name || ' is not unique');  
    END IF;
END;



