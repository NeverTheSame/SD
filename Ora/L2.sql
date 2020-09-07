--Chapter A-5: Diagnostics and Oralce support
  --performance problems vs database problems
  --ADDM - automatic database diagnostcs monitor
    --Performance tab - ADDM
    --has diagnostic trail
  --AWR - automatic workload repository
  --perfomance issues
--ADR - automatic diagnostics repository
  --alert logs
  --debug logs
  --optional ddl log
  --sql execution trace file
  --core dump
  --health monitor reports
  --data repair entries - RMAN
  --sql test cases
--consolidation of diagnostic data
  --db instances
  --ASM - automatic storage management
  --DB Listener
  --CLient connections themselves
    --EM, SQL Developer
    --execution context identifier (ECID)
--DIAG
-- DIAO - Hang manager and deadlock detector
--DIAGNOSTIC_DEST - ORACLE_BASE
  --/u01/app/oracle
select INST_ID, NAME, value from v$DIAG_INFO;

select * from DBA_DATA_FILES;

--ADRCI - ADR Command interpreter
  --V$HM_CHECK
DESCRIBE V$HM_CHECK;
select * from V$HM_CHECK;

-- CHAPTER B-1: tablespace management (p.311)
  --accessing tablespace metadata
  --tablespace creation
    --EM
    --SQL
  --tablespace management
    --EM
    --SQL

--Starter tablespaces for any table you create
  --SYSTEM
  --SYSAUX
  --TEMP
  --UNDO
  --USERS
  --EXAMPLE - created under certain conditions
    --use DBCA to create a DB
    --and indicate that you want sample chemas

select tablespace_name, block_size, status, logging
from dba_tablespaces;

--- EXERCISE:
create smallfile tablespace PERSONNEL
datafile '/u01/app/oracle/oradata/orcl/p1.dbf'
  size 500K,
    '/u01/app/oracle/oradata/orcl/p2.dbf'
  size 500K
LOGGING
ONLINE
extent management local
segment space management auto default
nocompress;

select tablespace_name, status, extent_management, segment_space_management, allocation_type
from dba_tablespaces;

select tablespace_name,
COUNT(file_name) as "DF_count"
from dba_data_files
group by tablespace_name
order by "DF_count"
;
-- TEMP is made of tempirary files and not the data files, that's why it's not shown in the output

alter user student1
  quota unlimited on personnel;

select table_name, tablespace_name from all_tables
where table_name = 'TEAMS' or table_name = 'MEMBERS' and owner = 'STUDENT1';

-- ran INSERT sql script
-- 44.2 and 11 % is free
ALTER TABLESPACE "PERSONNEL" ADD DATAFILE 'SQL-created' SIZE 500K AUTOEXTEND ON NEXT 500K;

select * from student1.TEAMS;

alter tablespace PERSONNEL
OFFLINE;
-- ORA-01110: data file 2: '/u01/app/oracle/oradata/orcl/p1.dbf'

alter tablespace PERSONNEL
ONLINE;

alter tablespace PERSONNEL
READ ONLY;

INSERT INTO teams VALUES (800, 'Random_team', '01-JAN-00', 500);
-- ORA-01110: data file 2: '/u01/app/oracle/oradata/orcl/p1.dbf'
-- 00372. 00000 -  "file %s cannot be modified at this time"


drop tablespace PERSONNEL
including contents and datafiles
cascade constraints;
-- FINISH

alter tablespace example
nologging;

alter tablespace new1
online;

alter tablespace new1
drop datafile '/u01/app/oracle/oradata/orcl/new102.dbf';

drop tablespace new1
including contents and datafiles
cascade constraints;


-- CHAPTER B-: Advanced tablespace management
  --temporary tablespaces
  --temporary TBS group
  --default permanent TBS
  --bigfile TBS
  --management of the SYSAUX TBS
    --occupants (procedures and functions)

  -- temporary TBS
    --intended to store temporary segments
    --permanent TBS storesdata and indexes
    --select ... order by
    --select distinct
    --select group by
    --select.. union, untersect, minus
    --create index
    --some correlated subqueries
    --some joins sort/merge operations
    --create global temporary table

