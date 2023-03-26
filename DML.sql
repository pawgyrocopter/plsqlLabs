CREATE OR REPLACE PROCEDURE CustomInsert (insertId NUMBER, val NUMBER) IS
    isExist NUMBER;
BEGIN
    SELECT COUNT(id) INTO isExist FROM MyTable WHERE id = insertId;

    IF isExist = 1 THEN
         raise DUP_VAL_ON_INDEX;
    END IF;

    INSERT INTO MyTable VALUES(insertId, val); 
    dbms_output.put_line('Insertion completed');

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('id = ' || TO_CHAR(insertId) || ' has beein already added in MyTable');

END CustomInsert;


CREATE OR REPLACE PROCEDURE CustomUpdate (updateId NUMBER, updateValue NUMBER) IS
    isExist NUMBER;
BEGIN
    SELECT COUNT(id) INTO isExist FROM MyTable WHERE id = updateId;

    IF isExist = 1 THEN
        UPDATE MyTable SET val = updateValue WHERE id = updateId;
        dbms_output.put_line('Update completed');
    ELSE        
         dbms_output.put_line('No data found for the given id');
    END IF;    
            
END CustomUpdate;


CREATE OR REPLACE PROCEDURE CustomDelete (deleteId NUMBER) IS
    isExist NUMBER;
BEGIN
    SELECT COUNT(id) INTO isExist FROM MyTable WHERE id = deleteId;

    IF isExist = 1 THEN
        DELETE FROM MyTable WHERE id = deleteId;
        dbms_output.put_line('Deletion completed');
    ELSE        
        dbms_output.put_line('No data found for the given id');
    END IF;    
   
END CustomDelete;