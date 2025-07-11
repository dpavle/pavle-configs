# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="af-magic"
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
#HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# unsetopt correct_all

RPROMPT='$(azure_prompt_info)'

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git azure docker docker-compose python ssh zsh-autosuggestions git-auto-status fzf vi-mode)
source $ZSH/oh-my-zsh.sh

#############################################################################################################
########################################## User configuration ###############################################
#############################################################################################################

# Enable 'fzf' integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export MANPATH="/usr/local/man:$MANPATH"

# Enable 'vi mode'
bindkey -v

ZSH_DISABLE_COMPFIX="false"

########################################### PATH Modifications ##############################################

# ondemand-tools
export PATH="$PATH:/opt/ondemand-tools"

# Golang
export PATH="$PATH:/usr/local/go/bin" # path to go installation

GOPATH="$HOME/go/bin"
export PATH="$PATH:$GOPATH" # path for go packages

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"

# lua-language-server
export PATH="/opt/luals/bin:$PATH"

# YARN - JavaScript package manager
export PATH="/home/pavle/.yarn/bin:$PATH"

# Python (pip) user packages
export PATH="/home/pavle/.local/bin:$PATH"

# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

############################################################################################################

############################################ User functions ################################################

function wsl_sync_ssh() {
  rsync -a --exclude='known_hosts' /mnt/c/Users/pavle.dencic/.ssh/* ~/.ssh/
  chmod 700 ~/.ssh
  find ~/.ssh -type d -exec chmod 700 {} +
  find ~/.ssh -type f -exec chmod 600 {} +
}

# sync with Windows on login
if [[ -d /mnt/c/Users/pavle.dencic/.ssh/ ]]; then
  wsl_sync_ssh
fi
#wsl_sync_hosts -- implemented as a script in /usr/local/bin/wsl_sync_hosts due to issues with permissions

function genstr() {
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1
  echo ''
}

# --- run ls after every cd -----------------------------------

function list_all() {
  emulate -L zsh
  ls
}

if [[ ${chpwd_functions[(r)list_all]} != "list_all" ]];then
  chpwd_functions=(${chpwd_functions[@]} "list_all")
fi

# -------------------------------------------------------------

#############################################################################################################

################################################# Aliases ###################################################

alias usage="du -h --max-depth 1"
alias vim="nvim"
alias fm="ranger"
alias gits="git status"
alias yls="ls -d */ | awk '{ print $9 }' | tr -d '/,' | sed -e 's/^/- /'"
#alias ls="ls -lah --color=auto"

#############################################################################################################

