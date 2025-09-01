#################################################################################################################
########################################## Standard configuration ###############################################
#################################################################################################################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

#RPROMPT='$(azure_prompt_info)'

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git azure zsh-autosuggestions git-auto-status fzf zsh-vi-mode)

# Keep in mind that plugins need to be added before oh-my-zsh.sh is sourced.
source $ZSH/oh-my-zsh.sh

###############################################################################################################
############################################ User Configuration ###############################################
###############################################################################################################

function zvm_after_init() {

  # Enable 'fzf' integration
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
  fi

}

############################################## User Functions ###################################################

# --- sync SSH configs with Windows (WSL) ------------------------------------------

function wsl_sync_ssh() {
  rsync -a --exclude='known_hosts' /mnt/c/Users/pavle.dencic/.ssh/* ~/.ssh/
  chmod 700 ~/.ssh
  find ~/.ssh -type d -exec chmod 700 {} +
  find ~/.ssh -type f -exec chmod 600 {} +
}

if [[ $(systemd-detect-virt) == 'wsl' ]]; then
  wsl_sync_ssh
  #wsl_sync_hosts -- (re)implemented as a script in /usr/local/bin/wsl_sync_hosts due to issues with permissions
fi

# -----------------------------------------------------------------------------------

function genstr() {
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1
  echo ''
}

# --- run ls after every cd ------------------------------------

function list_all() {
  emulate -L zsh
  ls
}

if [[ ${chpwd_functions[(r)list_all]} != "list_all" ]];then
  chpwd_functions=(${chpwd_functions[@]} "list_all")
fi

# -------------------------------------------------------------

##################################################################################################################

################################################## Aliases #######################################################

alias usage="du -h --max-depth 1"
alias vim="nvim"
alias fm="ranger"
alias gits="git status"
alias gitcm="git commit -m"
alias yls="ls -d */ | awk '{ print $9 }' | tr -d '/,' | sed -e 's/^/- /'"
alias ls="ls -lah --color=auto"
alias cd="z"

##################################################################################################################

#################################################### PATH #########################################################

# ondemand-tools
path+=('/opt/ondemand-tools')

# Golang
path+=('/usr/local/go/bin')
GOPATH="$HOME/go/bin"
path+=("$GOPATH") # path for go packages

# Vagrant
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
path+=('/mnt/c/Program Files/Oracle/VirtualBox')

# lua-language-server
path+=('/opt/luals/bin')

# YARN - JavaScript package manager
path+=("${HOME}/.yarn/bin")

# Python (pip) user packages
path+=("${HOME}/.local/bin")

# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [[ $(systemd-detect-virt) == 'wsl' ]]; then
  BROWSER=/opt/firefox
  export BROWSER
fi

export PATH

###############################################################################################################

eval "$(zoxide init zsh)"
