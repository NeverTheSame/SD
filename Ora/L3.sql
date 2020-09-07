--UNDO management

create undo tablespace SIDERIS_UNDO
  datafile '/u01/app/oracle/oradata/orcl/sideris_undo_01.dbf'
  size 10m
  autoextend off;


drop tablespace prod_undo_03
including contents and datafiles;


select * from dba_tablespaces;

--guarantee renetion
alter tablespace undotbs1
retention guarantee;

select tablespace_name, contents, GUARANTEE
  from DBA_TABLESPACES;

alter system
SET UNDO_TABLESPACE = prod_undo_02;

alter system
SET UNDO_TABLESPACE = '';

alter system
SET UNDO_TABLESPACE = UNDOTBS1;

select name, value
from v$parameter
where upper(name) like '%UNDO%'


--V$ROLLNAE
--V$UNDOSTAT
--DBA_UNDO_EXTENTS

select * from v$rollname;

select to_char(end_time, 'MM/DD/YYYY HH24:TI') from V$UNDOSTAT;


select segment_name, extent_id, block_id, bytes, blocks, commit_wtime, status
from dba_undo_extents
where tablespace_name = 'UNDOTBS1'
order by segment_name, extent_Id;

--EXERCISE
create undo tablespace SIDERIS_UNDO
  datafile '/u01/app/oracle/oradata/orcl/sideris_undo_01.dbf'
  size 10m
  autoextend off;

alter system
  set undo_tablespace = 'SIDERIS_UNDO';

alter table student1.customers
modify customerID NUMBER(8);

-- add more space to undo tablespace
alter tablespace "SIDERIS_UNDO"
  add datafile '/u01/app/oracle/oradata/orcl/undo3.dbf'
  size 100m;

-- END

--CHAPTER C-1: Security overview
  --database security principles
  --database system priviliges
  --database object priviliges
  --super administrator roles
  --privilege alanysis

  --discretanory access control
    --system priviliges
      --create session
      --create table
      --seelct any table
      --delete any table
    --object priviliges
      --owner - creator of an object
      --must be granted permission
        --delete
        --insert
        --update
        --select
      --principle of least privilege
      --separation of duties
        --security administrator
        --two-man rule
      --audit, verify, monitor

-- DB system priviligies
  --general admin priv
    --alter
    --drop
    --startup
    --shutdown
    --create/alter session
    --drop tablespace
    --unlimited tablespace
    --other
      --advisor
      --alter system
      --create control file
      --create pfile
      --create spfile
  --security admin priv
    --profile mgmt
  --general schema priv
    --index
    --sequence
    --synonym
    --tables
    --metadata
      --select any dict
      --select any transaction
  --DB persistent program unit priv
    --create procedure - create or replace procs, funcs, pkgs
    --create trigger

describe customers

--database object priv
select * from dba_directories;

--super administrator roles
  --SYSDBA - any DB operation and any DB object
  --SYSOPER
    --startup
    --shutdown
    --alter database
    --create pfile
    --restricted session
  --SYSBACKUP
  --SYSDG - data guard
  --SYSKM - key mgmt

grant sysbackup to student1;

--privilige analysis
  --DBMS_PRIVILEGE_CAPTURE
  --database vault


--Chapter C-2: User security

  --create and manage user accounts
  --granting and revoking priv
  --resource limits via profiles
  --password mgmt via profiles
  --role-based security
  --deleagate priv authorization
  --checklist for principle of least priv (POLP)

select username, account_status, default_tablespace, temporary_tablespace
from DBA_USERS
order by username;

--system-defined users
  --sysman
  --dbsnmp
  --system
  --sys

create user student5
identified by Pa$$w0rd
default tablespace USERS
temporary tablespace TEMP
profile DEFAULT;

--student5 cannot connect yet, granting ...
grant connect, create table to student5, student4;

select username, created, default_tablespace,
  temporary_tablespace, profile
from DBA_users
order by username;

select username, tablespace_name, blocks, max_blocks
from dba_ts_quotas
order by username;

alter user student2
account lock;

alter user student2
account unlock;

drop user student5
cascade;

grant create table to student1;

grant create any table to student2;

--using student1 conenction
grant select, update on TEAMS to student2;

revoke update on TEAMS from student2;

--different method / can only edit teamID
grant update(teamID, name) on TEAMS to student2;

revoke create table from student2;

select * from user_sys_privs;

select * from session_privs;

--table privs
select grantee, owner, table_name, grantor, privilege, grantable
from user_tab_privs
where grantor = 'student1';

select grantee, owner, table_name, column_name, grantor,
  privilege, grantable
from user_col_privs
where grantor = 'student1';

select * from dba_tab_privs;

--PROFILES
  --RESOURCE LIMITS
  --security policy

  --default profile (has set of parameters, eg password_life_time)

