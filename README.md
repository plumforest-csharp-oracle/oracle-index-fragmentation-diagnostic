# oracle-index-fragmentation-diagnostic
Oracleインデックス断片化診断スクリプト。ANALYZE+INDEX_STATSでCSV出力/再構築判定。

## フォルダ構成

設定ファイル/
└── settings.sql (共通変数定義: &sysuser &targetuser &v_now_time)


├── INDEX_STATS.sql (メイン: @..\設定ファイル\settings.sql → ANALYZE連打)
├── select_index_stats.sql (RATIO/FLAG計算SELECT)
└── index_stats.csv (出力例)
