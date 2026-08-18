#!/usr/bin/env bash
# ============================================================
# Ko-fi Shop サムネイル(1200×1200)の書き出し
#
# ⚠️ 注意点が2つある:
#   1. Chromium は日本語を含むパスを解決できない
#      → ASCII の一時ディレクトリを経由する(build.sh と同じ)
#   2. --window-size をそのまま指定すると、実際のレイアウト高が
#      指定より小さくなり、下端に背景色の帯が出る
#      → 縦を大きめに描画し、上から 1200×1200 を切り出す
# ============================================================
set -euo pipefail

CHROME=/opt/pw-browsers/chromium-1194/chrome-linux/chrome
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/../output"
TMP="$(mktemp -d /tmp/kofi-thumb-XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

cp -r "$HERE/." "$TMP/"
mkdir -p "$OUT"

shot () {   # $1=htmlファイル名  $2=出力PNG名
  "$CHROME" --headless --disable-gpu --no-sandbox \
    --virtual-time-budget=12000 --window-size=1200,1500 --hide-scrollbars \
    --screenshot="$TMP/raw.png" "file://$TMP/$1" 2>/dev/null
  python3 - "$TMP/raw.png" "$OUT/$2" <<'PY'
import sys, os
from PIL import Image
src, dst = sys.argv[1], sys.argv[2]
im = Image.open(src).convert("RGB").crop((0, 0, 1200, 1200))   # 上から正方形に切り出す
im.save(dst, optimize=True)
# 下端に背景色の帯が残っていないか検査
if im.getpixel((600, 1199)) == (17, 17, 17):
    raise SystemExit(f"✗ {os.path.basename(dst)}: 下端に帯が残っています")
print(f"  ✓ {os.path.basename(dst)} — {im.size[0]}×{im.size[1]} / {os.path.getsize(dst)//1024}KB")
PY
}

echo "サムネイルを書き出しています…"
shot thumb.html "thumb_善光寺.png"
echo "完了。出力先: works/日本の名刹ガイド/output/"
