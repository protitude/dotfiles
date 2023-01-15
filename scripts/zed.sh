#!/bin/bash

ssh chromebox "rm -fR $ZEDEXT"
rsync -azv --progress $ZEDINT chromebox:$ZEDEXT
