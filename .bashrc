export LANG=ja_JP.UTF-8

# machine specific
linux=false
darwin=false
cygwin=false
case "$(uname)" in
  Linux) linux=true;;
  Darwin) darwin=true;;
  CYGWIN*) cygwin=true;;
esac

# User specific aliases and functions
## Dropbox aliases and functions
alias dbst='dropbox status'
alias dbfs='dropbox filestatus'

dropbox_backup_dotfiles () {
  cp ~/.bashrc ~/.bash_profile ~/.bash_logout ~/.vimrc ~/.gvimrc ~/.screenrc ~/.tmux.conf ~/Dropbox/Program/dotfiles/
  cp -rf ~/vimfiles/dict \
  ~/vimfiles/after \
  ~/vimfiles/scripts \
  ~/vimfiles/colors \
  ~/vimfiles/ftplugin \
  ~/vimfiles/snippets \
  ~/vimfiles/doc \
  ~/vimfiles/syntax \
  ~/Dropbox/Program/dotfiles/vimfiles/
}

## tmux shortcuts
alias tm='tmux'

## screen shortcuts
alias sc='screen'
scx () {
  screen -x $1
}

## set aliases
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias RPE='ruby -pe'
alias RNE='ruby -ne'
alias be='bundle exec'
alias ber='bundle exec rails'
alias gvi='gvim'
if [ -x /usr/bin/vim ]; then
  alias vi='/usr/bin/vim'
fi
alias dateMyFormat='date +"%Y%m%d"'
datevi () {
  if [ ! -e  ~/Dropbox/work/`dateMyFormat`.md ]; then
    echo Daily `dateMyFormat` >> ~/Dropbox/work/`dateMyFormat`.md
  fi
  vi ~/Dropbox/work/`dateMyFormat`.md
}
alias datecp='cat ~/Dropbox/work/`dateMyFormat`.md | pbcopy'

if [ -x /usr/bin/dircolors ]; then
  alias ls='ls -F --color=auto'
  alias ll='ls -la --color=auto'
  alias la='ls -a --color=auto'
  alias l='ls -CF --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
elif $darwin; then
  alias ls='ls -F -G'
  alias ll='ls -la -G'
  alias la='ls -a -G'
  alias l='ls -CF -G'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -F'
  alias ll='ls -la'
  alias la='ls -a'
  alias l='ls -CF'
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

#stty -ixon

# unlimit stacksize for large aray in user mode
#ulimit -s unlimited

# user file-creation mask
umask 022

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# set export
export EDITOR='vi'

# ocamlbrew
# how to install : curl -kL https://raw.github.com/hcarty/ocamlbrew/master/ocamlbrew-install | env OCAMLBREW_FLAGS="-r" bash
# OPAM configuration
if [ -d ${HOME}/ocamlbrew ] ; then
  export PATH=${HOME}/ocamlbrew/ocaml-4.01.0/bin:$PATH
  export OPAMROOT=${HOME}/ocamlbrew/ocaml-4.01.0/.opam
  eval `opam config env`
fi

if [ -d /usr/local/share/npm ] ; then
  export PATH=$PATH:/usr/local/share/npm/bin
  export NODE_PATH=/usr/local/share/npm/lib/node_modules/jsctags/:$NODE_PATH
fi

if $linux; then
  ## TODO for yysaki.com
  export JAVA_HOME='/usr/lib/jvm/java-1.6.0-openjdk/' 
elif $darwin; then
  alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags' # avoid BSD ctags
  export PATH=${PATH}:~/.vim/scripts
  export CC=gcc-4.2 # avoid llvm
  export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 
  export JAVA_HOME='/Library/Java/JavaVirtualMachines/1.6.0_29-b11-402.jdk/Contents/Home'
  PATH=$PATH:${HOME}/.rvm/bin # Add RVM to PATH for scripting
  export RBENV_ROOT=/usr/local/var/rbenv

  if [ -f /Applications/MacVim.app/Contents/MacOS/mvim ]; then
    alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
  fi
elif $cygwin; then
  export PATH=/cygdrive/c/App/vim73-kaoriya-win64:${PATH}
  # open windows explorer
  e() {
    explorer.exe /e, `cygpath -aw $1`
  }
  # apt like
  alias apt-cyg='apt-cyg -u '
fi
