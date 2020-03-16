# .files
Includes vim, tmux, and emacs config.  
Vim: Required Vim 8+/Neovim
- installs:
Emacs: Modified version of DOOM
Tmux: prefix key rebind to `C-a` and switch key rebind to `^A`
Emacs/Vim Theme: Custom Doom/Dracula    

**TODO:**
- [x] Symlinks with GNU Stow
- [x] Add git submodules inside `.vim`  
- [ ] Add macOS configs
- [ ] Add other dotfiles - alacritty, etc. 
- [ ] Add software installation scripts for GNU/Linux and macOS
- [ ] Homebrew stuff
- [ ] Bootstrap scripts
- [ ] Better docs
- [ ] Add completion stuff with vim keybind j/k up down

## Installation
```bash
$ git clone --recurse-submodules git@github.com:schuermannator/dotfiles.git
```
or for a normal clone: 
```bash
$ git pull --recurse-submodules 
$ git submodule update --init --recursive
$ emacs/.emacs.d/bin/doom refresh
```

Neovim/COC requires: node/python3
```
npm install -g neovim
python3 -m pip install --user --upgrade pynvim
```

Inside emacs: M-x all-the-icons-install-fonts  

Install GNU Stow, Emacs 26.2+, Vim 8+  

## Deploying

``` bash
$ stow <dirname>
$ stow emacs # to install emacs configs
```

## Vim
![Vim](/vimdemo.png) 

## Resources
[Github dotfiles](http://dotfiles.github.io/)
[Jon Gjengset Configs](https://github.com/jonhoo/configs)


