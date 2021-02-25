brew_install() {
    if !command -v $1 >/dev/null 2>&1; then
        tell "Installing $1." 
        brew install $1
    else
        tell "Found $1: $($1 --version)"
    fi
}

# TODOs
# - add rust-analyzer
# - add gopls

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
    tell "installing basics"
    sudo apt install -y software-properties-common build-essential curl cmake git stow fd-find fzf ripgrep htop tree exa

    tell "installing bat"
    curl -LO "https://github.com/sharkdp/bat/releases/download/v0.16.0/bat_0.16.0_amd64.deb"
    sudo dpkg -i "bat_0.16.0_amd64.deb"
    rm "bat_0.16.0_amd64.deb"

    tell "building neovim"
    sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
    git clone git@github.com:neovim/neovim.git
    pushd neovim
    make CMAKE_BUILD_TYPE=Release
    #sudo add-apt-repository ppa:neovim-ppa/unstable
    #sudo apt update && sudo apt install -y neovim
    # curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
    # tar -xzf nvim-linux64.tar.gz
    # sudo mv nvim-linux64/bin/nvim /usr/bin/nvim
    # rm nvim-linux64.tar.gz
    # rm -rf nvim-linux64/
    tell "installing neovim"
    sudo make install
    popd && rm -rf neovim

    tell "installing fish"
    # curl -LO "https://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/amd64/fish_3.1.2-1_amd64.deb"
    # sudo dpkg -i "fish_3.1.2-1_amd64.deb"
    # rm "fish_3.1.2-1_amd64.deb"

    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells:fish:release:3.gpg > /dev/null
    sudo apt update && sudo apt install -y fish

    # make vim's backup dir
    mkdir ~/.vimbackup

    #while true; do
    read -p "stow fish config? [Y/n] " yn
    case $yn in
       [Nn]* ) ;;
            # [Nn]* ) exit;;
       * ) stow fish;;
    esac
    #done

    read -p "stow bash config? [Y/n] " yn
    case $yn in
       [Nn]* ) ;;
       * ) stow bash;;
    esac

    read -p "stow tmux config? [Y/n] " yn
    case $yn in
       [Nn]* ) ;;
       * ) stow tmux;;
    esac

    read -p "stow vim config? [Y/n] " yn
    case $yn in
       [Nn]* ) ;;
       * ) stow vim;;
    esac

    read -p "stow git config? [Y/n] " yn
    case $yn in
       [Nn]* ) ;;
       * ) stow git;;
    esac

    read -p "change shell to fish? [Y/n] " yn
    case $yn in
       [Nn]* ) ;;
       * ) chsh -s $(which fish);;
    esac

    tell "all done!"
    cecho "Go be great." $green
}

