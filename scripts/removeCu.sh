#!/bin/bash

/usr/bin/logger "Remove CU is running"
FILE="/Users/france/Desktop/Self Service.app"
WBLOC="/Users/france/Desktop/Get Desktop Support.webloc"
REDFOLDER="/Users/france/Desktop/CU Red Folder.webloc"
if [ -d "$FILE" ]; then
  /bin/rm -fR /Users/france/Desktop/Self\ Service.app
fi

if [ -d "$WBLOC" ]; then
  /bin/rm -fR /Users/france/Desktop/Get\ Desktop\ Support.webloc
fi

if [ -d "$REDFOLDER" ]; then
  /bin/rm -fR /Users/france/Desktop/CU\ Red\ Folder.webloc
fi