create profile LOW_END_USER
  limit CPU_PER_SESSION unlimited
    cpu_per_call 10
    connect_time unlimited
    idle_time 15
    sessions_per_user 1
    logical_reads_per_session 5000
    logical_reads_per_call 1000
    private_sga 4K
    composite_limit unlimited;

alter user student2
  profile low_end_user;

alter system
set resource_limit = TRUE;

-- check parameters for all profiles
select profile, resource_name, resource_type, limit
from dba_profiles
order by profile, resource_name;

--password_verify_function
  --ORA12C_VERIFY_FUNCTION
  --ORA12C_STRONG_VERIFY_FUNCTION


-- This script sets the default password resource parameters
-- This script needs to be run to enable the password features.
-- However the default resource parameters can be changed based
-- on the need.
-- A default password complexity function is provided.




CREATE OR REPLACE FUNCTION ora12c_verify_function
(username varchar2,
 password varchar2,
 old_password varchar2)
RETURN boolean IS
   differ integer;
   pw_lower varchar2(256);
   db_name varchar2(40);
   i integer;
   simple_password varchar2(10);
   reverse_user varchar2(32);
BEGIN
   IF NOT ora_complexity_check(password, chars => 8, letter => 1, digit => 1) THEN
      RETURN(FALSE);
   END IF;

   -- Check if the password contains the username
   pw_lower := NLS_LOWER(password);
   IF instr(pw_lower, NLS_LOWER(username)) > 0 THEN
     raise_application_error(-20002, 'Password contains the username');
   END IF;

   -- Check if the password contains the username reversed
   reverse_user := '';
   FOR i in REVERSE 1..length(username) LOOP
     reverse_user := reverse_user || substr(username, i, 1);
   END LOOP;
   IF instr(pw_lower, NLS_LOWER(reverse_user)) > 0 THEN
     raise_application_error(-20003, 'Password contains the username ' ||
                                     'reversed');
   END IF;

   -- Check if the password contains the server name
   select name into db_name from sys.v$database;
   IF instr(pw_lower, NLS_LOWER(db_name)) > 0 THEN
      raise_application_error(-20004, 'Password contains the server name');
   END IF;

   -- Check if the password contains 'oracle'
   IF instr(pw_lower, 'oracle') > 0 THEN
        raise_application_error(-20006, 'Password too simple');
   END IF;

   -- Check if the password is too simple. A dictionary of words may be
   -- maintained and a check may be made so as not to allow the words
   -- that are too simple for the password.
   IF pw_lower IN ('welcome1', 'database1', 'account1', 'user1234',
                              'password1', 'oracle123', 'computer1',
                              'abcdefg1', 'change_on_install') THEN
      raise_application_error(-20006, 'Password too simple');
   END IF;

   -- Check if the password differs from the previous password by at least
   -- 3 characters
   IF old_password IS NOT NULL THEN
     differ := ora_string_distance(old_password, password);
     IF differ < 3 THEN
        raise_application_error(-20010, 'Password should differ from the '
                                || 'old password by at least 3 characters');
     END IF;
   END IF ;

   RETURN(TRUE);
END;
/

GRANT EXECUTE ON ora12c_verify_function TO PUBLIC;

Rem Function: "verify_function_11G" - provided from 11G onwards.
Rem
Rem This function makes the minimum complexity checks like
Rem the minimum length of the password, password not same as the
Rem username, etc. The user may enhance this function according to
Rem the need.

CREATE OR REPLACE FUNCTION verify_function_11G
(username varchar2,
 password varchar2,
 old_password varchar2)
RETURN boolean IS
   differ integer;
   db_name varchar2(40);
   i integer;
   i_char varchar2(10);
   simple_password varchar2(10);
   reverse_user varchar2(32);
