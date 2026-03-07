@..\設定ファイル\settings.sql

spo &v_now_time._&1._index_stats.csv

PROMPT "SCHEMA","NAME","HEIGHT","LF_ROWS","DEL_LF_ROWS","RATIO","FLAG"

SET pagesize 0
SET feedback off
SET heading off
SET markup csv on delimiter ',' quote on
SET trims on
SET echo off
SET verify off
SET termout off
SET newpage none

COLUMN name format a20
COLUMN height format 9999
COLUMN lf_rows format 99999999
COLUMN del_lf_rows format 99999999
COLUMN ratio format 9990.99
COLUMN flag format 9

conn &sysuser./&syspass. as sysdba

analyze INDEX &1..YOUR_INDEX_NAME validate structure;  -- ex: IX_TCM0006_01
@①select_index_stats.sql &1.
  
-- 追加INDEX例:
-- analyze INDEX &1..IX_TCM0006_02 validate structure;
-- @select_index_stats.sql &1.

spo off

exit
