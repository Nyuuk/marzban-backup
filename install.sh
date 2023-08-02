#!/bin/sh

# Cek apakah perintah crontab sudah terinstall
if command -v crontab &>/dev/null; then
  echo "Crontab sudah terinstall."
else
  echo "Crontab belum terinstall. Instalasi tidak dapat dilanjutkan."
  exit 1
fi

# Ganti dengan jalur lengkap menuju skrip backup_to_github.sh
SCRIPT_PATH="$(pwd)/start.sh"

echo "cd $(pwd); ./start.sh > 2>&1" > $(pwd)/boot_script.sh

# Tambahkan entri ke crontab jika belum ada
if ! crontab -l | grep -q "@reboot $SCRIPT_PATH"; then
  (crontab -l 2>/dev/null; echo "@reboot $(pwd)/boot_script.sh 2>&1") | crontab -
  echo "Entri berhasil ditambahkan ke crontab."
else
  echo "Entri sudah ada di crontab. Tidak ada yang perlu ditambahkan."
fi

