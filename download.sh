#!/bin/sh

CURDIR=`dirname $0`

if [ -d tmp ]; then
  mkdir tmp
fi 

echo "download japanese vimhelp..."
cd $CURDIR/tmp
wget https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz
tar zxvf master.tar.gz
cp -rf vimdoc-ja-master/{doc,syntax} ../.vim/

echo "delete tmp files..."
cd ..
rm -rf $CURDIR/tmp

echo "to install japanese vimhelps, command :helptags ~/dotfiles/.vim/doc/"

