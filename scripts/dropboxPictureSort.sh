#!/bin/bash

# Installed as crontab to run monthly
# 00 17 1 * *
# Open Dropbox
open -a "Dropbox"
# Wait 10 minutes to open and sync

sleep 600

months=(
"12-December"
"01-January"
"02-February"
"03-March"
"04-April"
"05-May"
"06-June"
"07-July"
"08-August"
"09-September"
"10-October"
"11-November"
)
month=$(date +%m)
year=$(date +%Y)
echo $month
if [ $month == 01 ]; then
  year=$((10#$year-1))
fi
lastMonth="$((10#$month-1))"
folder=${months[$lastMonth]}
echo $folder
cd "/Users/france/Library/CloudStorage/Dropbox/Camera Uploads"
# Create folder of the month
mkdir -p "$year/$folder"
# Move files into folder
mv *.jpg "$year/$folder"
mv *.jpeg "$year/$folder"
mv *.png "$year/$folder"
mv *.mp4 "$year/$folder"
mv *.mpeg "$year/$folder"
rsync -azv "$year/$folder" protitude-pi-worker:/mnt/shaq/picts/CellPhotos/$year
cp -R "$year/$folder" /Volumes/godzilla/picts/CellPhotos/$year
