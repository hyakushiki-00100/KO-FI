#!/usr/bin/env bash
# ============================================================
# Ko-fi プロフィール画像の書き出し
#   カバー 1600×500 / アイコン 800×800 / ショップ共有用 1200×600(2:1)
#
# ⚠️ 既知の注意点(build_thumb.sh と同じ)
#   1. Chromium は日本語を含むパスを解決できない → ASCII の一時ディレクトリを経由
#   2. --window-size どおりのレイアウト高が取れない → 大きめに描画して切り出す
# ============================================================
set -euo pipefail

CHROME=/opt/pw-browsers/chromium-1194/chrome-linux/chrome
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/../output"
TMP="$(mktemp -d /tmp/kofi-prof-XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

cp -r "$HERE/." "$TMP/"
mkdir -p "$OUT"

shot () {   # $1=html  $2=出力名  $3=幅  $4=高さ
  "$CHROME" --headless --disable-gpu --no-sandbox \
    --virtual-time-budget=12000 --hide-scrollbars \
    --window-size="$3,$(( $4 + 320 ))" \
    --screenshot="$TMP/raw.png" "file://$TMP/$1" 2>/dev/null
  python3 - "$TMP/raw.png" "$OUT/$2" "$3" "$4" <<'PY'
import sys, os
from PIL import Image
src, dst, w, h = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
im = Image.open(src).convert("RGB").crop((0, 0, w, h))
im.save(dst, optimize=True)
if im.getpixel((w // 2, h - 1)) == (13, 16, 21):     # 下端に背景色の帯が残っていないか
    raise SystemExit(f"✗ {os.path.basename(dst)}: 下端に帯が残っています")
print(f"  ✓ {os.path.basename(dst)} — {w}×{h} / {os.path.getsize(dst)//1024}KB")
PY
}

echo "プロフィール画像を書き出しています…"
shot profile_cover.html  "kofi_cover.png"  1600 500
shot profile_avatar.html "kofi_avatar.png"  800 800
shot shop_preview.html   "kofi_shop_preview.png" 1200 600
echo "完了。出力先: works/日本の国宝ガイド/output/"
