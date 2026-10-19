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

# Tampilkan isi arsip tanpa mengekstrak
tar -tzvf "$BACKUP/$ARSIP"

# Tambahkan satu baris ke log (>> agar isi lama tidak tertimpa)
JUMLAH=$(wc -l < "$LIST")
UKURAN=$(du -h "$BACKUP/$ARSIP" | cut -f1)
echo "$(date '+%Y-%m-%d %H:%M:%S') | $ARSIP | $JUMLAH | $UKURAN" >> "$LOG"
# Rotasi: simpan 5 arsip terbaru, hapus yang lebih lama
ls -t "$BACKUP"/backup_${NIM}_*.tar.gz | tail -n +6 | xargs -r rm
