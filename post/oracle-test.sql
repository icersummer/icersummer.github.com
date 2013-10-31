set serveroutput on

DECLARE
	--cursor to retrieve the all user tables
	CURSOR c_userTables IS
		SELECT table_name
		from USER_TABLES
		ORDER BY table_name;
	
	cur PLS_INTEGER := DBMS_SQL.OPEN_CURSOR;
	fdbk PLS_INTEGER;
	
BEGIN
	DBMS_OUTPUT.ENABLE(100000);
	
	-- begin the loop. An implicit OPEN of c_userTables is done here.
	FOR v_catalogEntry IN c_userTables LOOP
    -- An implicit FETCH is done here.

    -- Process the fetched rows, in this case construct
    -- a dynamic pl/sql statement for each tablename found.
    -- Reuse the same cursor, parse and execute the truncate statement
    DBMS_SQL.PARSE
    	(CUR, 'SELECT 2 FROM ' || v_catalogEntry.table_name, DBMS_SQL.NATIVE);
    	
    fdbk := DBMS_SQL.EXECUTE(cur);
		DBMS_OUTPUT.PUT_LINE('TABLE VJ ' || v_catalogEntry.table_name || ' selected.');
	END LOOP;
	
	DBMS_SQL.CLOSE_CURSOR(cur);
END;	
/	
	