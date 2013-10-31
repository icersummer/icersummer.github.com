set serveroutput on

DECLARE
	--cursor to retrieve the all user tables
	CURSOR c_userTables IS
		SELECT table_name
		from USER_TABLES
		ORDER BY table_name;
	
	cur PLS_INTEGER := DBMS_SQL.OPEN_CURSOR;
	fdbk PLS_INTEGER;
	
	x NUMBER := 100;
	y NUMBER := 10000;
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
	
	/* test loop myself */
	FOR i IN 1..10 LOOP
		IF MOD(i,2) = 0 THEN -- i is even
			INSERT INTO vjiaTemp VALUES (i, x, 'i is even');
		ELSE
			INSERT INTO vjiaTemp VALUES (i, x, 'i is odd');
		END IF;
		x := x + 100;
	END LOOP;
	COMMIT;	
	
	/* test insert 10W/100W records to costsheet */
	
	FOR j IN 1..y LOOP
		INSERT INTO vjiaTemp VALUES (j, y, 'test, test');
	END LOOP;
	COMMIT;
	DBMS_OUTPUT.PUT_LINE(y || ' records inserted. ');
END;	
/	
	
	
-- http://docs.oracle.com/cd/B10500_01/appdev.920/a96624/a_samps.htm	