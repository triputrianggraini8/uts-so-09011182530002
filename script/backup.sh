#!/bin/bash
# Nama  : Tri Putri Anggraini
# NIM   : 09011182530002
# Kelas : SKU3B

# Variabel lokasi dan nama file
NIM="09011182530002"
DATA="$HOME/data_$NIM"
BACKUP="$HOME/backup_$NIM"
LOG="$BACKUP/backup.log"
LIST="$BACKUP/daftar.txt"

# Buat direktori backup jika belum ada
mkdir -p "$BACKUP"

# Cari semua file .txt di direktori data, simpan daftarnya
cd "$DATA" || exit 1
find . -type f -name "*.txt" > "$LIST"

# Buat arsip dengan nama berisi NIM, tanggal, dan jam
WAKTU=$(date +%Y%m%d_%H%M%S)
ARSIP="backup_${NIM}_${WAKTU}.tar.gz"
tar -czvf "$BACKUP/$ARSIP" -T "$LIST"
