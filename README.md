# WebPing (HTTPS Check via curl) — Termux

Script Termux untuk cek koneksi ke host/URL via **HTTPS** pakai `curl` secara loop.  
Bisa auto tambah `https://` jika input hanya host.

---

## Quick Install (Termux)

```bash
pkg update -y
pkg install -y curl

mkdir -p ~/bin
curl -LfsS 'https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/webping.sh' -o ~/bin/webping
chmod +x ~/bin/webping

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
