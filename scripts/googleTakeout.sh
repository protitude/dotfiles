#!/bin/bash -x

godzilla="/Volumes/godzilla/bkup/google-takeout"
downloads="/Users/france/Downloads"
shaq="/mnt/shaq/bkup/google-takeout"
catzilla="/mnt/wd-catzilla/bkup/google-takeout"

#remove old takeouts
rm -rf $godzilla/*
ssh protitude-pi-worker "rm -rf $shaq/*"
ssh protitude-pi-worker "rm -rf $catzilla/*"

#copy new takeouts
mv $downloads/takeout-* $godzilla

rsync -avz $godzilla/ protitude-pi-worker:$shaq

rsync -avz $godzilla/ mainebackups:$catzilla
