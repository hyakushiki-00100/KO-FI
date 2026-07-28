#!/usr/bin/env bash
# ============================================================
# 日本の国宝ガイド — PDFビルド
#
# ⚠️ Chromium は日本語を含むパスの file:// URL を解決できないため、
#    いったん ASCII のみの一時ディレクトリへコピーしてから書き出し、
#    生成された PDF を output/ へ戻す。
# ============================================================
set -euo pipefail

CHROME=/opt/pw-browsers/chromium-1194/chrome-linux/chrome
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/../output"
TMP="$(mktemp -d /tmp/kofi-build-XXXXXX)"   # ASCIIパス必須
trap 'rm -rf "$TMP"' EXIT

cp -r "$HERE/." "$TMP/"
mkdir -p "$OUT"

build () {                       # $1=htmlファイル名  $2=出力PDF名
  "$CHROME" --headless --disable-gpu --no-sandbox \
    --virtual-time-budget=20000 --no-pdf-header-footer \
    --print-to-pdf="$TMP/out.pdf" "file://$TMP/$1" 2>/dev/null
  cp "$TMP/out.pdf" "$OUT/$2"
  python3 - "$OUT/$2" <<'PY'
import re, sys, os
p = sys.argv[1]
d = open(p, 'rb').read()
pages = len(re.findall(rb'/Type\s*/Page[^s]', d))
print(f"  ✓ {os.path.basename(p)} — {pages}ページ / {len(d)/1024/1024:.1f}MB")
PY
}

echo "PDFを書き出しています…"
build himeji_ja.html  "日本の国宝ガイド_姫路城.pdf"
build himeji_en.html  "Japans-National-Treasures_Himeji-Castle.pdf"
build inuyama_ja.html "日本の国宝ガイド_犬山城.pdf"
build inuyama_en.html "Japans-National-Treasures_Inuyama-Castle.pdf"
echo "完了。出力先: works/日本の国宝ガイド/output/"
