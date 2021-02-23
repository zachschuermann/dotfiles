# .files
Requires GNU Stow.
Vim: Requires Vim 8+/Neovim 0.5+
Emacs: Requires GNU Emacs 26.2+
- installs:
Emacs: Modified version of DOOM
Tmux: prefix key rebind to `C-a` and switch key rebind to `^A`
Emacs/Vim Theme: Custom Doom/Dracula    
shells: bash/zsh/fish
terminal: alacritty

**nixos todo**:
- [ ] sxhkd keybinds that don't revert when keyboard unplugs/plugs in
- [ ] how to handle passphrase entry over ssh and gui
- [ ] vim create ~/.vimbackup?

**TODO:**
- [x] Symlinks with GNU Stow
- [x] Add git submodules inside `.vim`  
- [ ] gccemacs
- [ ] Add macOS configs
- [x] Add other dotfiles - alacritty, etc. 
- [ ] Add software installation scripts for GNU/Linux and macOS
- [x] Homebrew stuff
- [x] Bootstrap scripts
- [ ] Better docs
- [x] Add completion stuff with vim keybind j/k up down
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
MANUAL:
```
ln -s $HOME/.fzf/shell/key-bindings.fish $HOME/dotfiles/fish/.config/fish/functions/fzf_key_bindings.fish
```

### Language Tools
#### Rust
- [Rust Analyzer](https://github.com/rust-analyzer/rust-analyzer)
- default tooling

#### Haskell
- [Haskell Language Server](https://github.com/haskell/haskell-language-server)

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


### Dracula

#### Color Palette
[https://draculatheme.com](https://draculatheme.com)

Palette      | Hex       | RGB           | HSL             | ![Color Picker Boxes](https://draculatheme.com/static/img/color-boxes/eyedropper.png)
---          | ---       | ---           | ---             | ---
Background   | `#282a36` | `40 42 54`    | `231° 15% 18%`  | ![Background Color](https://draculatheme.com/static/img/color-boxes/background.png)
Current Line | `#44475a` | `68 71 90`    | `232° 14% 31%`  | ![Current Line Color](https://draculatheme.com/static/img/color-boxes/current_line.png)
Selection    | `#44475a` | `68 71 90`    | `232° 14% 31%`  | ![Selection Color](https://draculatheme.com/static/img/color-boxes/selection.png)
Foreground   | `#f8f8f2` | `248 248 242` | `60° 30% 96%`   | ![Foreground Color](https://draculatheme.com/static/img/color-boxes/foreground.png)
Comment      | `#6272a4` | `98 114 164`  | `225° 27% 51%`  | ![Comment Color](https://draculatheme.com/static/img/color-boxes/comment.png)
Cyan         | `#8be9fd` | `139 233 253` | `191° 97% 77%`  | ![Cyan Color](https://draculatheme.com/static/img/color-boxes/cyan.png)
Green        | `#50fa7b` | `80 250 123`  | `135° 94% 65%`  | ![Green Color](https://draculatheme.com/static/img/color-boxes/green.png)
Orange       | `#ffb86c` | `255 184 108` | `31° 100% 71%`  | ![Orange Color](https://draculatheme.com/static/img/color-boxes/orange.png)
Pink         | `#ff79c6` | `255 121 198` | `326° 100% 74%` | ![Pink Color](https://draculatheme.com/static/img/color-boxes/pink.png)
Purple       | `#bd93f9` | `189 147 249` | `265° 89% 78%`  | ![Purple Color](https://draculatheme.com/static/img/color-boxes/purple.png)
Red          | `#ff5555` | `255 85 85`   | `0° 100% 67%`   | ![Red Color](https://draculatheme.com/static/img/color-boxes/red.png)
Yellow       | `#f1fa8c` | `241 250 140` | `65° 92% 76%`   | ![Yellow Color](https://draculatheme.com/static/img/color-boxes/yellow.png)

## Screenshot
![Vim](/vimdemo.png) 

## Resources
[Github dotfiles](http://dotfiles.github.io/)
[Jon Gjengset Configs](https://github.com/jonhoo/configs)
[How to boost your Vim productivity](https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
[Git Log Commands](https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs)