BEGIN
   IF NOT ora_complexity_check(password, chars => 8, letter => 1, digit => 1) THEN
      RETURN(FALSE);
   END IF;

   -- Check if the password is same as the username or username(1-100)
   IF NLS_LOWER(password) = NLS_LOWER(username) THEN
     raise_application_error(-20002, 'Password same as or similar to user');
   END IF;
   FOR i IN 1..100 LOOP
      i_char := to_char(i);
      if NLS_LOWER(username)|| i_char = NLS_LOWER(password) THEN
        raise_application_error(-20005, 'Password same as or similar to ' ||
                                        'username ');
      END IF;
   END LOOP;

   -- Check if the password is same as the username reversed
   FOR i in REVERSE 1..length(username) LOOP
     reverse_user := reverse_user || substr(username, i, 1);
   END LOOP;
   IF NLS_LOWER(password) = NLS_LOWER(reverse_user) THEN
     raise_application_error(-20003, 'Password same as username reversed');
   END IF;

   -- Check if the password is the same as server name and or servername(1-100)
   select name into db_name from sys.v$database;
   if NLS_LOWER(db_name) = NLS_LOWER(password) THEN
      raise_application_error(-20004, 'Password same as or similar ' ||
                                      'to server name');
   END IF;
   FOR i IN 1..100 LOOP
      i_char := to_char(i);
      if NLS_LOWER(db_name)|| i_char = NLS_LOWER(password) THEN
        raise_application_error(-20005, 'Password same as or similar ' ||
                                        'to server name ');
      END IF;
   END LOOP;

   -- Check if the password is too simple. A dictionary of words may be
   -- maintained and a check may be made so as not to allow the words
   -- that are too simple for the password.
   IF NLS_LOWER(password) IN ('welcome1', 'database1', 'account1', 'user1234',
                              'password1', 'oracle123', 'computer1',
                              'abcdefg1', 'change_on_install') THEN
      raise_application_error(-20006, 'Password too simple');
   END IF;

   -- Check if the password is the same as oracle (1-100)
    simple_password := 'oracle';
    FOR i IN 1..100 LOOP
      i_char := to_char(i);
      if simple_password || i_char = NLS_LOWER(password) THEN
        raise_application_error(-20006, 'Password too simple ');
      END IF;
    END LOOP;

   -- Check if the password differs from the previous password by at least
   -- 3 letters
   IF old_password IS NOT NULL THEN
     differ := ora_string_distance(old_password, password);
     IF differ < 3 THEN
         raise_application_error(-20011, 'Password should differ from the ' ||
                                 'old password by at least 3 characters');
     END IF;
   END IF;

   RETURN(TRUE);
END;
/

GRANT EXECUTE ON verify_function_11G TO PUBLIC;

-- Below is the older version of the script

-- This script sets the default password resource parameters
-- This script needs to be run to enable the password features.
-- However the default resource parameters can be changed based
-- on the need.
-- A default password complexity function is also provided.
-- This function makes the minimum complexity checks like
-- the minimum length of the password, password not same as the
-- username, etc. The user may enhance this function according to
-- the need.
-- This function must be created in SYS schema.
-- connect sys/<password> as sysdba before running the script

CREATE OR REPLACE FUNCTION verify_function
(username varchar2,
 password varchar2,
 old_password varchar2)
RETURN boolean IS
   differ integer;
BEGIN
   -- Check if the password is same as the username
   IF NLS_LOWER(password) = NLS_LOWER(username) THEN
     raise_application_error(-20001, 'Password same as or similar to user');
   END IF;

   -- Check if the password contains at least four characters, including
   -- one letter, one digit and one punctuation mark.
   IF NOT ora_complexity_check(password, chars => 4, letter => 1, digit => 1,
                           special => 1) THEN
      RETURN(FALSE);
   END IF;

   -- Check if the password is too simple. A dictionary of words may be
   -- maintained and a check may be made so as not to allow the words
   -- that are too simple for the password.
   IF NLS_LOWER(password) IN ('welcome', 'database', 'account', 'user',
                              'password', 'oracle', 'computer', 'abcd') THEN
      raise_application_error(-20002, 'Password too simple');
   END IF;

   -- Check if the password differs from the previous password by at least
   -- 3 letters
   IF old_password IS NOT NULL THEN
     differ := ora_string_distance(old_password, password);
     IF differ < 3 THEN
         raise_application_error(-20004, 'Password should differ by at' ||
                                         'least 3 characters');
     END IF;
   END IF;

   RETURN(TRUE);
END;
/

GRANT EXECUTE ON verify_function TO PUBLIC;

Rem *************************************************************************
Rem END Password Verification Functions
Rem *************************************************************************

Rem *************************************************************************
Rem BEGIN Password Management Parameters
Rem *************************************************************************

-- This script alters the default parameters for Password Management
-- This means that all the users on the system have Password Management
-- enabled and set to the following values unless another profile is
-- created with parameter values set to different value or UNLIMITED
-- is created and assigned to the user.

ALTER PROFILE DEFAULT LIMIT
PASSWORD_LIFE_TIME 180
PASSWORD_GRACE_TIME 7
PASSWORD_REUSE_TIME UNLIMITED
PASSWORD_REUSE_MAX  UNLIMITED
FAILED_LOGIN_ATTEMPTS 10
PASSWORD_LOCK_TIME 1
PASSWORD_VERIFY_FUNCTION ora12c_verify_function;

/**
The below set of password profile parameters would take into consideration
recommendations from Center for Internet Security[CIS Oracle 11g].

ALTER PROFILE DEFAULT LIMIT
PASSWORD_LIFE_TIME 90
PASSWORD_GRACE_TIME 3
PASSWORD_REUSE_TIME 365
PASSWORD_REUSE_MAX  20
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 1
PASSWORD_VERIFY_FUNCTION ora12c_verify_function;
*/

