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
    
    IF FLOOR(bonus) <> CEILING(bonus) OR FLOOR(salary) <> CEILING(salary)  
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