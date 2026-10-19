#!/bin/bash
# Nama  : Tri Putri Anggraini
# NIM   : 09011182530002
# Kelas : SKU3B

# Jeda antar backup (detik)
INTERVAL=60

# Lokasi backup.sh, satu folder dengan file ini
FOLDER="$(dirname "$0")"

# Jalankan backup berulang sampai proses dihentikan dengan kill
while true; do
    "$FOLDER/backup.sh"
    sleep "$INTERVAL"
done
