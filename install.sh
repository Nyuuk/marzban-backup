#!/bin/sh

# Cek apakah perintah crontab sudah terinstall
if command -v crontab &>/dev/null; then
  echo "Crontab sudah terinstall."
else
  echo "Crontab belum terinstall. Instalasi tidak dapat dilanjutkan."
  exit 1
fi

# Ganti dengan jalur lengkap menuju skrip backup_to_github.sh
SCRIPT_PATH="$(pwd)/boot_script.sh"

echo "cd $(pwd);\nexec ./start.sh > log.txt 2>&1" > $(pwd)/boot_script.sh
chmod +x $(pwd)/boot_script.sh

git config --global user.email "$(hostname)@bukanvvip.my.id"
 git config --global user.name "$(hostname)"

# Tambahkan entri ke crontab jika belum ada
if ! crontab -l | grep -q "@reboot $SCRIPT_PATH"; then
  (crontab -l 2>/dev/null; echo "@reboot $SCRIPT_PATH") | crontab -
  echo "Entri berhasil ditambahkan ke crontab."
else
  echo "Entri sudah ada di crontab. Tidak ada yang perlu ditambahkan."
fi

