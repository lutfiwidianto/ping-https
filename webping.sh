#!/data/data/com.termux/files/usr/bin/bash

# =========================
# AUTO UPDATE
# =========================
UPDATE_URL="https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/webping.sh"
SELF_PATH="$HOME/bin/webping"

if [ "$1" = "--update" ]; then
  echo "🔄 Updating WebPing..."
  curl -fsSL "$UPDATE_URL" -o "$SELF_PATH" && chmod +x "$SELF_PATH"
  echo "✅ Update selesai. Jalankan ulang: webping / wp"
  exit 0
fi

# =========================
# INPUT URL
# =========================
read -p "Masukkan URL / Host (contoh: ava.game.naver.com): " TARGET_URL

if [ -z "$TARGET_URL" ]; then
  echo "URL tidak boleh kosong!"
  exit 1
fi

# 👉 AUTO TAMBAH HTTPS JIKA TIDAK ADA
if [[ ! "$TARGET_URL" =~ ^https?:// ]]; then
  TARGET_URL="https://$TARGET_URL"
fi

USER_AGENT="Mozilla/5.0 (Linux; Android)"
INTERVAL=5

echo "======================================"
echo "Target URL : $TARGET_URL"
echo "Tekan CTRL+C atau ketik 'stop' untuk berhenti"
echo "======================================"

trap 'echo -e "\nDihentikan oleh user."; exit 0' INT

while :; do
  TS=$(date "+%H:%M:%S")

  read -t 1 CMD
  if [ "$CMD" = "stop" ]; then
    echo "Perintah STOP diterima."
    exit 0
  fi

  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -A "$USER_AGENT" \
    --connect-timeout 5 \
    --max-time 10 \
    "$TARGET_URL")

  if [ "$HTTP_CODE" = "000" ]; then
    STATUS="NO-RESPONSE"
  elif [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 400 ]; then
    STATUS="OK"
  else
    STATUS="ERROR"
  fi

  printf "[%s] STATUS: %-12s | HTTP: %s\n" "$TS" "$STATUS" "$HTTP_CODE"
  sleep $INTERVAL
done
