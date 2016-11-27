export LANG=ja_JP.UTF-8

# machine specific
linux=false
darwin=false
cygwin=false
case "$(uname)" in
  Linux) linux=true;;
  Darwin) darwin=true;;
  CYGWIN*) cygwin=true;;
  MINGW32*) mingw=true;; # work
  MINGW64*) mingw=true;; # work
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

## set aliases
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

alias b='bundle'
alias bc='bundle exec compass'
alias be='bundle exec'
alias beg='bundle exec guard'
alias bn='bundle exec nanoc'
alias br='bundle exec rails'
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias f='find'
alias g='git'
alias gr='grep'
alias gvi='gvim'
alias h='head'
alias p='peco'
alias pg='cd $(ghq root)/$(ghq list | peco)'
alias sc='screen'
alias t='tail'
alias tm='tmux'
alias v='vim'
alias vi='vim'
alias x='xargs'

## screen shortcuts
scx () {
  screen -x $1
}

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
export HISTSIZE=100000

# texlive
if [ -d /usr/local/texlive/2013 ] ; then
  export MANPATH=/usr/local/texlive/2013/texmf-dist/doc/
  export INFOPATH=/usr/local/texlive/2013/texmf-dist/doc/info
  export PATH=/usr/local/texlive/2013/bin/x86_64-linux:$PATH
fi

# ocamlbrew
# how to install : curl -kL https://raw.github.com/hcarty/ocamlbrew/master/ocamlbrew-install | env OCAMLBREW_FLAGS="-r" bash
# OPAM configuration
if [ -d ${HOME}/ocamlbrew -a "$(uname -a | awk '{print $2}')" = metton ] ; then
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
elif $mingw; then
  export PATH=/c/Perl64/bin:${PATH}
  export PATH=/c/Program\ Files\ \(x86\)/Vim/vim74:${PATH}
  export LESSCHARSET=dos
fi

# node
export PATH=$PATH:./node_modules/.bin

# go
if [ -d $HOME/go ] ; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# Setup ssh-agent
if [ -f ~/.ssh-agent ]; then
    . ~/.ssh-agent
fi
if [ -z "$SSH_AGENT_PID" ] || ! kill -0 $SSH_AGENT_PID; then
    ssh-agent > ~/.ssh-agent
    . ~/.ssh-agent
fi
ssh-add -l >& /dev/null || ssh-add

# peco
pcd () {
  local PCD_FILE=$HOME/.peco/.peco-cd
  local PCD_RETURN
  if [ $1 ] && [ $1 = "add" ]; then
    if [ $2 ]; then
      ADD_DIR=$2
      if [ $2 = "." ]; then
        ADD_DIR=$(pwd)
      fi
      echo "add $ADD_DIR to $PCD_FILE"
      echo $ADD_DIR >> $PCD_FILE
    fi
  elif [ $1 ] && [ $1 = "edit" ]; then
    if [ $EDITOR ]; then
      $EDITOR $PCD_FILE
    fi
  elif [ $1 ] && [ $1 = "." ]; then
    PCD_RETURN=$(/bin/ls -F | grep /$ | sort | peco)
  else
    PCD_RETURN=$(cat $PCD_FILE | sort | peco)
  fi

  if [ $PCD_RETURN ]; then
    cd $PCD_RETURN
  fi
}

if [ -x ~/.ghq/github.com/rupa/z ]; then
  source ~/.ghq/github.com/rupa/z/z.sh
fi

# cdの引数を絶対パスにしてコマンドヒストリに残す
# ref: http://inaz2.hatenablog.com/entry/2014/12/11/015125
if [[ -n "$PS1" ]]; then
    cd() {
        command cd "$@"
        local s=$?
        if [[ ($s -eq 0) && (${#FUNCNAME[*]} -eq 1) ]]; then
            history -s cd $(printf "%q" "$PWD")
        fi
        return $s
    }
  fi
