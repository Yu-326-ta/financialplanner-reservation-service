# Financial Planner Service

## demonstration

ホーム画面

![ホーム画面](src/app/assets/images/home1.png)
![ホーム画面](src/app/assets/images/home2.png)
![よくある質問](src/app/assets/images/home3.png)
![サイトについて](src/app/assets/images/home4.png)
![サイトについて](src/app/assets/images/home5.png)

フォーム画面

![新規登録画面](src/app/assets/images/form1.png)
![ログイン画面](src/app/assets/images/form2.png)

クライアント画面

![マイページ画面](src/app/assets/images/mypage.png)
![プランナー一覧画面](src/app/assets/images/planners.png)
![予約画面](src/app/assets/images/reserve image.png)

プランナー画面

![プロフィール画面](src/app/assets/images/profile.png)
![プロフィール画面](src/app/assets/images/profile2.png)
![予約一覧画面](src/app/assets/images/reservations.png)

## ダウンロード
git clone 

もしくは、zip ファイルでダウンロードしてください。

## 環境構築手順
環境を構築したいディレクトリで `git clone` を行い、フォルダを作成する。
docker compose.yml ファイルがあるディレクトリで以下のコマンドを順に打つ

1. `docker-compose up -d` コマンドでコンテナを作成
2. `docker-compose run web rails db:create` コマンドでデータベースを作成
3. `docker-compose run web bundle exec rails ridgepole:apply` コマンドでデータベースにテーブル作成
4. localhost:3000にアクセス

## AWS構成図

![構成図](src/app/assets/images/aws_resource.png)

## AWSの環境変数の設定
aws-credentialsファイルを自分のAWSアカウントもしくはIAMに基づいて設定する．

```
export AWS_ACCESS_KEY_ID=YOUR_IAM_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_IAM_SECRET_KEY
```

## リソースの作成
以下のコマンドを実行すればリソースが作成される．

```
terraform init
terraform apply
```
