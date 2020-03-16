#if status --is-interactive
	#tmux ^ /dev/null; and exec true
#end

set PATH /Users/zach/.cargo/bin/ $PATH

set -g fish_key_bindings fish_vi_key_bindings

if command -v exa > /dev/null
	alias l 'exa'
	alias ls 'exa'
	alias lll 'exa -l'
	alias ll 'exa -la'
else
	alias l 'ls'
	alias lll 'ls -l'
	alias ll 'ls -la'
end

if command -v bat > /dev/null
	alias cat 'bat'
else
	alias cat 'cat'
end

if command -v nvim > /dev/null
    alias vim 'nvim'
    alias vi 'vim'
end
