--chapter d-1: performance - sql tuning
  --management and advisory framework
  --perforamnce monitoring & AWR
  --SQL tuning advisor
  --metrics

  --AWR - automatic workload repository
    --stored in SYSAUX TBS
    --stores metrics for 7 days
  --ADDM - automatic database diagnostic monitor
    --takes snapshots of performance
    --you can set the time froma for those snapshots to be taken
      --by default, 60minutes

select /* + MONITOR */ firstname, lastname, name
from members
inner join teams on teams.teamid = members.teamid
where lastname = 'Jones';

--SQL tuning advisor
  --operate on a set of SQL statements
dbms_sqltune.set_auto_tuning_task_parameter('LOCAL_TIME_LIMIT', '200');

select /* +MONITOR */ firstname, lastname, name
from members m
inner join teams t
on t.teamid = m.teamid
where lastname = 'Jones';

create index mem_lastname_idx on members (lastname);


--monitoring exceptions with metrics
  --metrics
    --system-defined operational measurements
  --event
    --exceptioms
    --errors

--CHAPTER D-2: data concurrency
  --system and user locks
  --monitor & manage user locks
  --monitor locks with the data dictionary

--system locks
  --internal lock - automatic lock on DB components
  --latch - lower level concurrenct mechanism
    --protect a group of shared objects with SGA
  --mutex - mutual exclusion object
    --protects a single object
    --an individual SQL cursor
  --user locks
    --user has some control over
    --database object lock
      --table locks
      --row-level locks
      --enqueue locks
        --blocking session
        --waiting session
        --DML locks -- data locks (FOR UPDATE in SELECT statemenet)
        --DDL locks - dictionary locks
      --lock modes
        --exclusive locks - TX for update


  select type, name, description
  from V$LOCK_TYPE
  where IS_USER = 'YES'
  order by type;

--V$LOCK
select * from v$lock;

select object_id, session_id, oracle_username, os_user_name, locked_mode
from v$locked_object;

select username, row_wait_obj#, row_wait_block#
from v$session
where SID in (253, 254);

--v$session_wait
select s.username, sw.event, sw.seconds_in_wait, sw.state
from v$session s, v$session_wait sw
where s.sid = sw.sid
and s.sid in (253, 254);

--DBA_BLOCKERS & DBA_WAITERS
select * from DBA_BLOCKERS;
select * from DBA_WAITERS;

--DBA_DML_LOCKS
select * from dba_dml_locks;

select * from dba_ddl_locks where owner like 'student%';

select sid, serial#
from v$session
where sid in (select holding_session from dba_waiters);

alter system
kill session '254, 27781';


--EXERCISE
--1
create user student2 identified by password;
grant create session to student2;
grant all on customers to student2;

delete from customers
where customerid = 100;

grant select on customers
to student2;

--3 as SYSDBA
select l.sid, s.username, l.id1, o.object_name, l.type,
  l.lmode, l.request
from v$lock l, v$session s, dba_objects o
where l.sid = s.sid
AND l.id1 = o.object_id;

--4 as SYSDBA
select object_id, session_id,
  oracle_username, os_user_name, locked_mode
FROm v$locked_object;

--5
select * from dba_blockers;

select * from dba_waiters;

--6
select sid, serial#
from v$session
where sid in (select holding_session from dba_waiters);

--chapter d-3: Backup and RECOVERY
  --backup and recovery structures
    --recovery from failure
      --restored from backup copies
      --recovered through recovery operations
  --managing redo data
  --configuring the DB for recoverability;
  --instance recovery
  --recovery checklist

--flashback technology (recovery from user errors)
--RMAN  - includes metadata repository - stored in control file
  --full backup
  --incremental backups - only for DATA FILES
  --compression
  --consistent backups - when DB is mounted mode - cold backup
  --incosistent backup - DB is in operation mode - hot backup
--data structures needed
  --data structures at risk
    --tablespaces and their data files
    --control file
    --db config files
    --spfile
    --net config files - tnsnames.ora, listener.ora
    --password file
    --oracle wallet
    --alert and trace files
  --data structures used during recovery
    --redo log files (records of all commited transactions)
    --undo information - udno segments
    --control file

select log_mode from v$database;

--configuration of redo log files
  --rules
    --at least 2 online redo log files
      --one to be active
      --other to be inactive
      --2 is minimum
      --3 is a practical minimum
    --all redo logs should be the same size (across groups)
    --the files must be on different devices than the data files
    --archive destination is a different location than the redo files
    --should statemement
      --multiplex the redo logs
      --duplicate of each redo log file

select group#, sequence#, bytes, members, archived, status
from v$log;

select sequence#, first_change#, next_change#
from v$log_history
order by sequence#;

select group#, status,type, member
from v$logfile
order by group#;

select name, dest_id, first_change#, archived
from v$archived_log;

select log_mode from v$database;

















