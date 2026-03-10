# oracle-index-fragmentation-diagnostic
Oracleインデックス断片化診断スクリプト。ANALYZE+INDEX_STATSでCSV出力/再構築判定。

## フォルダ構成

設定ファイル/
- settings.sql (共通変数定義: &sysuser &targetuser &v_now_time)

①インデックス情報取得/
- INDEX_STATS.sql (メイン: @..\設定ファイル\settings.sql → ANALYZE連打)
- ①select_index_stats.sql (RATIO/FLAG計算SELECT)
- INDEX_STATS.bat (ユーザがダブルクリックで起動。INDEX_STATS.sqlを呼び出す)
- YYYYDDMM_hhmmss_XXXX_index_stats.csv (出力例)

②インデックス再構築/
- INDEX_REBUILD.bat (ユーザがダブルクリックで起動。YOUR_INDEX_NAME.sqlを呼び出す)
- YOUR_INDEX_NAME.sql (メンテナンス対象のインデックスのDropとCreate)



## 実行手順
1. **設定ファイル/settings.sql**編集 → **伏字を実際値に**
   - DEFINE sysuser=オラクルDBのシステムユーザ名
   - DEFINE syspass=オラクルDBのシステムユーザのパスワード
   - DEFINE mntrole=オラクルDBのメンテナンス可能なロール
   - DEFINE mntrole_pass=オラクルDBのメンテナンス可能なロールのパスワード

2. **①ンデックス情報取得/INDEX_STATS.bat**編集 
   - 第一パラメータ：YOUR_SCHEMA を対象のスキーマ名に修正
  
3. **①インデックス情報取得/INDEX_STATS.sql**編集
   - YOUR_INDEX_NAME を対象のインデックス名に変更
   - 複数INDEXを同時に実行することも可能

↓4以降は、メンテナンス対象インデックスがあった時のみ
4. **②インデックス再構築/INDEX_REBUILD.bat**編集
   - mnt/XXXXXXXX のユーザ名とパスワードを編集。※mntroleを付与しているユーザ名
   - 第一パラメータ：YOUR_SCHEMA を対象のスキーマ名に修正

5. **②インデックス再構築/YOUR_INDEX_NAME.sql**編集
   - YOUR_TABLE を対象のインデックスを保持するテーブル名に変更
   - YOUR_INDEX_NAME を対象のインデックス名に変更
   - YOUR_CULUMN を対象のインデックスに指定したテーブルのカラム名に変更

## CSV診断結果確認
バッチと同階層にcsvファイルが出力される。YYYYDDMM_hhmmss_YOUR_SCHEMA_index_stats.csv  
一行目がヘッダー行で、2行目以降が、インデックス情報

Ex)↓  
"SCHEMA","NAME","HEIGHT","LF_ROWS","DEL_LF_ROWS","RATIO","FLAG"  
"YOUR_SCHEMA","YOUR_INDEX_NAME_01","2","37461","0","0.00","0"  
"YOUR_SCHEMA","YOUR_INDEX_NAME_02","4","10000","2500","0.250","1"

## 判定基準

| 項目 | 閾値 | 対処 |
|------|------|------|
| RATIO | > 0.2 | ALTER INDEX REBUILD ONLINE |
| HEIGHT | >= 4 | 肥大化注意 |
| FLAG | 1 | 即再構築 |

## 実務活用例
[クエリ遅延発生]  
1. INDEX_STATS.batを実行
2. 出力結果CSVでFLAG=1のインデックス名を確認
3. 対象のインデックスをDrop → Create でインデックスを再作成（インデックス再構築のSQLはまた作成します）

[インデックス劣化の定期確認]
- オラクルDBをインストールしているサーバー上の定期実行ジョブまたは、スケジュールを取り決めてからの直接バッチ実行。  
- 手順は、クエリ遅延発生と同様

## 特徴
- **モジュール化**: settings.sql共有で複数スクリプト統一管理
- **CSV出力**: Excelでフィルタ/グラフ化
- **エラー安全**: WHENEVER SQLERRORでROLLBACK
