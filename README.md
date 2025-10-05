# local-lambda

Go で実装した Lambda 関数を `public.ecr.aws/lambda/provided:al2.2025.10.04.11` ベースのコンテナでローカル実行するための最小構成です。

## 必要要件

- Docker
- Go 1.22 以降
- `jq` (レスポンス確認用、無くても問題ありません)

## 使い方

1. コンテナイメージをビルドします。
   ```bash
   make docker-build
   ```
2. 別ターミナルでコンテナを起動し、Lambda Runtime Interface Emulator を待ち受けます。
   ```bash
   make run
   ```
   - ポート `9000` が開き、`curl` などからイベントを送信できます。
3. 用意したイベント (`event.json`) を投げてハンドラーを実行します。
   ```bash
   make invoke
   ```

イベントの JSON は `event.json` にあり、必要に応じて編集してください。ハンドラーは `cmd/handler/main.go` にあり、`name` フィールドを受け取りメッセージを返します。

## 開発メモ

- `make bootstrap` で Linux 向けに `bootstrap` バイナリをビルドできます。
- ビルド成果物を片付ける場合は `make clean` を実行してください。
