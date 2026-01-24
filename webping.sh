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

# =========================
# AIRPLANE MODE RESET CONFIG
# =========================
FAIL_STREAK_TRIGGER=3     # berapa kali NO-RESPONSE berturut-turut sebelum reset
AIRPLANE_ON_SLEEP=3       # lama mode pesawat ON (detik)
RESET_COOLDOWN=180        # minimal jeda antar reset (detik)

last_reset_ts=0
fail_streak=0

airplane_on() {
  su -c 'settings put global airplane_mode_on 1; am broadcast -a android.intent.action.AIRPLANE_MODE --ez state true' >/dev/null 2>&1
}

airplane_off() {
  su -c 'settings put global airplane_mode_on 0; am broadcast -a android.intent.action.AIRPLANE_MODE --ez state false' >/dev/null 2>&1
}

do_airplane_reset() {
  local now
  now=$(date +%s)

  # cooldown supaya gak spam
  if [ $((now - last_reset_ts)) -lt $RESET_COOLDOWN ]; then
    echo "⏳ Cooldown reset masih aktif (${RESET_COOLDOWN}s). Lewatkan reset."
    return 0
  fi

  echo "✈️  Reset koneksi: Airplane ON -> OFF"
  airplane_on
  sleep "$AIRPLANE_ON_SLEEP"
  airplane_off

  last_reset_ts="$now"
}

echo "======================================"
echo "Target URL : $TARGET_URL"
echo "Tekan CTRL+C atau ketik 'stop' untuk berhenti"
echo "Auto reset (Airplane) jika NO-RESPONSE x$FAIL_STREAK_TRIGGER"
echo "Cooldown reset: ${RESET_COOLDOWN}s"
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
    fail_streak=$((fail_streak + 1))
  elif [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 400 ]; then
    STATUS="OK"
    fail_streak=0
  else
    STATUS="ERROR"
    fail_streak=0
  fi

  printf "[%s] STATUS: %-12s | HTTP: %s | FAIL_STREAK: %d\n" "$TS" "$STATUS" "$HTTP_CODE" "$fail_streak"

  # Trigger reset kalau 000 beruntun
  if [ "$fail_streak" -ge "$FAIL_STREAK_TRIGGER" ]; then
    do_airplane_reset
    fail_streak=0
  fi

  sleep "$INTERVAL"
done
