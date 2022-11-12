#!/bin/bash

osascript -e 'display notification "Basement Motion Backup Started" with title "Basement Motion Backup"'
last_month=$(date -v1d -v-1d +%m)
last_month_year=$(date -v1d -v-1d +%Y)

mkdir -p ~/Downloads/basement/$last_month_year/$last_month
cd ~/Downloads/basement/$last_month_year/$last_month

rclone copy -P dropbox_crypt:home-rpi/motionvids/basement/$last_month_year/$last_month ./

FL=''
for d in */ ; do
  cd $d
  FILES="*"
  for f in $FILES ; do
    #echo "Processing $f file..."
    # take action on each file. $f store current file name
    if [ ${#FL} -lt 1400 ]
    then
      FL="$FL $f"
    else
      squoosh-cli --avif '{speed: 5}' $FL
      FL=''
    fi
  done
  if [ ${#FL} -gt 1 ]
  then
    squoosh-cli --avif '{speed: 5}' $FL
  fi
  cd ..
done

rm -f */*.jpg
7z a -p$CAMERAPASS $last_month.7z *

ssh chromebox "mkdir /home/protitude/godzilla/Motion-vids-backup/basement/$last_month_year"
rsync -azv $last_month.7z chromebox:/home/protitude/godzilla/Motion-vids-backup/basement/$last_month_year/
cd ~/Downloads/
rm -fR ~/Downloads/basement
rclone purge dropbox_crypt:home-rpi/motionvids/basement/$last_month_year/$last_month
afplay /System/Library/Sounds/Ping.aiff -v 2
osascript -e 'display notification "Basement Motion Backup completed" with title "Basement Motion Backup"'
pushover 'Basement backup completed'
