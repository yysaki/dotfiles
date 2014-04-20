#!/bin/sh

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

link () {
  git pull origin master

  link_dot_file $VIMFILES .vim
  link_dot_file $VIMFILES vimfiles
  for DOT_FILE in $DOT_FILES; do
    link_dot_file $DOT_FILE $DOT_FILE
  done
}

unlink () {
  unlink_dot_file .vim
  unlink_dot_file vimfiles
  for DOT_FILE in $DOT_FILES; do
    unlink_dot_file $DOT_FILE
  done
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
    link
esac
