CREATE OR REPLACE PROCEDURE dataRestoration(time TIMESTAMP) IS
BEGIN
    FOR action IN (SELECT * FROM studentsLogs WHERE time < date_time ORDER BY id DESC)
    LOOP
        CASE
            WHEN action.description = 'INSERTING' THEN
                DELETE FROM Students WHERE id = action.new_id;
            WHEN action.description = 'UPDATING' THEN
                UPDATE Students SET id = action.old_id,
                        name = action.old_name,
                        group_id = action.old_group_id
                    WHERE id = action.new_id;
            WHEN action.description = 'DELETING' THEN
                INSERT INTO Students VALUES (
                    action.old_id, action.old_name, action.old_group_id);
        END CASE;
    END LOOP;
END dataRestoration;