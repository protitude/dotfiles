#!/bin/bash

osascript -e 'display notification "Basement Motion Backup Started" with title "Basement Motion Backup"'
last_month=$(date -v1d -v-1d +%m)
last_month_year=$(date -v1d -v-1d +%Y)

cd /Volumes/godzilla/motion-vids/basement/
mkdir -p $last_month_year/$last_month
cd $last_month_year/$last_month

rclone copy -P dropbox_crypt:home-rpi/motionvids/basement/$last_month_year/$last_month ./

cd ..
7z a -p$CAMERAPASS $last_month.7z $last_month

ssh protitude-pi-worker "mkdir /mnt/shaq/bkup/motion-vids/basement/$last_month_year"
rsync -azv $last_month.7z protitude-pi-worker:/mnt/shaq/bkup/motion-vids/basement/$last_month_year/
rsync -azv $last_month.7z mainebackups:/mnt/wd-catzilla/bkup/motion-vids/$last_month_year/
rclone purge dropbox_crypt:home-rpi/motionvids/basement/$last_month_year/$last_month
rm -fR $last_month
afplay /System/Library/Sounds/Ping.aiff -v 2
osascript -e 'display notification "Basement Motion Backup completed" with title "Basement Motion Backup"'
