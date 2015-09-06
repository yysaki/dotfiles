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
  MINGW64*) mingw=true;;
esac

cd `dirname $0`

DOT_FILES="
.bash_profile
.bashrc
.gitconfig
.gitignore
.gvimrc
.minttyrc
.screenrc
.tmux.conf
.vimrc
.vsvimrc
.zprofile
.zshrc
"
VIMFILES=".vim"

link_dot_file () {
  if [ ! -L ~/$2 ]; then
    echo "Make Symlink ~/$2"
    if [ -f ~/$2 -o -d ~/$2 ]; then
      mv ~/$2 ~/$2.bak
    fi 
    if $mingw; then
      cp -rf $PWD/$1 ~/$2
    else
      ln -s $PWD/$1 ~/$2
    fi
  fi
}

unlink_dot_file () {
  echo "Remove Symlink ~/$1"
  rm ~/$1
}

link_impl () {
  if $mingw; then
    $1 $VIMFILES vimfiles
    # TODO .vimrcを設定して.vimのlnを外す
    $1 $VIMFILES .vim
  else
    $1 $VIMFILES .vim
  fi
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
    cp ~/$DOT_FILE $PWD/$DOT_FILE
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
