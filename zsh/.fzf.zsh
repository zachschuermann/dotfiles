# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/zach/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/zach/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/zach/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/zach/.fzf/shell/key-bindings.zsh"