CREATE temporary tablespace temp_local
 TEMPFILE '/u01/app/oracle/oradata/orcl/temp_local1.dbf'
 SIZE 5M
 Extent management local;

alter database
  default temporary tablespace temp_local;

select * from v$sort_segment;
select * from student1.TEAMS order by name;


--temporary tablespace groups
  -- can assign groups in EM
Alter user student1
  temporary tablespace group1;

select group_name, tablespace_name
from DBA_tablespace_groups;

select * from database_properties;

alter database
set default bigfile tablespace;

alter database
set default smallfile tablespace;

select tablespace_name, bigfile from dba_tablespaces;

select name, bigfile from v$tablespace;

--bigfiles TBS are only supported for locally managed TBS (not dictionary-managed)
--TBS that support bigfiles
  --atemporary RBS
  --UNDO TBS
  --SYSTEM TBS

--SYSAUX TBS
  --SYSTEM TBS
  --aux activities (not a part of a normal routine)
  --manadatory attributes
    --permament
    --read-write
    --extent maangement local (not dictionary)
    --segment space managmeent auto
select * from dba_data_files;
alter tablespace SYSAUX
add datafile '/u01/app/oracle/oradata/orcl/sysaux02.dbf'
size 300M;

select occupant_name, schema_name, space_usage_kbytes, move_procedure
from v$sysaux_occupants
order by occupant_name;


create tablespace LOG_MINER_TS
datafile '/u01/app/oracle/oradata/orcl/log_miner_ts01.dbf'
size 300M;

execute sys.dbms_logmnr_d.set_tablespace('LOG_MINER_TS');

-- EXERCISE
create smallfile temporary tablespace MyTemp
 TEMPFILE '/u01/app/oracle/oradata/orcl/myTemp1.dbf' SIZE 500K,
          '/u01/app/oracle/oradata/orcl/myTemp2.dbf' SIZE 500K
  EXTENT MANAGEMENT LOCAL
  UNIFORM SIZE 100K;

select * from v$tablespace;
-- True because this aux operations have to all be separated from regular procedures

create smallfile temporary tablespace MyTempA
 TEMPFILE '/u01/app/oracle/oradata/orcl/myTempA1.dbf' SIZE 500K,
          '/u01/app/oracle/oradata/orcl/myTempA2.dbf' SIZE 500K
  EXTENT MANAGEMENT LOCAL
  UNIFORM SIZE 100K;

ALTER TABLESPACE "MYTEMPA" TABLESPACE GROUP "MYGROUP";
ALTER TABLESPACE "MYTEMP" TABLESPACE GROUP "MYGROUP";
select group_name, tablespace_name
from DBA_tablespace_groups;

select * from v$tablespace;

select * from database_properties where property_name like '%TEMP%';

alter database
default temporary tablespace "MYGROUP";

drop tablespace MyTemp including contents and datafiles;

select tablespace_name, status from dba_tablespaces where contents = 'TEMPORARY';

alter database default temporary tablespace  temp;
-- END


--Chapter B-3: datafiles & temp files
  --level of the physical DB
  --metadata file datafiles
  --managew datafiles with sql
  --managing temp files
  --OMF - oracle managed files

select tablespace_name, file_name, Bytes, blocks, status, autoextensible from dba_data_files
order by tablespace_name;

select tablespace_name, count(file_name) as df_count,
sum(bytes) / 1024 as total_space
from DBA_data_files
group by tablespace_name
order by tablespace_name;

select tablespace_name, file_name, file_id, relative_fno
from DBA_data_files -- shows what is avaialble
order by tablespace_name;

select tablespace_name, count(block_id), sum(bytes)
from DBA_free_space -- shows what is free
group by tablespace_name
order by tablespace_name;

select distinct segment_type
from DBA_segments;

select segment_type, segment_name, tablespace_name
from DBA_segments
where owner like '%STUDENT%'
order by segment_type;

