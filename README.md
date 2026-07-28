# KO-FI 出品作品製作チーム

[Ko-fi](https://ko-fi.com/) で頒布・販売する作品を、チームで企画・制作・出品するためのプロジェクトリポジトリです。
企画から出品までの進行、素材・原稿・成果物の管理、チームの役割分担をこのリポジトリ上で一元管理します。

## 目的

- 作品の企画から出品までの流れを **見える化** する
- 制作物・素材・下書きを **散らからず** に管理する
- 誰が何を担当しているかを **明確** にする

## ディレクトリ構成

```
KO-FI/
├── README.md              … このファイル(プロジェクト全体の入口)
├── docs/                  … チーム運用ドキュメント
│   ├── kofi-setup.md      … Ko-fi アカウント初期設定の手順
│   ├── kofi-profile.md    … プロフィール文面・タグ・画像
│   ├── kofi-shop-登録手順.md … 商品登録用のコピペ文面
│   ├── image-sources.md   … 著作権フリー画像の探し方・ライセンス注意
│   ├── team.md            … 役割分担・メンバー
│   ├── workflow.md        … 企画〜出品までの制作フロー
│   └── conventions.md     … 命名・管理ルール
├── works/                 … 個別作品(1作品 = 1ディレクトリ)
│   └── _template/         … 新規作品を始めるときの雛形
│       └── README.md
└── templates/             … 出品説明文などの共通テンプレート
    └── kofi-listing.md    … Ko-fi 出品ページ用テンプレート
```

## 使い方(新しい作品を始める)

1. `works/_template/` を `works/<作品名>/` にコピーする
2. コピーした `README.md` に企画内容を記入する
3. 進行状況を `docs/workflow.md` のフローに沿って更新する

```bash
cp -r works/_template "works/新しい作品名"
```

## リンク

- [Ko-fi セットアップ手順](docs/kofi-setup.md)
- [Ko-fi プロフィール](docs/kofi-profile.md)
- [Ko-fi Shop 商品登録の手順](docs/kofi-shop-登録手順.md)
- [著作権フリー画像の探し方](docs/image-sources.md)
- [チーム・役割分担](docs/team.md)
- [制作フロー](docs/workflow.md)
- [命名・管理ルール](docs/conventions.md)
- [Ko-fi 出品テンプレート](templates/kofi-listing.md)
