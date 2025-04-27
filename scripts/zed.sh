#!/bin/bash

echo 'Main sync'
ssh mainebackups "rm -fR $ZEDEXTMAIN"
rsync -azv --progress $ZEDINT mainebackups:$ZEDEXTMAIN

echo 'Brain sync'
ssh protitude-pi-worker "rm -fR $ZEDEXTBRAIN"
rsync -azv --progress $ZEDINT protitude-pi-worker:$ZEDEXTBRAIN

echo 'Internal external sync'
mv $INTEXT /tmp/
cp $ZEDINT $INTEXT
