# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#------#
# PATH #
#------#
export SUBLIME_PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export USER_BIN_PATH="$HOME/bin"
export POSTGRES_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_PATH="/opt/homebrew/bin:/opt/homebrew/sbin"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export BZIP2_PATH="/opt/homebrew/opt/bzip2/bin"
export OPEN_SSL_PATH="/opt/homebrew/opt/openssl@3/bin"
export GRAPHVIZ_DIR="/opt/homebrew/opt/graphviz"
export USER_PIP="$HOME/.local/bin"
export PATH=$HOMEBREW_PATH:$SUBLIME_PATH:$OPEN_SSL_PATH:$GRAPHVIZ_DIR:$USER_BIN_PATH:$POSTGRES_PATH:$HOME:$BZIP2_PATH:$USER_PIP:$PATH:.

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
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_VAULT_BACKEND=pass

#---------#
# OpenSSL #  # Order matters, the first exports don't have -L/-I
#---------#
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig"

#----------#
# graphviz #
#----------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix graphviz)/lib"
export CFLAGS="${CPPFLAGS} -I$(brew --prefix graphviz)/include"

#------#
# zlib #
#------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix zlib)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix zlib)/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $(brew --prefix zlib)/lib/pkgconfig"

#-------#
# bzip2 #
#-------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix bzip2)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix bzip2)/include"

#----------#
# readline #
#----------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix readline)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix readline)/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $(brew --prefix readline)/lib/pkgconfig"

#-------#
# icu4c #
#-------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix icu4c@77)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix icu4c@77)/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $(brew --prefix icu4c@77)/lib/pkgconfig"

#--------#
# sqlite #
#--------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix sqlite)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix sqlite)/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $(brew --prefix sqlite)/lib/pkgconfig"

#----------#
# OpenBLAS #
#----------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix openblas)/lib"
export CPPFLAGS="${CPPFLAGS} -I$(brew --prefix openblas)/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} $(brew --prefix openblas)/lib/pkgconfig"

#----------#
# graphviz #
#----------#
export LDFLAGS="${LDFLAGS} -L$(brew --prefix graphviz)/lib"
export CFLAGS="${CPPFLAGS} -I$(brew --prefix graphviz)/include"

#-------------------#
# VirtualEnvWrapper #
#-------------------#
export VIRTUALENVWRAPPER_PYTHON=$HOME/.pyenv/bin/shims/python
export WORKON_HOME=$HOME/venv
export PROJECT_HOME=$HOME/projects
export VIRTUALENVWRAPPER_HOOK_DIR=$WORKON_HOME
export VIRTUALENVWRAPPER_LOG_DIR=$WORKON_HOME

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#------------------#
# DEFAULT SETTINGS #
#------------------#

# Theme is set by powerlevel10k below — leave ZSH_THEME empty here
ZSH_THEME=""

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Update automatically
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
    pipenv
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

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id.pub"

# AWS Vault
export AWS_VAULT_BACKEND=keychain
export AWS_VAULT_KEYCHAIN_NAME=aws-vault

# Get a fortune
command -v fortune >/dev/null && fortune

# Google Cloud SDK
[ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"

# PDM
export PDM_VENV_PROMPT='{project_name}-py{python_version}'

# Docker CLI completions
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit
compinit

# OpenClaw Completion
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"

#---------------------------#
# Brew-installed zsh plugins #
#---------------------------#
# zsh-autosuggestions
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting (must be sourced LAST among these two)
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#---------------#
# Powerlevel10k #
#---------------#
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
