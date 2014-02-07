# .zprofile

# User specific environment and startup programs

# rbenv
if [ -f /usr/local/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if ! [ -d ~/.vim/bundle/neobundle.vim ]; then
  echo "echo) get neobundle"
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

