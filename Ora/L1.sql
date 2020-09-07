-- Separation of duties
  -- evaluate DB server hardware
  -- install DB software
  -- create physical databases
  -- startup and shutdown
  -- ongoing administration tasks
    -- monitoring various DBS
    -- monitor storage resources
    -- utilize DB utilities - import, export, bulk loading
    -- backup and recovery
    -- user security pan
      -- basic user security -- creation of accounts
      -- auditing DB
        -- traditional auditing
        -- unified auditing
      -- data protection - encryption


-- DB architecture overview
  --instance configurations
  --memory structures
    --global structures
    --process structures
  --storage architecture


--DB instance
  --background processes-run the DB instance
    --mandatory
    --optional
  --foreground processes
    --execute SQL statements
    --execute PL/SQL program units
  --memory structures
  --DB files
    --physical DB


--CONFIGURATIONS
  --single instance DB
  --two or more independednt instances
  --cluster instances
  --multitenant DB
    --container DB - CDB
    --multiple pluggable DBs - PDBs

  --MEMORY structures
    --shared memory
      --shared by all users
        --system global area
        --shared global area
    --private memory
      --utilized by a single user
      --program global area
      -- user global area - when stored in the SGA

select * from v$parameter where name like '%size';

  --Process structures
    --background processes
      --DBWR -- 100 running simulataneously
        --writes data out of the DB_cache_size to DATAFILES
      --CKPT
    --LGWR - LOG writer
      --writing all transactions to redo log files
      --in response to a database commit

    --background process startup sequence (no DB connection allowed until all are up and running)
      --PMON - process monitor - responsible for making sure all other processes will be launched
      --LREG - listener registration
      --SMON - system monitor- performance of instance/instance recovery + some housekeeping
      --DBWR
      --LGWR
      --CKPT
      --MMON and MMNL - manageability facilities
      --RECO - distributed DB recovery process


--Storage architecture
  --DB files - several different file types
    --SPFIle - server parameter file (V$PARAMETER), aka initialization file - first file read at startup
      --location of the control file(s)
    --control file (knows where essential DB files are located)
      --knows the location of all data files
      --location of all redo log files
      --multiplexed - duplicate copies
    --DATA files
      --contains rows of actual data
      --contains non-table segments - indexes
      --tablespace
        --user tablespaces
        --system tablespaces
        --undo tablespaces
        --temporary tablespaces
      --REDO logs
        --redundantly record completed DB transactions
        --needed for performance purposes
        --needed for backup and recovery
      --diagnostic files
      --support files
        --oracle wallet
          --transparent data encryption
          --password-protected (2 layers)
            --wallet key - known by the encryption administrators
            --internal key - exposed only when the wallet key is used
      --multitenant files
        --shared files
          --server parameter file
          --temp files


-- CHAPTER A-3: Starting and stopping DB services
  --DB listener
  --DB shutdown and startup
    --various stages of shutdown and startup
    --SQL*plus (sqlplus sys/Pa$$w0rd as sysdba)
    --cloud control
    --MS windows servoices

-- DATABASE Listener  - database API
  --application programmatic interface
  --oracle NET services
--LISTENER.ORA - pulls the status of a listener: lsnrctl -> status

--DB startup and shutdown
select * from teams;
-- echo $ORACLE_SID
-- shutdown immediate + startup
-- / - runs what is in the buffer
-- startup nomount - DB is not open
-- alter database mount; -- alter database open
-- alter database close - only permitted when no sessions conencted
-- alter database dismount
-- shutdown;
-- startup

--MS: services window


-- Chapter A-4: oracle network environment
  --LISTENER - interface to the network
  --Tools
    --netconfiguration manager
    --oracle net manager
  --configure the network using EM CLOUD Control
  --troubleshooting network problems

--primary component  - Oracle NET
  --transport software used for communication
  --TNS - transparent network substrate
  --applictation programmatic interface API for Oracle DB
    --let's you open or close DB session
    --transports data to or from clients
    --handle communication exceptions - errors
--Oracle protocols support
  --TCP/IP
  --TCP/IP SSL
  --SDP
  --Named pipes
--Tools
  --Oracle net manager
    --SQLNET.ORA - server
      --names.directory_path = (TNSNAMES, EZCONNECT)
    --TNSNames.ORA - resides on a client
      --contains physical defenitions of different server names
      --name of the server/instance , e.g. SID
    --LISTENER.ORA - server - /u01/app/oracle/product/12.1.0.2/db_1/network/admin/listener.ora'
      --describes the external protocol
  --Oracle NET congifuration assistance (works with network files)  - netca
--Net manager netmgr
  --command - test service is useful

--TROUBLESHOOTING
  --utilize NET services LOG and TRACE files
    --ping and tnsping (tnsping orcl) - reading TNSNAMES.ORA file