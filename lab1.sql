CREATE TABLE MyTable(
    id number NOT NULL PRIMARY KEY,
    val number NOT NULL
)

DECLARE
    randomNumber INTEGER;
    i INTEGER := 1;
BEGIN 
    WHILE i < 10000
    LOOP
        randomNumber := dbms_random.value(1,100000);
        INSERT INTO MyTable
        VALUES(i, randomNumber);
        i := i + 1;
    END LOOP;
END;


CREATE OR REPLACE FUNCTION EvenOddChecker
    return VARCHAR
IS
    odd INTEGER := 0;
    even INTEGER := 0;
BEGIN
    SELECT COUNT(id) INTO even FROM MyTable
    WHERE mod(val, 2) = 0;
    
    SELECT COUNT(id) INTO odd FROM MyTable
    WHERE mod(val, 2) != 0;
    
    if odd = even
    then
    -- dbms_output.put_line('EQUAL');
    return 'EQUAL';
    end if;
    
    if odd > even
    then
    -- dbms_output.put_line('FALSE');
    return 'FALSE';
    end if;
    
    if even > odd
    then
    -- dbms_output.put_line('TRUE');
    return 'TRUE';
    end if;
END;

CREATE OR REPLACE FUNCTION PrintInserCommant (insertionId IN NUMBER) RETURN VARCHAR2 IS
    result VARCHAR2;
    isExist NUMBER;
BEGIN
    SELECT COUNT(id) INTO isExist FROM MyTable WHERE id = insertionId;
    
    IF isExist = 1 THEN
         return ('id=' || TO_CHAR(insertionId) || 
                    ' is already exist in MyTable');
    ELSE    
        result := 'INSERT INTO MyTable VALUES(' || TO_CHAR(insertionId) || ', someValue' ');';
    END IF;
    
    RETURN result;
END PrintInserCommant;

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

CREATE OR REPLACE FUNCTION salaryTask (salary IN VARCHAR2, bonus IN VARCHAR2) 
RETURN NUMBER IS
    result NUMBER;
    NegativeArgumentException EXCEPTION;
    FloatArgumentException EXCEPTION;
BEGIN
    IF TO_NUMBER(bonus) < 0 OR TO_NUMBER(salary) < 0 
    THEN
        RAISE NegativeArgumentException;    
    END IF;
    
    IF (ROUND(bonus) != bonus) OR (ROUND(salary) != salary)  
    THEN
        RAISE FloatArgumentException;
    END IF;


    result := (1 + TO_NUMBER(bonus) / 100) * 12 * TO_NUMBER(salary);
    
    RETURN result;
    
    EXCEPTION 
        WHEN VALUE_ERROR THEN
            dbms_output.put_line('Try using integer values');
            RETURN NULL;

        WHEN NegativeArgumentException THEN
            dbms_output.put_line('Positive integers are required');
            RETURN NULL;
        
        WHEN FloatArgumentException THEN
            dbms_output.put_line('Try using integer values instead of float');
            RETURN NULL;
       
END salaryTask; 

