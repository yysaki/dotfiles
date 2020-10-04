# .zprofile

# User specific environment and startup programs

# rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if [ /usr/bin/gcc ]; then
  export CC=/usr/bin/gcc
fi

if [ -d $HOME/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

if [ -d $HOME/.npm-global ]; then
  export PATH=$HOME/.npm-global/bin:$PATH
fi
