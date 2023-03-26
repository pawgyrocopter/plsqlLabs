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
