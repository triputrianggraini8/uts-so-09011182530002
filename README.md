# Tugas Besar UTS Sistem Operasi

## Identitas
- Nama  : Tri Putri Anggraini
- NIM   : 09011182530002
- Kelas : SKU3B

## Deskripsi
Proyek ini membuat backup otomatis untuk file catatan praktikum.

`backup.sh` mencari semua file `.txt` di `~/data_09011182530002`, termasuk
yang ada di subfolder, lalu membungkusnya jadi satu arsip
`backup_09011182530002_TANGGAL_JAM.tar.gz` di `~/backup_09011182530002`.
Setelah arsip jadi, isinya ditampilkan untuk dicek, dan satu baris catatan
(waktu, nama arsip, jumlah file, ukuran) ditambahkan ke `backup.log`.

`backup_loop.sh` memanggil `backup.sh` terus-menerus dengan jeda `INTERVAL`
detik (bawaannya 60), jadi backup jalan sendiri di background.

`alias.sh` berisi alias `bk002` supaya backup cukup dijalankan dengan
mengetik `bk002`.

## Cara menjalankan
Pastikan folder `~/data_09011182530002` sudah ada dan berisi file `.txt`.

Backup satu kali:
```
./script/backup.sh
```
Backup berulang di background (hentikan dengan `kill`):
```
./script/backup_loop.sh &
```
Alias (alias juga sudah ditulis di `~/.bashrc`):
```
source script/alias.sh
bk002
```

## Fitur pengembangan
Fitur yang saya pilih adalah rotasi arsip: setiap backup selesai, hanya 5
arsip terbaru yang disimpan, sisanya yang lebih lama dihapus.

Cara mencobanya, jalankan backup beberapa kali lalu hitung arsipnya:
```
for i in 1 2 3 4 5 6 7; do ./script/backup.sh > /dev/null; sleep 1; done
ls ~/backup_09011182530002/*.tar.gz
```
Setelah 7 kali backup, file `.tar.gz` yang tersisa tetap 5.

