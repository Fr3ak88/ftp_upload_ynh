#!/bin/bash

# YunoHost-Helfer laden
source /usr/share/yunohost/helpers

# FTP-Daten abrufen
ftp_server=$(ynh_app_setting_get --app=$app --key=ftp_server)
ftp_user=$(ynh_app_setting_get --app=$app --key=ftp_user)
ftp_password=$(ynh_app_setting_get --app=$app --key=ftp_password)
ftp_path=$(ynh_app_setting_get --app=$app --key=ftp_path)

# Lokales Backup-Verzeichnis
local_backup_dir="/home/yunohost.backup/"
mkdir -p "$local_backup_dir"  # Sicherstellen, dass das Verzeichnis existiert

# Backup erstellen
backup_file="$local_backup_dir$(date +%Y%m%d_%H%M%S)_yunohost_backup.tar.gz"
ynh_print_info "Erstelle Backup unter $backup_file..."
yunohost backup create --output-directory "$local_backup_dir" --name "$(basename $backup_file .tar.gz)"

# Prüfen, ob das Backup erfolgreich war
if [ ! -f "$backup_file" ]; then
    ynh_die "Backup konnte nicht erstellt werden!"
fi

# Backup auf FTP-Server hochladen
ynh_print_info "Lade Backup auf FTP-Server hoch..."
ftp -inv "$ftp_server" <<EOF
user $ftp_user $ftp_password
cd $ftp_path
put $backup_file
quit
EOF

# Prüfen, ob der Upload erfolgreich war
if [ $? -eq 0 ]; then
    ynh_print_info "Backup erfolgreich auf FTP-Server hochgeladen."
else
    ynh_die "Fehler beim Hochladen des Backups auf den FTP-Server!"
fi

ynh_print_info "Backup abgeschlossen."
