export LANG=ja_JP.UTF-8
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

stty stop undef

# machine specific
linux=false
darwin=false
cygwin=false
wsl=false
case "$(uname)" in
  Linux) linux=true;;
  Darwin) darwin=true;;
  CYGWIN*) cygwin=true;;
  MINGW32*) mingw=true;; # work
  MINGW64*) mingw=true;; # work
esac
if [[ "$(uname -r)" == *microsoft* ]]; then
  wsl=true
fi

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT=$'${vcs_info_msg_0_}%{[32m%}[%~]%{[m%}\n%{[31m%}%n@%m%%%{[m%} '
PROMPT2="%{[31m%}%_%%%{[m%} "
SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
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


## github
# require `gh extension install github/gh-copilot`
copilot() {
  gh copilot suggest -t shell "$@"
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
alias be='bundle exec'
alias beg='bundle exec guard'
alias bn='bundle exec nanoc'
alias br='bundle exec rails'
alias c='copilot'
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

# ripgrep https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
export RIPGREP_CONFIG_PATH=${HOME}/.config/ripgrep/.ripgreprc

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
if $darwin || $wsl; then
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

to() {
  mkdir -p "$(dirname "$1")" && touch "$1";
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
}

if $darwin; then
  enable-docker-complete
fi

if $wsl; then
  export BROWSER='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
  export GH_BROWSER="'/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'"
fi

# zplug
if [ ! -d ~/.zplug ]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

if [ -d ~/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

# cargo
if [ -x "$HOME/.cargo/bin" ]; then
  export PATH=${HOME}/.cargo/bin:$PATH
fi

source ~/.zplug/init.zsh
source ${HOME}/.zprofile

if command -v aws_completer >/dev/null; then
  complete -C "$(command -v aws_completer)" aws
fi

if [[ $- =~ "i" ]]; then
  if [[ -z "$VIM_TERMINAL" ]] && [[ "$TERM_PROGRAM" != "tmux" ]]; then
    command -v neofetch >/dev/null && neofetch
  fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# __END__  "{{{1
# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
