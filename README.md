# .files
Includes vim, tmux, and emacs config.  
Vim: Pathogen, NERDtree, and Lightline  
Emacs: Modified version of DOOM: EViL Mode, Powerline?, Neotree?, Magit, Projectile, and Melpa (and languages)
Tmux: prefix key rebind to `C-a` and switch key rebind to `^A`
Emacs/Vim Theme: Custom Doom/Dracula    

**TODO:**
- [x] Symlinks with GNU Stow
- [ ] Add git submodules inside `.vim`  
- [ ] Add macOS configs
- [ ] Add other dotfiles - alacritty, etc. 
- [ ] Add software installation scripts for GNU/Linux and macOS

## Installation
```bash
$ git pull --recurse-submodules # or clone with submodules
$ git submodule update --init --recursive
$ emacs/.emacs.d/bin/doom refresh
```

Inside emacs: M-x all-the-icons-install-fonts  

Install GNU Stow, Emacs 26.2+, Vim 8+  

Profit.

## Deploying

``` bash
$ stow <dirname>
$ stow emacs # to install emacs configs
```

## Emacs
![Emacs](/emacs.png)  

## Vim
![Vim](/vimdemo.png) 

## Resources
[Github dotfiles](http://dotfiles.github.io/)

