-- run from sys user as sysdba
DECLARE
    vsuffix   VARCHAR2 (50):='qLTn23sS!';

    CURSOR vcrs IS
        SELECT USERNAME
          FROM ALL_USERS
         WHERE USERNAME IN ('USAGE', 'MASTER',
                                    'ADMUSER',
                                    'DBUTIL',
                                    'SUBSCRIBERS',
                                    'FOUNDATION',
                                    'CM',
                                    'BUSINESS_LAYER',
                                    'TARIFFENGINE6_1_4',
                                    'TARIFFENGINE6_1_5',
                                    'TARIFFENGINE6_1_6',
                                    'TARIFFENGINE6_TEMPLATE');
BEGIN
    FOR rec IN vcrs
    LOOP
        BEGIN
            DBMS_OUTPUT.put_line ('new password of ' || rec.USERNAME || ' is: ' ||vsuffix);   
            EXECUTE IMMEDIATE 'alter user '||rec.USERNAME||' identified by "'||vsuffix||'"';
            
        END;
    END LOOP;
END;
