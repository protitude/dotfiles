#!/bin/bash

if [ ! -d bundle ]
then
  mkdir .vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
  npm -g install instant-markdown-d
fi

if [ ! -L ~/.bash_profile ]
then
  ln -s $(pwd)"/.bash_profile" "$1.bash_profile"
  echo "linked .bash_profile"
fi

if [ ! -L ~/.bash_ps1 ]
then
  ln -s $(pwd)"/.bash_ps1" "$1.bash_ps1"
  echo "linked .bash_ps1"
fi

if [ ! -L ~/.vim ]
then
  ln -s $(pwd)"/.vim" "$1.vim"
  echo "linked .vim"
fi

if [ ! -L ~/.vimrc ]
then
  ln -s $(pwd)"/.vimrc" "$1.vimrc"
  echo "linked .vimrc"
fi

if [ ! -L ~/.osx ]
then
  ln -s $(pwd)"/.osx" "$1.osx"
  echo "linked .osx"
fi
if [ ! -L ~/.goto_shortcuts ]
then
  touch ~/.goto_shortcuts
  echo "Created .goto_shortcuts"
fi
if [ ! -L ~/.vim/bundle/vim-multiple-cursors ]
then
  vim +PluginInstall +qall
fi

