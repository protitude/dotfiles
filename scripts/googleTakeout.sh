#!/bin/bash -x

# Ask which Gmail account (default: miles.france)
read -p "Which Gmail account is this for? (miles.france/fi) [miles.france]: " account
account=${account:-miles.france}

if [ "$account" = "fi" ]; then
    godzilla="/Volumes/godzilla/bkup/google-takeout/takeout-takeout-protitude.fi"
    shaq="/mnt/shaq/bkup/google-takeout/takeout-takeout-protitude.fi"
    catzilla="/mnt/wd-catzilla/bkup/google-takeout/takeout-takeout-protitude.fi"
else
    godzilla="/Volumes/godzilla/bkup/google-takeout/takeout-miles.france"
    shaq="/mnt/shaq/bkup/google-takeout/takeout-miles.france"
    catzilla="/mnt/wd-catzilla/bkup/google-takeout/takeout-miles.france"
fi

downloads="/Users/france/Downloads"

#remove old takeouts
rm -rf $godzilla/*
ssh protitude-cloak "rm -rf $shaq/*"
ssh mainebackups "rm -rf $catzilla/*"

#copy new takeouts
mv $downloads/takeout-* $godzilla

rsync -avz $godzilla/ protitude-cloak:$shaq

rsync -avz $godzilla/ mainebackups:$catzilla
