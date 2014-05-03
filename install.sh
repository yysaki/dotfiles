#!/bin/bash

# machine specific
linux=false
darwin=false
cygwin=false
mingw=false
case "$(uname)" in
  Linux) linux=true;;
  Darwin) darwin=true;;
  CYGWIN*) cygwin=true;;
  MINGW32*) mingw=true;; # work
esac

cd `dirname $0`

DOT_FILES=".bash_profile .bashrc .zprofile .zshrc .gvimrc .screenrc .tmux.conf .vimrc .minttyrc .gitignore .gitconfig"
VIMFILES=".vim"

link_dot_file () {
  if [ ! -L $HOME/$2 ]; then
    echo "Make Symlink $HOME/$2"
    if [ -f $HOME/$2 -o -d $HOME/$2 ]; then
      mv $HOME/$2 $HOME/$2.bak
    fi 
    ln -s $PWD/$1 $HOME/$2
  fi
}

unlink_dot_file () {
  echo "Remove Symlink $HOME/$1"
  rm $HOME/$1
}

link_impl () {
  $1 $VIMFILES .vim
  $1 $VIMFILES vimfiles
  for DOT_FILE in $DOT_FILES; do
    $1 $DOT_FILE $DOT_FILE
  done
}
  

link () {
  link_impl link_dot_file
}

unlink () {
  link_impl unlink_dot_file
}

# git bash用, 修正した変更を集める
gather () {
  for DOT_FILE in $DOT_FILES; do
    cp ~/$DOT_FILE ./$DOT_FILE
  done
}

case "$1" in
  link)
    link
    ;;
  unlink)
    unlink
    ;;
  gather)
    gather
    ;;
  *)
    echo "Usage: sh install.sh {link|unlink|gather}" 
esac
