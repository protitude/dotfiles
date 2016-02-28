#!/bin/bash

if [ ! -L ~/.bash_profile ]
then
  ln -s $(pwd)"/.bash_profile" ~/.bash_profile
  echo "linked .bash_profile"
fi

if [ ! -L ~/.bash_ps1 ]
then
  ln -s $(pwd)"/.bash_ps1" ~/.bash_ps1
  echo "linked .bash_ps1"
fi

if [ ! -L ~/.vim ]
then
  ln -s $(pwd)"/.vim" ~/.vim
  echo "linked .vim"
fi

if [ ! -L ~/.vimrc ]
then
  ln -s $(pwd)"/.vimrc" ~/.vimrc
  echo "linked .vimrc"
fi

if [ ! -L ~/.osx ]
then
  ln -s $(pwd)"/.osx" ~/.osx
  echo "linked .osx"
fi
