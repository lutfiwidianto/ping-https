#!/data/data/com.termux/files/usr/bin/bash

read -p "Masukkan URL (contoh: https://ava.game.naver.com): " TARGET_URL

if [ -z "$TARGET_URL" ]; then
  echo "URL tidak boleh kosong!"
  exit 1
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

  # Input non-blocking untuk stop
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
