#!/bin/bash

# YunoHost-Helfer laden
source /usr/share/yunohost/helpers

# Lokales Backup-Verzeichnis
local_backup_dir="/home/yunohost.backup/"

# Lösche Backups, die älter als 1 Tag sind
find "$local_backup_dir" -name "*_yunohost_backup.tar.gz" -type f -mtime +1 -delete

ynh_print_info "Alte Backups wurden gelöscht."
