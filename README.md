# using-goose

## セットアップ
### Goのインストール
``` sh
brew install go
```

### 環境変数の設定
``` sh
cat ~/.zshrc
...
# --- 追加 ここから ---
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# --- 追加 ここまで ---
...

# 設定を再読み込み
source ~/.zshrc
```

### gooseのインストール
``` sh
# https://github.com/pressly/goose
$ go get -u github.com/pressly/goose/cmd/goose
```

## 基本的な使い方
1. マイグレーションファイルの作成
2. マイグレーション状況の確認
3. マイグレーションの実行
4. ロールバック

### マイグレーションファイルの作成
``` sh
# マイグレーションファイルのテンプレートを作成
$ mkdir -p db/migrations
$ goose -dir db/migrations create create_table_users sql
2019/02/28 00:40:23 Created new file: db/migrations/20190228004023_create_table_users.sql

# 作成したファイルにマイグレーション内容を記述
$ vi db/migrations/20190228004023_create_table_users.sql
```

### マイグレーション状況を確認
``` sh
# マイグレーション状況を確認
# goose mysql "user:password@/dbname?parseTime=true" status
$ goose -dir db/migrations mysql "admin:admin@tcp(127.0.0.1:3306)/sandbox?parseTime=true" status
2019/02/28 01:03:58     Applied At                  Migration
2019/02/28 01:03:58     =======================================
2019/02/28 01:03:58     Pending                  -- 20190228004023_create_table_users.sql
```

### マイグレーションの実行
``` sh
# マイグレーションの実行
$ goose -dir db/migrations mysql "admin:admin@tcp(127.0.0.1:3306)/sandbox?parseTime=true" up
2019/02/28 01:09:48 OK    20190228004023_create_table_users.sql
2019/02/28 01:09:48 goose: no migrations to run. current version: 20190228004023

# マイグレーション状況を確認
$ goose -dir db/migrations mysql "admin:admin@tcp(127.0.0.1:3306)/sandbox?parseTime=true" status
2019/02/28 01:12:15     Applied At                  Migration
2019/02/28 01:12:15     =======================================
2019/02/28 01:12:15     Wed Feb 27 16:09:48 2019 -- 20190228004023_create_table_users.sql
```

### マイグレーションの取消 (ロールバック)
``` sh
# ロールバックの実行
$ goose -dir db/migrations mysql "admin:admin@tcp(127.0.0.1:3306)/sandbox?parseTime=true" down
2019/02/28 01:13:55 OK    20190228004023_create_table_users.sql

# マイグレーション状況を確認
$ goose -dir db/migrations mysql "admin:admin@tcp(127.0.0.1:3306)/sandbox?parseTime=true" status
019/02/28 01:14:25     Applied At                  Migration
2019/02/28 01:14:25     =======================================
2019/02/28 01:14:25     Pending                  -- 20190228004023_create_table_users.sql
```


## 参考
- [pressly/goose: Goose database migration tool - fork of https://bitbucket.org/liamstask/goose](https://github.com/pressly/goose)
