@..\設定ファイル\settings.sql

set role mntrole identified by mntrole_pass; --メンテナンス用のロールを有効化
alter session set current_schema=&1; --記述簡略化のため。この記述がないと、毎回 YOUR_SCHEMA.YOUR_INDEX_NAME などの記述が必要

spo &v_now_time._&1._YOUR_TABLE_index.log

-- ■Index削除
DROP INDEX YOUR_INDEX_NAME;

-- ■Index作成
CREATE INDEX YOUR_INDEX_NAME
ON YOUR_TABLE(
    YOUR_CULUMN)
TABLESPACE &1._IND1 --インデックスを保存する**表領域（Tablespace）**を指定
PCTFREE 5 --デフォルト10% → 5%に減らすことでデータ密度UP→読み取り高速化
NOLOGGING --ログ生成を抑制 → インデックス作成を爆速化（通常の数倍速）
;

spo off

exit
