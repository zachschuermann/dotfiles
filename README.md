# .files
Requires GNU Stow.
Vim: Requires Vim 8+/Neovim 0.3+
Emacs: Requires GNU Emacs 26.2+
- installs:
Emacs: Modified version of DOOM
Tmux: prefix key rebind to `C-a` and switch key rebind to `^A`
Emacs/Vim Theme: Custom Doom/Dracula    
shells: bash/zsh/fish
terminal: alacritty

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
- [ ] Nix for predictable bootstrapping

## Installation
```bash
$ git clone --recurse-submodules git@github.com:schuermannator/dotfiles.git
```
or for a normal clone: 
```bash
$ git pull --recurse-submodules 
$ git submodule update --init --recursive
```
then,
``` bash
$ stow vim
$ stow fish
etc.
```

### Vim
Neovim/COC requires: node/python3
```
$ npm install -g neovim
$ python3 -m pip install --user --upgrade pynvim
```

### Emacs
```
$ emacs/.emacs.d/bin/doom refresh
```
Inside emacs: `M-x all-the-icons-install-fonts`


## Screenshot
![Vim](/vimdemo.png) 

## Resources
[Github dotfiles](http://dotfiles.github.io/)
[Jon Gjengset Configs](https://github.com/jonhoo/configs)
[How to boost your Vim productivity](https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
[Git Log Commands](https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs)
