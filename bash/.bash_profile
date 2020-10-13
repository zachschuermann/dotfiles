source ~/dotfiles/tmux-chooser.sh

if [[ ! -v TMUX && $TERM_PROGRAM != "vscode" ]]; then
	tmux_chooser && exit
fi
