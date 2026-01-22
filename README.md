# WebPing (HTTPS Keep-Alive Monitor for Termux)

WebPing adalah script Bash ringan untuk menjaga koneksi HTTPS tetap aktif
dan memonitor status website secara terus-menerus dari Termux (Android).

Script ini menggunakan HTTPS request (seperti browser),
BUKAN ICMP ping, sehingga lebih stabil di jaringan seluler dan CDN.

--------------------------------------------------

FITUR
- Input host / URL manual (tanpa http juga bisa)
- Monitoring tanpa batas (infinite loop)
- HTTPS request setara browser
- Stop dengan CTRL+C atau ketik: stop
- Status OK / ERROR / NO-RESPONSE
- Counter sukses & gagal
- Ringan & cocok untuk HP (Termux)
- Bisa dipanggil dengan alias: wp
- Auto Update: wp --update

--------------------------------------------------

KEBUTUHAN
- Termux
- Package curl

Install dependency:
pkg install curl -y

--------------------------------------------------

INSTALASI (SEKALI PASANG)

METODE 1 (DISARANKAN) - INSTALLER OTOMATIS

curl -fsSL https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/install-webping.sh | sed 's/\r$//' | bash

Installer akan:
- Download script webping
- Simpan ke ~/.local/bin
- Tambahkan PATH otomatis
- Menyediakan perintah webping dan alias wp

--------------------------------------------------

METODE 2 - INSTALL MANUAL

pkg install curl -y
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/webping.sh -o ~/.local/bin/webping
sed -i 's/\r$//' ~/.local/bin/webping
chmod +x ~/.local/bin/webping

Tambahkan PATH & alias:
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
echo "alias wp='webping'" >> ~/.bashrc
source ~/.bashrc

--------------------------------------------------

CARA PAKAI

Jalankan:
wp

atau:
webping

Masukkan host / URL:
contoh:
ava.game.naver.com
https://ava.game.naver.com

--------------------------------------------------

CONTOH OUTPUT

[17:30:01] STATUS: OK           | HTTP: 200 | SUCCESS: 12 | FAIL: 1
[17:30:06] STATUS: OK           | HTTP: 200 | SUCCESS: 13 | FAIL: 1
[17:30:11] STATUS: ERROR        | HTTP: 503 | SUCCESS: 13 | FAIL: 2

KETERANGAN STATUS
OK          : Website normal (HTTP 2xx–3xx)
ERROR       : Website error (HTTP 4xx–5xx)
NO-RESPONSE : Timeout / tidak ada respon

--------------------------------------------------

CARA STOP
- Tekan CTRL + C
- Atau ketik: stop lalu ENTER

--------------------------------------------------

AUTO UPDATE

Update ke versi terbaru tanpa install ulang:
wp --update

--------------------------------------------------

TIPS TERMUX

Agar script tetap jalan saat layar mati:
termux-wake-lock

Matikan wake lock:
termux-wake-unlock

--------------------------------------------------

CATATAN
- Jangan gunakan interval terlalu agresif
- Gunakan untuk monitoring pribadi
- Beberapa website bisa membatasi request berlebih

--------------------------------------------------

LICENSE
MIT License

AUTHOR
Lutfi Widianto
