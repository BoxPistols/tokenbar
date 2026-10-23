#!/bin/sh
# Claude Code の statusLine から渡される JSON を TokenBar 用に保存する（公式の仕組みのみ使用）
dir="$HOME/Library/Application Support/TokenBar"
mkdir -p "$dir"
input=$(cat)
# rate_limits は各セッションの最初の応答後にしか入らないため、無い場合は前回値を残す
if printf '%s' "$input" | grep -q '"rate_limits"'; then
  printf '%s' "$input" > "$dir/statusline.json.tmp" && mv "$dir/statusline.json.tmp" "$dir/statusline.json"
fi
# 端末側のステータスラインにはモデル名だけ出す
printf '%s' "$input" | /usr/bin/python3 -c 'import json,sys
try: print(json.load(sys.stdin).get("model",{}).get("display_name",""))
except Exception: print("")' 2>/dev/null
