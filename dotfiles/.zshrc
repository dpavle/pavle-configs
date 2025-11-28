#################################################################################################################
########################################## Standard configuration ###############################################
#################################################################################################################

###############################################################################################################
############################################ User Configuration ###############################################
###############################################################################################################

############################################## User Functions ###################################################

# --- sync SSH configs with Windows (WSL) ------------------------------------------

function wsl_sync_ssh() {
  rsync -a --exclude='known_hosts' /mnt/c/Users/pavle.dencic/.ssh/* ~/.ssh/
  chmod 700 ~/.ssh
  find ~/.ssh -type d -exec chmod 700 {} +
  find ~/.ssh -type f -exec chmod 600 {} +
}

detect_virt=$(systemd-detect-virt)
if [ "${detect_virt}" = 'wsl' ]; then
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
alias ls="ls -lh --color=auto"
alias cd="z"

##################################################################################################################

#################################################### PATH #########################################################

# ondemand-tools
path+=('/opt/ondemand-tools')

# Golang
path+=('/usr/local/go/bin')
GOPATH="$HOME/go/bin"
path+=("$GOPATH") # path for go packages

if [ "${detect_virt}" = "wsl" ]; then
  # Vagrant
  export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
  path+=('/mnt/c/Program Files/Oracle/VirtualBox')
fi

# lua-language-server
path+=('/opt/luals/bin')

# YARN - JavaScript package manager
path+=("${HOME}/.yarn/bin")

# Python (pip) user packages
path+=("${HOME}/.local/bin")

# Brew
path+=("/home/linuxbrew/.linuxbrew/bin")

# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

if [[ $(systemd-detect-virt) == 'wsl' ]]; then
  BROWSER=/opt/firefox
  export BROWSER
fi

# Rust
. "$HOME/.cargo/env"

export PATH

###############################################################################################################

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
#LS_COLORS=$(vivid generate solarized-dark)

source <(fzf --zsh)

if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit


export EDITOR=vim
export ZVM_VI_EDITOR=vim
