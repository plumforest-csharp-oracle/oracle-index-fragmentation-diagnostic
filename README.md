# oracle-index-fragmentation-diagnostic
Oracleインデックス断片化診断スクリプト。ANALYZE+INDEX_STATSでCSV出力/再構築判定。

## フォルダ構成

設定ファイル/
- settings.sql (共通変数定義: &sysuser &targetuser &v_now_time)

インデックス情報取得/
- INDEX_STATS.sql (メイン: @..\設定ファイル\settings.sql → ANALYZE連打)
- ①select_index_stats.sql (RATIO/FLAG計算SELECT)
- INDEX_STATS.bat (ユーザがダブルクリックで起動。INDEX_STATS.sqlを呼び出す)
- YYYYDDMM_hhmmss_XXXX_index_stats.csv (出力例)


## 実行手順
1. **設定ファイル/settings.sql**編集
   - DEFINE sysuser=オラクルDBのシステムユーザ名
   - DEFINE syspass=オラクルDBのシステムユーザのパスワード

2. **インデックス情報取得/INDEX_STATS.bat**編集
   - 第一パラメータ：YOUR_SCHEMA を対象のスキーマ名に修正
  
3. **インデックス情報取得/INDEX_STATS.sql**編集
   - YOUR_INDEX_NAME を対象のインデックス名に変更
   - 複数INDEXを同時に実行することも可能

## CSV診断結果確認
バッチと同階層にcsvファイルが出力される。YYYYDDMM_hhmmss_YOUR_SCHEMA_index_stats.csv

Ex)↓
"SCHEMA","NAME","HEIGHT","LF_ROWS","DEL_LF_ROWS","RATIO","FLAG"
"YOUR_SCHEMA","YOUR_INDEX_NAME","2","37461","0","0.00","0"
