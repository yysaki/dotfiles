#!/bin/sh

CURDIR=`dirname $0`

if [ ! -d tmp ]; then
  mkdir tmp
fi 

cd $CURDIR/tmp

echo "[echo] download and install zenburn colorscheme..."
wget http://slinky.imukuppi.org/zenburn/zenburn.vim
if [ ! -d ../.vim/colors ]; then
  mkdir ../.vim/colors
fi
cp zenburn.vim ../.vim/colors/

echo "[echo] download japanese vimhelp..."
wget https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz -O master.tar.gz
tar zxvf master.tar.gz
cp -rf vimdoc-ja-master/{doc,syntax} ../.vim/

echo "[echo] delete tmp files..."
cd ..
rm -rf $CURDIR/tmp

echo "[echo] to install japanese vimhelps, command :helptags ~/dotfiles/.vim/doc/"

