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
export PS1="\[\e[31m\]\u@\h \W\$ \[\e[0m\]"

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
  if [ -d /usr/local/Cellar/ctags/5.8/ ] ; then
    alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags' # avoid BSD ctags
  fi
  export PATH=${PATH}:~/.vim/scripts
  export CC=gcc-4.2 # avoid llvm
  export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 
  export JAVA_HOME='/Library/Java/JavaVirtualMachines/1.6.0_29-b11-402.jdk/Contents/Home'
  export PATH=${PATH}:/Users/yysaki/Library/Android/sdk/platform-tools
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
  export PATH=/c/Program\ Files\ \(x86\)/Vim/vim80:${PATH}
  export PATH=/cmd/:${PATH}
  export LESSCHARSET=dos
fi

# node
export PATH=$PATH:./node_modules/.bin

# go
if [ -d $HOME/go ] ; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
  export GHQ_ROOT=$GOPATH/src
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

function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

if [ -f "${HOME}/.bashrc_local" ]; then
  source "${HOME}/.bashrc_local"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
