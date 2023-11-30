#!/bin/bash

ssh protitude-pi-worker "rm -fR $ZEDEXT"
rsync -azv --progress $ZEDINT protitude-pi-worker:$ZEDEXT
mv $INTEXT /tmp/
cp $ZEDINT $INTEXT
