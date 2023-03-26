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