-- run from sys user as sysdba
DECLARE
    vsuffix   VARCHAR2 (50) default ('_test');

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
            DBMS_OUTPUT.put_line ('new password of ' || rec.base_schema_name || ' is: ' || lower(rec.base_schema_name)||vsuffix);
            EXECUTE IMMEDIATE 'alter user '||rec.base_schema_name||' identified by '||lower(rec.base_schema_name)||vsuffix;
        END;
    END LOOP;
END;