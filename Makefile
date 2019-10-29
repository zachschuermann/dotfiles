all: install

install: stow emacs vim tmux

stow:
	sudo apt install stow

emacs: stow
	sudo apt install emacs
	stow emacs

vim: stow
	sudo apt install vim
	stow vim

tmux: stow
	sudo apt install tmux
	stow tmux
