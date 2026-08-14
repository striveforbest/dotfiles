# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#----------#
# Homebrew #
#----------#
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
export HOMEBREW_PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin"
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:"

#------#
# PATH #
#------#
# Neither "." nor "$HOME" belongs on PATH: both let a file dropped into a
# directory you cd through become an executed command. Stripped again at the
# bottom of this file in case a parent shell exported them in.
export SUBLIME_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export USER_BIN_PATH="$HOME/bin"
export POSTGRES_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin"
export BZIP2_PATH="$HOMEBREW_PREFIX/opt/bzip2/bin"
export OPEN_SSL_PATH="$HOMEBREW_PREFIX/opt/openssl@3/bin"
export GRAPHVIZ_DIR="$HOMEBREW_PREFIX/opt/graphviz"
export USER_PIP="$HOME/.local/bin"
export PATH="$HOMEBREW_PATH:$SUBLIME_PATH:$OPEN_SSL_PATH:$GRAPHVIZ_DIR:$USER_BIN_PATH:$POSTGRES_PATH:$BZIP2_PATH:$USER_PIP:$PATH"

#-------#
# PyEnv #
#-------#
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export GPG_TTY=$(tty)

#-------------------#
# Shell integration #
#-------------------#
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

#-----#
# NVM #
#-----#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#-----------#
# AWS Vault #
#-----------#
export AWS_VAULT_BACKEND=keychain
export AWS_VAULT_KEYCHAIN_NAME=aws-vault

#------------------------#
# Build flags (Homebrew) #
#------------------------#
# Reset first: these are exported, so "exec zsh" would otherwise inherit the
# previous value and append to it forever.
# PKG_CONFIG_PATH is COLON separated. It used to be built with spaces, which
# silently hid every entry after the first from pkg-config.
LDFLAGS=""; CPPFLAGS=""; PKG_CONFIG_PATH=""
for _pkg in openssl@3 graphviz zlib readline icu4c@77 sqlite openblas bzip2; do
  _p="$HOMEBREW_PREFIX/opt/$_pkg"
  [ -d "$_p" ] || continue
  [ -d "$_p/lib" ]           && LDFLAGS="${LDFLAGS:+$LDFLAGS }-L$_p/lib"
  [ -d "$_p/include" ]       && CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I$_p/include"
  [ -d "$_p/lib/pkgconfig" ] && PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+$PKG_CONFIG_PATH:}$_p/lib/pkgconfig"
done
unset _pkg _p
export LDFLAGS CPPFLAGS PKG_CONFIG_PATH
export CFLAGS="$CPPFLAGS"

#-------------------#
# VirtualEnvWrapper #
#-------------------#
# Was pointing at ~/.pyenv/bin/shims/python, which has never existed.
# Resolve whichever shim is actually present.
for _vw in "$PYENV_ROOT/shims/python" "$PYENV_ROOT/shims/python3"; do
  if [ -x "$_vw" ]; then export VIRTUALENVWRAPPER_PYTHON="$_vw"; break; fi
done
unset _vw
export WORKON_HOME=$HOME/venv
export PROJECT_HOME=$HOME/projects
export VIRTUALENVWRAPPER_HOOK_DIR=$WORKON_HOME
export VIRTUALENVWRAPPER_LOG_DIR=$WORKON_HOME

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#------------------#
# DEFAULT SETTINGS #
#------------------#

# Theme is set by powerlevel10k below -- leave ZSH_THEME empty here
ZSH_THEME=""

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Update automatically
DISABLE_UPDATE_PROMPT="true"

# Command auto-correction. Previously enabled here and then unset twice at the
# bottom of the file; decided in one place now.
ENABLE_CORRECTION="false"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    1password
    alias-finder
    aliases
    aws
    brew
    celery
    charm
    colored-man-pages
    colorize
    command-not-found
    common-aliases
    cp
    docker
    git
    git-auto-fetch
    history
    iterm2
    macos
    npm
    nvm
    pre-commit
    pip
    poetry
    pyenv
    python
    sublime
)

source $ZSH/oh-my-zsh.sh

# User configuration

DEFAULT_USER=ziggy

export LANG=en_US.UTF-8

# Separate aliases/functions file
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.functions" ] && source "$HOME/.functions"

# Get a fortune
command -v fortune >/dev/null && fortune

# Google Cloud SDK
for _gc in "$HOME/.local/google-cloud-sdk" "$HOME/Downloads/google-cloud-sdk"; do
  [ -f "$_gc/path.zsh.inc" ] || continue
  source "$_gc/path.zsh.inc"
  [ -f "$_gc/completion.zsh.inc" ] && source "$_gc/completion.zsh.inc"
  break
done
unset _gc

# PDM
export PDM_VENV_PROMPT='{project_name}-py{python_version}'

# Docker CLI completions
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)
# oh-my-zsh already runs compinit; do not call it a second time.

# OpenClaw Completion
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"

#----------------------------#
# Brew-installed zsh plugins #
#----------------------------#
[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting (must be sourced LAST among these two)
[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

#---------------#
# Powerlevel10k #
#---------------#
source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#----------------#
# PATH hardening #
#----------------#
# Runs last, after pyenv/nvm/oh-my-zsh. Dedupes, and strips "." and $HOME even
# when they arrive inherited from a parent shell (exec zsh, nested shell,
# editor-launched terminal).
typeset -U path PATH
path=("${(@)path:#.}")
path=("${(@)path:#$HOME}")
export PATH

#----------------------------------------------#
# Machine-local settings -- NOT tracked in git  #
#----------------------------------------------#
# Anything with a personal path, address, account name or token goes here.
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
