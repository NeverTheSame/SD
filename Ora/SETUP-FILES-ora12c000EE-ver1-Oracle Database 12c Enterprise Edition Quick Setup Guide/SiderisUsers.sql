/* 
Copyright (c) 2013 Sideris Courseware Corporation. All Rights Reserved.
Each instructor or student with access to this file must have purchased
a license to the corresponding Sideris Courseware textbook to which 
these files apply. All other use, broadcast, webcast, duplication or distribution
is prohibited and illegal.
*/

UNDEFINE PASSWORD
UNDEFINE SERVICE
UNDEFINE DBA
UNDEFINE PREFIX
UNDEFINE COUNT
UNDEFINE TABLESPACE
UNDEFINE HOSTNAME
UNDEFINE PORT
SET VERIFY OFF
SET FEEDBACK OFF
REM
REM Copyright 2013 Sideris Courseware Corporation
REM Script to build database user IDs for Sideris training courses
REM Certified for Oracle 12c
REM
REM File name is SiderisUsers.sql
REM Execute from Oracle SQL*Plus as follows:
REM       SQL> @ SiderisUsers.sql
REM
PROMPT  
PROMPT  
PROMPT  ============================================================================
PROMPT  Welcome to the Sideris classroom setup. Your assistance in preparing the 
PROMPT  workshop environment for the course is appreciated.
PROMPT  
PROMPT  You will be asked to answer several questions. Some questions
PROMPT  will indicate a possible answer in parentheses (e.g. Y or N) and 
PROMPT  the default answer in brackets [N]. Press ENTER following each reply.
PROMPT
PROMPT  You may abort this script at any time by pressing the CONTROL C keys.
PROMPT
PROMPT  Regardless of your answers, this procedure will not make any destructive
PROMPT  changes to your database. 
PROMPT  ============================================================================
PROMPT
accept  PASSWORD HIDE DEFAULT MANAGER prompt 'Enter the password for the SYSTEM ID [MANAGER]: '
accept  SERVICE DEFAULT XE prompt  'Enter database service name, such as XE or TEST [XE] : '
accept  HOSTNAME DEFAULT localhost prompt  'Enter database host name [LOCALHOST] : '
accept  PORT DEFAULT 1521 prompt  'Enter database listener port number [1521] : '
PROMPT  ...Attempting to connect as user SYSTEM now.
PROMPT
connect SYSTEM/&PASSWORD@&HOSTNAME:&PORT/&SERVICE
PROMPT
PAUSE  Press ENTER if "Connected." is shown above. Otherwise an error has occurred. Press CONTROL C.
PROMPT
PROMPT  ============================================================================
PROMPT  Please provide information about the student IDs that should be created
PROMPT
accept DBA DEFAULT N prompt 'Do the student IDs need DBA privilege; is this a database administrator course? (Y or N) [N] : '
accept PREFIX DEFAULT student PROMPT 'What prefix do you wish to use for the student IDs? [student] : '
accept COUNT number DEFAULT 12 prompt 'How many student IDs do you wish to create? [12] : '
PROMPT  ============================================================================
PROMPT 
PROMPT  The list of tablespaces in your database is shown below. Choose a 
PROMPT  tablespace where the student work will be stored. The amount of space
PROMPT  the students will be using will be very small so you need not be overly concerned
PROMPT  about the tablespace that you select. However, we will not permit you to use the
PROMPT  SYSTEM tablespace.
SELECT tablespace_name, contents
FROM dba_tablespaces
WHERE tablespace_name <> 'SYSTEM'
AND status = 'ONLINE'
ORDER BY tablespace_name;
PROMPT
accept TABLESPACE char DEFAULT USERS prompt 'Enter a tablespace for the students from the list shown above [USERS]: '
PROMPT
accept TEMP_TABLESPACE char DEFAULT TEMP prompt 'Enter temporary tablespace from the list shown above [TEMP]: '
PROMPT
PROMPT  ============================================================================
PROMPT  ...Attempting to create the IDs now.
PROMPT 
SET SERVEROUTPUT ON
DECLARE
    cursor_id        INTEGER;
    rows_processed   INTEGER;


