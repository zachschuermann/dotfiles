# If you come from bash you might have to change your $PATH.

export GOPATH=$HOME/go:/Users/zach/Documents/fall19/class/distributed-systems/4113
#path+=('$GOPATH/bin')
export PATH=$GOPATH/bin:$PATH

TIMEFMT='%J'$'\n'\
'%U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M KB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'

export VISUAL=nvim
export EDITOR="$VISUAL"

# Path to your oh-my-zsh installation.
# also stack path
export ZSH="/home/zach/.oh-my-zsh"
if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    export ZSH="/Users/zach/.oh-my-zsh"
    path+=('/Users/zach/.emacs.d/bin')
    path+=('/Users/zach/.local/bin')
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [ "$(uname 2> /dev/null)" = "Linux" ]; then
    ZSH_THEME="nox"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
###
# look into: emacs, gpg-agent, kubectl, thefuck
# useful, not needed now: aws
# removed for speed:
    # autopep8
    # cabal
    # celery
    # django
    # docker-compose
    # cargo
    # command-not-found
    # docker
    # gcloud
    # httpie
    # pip
    # stack
    # sublime
    # ufw
    # vagrant-prompt
    # vagrant
    #
    # golang
    # rust
    #
plugins=(
    fd
    ripgrep
    safe-paste
    tmux
    vi-mode
    z
)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' menu select
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# undo aliases (to run original 'cat') by running \cat

# User configuration
alias ls='exa'
alias cat='bat'

# how to access originals
alias ll='exa -la'
alias lls='/bin/ls'
alias ct='/bin/cat'

alias emacs='emacs -nw'
alias emax='emacs'

alias vim='nvim'
alias vi='vim'

# overwrite vi-mode for reverse-inc-search
bindkey "^R" history-incremental-search-backward

alias vmstart='VBoxManage startvm --type headless'  # starts VM headlessly
function vmpower() {
    VBoxManage controlvm $1 poweroff                # force shutdown
}
function vmacpi() {
    VBoxManage controlvm $1 acpipowerbutton         # send ACPI power button
}
alias vmls='VBoxManage list vms'                    # list all VMs
alias vmlson='VBoxManage list runningvms'           # list running VMs
vmrestart() {
    vmpower $1 && vmstart $1                        # restart VM
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# broot stuff
source /Users/zach/Library/Preferences/org.dystroy.broot/launcher/bash/br
alias tree='br'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
