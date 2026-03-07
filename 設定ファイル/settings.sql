-- ユーザ定義変数
-- 変数を参照する際は「&」を頭に、「.」を後ろに付ける


-- 各種SQLファイルの実行時にOraエラーが発生した場合は、ロールバックして停止
WHENEVER SQLERROR EXIT 1 ROLLBACK


------ ▼対象ユーザ ------

DEFINE targetuser=XXXXXXXX
DEFINE targetuser_pass=********

------ ▲対象ユーザ ------

--  SYS
DEFINE sysuser=XXXXXXXX
DEFINE syspass==********


-- SYSTEM
DEFINE systemuser=XXXXXXXX
DEFINE systempass=********

--日付＋時刻の文字列を定義
conn &systemuser./&systempass.
col now_time new_value v_now_time
SELECT TO_CHAR(SYSDATE,'YYYYMMDD_HH24MISS') NOW_TIME FROM DUAL ;
disconn
