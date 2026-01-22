#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "[+] Installing WebPing for Termux..."

# Lokasi install
BIN_DIR="$HOME/.local/bin"
SCRIPT_NAME="webping"
RAW_URL="https://raw.githubusercontent.com/lutfiwidianto/ping-https/main/webping.sh"

# Dependency
command -v curl >/dev/null 2>&1 || {
  echo "[!] curl not found, installing..."
  pkg install curl -y
}

# Buat folder bin
mkdir -p "$BIN_DIR"

# Download script
echo "[+] Downloading webping..."
curl -fsSL "$RAW_URL" -o "$BIN_DIR/$SCRIPT_NAME"

# Fix CRLF (Windows line ending)
sed -i 's/\r$//' "$BIN_DIR/$SCRIPT_NAME"

# Permission
chmod +x "$BIN_DIR/$SCRIPT_NAME"

# PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Alias
if ! grep -q "alias wp=" "$HOME/.bashrc" 2>/dev/null; then
  echo "alias wp='webping'" >> "$HOME/.bashrc"
fi

echo
echo "[✓] WebPing installed successfully!"
echo "    Command : webping"
echo "    Alias   : wp"
echo
echo "👉 Restart Termux or run: source ~/.bashrc"
echo "👉 Then run: wp"
