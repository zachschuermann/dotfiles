brew_install() {
    if !command -v $1 >/dev/null 2>&1; then
        tell "Installing $1." 
        brew install $1
    else
        tell "Found $1: $($1 --version)"
    fi
}

install_mac() {

    ### Dependencies
    if !command -v brew >/dev/null 2>&1; then
        tell "Installing Homebrew." 
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
        tell "Found brew: $(brew --version)"
    fi
    brew update

    if !command -v git >/dev/null 2>&1; then
        tell "Installing git." 
        brew install git
    else
        tell "Found git: $(git --version)"
    fi

    if !command -v stow >/dev/null 2>&1; then
        tell "Installing stow." 
        brew install stow
    else
        tell "Found stow: $(stow --version)"
    fi

    tell "get submodules"
    git submodule init
    git pull --recurse-submodules

    tell "stowing git..."
    stow git

    ######### (N)VIM ###########
    if !command -v nvim >/dev/null 2>&1; then
        tell "Installing neovim." 
        brew install neovim --HEAD
    else
        tell "Found neovim: $(nvim --version)"
    fi

    tell "stowing vim..."
    stow vim
    ############################



    ######### (N)VIM ###########
    if !command -v tmux >/dev/null 2>&1; then
        tell "Installing tmux." 
        brew install tmux
    else
        tell "Found tmux: $(tmux --version)"
    fi

    tell "stowing tmux..."
    stow tmux

    
    ######### Rusty Utils ###########
    brew_install alacritty
    brew_install ripgrep
    brew_install fd
    brew_install fzf
    brew_install bat
    brew_install exa

    tell "stowing alacritty..."
    stow alacritty

    ### misc
    brew_install htop
    brew_install tree

    ########################## shells #########################

    ######### Fish ###########
    if !command -v fish >/dev/null 2>&1; then
        tell "Installing fish." 
        brew install fish
    else
        tell "Found fish: $(fish --version)"
    fi

    tell "stowing fish..."
    stow fish

    ######### zsh ###########
    if !command -v zsh >/dev/null 2>&1; then
        tell "Installing zsh." 
        brew install zsh
    else
        tell "Found zsh: $(zsh --version)"
    fi

    tell "stowing zsh..."
    stow zsh

    tell "all done!"
    cecho "Go be great." $green
}

install_linux() {
    # TODO
    tell "install prereqs"
    sudo apt install stow
    sudo apt install fish
}

