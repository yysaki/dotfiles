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
