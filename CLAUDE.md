# CLAUDE.md — このリポジトリでの作業ガイド

> このファイルは新しいセッションを開くたびに自動で読み込まれます。
> **会話の記憶に頼らず、ここと各ドキュメントを読めば作業を再開できる**ようにするための入口です。

## このリポジトリは何か

Ko-fi(ko-fi.com/zenkyu)で頒布・販売するデジタル作品(主にPDFガイドブック)を
企画から出品まで一元管理するプロジェクト。詳細構成は [`README.md`](README.md)。

## 今、何を作っているか

**Vol.1: 日本の国宝ガイド(国宝五城シリーズ)** — 姫路城・松本城・犬山城・彦根城・松江城の
5冊(日英・各¥500)+5城セット。

- **必ず最初に読む**: [`works/日本の国宝ガイド/README.md`](works/日本の国宝ガイド/README.md)
  — 5城それぞれの進捗ステータス表がある(本文/画像/PDFの完了状況)
- 個別作業に入る前に、関連ドキュメントも読む:
  - 文章量・構成の見本 → [`works/日本の国宝ガイド/entries/1_姫路城.md`](works/日本の国宝ガイド/entries/1_姫路城.md)
  - 画像ライセンス判断ルール → [`docs/image-sources.md`](docs/image-sources.md)
  - 画像クレジット台帳 → [`works/日本の国宝ガイド/クレジット一覧.md`](works/日本の国宝ガイド/クレジット一覧.md)
  - PDF組版の環境バグ・手順 → [`.claude/agents/layout.md`](.claude/agents/layout.md)(`layout` サブエージェントの定義。「PDFにして」「組版して」で呼び出す)
  - 生成済みファイル一覧・再生成コマンド → [`works/日本の国宝ガイド/output/README.md`](works/日本の国宝ガイド/output/README.md)
  - Ko-fi Shop 出品の手順・コピペ文面 → [`docs/kofi-shop-登録手順.md`](docs/kofi-shop-登録手順.md)
  - Ko-fi プロフィール文面 → [`docs/kofi-profile.md`](docs/kofi-profile.md)
  - 英文記事(高級旅行誌トーン。PDFとは別系統)の書き手設定・文体ルール → [`works/日本の国宝ガイド/articles/README.md`](works/日本の国宝ガイド/articles/README.md)

## 押さえておくべき前提・ルール

- **ブランチ**: `claude/kofi-production-team-b67gly` で作業する
- **ページURLは固定**: `ko-fi.com/zenkyu`(変更すると公開済みリンクが壊れるので絶対に変えない)
- **画像ライセンス方針**(詳細は `docs/image-sources.md`):
  - ✅ 使える: Public Domain / CC0 / CC BY(要クレジット)
  - ❌ 避ける: CC BY-SA(改変不可・別ライセンス併記がない限り)、CC BY-ND
  - ❌ 絶対NG: NC(非営利限定。有料販売と矛盾)
  - Wikimedia Commonsのライセンス欄は**「File history / Original upload log」が出るまで最後までスクロール**する
    (CC BY-SAより下に、より緩いライセンス選択肢が隠れていたケースが2回あった)
- **PDF組版(Chromium)の既知の環境バグ**(詳細は `.claude/agents/layout.md`):
  1. Chromiumは日本語を含む `file://` パスを解決できない → ASCII一時ディレクトリ経由で書き出す
  2. `--window-size` 指定どおりの高さにならず下端に帯が出る → 大きめに描画してから正確なサイズに切り出す
  3. 英語版PDFに日本語ラベルの図を混ぜない(図版は言語別に用意する)
- **既刊の状態**(詳細は works 側 README.md):
  - 姫路城: 本文・画像9枚・PDF(日英)完了
  - 犬山城: 本文・画像6枚・PDF(日英)完了
  - 松本城: 本文完成、画像1枚のみ(ユーザー指示で収集を一旦保留中)
  - 彦根城・松江城: 本文拡張完了(姫路城と同構成)。画像収集は未着手

## 新しい作品(城)に着手するときの進め方

1. `works/日本の国宝ガイド/README.md` を読んで現在地を確認
2. `entries/1_姫路城.md` の分量・章立てに合わせて対象の entry を拡張
3. 画像を集めてライセンス確認 → `クレジット一覧.md` に記録
4. `layout` サブエージェントでPDF化(JA/EN)・サムネイル生成
5. `works/日本の国宝ガイド/README.md` と `output/README.md` の進捗表を更新
6. コミット・push(このブランチへ)

## セッション運用の方針

- 1つの会話に作業を詰め込みすぎない。**画像を何十枚も読ませる作業や、次の城の作業は
  新しいセッションに分ける**(このファイルと各ドキュメントを読めば引き継げる)
- 会話の記憶ではなく、**ファイルに書いて残す**(README.mdの進捗表、クレジット一覧、出力ログ)ことを優先する
