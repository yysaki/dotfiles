export LANG=ja_JP.UTF-8

# User specific aliases and functions
## Dropbox aliases and functions
alias dbst='dropbox status'
alias dbfs='dropbox filestatus'

dropbox_backup_dotfiles () {
  cp ~/.bashrc ~/.bash_profile ~/.bash_logout ~/.vimrc ~/.gvimrc ~/.screenrc ~/Dropbox/Program/dotfiles/
  cp -rf ~/vimfiles/dict \
  ~/vimfiles/scripts \
  ~/vimfiles/colors \
  ~/vimfiles/ftplugin \
  ~/vimfiles/snippets \
  ~/vimfiles/doc \
  ~/vimfiles/syntax \
  ~/Dropbox/Program/dotfiles/vimfiles/
  cp ~/.ssh/config ~/Dropbox/Program/dotfiles/.ssh/
}

## screen shortcuts
alias sc='screen'
scx () {
  screen -x $1
}

## set aliases
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias RPE='ruby -pe'
alias RNE='ruby -ne'
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

# machine specific
linux=false
darwin=false
cygwin=false
case "$(uname)" in
  Linux) linux=true;;
Darwin) darwin=true;;
  CYGWIN*) cygwin=true;;
esac

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

  if [ -f /Applications/MacVim.app/Contents/MacOS/mvim ]; then
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
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
