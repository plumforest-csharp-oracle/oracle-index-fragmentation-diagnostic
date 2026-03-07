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

2. **設定ファイル/settings.sql**編集
