# .bash_profile

# User specific environment and startup programs

# addpath $HOME/bin
BASH_ENV=$HOME/.bashrc
USERNAME=""

export USERNAME BASH_ENV PATH LESSOPEN

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# update bash settings from Dropbox
#DIR=$HOME/Dropbox/Program/unix
#cp $DIR/.bashrc $DIR/.bash_profile $DIR/.bash_logout ./
#cp $DIR/../vim/.vimrc $DIR/../vim/.gvimrc ./
#cp -rf $DIR/../vim/.vim/colors ./.vim/
if ! [ -d ~/.vim/bundle/neobundle.vim ]; then
  echo "echo) get neobundle"
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

eval "$(rbenv init -)"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
