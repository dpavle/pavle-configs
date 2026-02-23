########################################################################################################################
############################################ Standard ZSH/OMZ configuration ############################################
########################################################################################################################

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

############################################################################################################
############################################ User configuration ############################################
############################################################################################################

function zvm_after_init() {

  # Enable 'fzf' integration
  source <(fzf --zsh)

  # Attach to existing 'default' TMUX session or spawn a new one if it doesn't exist
  if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -z "$SSH_CONNECTION" ]; then
    tmux attach-session -t default || tmux new-session -s default
  fi

  # Enable 'zoxide' integration
  eval "$(zoxide init zsh)"

  # Start 'ssh-agent'
  eval $(ssh-agent) > /dev/null
}

################################################################################################################
############################################ User-defined functions ############################################
################################################################################################################

# Generate a random string of 'n' length
function genstr() {
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c $1
  echo ''
}

######################################################################################################
############################################ User aliases ############################################
######################################################################################################

# shortcuts
alias fm="ranger"
alias usage="du -h --max-depth 1"

# git shortcuts
alias gits="git status"
alias gitcm="git commit -m"
alias gitcam="git commit -am"

alias cd="z" # replace 'cd' with 'zoxide'
alias vim="nvim" # replace regular vim with neovim

######################################################################################################
############################################ PATH changes ############################################
######################################################################################################

path+=('~/.local/bin')

# /opt/*-tools
path+=('/opt/ondemand-tools' '/opt/ssh-tools')

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

# Brew
path+=("/home/linuxbrew/.linuxbrew/bin")

# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Rust
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

# .NET
if [[ -d "$HOME/.dotnet" ]]; then
  DOTNET_ROOT="$HOME/.dotnet"
  path+=("$DOTNET_ROOT" "$DOTNET_ROOT/tools")
fi

export PATH

#######################################################################################################
############################################ Miscellaneous ############################################
#######################################################################################################

LS_COLORS=$(vivid generate molokai)

# Run 'ls' after every 'cd'
function list_all() {
  emulate -L zsh
  ls
}
if [[ ${chpwd_functions[(r)list_all]} != "list_all" ]];then
  chpwd_functions=(${chpwd_functions[@]} "list_all")
fi

# https://www.reddit.com/r/linux_gaming/comments/1jh2sdr/i_automated_switching_to_steam_gamemode_and_back/
alias gsteam="gamescope-session; chvt 2; exit"


# WSL <-> Windows browser integration
if [[ $(systemd-detect-virt) == 'wsl' ]]; then
  BROWSER=/opt/firefox
  export BROWSER
fi

if [[ $(tty) == "/dev/tty3" ]]; then
  gsteam
fi

# https://taskwarrior.org/
[[ -n $(which task) ]] && task list