/**
The below set of password profile parameters would take into
consideration recommendations from Department of Defense Database
Security Technical Implementation Guide[STIG v8R1].

ALTER PROFILE DEFAULT LIMIT
PASSWORD_LIFE_TIME 60
PASSWORD_REUSE_TIME 365
PASSWORD_REUSE_MAX  5
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_VERIFY_FUNCTION ora12c_strong_verify_function;
*/

Rem *************************************************************************
Rem END Password Management Parameters
Rem *************************************************************************

alter user student2
profile strong_password;


alter user student2
identified by Pa$$w0rd;


--role-based security

create role standard_user;

grant create session, select any table
to standard_user;

--financial_app_role - customers, sales
--HR_APP_ROLE - members, teams_specified
--manager_role
--financial_clerk_role - smith, jones
--hr_clerk_role -wilson, jackson

select role, owner, table_name, privilege
from role_tab_privs
order by role;

grant select, insert, update, delete
on MEMBERS to student2
with grant option;

grant create session
to student2
with admin option;

--EXERCISE
create user USER1
identified by Pa$$w0rd
ACCOUNT UNLOCK
profile DEFAULT;

create user USER2
identified by Pa$$w0rd
ACCOUNT UNLOCK
profile DEFAULT;

create user USER3
identified by Pa$$w0rd
ACCOUNT UNLOCK
profile DEFAULT;

grant CONNECT, RESOURCE, unlimited tablespace, create any table
to USER1, USER2, USER3;

--2
--conencted as User1 and ran 2 scripts

--3
select username, created, default_tablespace,
  temporary_tablespace, profile
from DBA_users
order by username;

--4
select grantee, privilege, admin_option
from dba_sys_privs
where grantee like 'USER%'
order by grantee;

--7
create profile ONLY_ONCE LIMIT
    sessions_per_user 1;

alter user USER2
  profile ONLY_ONCE;

--enable resource limit enforcement
alter system
set resource_limit = TRUE;

--8
select * from dba_profiles
where profile = 'ONLY_ONCE';

--9
create role financial_app;
create role hr_app;
create role financial_clerk;
create role HR_CLERK;
create role COMPANY_MANAGER;

--10
GRANT FINANCIAL_CLERK TO USER1;
GRANT COMPANY_MANAGER TO USER2;
GRANT HR_CLERK TO user3;

--11
GRANT SELECT, INSERT, UPDATE, DELETE
ON STUDENT1.SALES TO FINANCIAL_APP;

GRANT SELECT, INSERT, UPDATE, DELETE
ON STUDENT1.TEAMS TO HR_APP;
GRANT SELECT, INSERT, UPDATE, DELETE
ON STUDENT1.members TO HR_APP;

GRANT SELECT
ON STUDENT1.PRODUCTS TO FINANCIAL_APP, HR_APP;

GRANT SELECT
ON STUDENT1.CUSTOMERS TO FINANCIAL_APP, HR_APP;

--12
GRANT FINANCIAL_APP TO FINANCIAL_CLERK;

GRANT HR_APP TO HR_CLERK;

GRANT HR_APP, FINANCIAL_APP TO COMPANY_MANAGER;

SELECT GRANTEE, OWNER, TABLE_NAME, GRANTOR, PRIVILEGE
--FROM USER_TAB_PRIVS
FROM DBA_TAB_PRIVS
WHERE GRANTEE LIKE 'FINANCIAL_%';

GRANT CONNECT TO FINANCIAL_CLERK;
GRANT SELECT, INSERT, UPDATE, DELETE ON STUDENT1.SALES TO FINANCIAL_APP;
GRANT FINANCIAL_APP TO FINANCIAL_CLERK;
GRANT FINANCIAL_CLERK TO USER1;

ALTER USER USER1
IDENTIFIED BY Pa$$w0rd;

--16
SELECT ROLE, PASSWORD_REQUIRED FROM DBA_ROLES;

SELECT *
FROM DBA_ROLE_PRIVS
WHERE GRANTEE IN ('HR_CLERK', 'FINANCIAL_CLERK', 'COMPANY_MANAGER')
ORDER BY GRANTEE;

SELECT *
FROM DBA_ROLE_PRIVS
WHERE GRANTEE LIKE 'USER%'
ORDER BY GRANTEE;

SELECT *
FROM ROLE_TAB_PRIVS
WHERE ROLE IN ('HR_APP', 'FINANCIAL_APP')
ORDER BY ROLE;

ALTER PROFILE DEFAULT LIMIT
PASSWORD_verify_FUNCTION NULL;

ALTER USER USER2 IDENTIFIED BY USER2;
ALTER USER USER2 IDENTIFIED BY Pa$$w0rd;
--END