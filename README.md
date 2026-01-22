# WebPing (HTTPS Keep-Alive Monitor for Termux)

WebPing adalah script Bash ringan untuk **menjaga koneksi HTTPS tetap aktif** dan **monitor status website** secara terus-menerus dari **Termux (Android)**.

Script ini mensimulasikan akses browser (HTTPS request), **bukan ICMP ping**, sehingga lebih stabil di jaringan seluler dan CDN.

---

## ✨ Fitur

* ✅ Input URL manual
* 🔁 Monitoring tanpa batas (infinite loop)
* 🌐 HTTPS request setara browser (bukan ICMP ping)
* 🛑 Stop dengan `CTRL+C` atau ketik `stop`
* ⚡ Ringan & cocok untuk HP (Termux)
* 🧩 Bisa dipanggil dengan alias (`wp`)
* 🔄 **Auto Update (`wp --update`)**

---

## 📦 Kebutuhan

* Termux
* Package: `curl`

---

## 🚀 Instalasi (Sekali Pasang)

### Metode 1 — Installer Otomatis (Disarankan)

```bash
curl -fsSL https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/install-webping.sh | bash
```

Installer akan otomatis:

* Menginstall dependency
* Download script `webping`
* Menambahkan `~/bin` ke PATH
* Membuat alias `wp`

---

### Metode 2 — Manual Install

```bash
pkg install curl -y
mkdir -p ~/bin
curl -fsSL https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/webping.sh -o ~/bin/webping
chmod +x ~/bin/webping
```

Tambahkan PATH & alias:

```bash
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
echo "alias wp='webping'" >> ~/.bashrc
source ~/.bashrc
```

---

## ▶️ Cara Pakai

Jalankan dengan:

```bash
wp
```

atau:

```bash
webping
```

Masukkan URL yang ingin dipantau:

```text
Masukkan URL (contoh: https://ava.game.naver.com):
```

Untuk update ke versi terbaru:

```bash
wp --update
```

---

## 🖥️ Contoh Output

```text
[17:30:01] STATUS: OK           | HTTP: 200
[17:30:06] STATUS: OK           | HTTP: 200
[17:30:11] STATUS: ERROR        | HTTP: 503
```

Keterangan:

* `OK` → Website merespon normal (HTTP 2xx–3xx)
* `ERROR` → Website error (HTTP 4xx–5xx)
* `NO-RESPONSE` → Tidak ada respon / timeout (HTTP 000)

---

## 🛑 Cara Stop

* Tekan **CTRL + C**
* Atau ketik **`stop`** lalu ENTER

---

## 🔄 Auto Update (Disarankan)

WebPing mendukung **auto update langsung dari GitHub** tanpa install ulang.

### Cara Update

Jalankan perintah berikut:

```bash
webping --update
```

atau jika memakai alias:

```bash
wp --update
```

Script akan:

* Mengambil versi terbaru dari GitHub
* Menimpa script lama secara otomatis
* Tetap menjaga alias & PATH

---

## 📱 Tips Penting (Termux)

Agar script tetap berjalan saat layar mati:

````bash
termux-wake-lock
```bash
termux-wake-lock
````

---

## ⚠️ Catatan

* Jangan gunakan interval terlalu agresif
* Gunakan untuk monitoring pribadi
* Website tertentu bisa membatasi request berlebih

---

## 📄 Lisensi

MIT License

---

## 🤝 Kontribusi

Pull request & issue sangat dipersilakan.

---

**Author:** Lutfi Widianto
