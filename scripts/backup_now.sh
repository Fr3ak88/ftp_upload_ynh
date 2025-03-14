#!/bin/bash

# YunoHost-Helfer laden
source /usr/share/yunohost/helpers

# FTP-Daten abrufen
ftp_server=$(ynh_app_setting_get --app=$app --key=ftp_server)
ftp_user=$(ynh_app_setting_get --app=$app --key=ftp_user)
ftp_password=$(ynh_app_setting_get --app=$app --key=ftp_password)
ftp_path=$(ynh_app_setting_get --app=$app --key=ftp_path)

# Backup erstellen
ynh_print_info "Erstelle YunoHost backup..."
backup_file="yunohost_backup_$(date +%Y%m%d_%H%M%S).tar.gz"
yunohost backup create --output-directory /home/yunohost.backup/archives/ --name $backup_file

# Backup auf FTP-Server hochladen
ynh_print_info "Lade das Backup auf den FTP Server..."
ftp -inv $ftp_server << EOF
user $ftp_user $ftp_password
cd $ftp_path
put /home/yunohost.backup/archives/$backup_file
quit
EOF

# Aufräumen
rm /home/yunohost.backup/archives/$backup_file

ynh_print_info "Backup and FTP upload abgeschlossen."
