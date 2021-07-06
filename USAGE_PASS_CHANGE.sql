-- run from sys user as sysdba
DECLARE
    vsuffix   VARCHAR2 (50) := 'qLTn23sS!';

    CURSOR vcrs IS
        SELECT BASE_SCHEMA_NAME
          FROM admuser.applicative_schemas
         WHERE base_schema_name IN ('USAGE', 'MASTER',
                                    'ADMUSER',
                                    'DBUTIL',
                                    'AR',
                                    'CARDS',
                                    'REPORT',
                                    'MEDIATION',
                                    'INVOICE');
BEGIN
    FOR rec IN vcrs
    LOOP
        BEGIN
            DBMS_OUTPUT.put_line ('new password of ' || rec.base_schema_name || ' is: ' ||vsuffix);
            EXECUTE IMMEDIATE 'alter user '||rec.base_schema_name||' identified by "'||vsuffix||'"';
        END;
    END LOOP;
END;