#!/bin/bash

if [ ! -d bundle ]
then
  mkdir .vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
  npm -g install instant-markdown-d
fi

if [ ! -L $1.bash_profile ]
then
  ln -s $(pwd)"/.bash_profile" "$1.bash_profile"
  echo "linked .bash_profile"
fi

if [ ! -L $1.gitconfig ]
then
  ln -s $(pwd)"/.gitconfig" "$1.gitconfig"
  echo "linked .gitconfig"
fi

if [ ! -L $1.gitignore ]
then
  ln -s $(pwd)"/gitignore" "$1.gitignore"
  echo "linked .gitignore"
fi

if [ ! -L $1.bash_ps1 ]
then
  ln -s $(pwd)"/.bash_ps1" "$1.bash_ps1"
  echo "linked .bash_ps1"
fi

if [ ! -L $1.vim ]
then
  ln -s $(pwd)"/.vim" "$1.vim"
  echo "linked .vim"
fi

if [ ! -L $1.vimrc ]
then
  ln -s $(pwd)"/.vimrc" "$1.vimrc"
  echo "linked .vimrc"
fi

if [ ! -L $1.osx ]
then
  ln -s $(pwd)"/.osx" "$1.osx"
  echo "linked .osx"
fi
if [ ! -e $1.goto_shortcuts ]
then
  touch $1.goto_shortcuts
  echo "Created .goto_shortcuts"
fi

if [ ! -L $1.tmux.conf ]
then
  ln -s $(pwd)"/.tmux.conf" "$1.tmux.conf"
  echo "linked .tmux.conf"
fi

if [ ! -L $1.tmux.theme.sh ]
then
  ln -s $(pwd)"/.tmux.theme.sh" "$1.tmux.theme.sh"
  echo "linked .tmux.theme.sh"
fi

if [ ! -L $1.tmux-git ]
then
  ln -s $(pwd)"/.tmux-git" "$1.tmux-git"
  echo "linked .tmux-git"
fi

if [ ! -L $1.vim/bundle/vim-multiple-cursors ]
then
  vim +PluginInstall +qall
fi

