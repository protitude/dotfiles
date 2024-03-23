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
tar -czf portainer-volumes.sparsebundle.tgz /Volumes/godzilla/bkup/portainer-volumes.sparsebundle
ssh protitude-pi-worker "rm -fR /mnt/shaq/bkup/portainer-volumes.sparsebundle.tgz"
rsync -azv --progress portainer-volumes.sparsebundle.tgz protitude-pi-worker:/mnt/shaq/bkup/
rm portainer-volumes.sparsebundle.tgz
