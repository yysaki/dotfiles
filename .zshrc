export LANG=ja_JP.UTF-8
autoload -Uz compinit
compinit -u

stty stop undef

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

case ${UID} in
  0)
    PROMPT="%B%{[31m%}%n@%m#%{[m%}%b "
    RPROMPT="%B%{[32m%}[%~]%{[m%}%b"
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    ;;
  *)
    PROMPT="%{[31m%}%n@%m%%%{[m%} "
    RPROMPT="%{[32m%}[%/]%{[m%}"
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    ;;
esac

# リポジトリの状態を表示
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_} '$RPROMPT

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -d
bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# shortcut for searching history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt nolistbeep
setopt multios

zstyle ':completion:*' list-colors ''

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

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
alias pvim='vim -N -u NONE -U NONE -i NONE --noplugin'
alias sc='screen'
alias t='tail'
alias tm='tmux'
alias tvim='vim -N -u ~/test.vimrc -U NONE -i NONE --noplugin'
alias v='vim'
alias vi='vim'
alias x='xargs'

## screen shortcuts
scx () {
  screen -x $1
}


# set export
export EDITOR='vi'

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

if $linux; then
  ## TODO for yysaki.com
  export JAVA_HOME='/usr/lib/jvm/java-1.6.0-openjdk/' 
  alias rm='rm --preserve-root'
elif $darwin; then
  export PATH=$PATH:${HOME}/bin
  if [ -d /usr/local/Cellar/ctags/5.8 ] ; then
    alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags' # avoid BSD ctags
  fi
  export PATH=${PATH}:/usr/local/share/dotnet/
  export PATH=${PATH}:~/.vim/scripts
  export CC=gcc-4.2 # avoid llvm
  export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 
  export JAVA_HOME=$(/usr/libexec/java_home)
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
  alias rm='rm --preserve-root'
fi

# node
export PATH=$PATH:./node_modules/.bin

# go
if [ -d $HOME/go ] ; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

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

if [ -x $GHQ_ROOT/github.com/rupa/z ]; then
  source $GHQ_ROOT/github.com/rupa/z/z.sh
fi

# install latest vim. required homebrew installed lua, python3
if $darwin; then
  function makeInstallLatestVim() {
    ghq get --update vim/vim;
    pushd `ghq list --full-path vim/vim`;
    git checkout master;

    make distclean;

    ./configure \
      --with-features=huge \
      --enable-luainterp \
      --with-lua-prefix=/usr/local \
      --enable-perlinterp \
      --enable-python3interp \
      --enable-rubyinterp \
      --enable-fail-if-missing;

    make;
    sudo make install;
    popd
  }

  alias vup=makeInstallLatestVim
fi

ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 33
}

if [ -f "${HOME}/.zshrc_local" ]; then
  source "${HOME}/.zshrc_local"
fi

fq() {
  cd /$(ghq list --full-path | fzf)
}

# fbr - checkout git branch
fb() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

if type hub > /dev/null 2>&1; then
  eval "$(hub alias -s)"
fi

# docker completion

enable-docker-complete() {
  etc=/Applications/Docker.app/Contents/Resources/etc
  dir=/usr/local/share/zsh/site-functions
  if [ ! -e $dir/_docker ]; then
    ln -s $etc/docker.zsh-completion $dir/_docker
  fi

  if [ ! -e $dir/_docker-compose ]; then
    ln -s $etc/docker-compose.zsh-completion $dir/_docker-compose
  fi
}

if $darwin; then
  enable-docker-complete
fi

if type aws_zsh_completer.sh > /dev/null; then
  source aws_zsh_completer.sh
fi

# zplug
if [ ! -d ~/.zplug ]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

if [ -x pyenv ]; then
  eval "$(pyenv init -)"
fi

source ~/.zplug/init.zsh

source ${HOME}/.zprofile

# __END__  "{{{1
# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