## Bukti job control
```
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ ./backup_loop.sh &
[1] 3627
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ ./sub2/c.txt
./sub2/d.txt
./catatan6.txt
./catatan2.txt
./catatan10.txt
./catatan1.txt
./catatan8.txt
./catatan7.txt
./catatan5.txt
./catatan9.txt
./catatan3.txt
./sub1/a.txt
./sub1/b.txt
./catatan4.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./sub2/c.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./sub2/d.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan6.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan2.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan10.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan1.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan8.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan7.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan5.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan9.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan3.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./sub1/a.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./sub1/b.txt
-rw-rw-r-- triputri/triputri 0 2026-10-19 08:05 ./catatan4.txt
jobs -l
[1]+  3627 Running                 ./backup_loop.sh &
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ fg
./backup_loop.sh
^Z
[1]+  Stopped                 ./backup_loop.sh
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ bg
[1]+ ./backup_loop.sh &
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ ps x
    PID TTY      STAT   TIME COMMAND
   1272 ?        Ss     0:00 /lib/systemd/systemd --user
   1273 ?        S      0:00 (sd-pam)
   1279 ?        S<sl   0:00 /usr/bin/pipewire
   1280 ?        Ssl    0:00 /usr/bin/pipewire-media-session
   1281 ?        S<sl   0:01 /usr/bin/pulseaudio --daemonize=no --log-target=journal
   1282 ?        Ssl    0:00 /snap/snapd-desktop-integration/391/usr/bin/user-session-helper /snap/snapd-desktop-integration/391/usr
   1289 ?        Sl     0:00 /usr/bin/gnome-keyring-daemon --daemonize --login
   1293 tty2     Ssl+   0:00 /usr/libexec/gdm-wayland-session env GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --session=u
   1295 ?        Ss     0:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-on
   1297 tty2     Sl+    0:00 /usr/libexec/gnome-session-binary --session=ubuntu
   1339 ?        Ssl    0:00 /usr/libexec/xdg-document-portal
   1342 ?        Ssl    0:00 /usr/libexec/xdg-permission-store
   1376 ?        Ssl    0:00 /usr/libexec/gnome-session-ctl --monitor
   1386 ?        Ssl    0:00 /usr/libexec/gvfsd
   1395 ?        Sl     0:00 /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -f
   1397 ?        Ssl    0:00 /usr/libexec/gnome-session-binary --systemd-service --session=ubuntu
   1420 ?        Sl     0:00 /usr/libexec/at-spi-bus-launcher --launch-immediately
   1422 ?        Ssl    1:01 /usr/bin/gnome-shell
   1434 ?        S      0:00 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-addr
   1479 ?        Sl     0:00 /usr/libexec/gnome-shell-calendar-server
   1486 ?        Ssl    0:00 /usr/libexec/evolution-source-registry
   1492 ?        Sl     0:00 /usr/libexec/goa-daemon
   1493 ?        Ssl    0:00 /usr/libexec/dconf-service
   1496 ?        Ssl    0:00 /usr/libexec/gvfs-udisks2-volume-monitor
   1499 ?        Ssl    0:00 /usr/libexec/evolution-calendar-factory
   1506 ?        Ssl    0:00 /usr/libexec/gvfs-mtp-volume-monitor
   1510 ?        Ssl    0:00 /usr/libexec/gvfs-gphoto2-volume-monitor
   1520 ?        Sl     0:00 /usr/libexec/goa-identity-service
   1524 ?        Ssl    0:00 /usr/libexec/gvfs-goa-volume-monitor
1532 ?        Ssl    0:00 /usr/libexec/evolution-addressbook-factory
   1538 ?        Ssl    0:00 /usr/libexec/gvfs-afc-volume-monitor
   1558 ?        Sl     0:00 /usr/libexec/gvfsd-trash --spawner :1.14 /org/gtk/gvfs/exec_spaw/0
   1565 ?        Sl     0:00 /usr/libexec/at-spi2-registryd --use-gnome-session
   1566 ?        Sl     0:00 /usr/bin/gjs /usr/share/gnome-shell/org.gnome.Shell.Notifications
   1578 ?        Ss     0:00 sh -c /usr/bin/ibus-daemon --panel disable $([ "$XDG_SESSION_TYPE" = "x11" ] && echo "--xim")
   1580 ?        Ssl    0:00 /usr/libexec/gsd-a11y-settings
   1581 ?        Sl     0:01 /usr/bin/ibus-daemon --panel disable
   1583 ?        Ssl    0:00 /usr/libexec/gsd-color
   1587 ?        Ssl    0:00 /usr/libexec/gsd-datetime
   1588 ?        Ssl    0:00 /usr/libexec/gsd-housekeeping
   1592 ?        Ssl    0:00 /usr/libexec/gsd-keyboard
   1603 ?        Ssl    0:00 /usr/libexec/gsd-media-keys
   1604 ?        Ssl    0:00 /usr/libexec/gsd-power
   1605 ?        Ssl    0:00 /usr/libexec/gsd-print-notifications
   1606 ?        Ssl    0:00 /usr/libexec/gsd-rfkill
   1612 ?        Ssl    0:00 /usr/libexec/gsd-screensaver-proxy
   1613 ?        Ssl    0:00 /usr/libexec/gsd-sharing
   1615 ?        Ssl    0:00 /usr/libexec/gsd-smartcard
   1616 ?        Ssl    0:00 /usr/libexec/gsd-sound
   1633 ?        Ssl    0:00 /usr/libexec/gsd-wacom
   1656 ?        Sl     0:00 /usr/libexec/ibus-memconf
   1659 ?        Sl     0:01 /usr/libexec/ibus-extension-gtk3
   1661 ?        Sl     0:00 /usr/libexec/gsd-disk-utility-notify
   1664 ?        Sl     0:00 /usr/libexec/ibus-portal
   1667 ?        Sl     0:00 /usr/libexec/evolution-data-server/evolution-alarm-notify
   1725 ?        Sl     0:00 /usr/libexec/gsd-printer
   1740 ?        Sl     0:00 /usr/libexec/ibus-engine-simple
   1758 ?        Sl     0:05 /snap/snap-store/1113/usr/bin/snap-store --gapplication-service
   1766 ?        Ssl    0:00 /usr/libexec/xdg-desktop-portal
   1770 ?        Ssl    0:00 /usr/libexec/xdg-desktop-portal-gnome
   1805 ?        SNsl   0:00 /usr/libexec/tracker-miner-fs-3
   1830 ?        S      0:00 /usr/bin/Xwayland :0 -rootless -noreset -accessx -core -auth /run/user/1000/.mutter-Xwaylandauth.B8ZRX3
   1837 ?        Sl     0:00 /usr/bin/gjs /usr/share/gnome-shell/org.gnome.ScreenSaver
   1860 ?        Sl     0:00 gjs /usr/share/gnome-shell/extensions/ding@rastersoft.com/ding.js -E -P /usr/share/gnome-shell/extensio
   1861 ?        Ssl    0:00 /usr/libexec/xdg-desktop-portal-gtk
   1883 ?        Ssl    0:00 /usr/libexec/gsd-xsettings
   1914 ?        Sl     0:00 /snap/snapd-desktop-integration/391/usr/bin/snapd-desktop-integration
   1934 ?        Sl     0:00 /usr/libexec/ibus-x11
1970 ?        Ssl    0:00 /usr/libexec/gvfsd-metadata
   2071 ?        Rsl    0:10 /usr/libexec/gnome-terminal-server
   2089 pts/0    Ss     0:00 bash
   3094 ?        Ssl    0:00 /usr/libexec/glib-pacrunner
   3099 ?        Sl     0:00 update-notifier
   3137 ?        S      0:00 VBoxClient --clipboard
   3138 ?        Sl     0:00 VBoxClient --clipboard
   3627 pts/0    S      0:00 /bin/bash ./backup_loop.sh
   3648 pts/0    S      0:00 sleep 60
   3650 pts/0    R+     0:00 ps x
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ kill %1
triputri@triputri-VirtualBox:~/uts-so-09011182530002/script$ jobs -l
[1]+  3627 Terminated              ./backup_loop.sh
```

## Kendala
- Waktu `git clone`, muncul `Could not resolve host: github.com`. Internet di
  VM sebenarnya ada (ping ke 8.8.8.8 berhasil), tapi DNS-nya bermasalah. Saya
  ganti DNS ke 8.8.8.8 lalu clone ulang, dan berhasil.
