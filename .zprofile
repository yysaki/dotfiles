# .zprofile

# User specific environment and startup programs

# rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if ! [ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ]; then
  echo "echo) get dein"
  git clone https://github.com/Shougo/dein.vim.git ~/.vim/dein/repos/github.com/Shougo/dein.vim
fi

if [ /usr/bin/gcc ]; then
  export CC=/usr/bin/gcc
fi

if [ -d $HOME/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi
