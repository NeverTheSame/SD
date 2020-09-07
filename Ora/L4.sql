--EXERCISE
--1
--check if auditing is enabled
select value from v$parameter
where name = 'audit_trail';

--enable traditional auditing
alter system
  set audit_trail = DB
  SCOPE = SPFILE;


--2
AUDIT SELECT TABLE
  BY student1
  WHENEVER NOT SUCCESSFUL;

audit create session
by student1;

audit delete on student1.teams;

--3

select user_name, audit_option,
       success, failure
from dba_stmt_audit_opts
order by user_name;

select user_name, privilege,
       success, failure
from dba_priv_audit_opts
order by user_name;

select *
from dba_obj_audit_opts
where owner = 'student1'
and object_name = 'Teams';

select * from unified_audit_trail where dbusername = 'student1';

--5
select username, obj_name, action_name, comment_text
from SYS.dba_audit_trail
where username = 'student1'
order by timestamp desc;

--6
select distinct policy_name from SYS.audit_unified_policies;

--enter mixed-mode
audit policy ora_account_mgmt;

-- confirming mixed-mode ecurity is enabled
select * from audit_unified_enabled_policies;

--7
create audit policy MyPolicy
privileges create any table, drop any table, create trigger
actions select on student1.sales,
        update on student1.customers
roles capture_admin, audit_admin
when 'sys_context(''userenv'', ''session_user'')
      in (''student1'', ''sys'')'
      evaluate per session;

audit policy MyPolicy;

select * from audit_unified_enabled_policies;

--9
--fliush the unified audit records
BEGIN
  dbms_audit_mgmt.flush_unified_audit_trail;
END;
/

select event_timestamp, dbusername, client_program_name, action_name
from unified_audit_trail
where dbusername in ('student1');

--10
create smallfile tablespace 'auditing'
  datafile size 1g autoextend off
  logging
  default nocompress
  online
  extent management local autoallocate
  segment space management auto;

--END


--chapter c-4: SQL loader
  --loader concepts
  --run loader from command line
  --control file options
  --different load methods
  --express mode


-- data movememnt and transport
--sql*loader
--non-oracle data sources - .txt
--data pump export, import

select * from student1.members;

alter user student1 identified by password;

delete from student1.members
where lastname in ('JONES', 'RABIN', 'AMENTA');

commit;

select * from student1.teams;
--EXERCISE
--2
create index LastNameIndex ON members (LastName);

--3
-- sqlldr userid=student1/password direct=true control=/home/oracle/Documents/ex.ctl

--4
select * from student1.teams;
select * from student1.members;
--END

--chapter c-5: EXPORT & IMPORT
  --managing directory objects
    --db objects that are part of the oracle db
    --pointers to an OS folder
  --data pump architecture
  --data pum export
  --data pump import
  --data pump dictionary views

select * from dba_directories;

create directory DPUMP as '/home/oracle/Documents';

grant read, write on directory DPUMP to student1;


--datapump components
  --DBMS_METADATA - reads DB objects
  --DBMS_DATAPUMP - service to do the methods
  --master table (MT)
  --direct path method
    --domain indexes
    --clustered tables
    --tables with active triggers
    --global indexes on partitioned tables
    --referntial integrity constraints
    --array columns
    --bfile data type
    --fine-graned access control
  --external table method
    --very large table
    --global or domain indexes
    --active triggers
    --encrypted columns
    --fine grained access
  --export
    --modes
      --table mode
      --schema mode
      --tablespace mode
      --full export mode - FULL=Y
      --transportable tablsepace mode

  --DBA_DATAPUMP_JOBS
  --dba_datapump_sessions
  --v$session_longops

--EXERCISE

--1
grant read, write on directory DPUMP2 to student1;
--set the env variable
--export DATA_PUMP_DIR=DPUMP2
expdp student1/student TABLES="(sales,products)" DIRECTORY=DPUMP2 DUMPFILE=tables.dmp;


--END


