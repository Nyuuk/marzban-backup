#!/bin/sh
. ./.env

BACKUP_DIR="$HOME/backup-to-github"
# Cek apakah direktori backup ada atau tidak
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Direktori backup tidak ditemukan: $BACKUP_DIR"
  mkdir $BACKUP_DIR
fi

# Pindah ke direktori backup
cd "$BACKUP_DIR"

# Inisialisasi Git repository jika belum ada
if [ ! -d ".git" ]; then
  git init
  git remote add origin "https://$USERNAME:$TOKEN@github.com/$USERNAME/$REPO.git"
fi

# membaca Marzban directory dan mencopy ke directory
if [ -d $MARZBAN_DIR ]; then
       cp -r $MARZBAN_DIR/* .
else
        echo Directory $MARZBAN_DIR tidak di temukan; exit
fi
# Tambahkan semua file ke staging area
git add .

# Commit dengan pesan timestamp
git commit -m "Backup pada $(date +'%Y-%m-%d %H:%M:%S')"

# Push ke remote repository
git push origin master

echo "Backup berhasil dilakukan ke GitHub."

