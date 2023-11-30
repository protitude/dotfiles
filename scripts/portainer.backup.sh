#!/bin/bash
set -e

hdiutil attach /Volumes/godzilla/bkup/portainer-volumes.sparsebundle
cd ~/Downloads
rsync -azv --progress --rsync-path="sudo rsync" protitude-pi-worker:/var/lib/docker/volumes/ volumes
7z a volumes.7z volumes
rm -fR /Volumes/portainer-volume/volumes.7z
rm -fR volumes
mv volumes.7z /Volumes/portainer-volumes
hdiutil detach /Volumes/portainer-volumes
tar -czf portainer-volumes.sparsebundle.tgz ~/Documents/portainer-volumes.sparsebundle
#rclone rm cu_onedrive_crypt:bkup/portainer-volumes.sparsebundle.tgz
#rclone copy portainer-volumes.sparsebundle.tgz cu_onedrive_crypt:bkup
rclone rm dropbox_crypt:portainer/portainer-volumes.sparsebundle.tgz
rclone copy portainer-volumes.sparsebundle.tgz dropbox_crypt:portainer/
rm portainer-volumes.sparsebundle.tgz
