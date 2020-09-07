/* 
Copyright (c) 2013 Sideris Courseware Corporation. All Rights Reserved.
Each instructor or student with access to this file must have purchased
a license to the corresponding Sideris Courseware textbook to which 
these files apply. All other use, broadcast, webcast, duplication or distribution
is prohibited and illegal.
*/

/*
General settings
*/

set echo on;
set linesize 132;
set pagesize 200;
set echo off;
set serveroutput on;

/*
Helpful settings for the EQUITIES database
*/

COLUMN price FORMAT B99,999.99;
COLUMN q FORMAT 9
COLUMN i FORMAT 9
COLUMN o FORMAT 9
COLUMN quarter FORMAT A15

/*
Administrator metadata column settings
*/

COLUMN username                 FORMAT A15
COLUMN owner                    FORMAT A8
COLUMN comments                 FORMAT A30 WORD_WRAP
COLUMN credential_name          FORMAT A20
COLUMN ip_address               FORMAT A15
COLUMN hostname                 FORMAT A15

COLUMN tablespace_name          FORMAT A15
COLUMN table_name               FORMAT A15
COLUMN directory_name           FORMAT A20 WRAP
COLUMN directory_path           FORMAT A25 WRAP
COLUMN file_name                FORMAT A30 WRAP
COLUMN segment_name             FORMAT A15
COLUMN object_name              FORMAT A10
COLUMN extent_management        FORMAT A8
COLUMN segment_space_management FORMAT A8
COLUMN default_tablespace       FORMAT A15
COLUMN temporary_tablespace     FORMAT A15
COLUMN account_status           FORMAT A20

COLUMN occupant_name            FORMAT A25COLUMN schema_name              FORMAT A20COLUMN move_procedure           FORMAT A35 WRAPCOLUMN property_name            FORMAT A30COLUMN property_value           FORMAT A25COLUMN description              FORMAT A40 WORD_WRAP

COLUMN privilege                FORMAT A20 WORD_WRAP
COLUMN grantee                  FORMAT A15
COLUMN role                     FORMAT A15
COLUMN granted_role             FORMAT A15
COLUMN profile                  FORMAT A10 WRAP
COLUMN limit                    FORMAT A10 WRAP
COLUMN product                  FORMAT A40 WORD_WRAPCOLUMN version                  FORMAT A10COLUMN status                   FORMAT A20COLUMN job_name                 FORMAT A20COLUMN operation                FORMAT A10COLUMN job_mode                 FORMAT A10COLUMN state                    FORMAT A12
COLUMN message                  FORMAT A40COLUMN value                    FORMAT A50COLUMN pid                      FORMAT A3
/*
Lock metadata column settings
*/
COLUMN type                     FORMAT A6
COLUMN name                     FORMAT A15 WORD_WRAP/*
Traditional and unified auditing column settings
*/
COLUMN obj_name                 FORMAT A15
COLUMN action_name              FORMAT A15
COLUMN audit_option             FORMAT A35
COLUMN user_name                FORMAT A10
COLUMN policy_name              FORMAT A20

/*
Database internals column settings
*/

COLUMN component                FORMAT A25
COLUMN spID                     FORMAT A6
COLUMN traceFile                FORMAT A70