create index FNAME_LNAME_IDX
On members(firstname, lastname);

--modify auto-extend
--change the size of the file
--bring the file offline/online
--drop and empty datafile
--move or rename a datafile
--db_files that sets the max num of files that is avaialble in every table

alter tablespace EXAMPLE
datafile '/u01/app/oracle/oradata/orcl/example01.dbf'
resize 50M;
-- or OFFLINE - to take ot offline

alter database
datafile '/u01/app/oracle/oradata/orcl/example01.dbf'
OFFLINE;

select file_name from dba_data_files;

alter tablespace example
add datafile '/u01/app/oracle/oradata/orcl/example02.dbf'
size 100M
autoextend on;

alter database
drop datafile '/u01/app/oracle/oradata/orcl/example02.dbf';

select file_name, tablespace_name from dba_temp_files;

select file#, bytes from v$tempfile;


--Oracle managed files, 12c+
--TBS and datafiles
--onloine redo log files and archvie logs
--control files
--create block change tracking files
-- create flashback lgfiles
--create RMAn backups


--parameters
  --db_create_file_dest
  --db_recovery_file_dest
  --db_create_online_log_dest_1

select name, value from v$parameter
where name like 'db_create%';

alter session
set db_create_file_dest = '/u01/app/oracle/oradata/';

create tablespace test_OMF1;

create tablespace test_OMF2
datafile size 100M
autoextend off;

select file_name, bytes from dba_data_files;


-- EXERCISE
select DBID, name, created, log_mode from v$database;

select * from DBA_DATA_FILES;  -- all physical fiels within the DB
select * from DBA_FREE_SPACE;  -- all free extents
select * from DBA_SEGMENTS;  --   all segments
select * from DBA_EXTENTS;

select tablespace_name, file_name, file_id, bytes, status, autoextensible
from dba_data_files
order by tablespace_name, file_name;

select tablespace_name, relative_fno, count(block_id) as FreeExt, sum(bytes) FreeBytes
from dba_free_space
group by tablespace_name, relative_fno
order by tablespace_name ASC, FreeBytes DESC;

select owner, segment_type, segment_name, tablespace_name
FROM dba_segments
where owner like '%STUDENT%'
order by segment_type;

select tablespace_name, segment_type, segment_name,
  COUNT(extent_id) AS '# Extents',
  TRUNC(SUM(bytes)/1000) AS 'KBytes'
FROM dba_extents
Where segment_type = 'TABLE'
GROUP BY tablespace_name, segment_type, segment_name
HAVING COUNT(extent_id) > 1
ORDER BY tablespace_name, segment_type, segment_name;

-- AS '# Extents'

select tablespace_name, segment_type, segment_name, extent_id FROM dba_extents;
  --TRUNC(SUM(bytes)/1024) AS 'KBytes'


alter session
set db_create_file_dest = '/u01/app/oracle/oradata/';

create tablespace TestOMF
DATAFILE SIZE 10M;

select * from DBA_DATA_FILES;

drop tablespace TestOMF;

--END

--IMPORTANT COMMANDS
--fetch info about tablespaces
SELECT tablespace_name, block_size, status, logging
FROM dba_tablespaces;

--create smallfile tablespace
create smallfile tablespace PERSONNEL
datafile '/u01/app/oracle/oradata/orcl/p1.dbf'
  size 500K,
    '/u01/app/oracle/oradata/orcl/p2.dbf'
  size 500K
LOGGING
ONLINE
extent management local
segment space management auto default
nocompress;

--drop tablespace
DROP TABLESPACE New1
    INCLUDING CONTENTS AND DATAFILES
    CASCADE CONSTRAINTS;

--taking tablespace offline
ALTER TABLESPACE junk OFFLINE;

-- add datafile to tablespace
ALTER TABLESPACE junk
    ADD DATAFILE 'C:\BusinessSystems\Test\junk2.dbf'
    SIZE 500K
    AUTOEXTEND OFF;