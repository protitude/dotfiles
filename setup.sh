#!/bin/bash

if [ ! \(-e "~/.bash_profile" \) ]
then
  echo "linked .bash_profile"
  ln -s $(pwd)/.bash_profile .bash_profile
fi
