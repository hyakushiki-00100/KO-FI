# output(完成品置き場)

**Ko-fi に出品する完成ファイル(PDF)を、このフォルダに入れます。**

## 場所

```
KO-FI/
└── works/
    └── 日本の国宝ガイド/
        ├── assets/     … 素材(画像)
        ├── entries/    … 各城の本文
        └── output/     ← ここ(完成PDF)
```

## 出品予定のファイル(単品5点 + セット1点)

```
日本の国宝ガイド_姫路城.pdf
日本の国宝ガイド_松本城.pdf
日本の国宝ガイド_犬山城.pdf
日本の国宝ガイド_彦根城.pdf
日本の国宝ガイド_松江城.pdf
日本の国宝ガイド_国宝五城セット.zip   ← 上記5冊をまとめたもの
```

サムネイル画像もここに置くと分かりやすいです(例:`thumb_姫路城.png`)。

## 出品前チェック

完成PDFをここに置いたら、[`../出品文.md`](../出品文.md) 末尾のチェックリストで最終確認してください。
特に以下は必須です。

- [ ] 全画像のライセンスを確認・記録した(NC/NDを使っていない)
- [ ] 巻末に写真クレジットを記載した
- [ ] 「料金・時間は変動するため公式サイトで確認」の注意書きを入れた
- [ ] 拝観料・アクセスを各城の公式サイトで最終確認した

---

> 📌 このファイルは、フォルダの場所を示すために置いています(Git は空のフォルダを
> 記録しないため)。完成品を入れたあとも消さないでください。
> ⚠️ 完成PDFやサムネイルが大容量になる場合は、Git に載せるか別管理にするか検討してください。

---

## 生成済みファイル(2026-07)

| ファイル | 内容 |
| --- | --- |
| `日本の国宝ガイド_姫路城.pdf` | 日本語版・A4縦11ページ・約5.2MB |
| `Japans-National-Treasures_Himeji-Castle.pdf` | 英語版・A4縦11ページ・約4.3MB |
| `thumb_姫路城_ja.png` | 日本語版サムネイル・1200×1200 |
| `thumb_Himeji_en.png` | 英語版サムネイル・1200×1200 |
| `kofi_cover.png` | Ko-fi カバー画像・1600×500 |
| `日本の国宝ガイド_犬山城.pdf` | 日本語版・A4縦12ページ・約4.2MB |
| `Japans-National-Treasures_Inuyama-Castle.pdf` | 英語版・A4縦12ページ・約3.2MB |
| `thumb_犬山城_ja.png` / `thumb_Inuyama_en.png` | 犬山城サムネイル・1200×1200 |
| `kofi_avatar.png` | Ko-fi アイコン・800×800 |
| `kofi_shop_preview.png` | Ko-fi ショップ共有用・1200×600 |

## 生成済みファイル(2026-08)

| ファイル | 内容 |
| --- | --- |
| `Japans-National-Treasures_Hikone-Castle.pdf` | 英語版・A4縦12ページ・約3.5MB(日本語版は未作成) |
| `Japans-National-Treasures_Matsue-Castle.pdf` | 英語版・A4縦12ページ・約3.8MB(日本語版は未作成) |
| `thumb_Hikone_en.png` / `thumb_Matsue_en.png` | 彦根城・松江城サムネイル・1200×1200(英語版のみ) |

### 作り直すには

```bash
bash works/日本の国宝ガイド/layout/build.sh        # PDF
bash works/日本の国宝ガイド/layout/build_thumb.sh  # サムネイル
bash works/日本の国宝ガイド/layout/build_profile.sh # プロフィール画像
```

原稿は `layout/himeji_ja.html` / `layout/himeji_en.html`、
体裁は `layout/style.css`、掲載画像は `layout/img/`(assets からリサイズ済み)。

> ⚠️ Chromium は**日本語を含むパス**の `file://` URL を解決できません。
> `build.sh` は ASCII のみの一時ディレクトリへコピーしてから書き出す仕組みになっています。
> 直接 chrome を叩くと1ページの空PDFになるので注意。

### サムネイルについて

`layout/thumb.html` / `thumb_en.html` は**シリーズ共通のテンプレート**です。
残り4城は、次の4点を差し替えるだけで統一感のあるサムネイルが作れます。

1. 写真(`img/○○城_….jpg`)
2. 通し番号(`01` → `02` …)
3. 城名
4. 英名・県名

> ⚠️ `--window-size` の指定どおりにレイアウト高が確保されず、下端に背景色の帯が出ます。
> `build_thumb.sh` は縦を大きめに描画してから 1200×1200 を切り出し、
> 帯が残っていないか自動検査しています。

### プロフィール画像について

文面一式は [`docs/kofi-profile.md`](../../../docs/kofi-profile.md)。

- **カバー**は表示環境で上下左右が切られるため、文字を左中央に寄せ、周囲に余白を確保
- **アイコン**は円形に切り抜かれることがあり、50〜100pxまで縮むため**文字は入れていない**
  (天守のシルエットで識別させる。56pxでも判別できることを確認済み)

### 図版の言語別バージョン

図中の文字も言語ごとに用意しています。**英語版PDFに日本語ラベルの図を混ぜないこと。**

| 言語 | レイアウト用(図版のみ) | 元データ(注釈つき) |
| --- | --- | --- |
| 日本語 | `layout/img/図_狭間の種類.svg` | `assets/図_狭間の種類.svg` |
| 英語 | `layout/img/図_狭間の種類_en.svg` | `assets/図_狭間の種類_en.svg` |

> 💡 英語版PDFに日本語が残っていないかは次で検査できます。
> **表紙の「姫路城」併記のみ残るのが正しい状態**です。
>
> ```bash
> python3 -c "import fitz;d=fitz.open('works/日本の国宝ガイド/output/Japans-National-Treasures_Himeji-Castle.pdf');t=''.join(p.get_text() for p in d);print(''.join(sorted({c for c in t if '一'<=c<='鿿'})))"
> ```
