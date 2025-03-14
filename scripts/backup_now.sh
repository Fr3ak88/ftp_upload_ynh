#!/bin/bash

# YunoHost-Helfer laden
source /usr/share/yunohost/helpers

# FTP-Daten abrufen
ftp_server=$(ynh_app_setting_get --app=$app --key=ftp_server)
ftp_user=$(ynh_app_setting_get --app=$app --key=ftp_user)
ftp_password=$(ynh_app_setting_get --app=$app --key=ftp_password)
ftp_path=$(ynh_app_setting_get --app=$app --key=ftp_path)

# Backup erstellen und auf FTP-Server hochladen
ynh_print_info "Starting backup and FTP upload..."

# Hier Ihren Backup- und Upload-Code einfügen
# Beispiel:
# yunohost backup create
# ftp -inv $ftp_server << EOF
# user $ftp_user $ftp_password
# cd $ftp_path
# put /path/to/backup/file
# quit
# EOF

ynh_print_info "Backup and FTP upload completed."
