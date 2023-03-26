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
