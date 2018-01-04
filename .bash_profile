# .bash_profile

case "$(uname)" in
  MINGW32*) mingw=true;; # work
  MINGW64*) mingw=true;; # work
esac

# User specific environment and startup programs

# addpath $HOME/bin
BASH_ENV=$HOME/.bashrc
USERNAME=""

export USERNAME BASH_ENV PATH LESSOPEN

# rbenv
if [ -f /usr/local/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# update bash settings from Dropbox
#DIR=$HOME/Dropbox/Program/unix
#cp $DIR/.bashrc $DIR/.bash_profile $DIR/.bash_logout ./
#cp $DIR/../vim/.vimrc $DIR/../vim/.gvimrc ./
#cp -rf $DIR/../vim/.vim/colors ./.vim/
if $mingw; then
  if ! [ -d ~/vimfiles/dein/repos/github.com/Shougo/dein.vim ]; then
    echo "echo) get dein"
    git clone https://github.com/Shougo/dein.vim.git ~/vimfiles/dein/repos/github.com/Shougo/dein.vim
  fi
else
  if ! [ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ]; then
    echo "echo) get dein"
    git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
  fi
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