-- CHANGE THESE VARIABLES AS NEEDED
    dba_ids_needed          VARCHAR2(3)  := '&&DBA';
    student_schema_prefix   VARCHAR2(30) := '&&PREFIX';
    student_id_count        NUMBER(2)    :=  &&COUNT;
    user_tablespace         VARCHAR2(30) := '&&TABLESPACE';
    temporary_tablespace    VARCHAR2(30) := '&&TEMP_TABLESPACE';
    
    object_exists           NUMBER := 0;
    tablespace_not_exists   EXCEPTION;

BEGIN
-- Confirm requested tablespace DOES exist
     SELECT count(*)
     INTO object_exists
     FROM dba_tablespaces
     WHERE tablespace_name = UPPER(user_tablespace);

     IF object_exists = 0 THEN
        raise tablespace_not_exists;
     END IF;

     SELECT count(*)
     INTO object_exists
     FROM dba_tablespaces
     WHERE tablespace_name = UPPER(temporary_tablespace);

     IF object_exists = 0 THEN
        raise tablespace_not_exists;
     END IF;

-- Create student1 to student_id_count
    FOR i IN 1..student_id_count LOOP
         SELECT count(*)
         INTO object_exists
         FROM dba_users
         WHERE username = UPPER(student_schema_prefix) || i;

         IF object_exists > 0 THEN
            dbms_output.put_line ('ID ' || student_schema_prefix || i || ' already exists. It was not created');
         ELSE
            cursor_id := dbms_sql.open_cursor;
            dbms_sql.parse (cursor_id, 'CREATE USER ' || student_schema_prefix ||
                                       i ||
                                       ' identified by '|| lower(student_schema_prefix) ||
                                       i ||
                                       ' default tablespace ' || user_tablespace ||
                                       ' temporary tablespace ' || temporary_tablespace,
                            dbms_sql.native);
            rows_processed := dbms_sql.execute (cursor_id);
            dbms_output.put_line ('ID ' || student_schema_prefix || i ||
                                  ' created with a password of ' || lower(student_schema_prefix) || i);
            dbms_sql.close_cursor (cursor_id);
         END IF;
    END LOOP;

-- Grant privileges to student1 to student_id_count
    FOR i IN 1..student_id_count LOOP
         cursor_id := dbms_sql.open_cursor;
         IF UPPER(dba_ids_needed) IN ('Y', 'YES') THEN
              dbms_sql.parse (cursor_id, 'GRANT DBA TO ' || student_schema_prefix || i, dbms_sql.native);
              rows_processed := dbms_sql.execute (cursor_id);
              dbms_output.put_line ('ID ' || student_schema_prefix || i || ' granted DBA privilege');
         ELSE
              dbms_sql.parse (cursor_id, 'GRANT CONNECT, RESOURCE, CREATE SYNONYM, CREATE VIEW TO ' || student_schema_prefix || i, dbms_sql.native);
              rows_processed := dbms_sql.execute (cursor_id);
              dbms_output.put_line ('ID ' || student_schema_prefix || i || ' granted RESOURCE, CONNECT, CREATE SYNONYM, CREATE VIEW privileges');

              dbms_sql.parse (cursor_id, 'alter user ' || student_schema_prefix || i || 
                                         ' quota 5M on ' || user_tablespace, dbms_sql.native);
              rows_processed := dbms_sql.execute (cursor_id);
              dbms_output.put_line ('ID ' || student_schema_prefix || i || ' granted 5M quota on ' || user_tablespace);

         END IF;
         dbms_sql.close_cursor (cursor_id);
    END LOOP;

EXCEPTION
    WHEN tablespace_not_exists THEN
         dbms_output.put_line ('============================== ERROR! ==================================');
         dbms_output.put_line ('You selected a tablespace that does not exist. No user IDs were created.');
         dbms_output.put_line ('The tablespaces you selected were ' || user_tablespace || ' ' || temporary_tablespace);
         dbms_output.put_line ('Execute this procedure again and select a tablespace that exists.');
         dbms_output.put_line ('============================== ERROR! ==================================');
    WHEN OTHERS THEN
         dbms_output.put_line ('============================== ERROR! ==================================');
         dbms_output.put_line (sqlerrm);
         dbms_output.put_line ('============================== ERROR! ==================================');
END;
/
PROMPT

SET VERIFY ON
SET FEEDBACK ON