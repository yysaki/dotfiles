export LANG=ja_JP.UTF-8
autoload -Uz compinit
compinit -u

case ${UID} in
  0)
    PROMPT="%B%{[31m%}%m:%n#%{[m%}%b "
    RPROMPT="%B%{[32m%}[%~]%{[m%}%b"
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    ;;
  *)
    PROMPT="%{[31m%}%m:%n%%%{[m%} "
    RPROMPT="%{[32m%}[%/]%{[m%}"
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    ;;
esac


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

bindkey -v
bindkey '^R' history-incremental-search-backward

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

## screen shortcuts
alias sc='screen'
scx () {
  screen -x $1
}

# machine specific
linux=false
darwin=false
cygwin=false
case "$(uname)" in
  Linux) linux=true;;
  Darwin) darwin=true;;
  CYGWIN*) cygwin=true;;
esac

## set aliases
alias rm='rm --preserve-root'
alias tm='tmux'
alias where="command -v"
alias j="jobs -l"
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias RPE='ruby -pe'
alias RNE='ruby -ne'
alias be='noglob bundle exec'
alias ber='noglob bundle exec rails'
alias rake="noglob rake"
alias gvi='gvim'
if [ -x /usr/bin/vim ]; then
  alias vi='/usr/bin/vim'
fi

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

