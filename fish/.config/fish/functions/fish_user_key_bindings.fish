function fish_user_key_bindings
    # set vi-mode keybindings
    set -g fish_key_bindings fish_vi_key_bindings

    # retain the old ctrl-f autocomplete
    bind -M insert \cf accept-autosuggestion
    bind \cf accept-autosuggestion

    # add FZF keybindings (ctrl-t and ctrl-r)
    fzf_key_bindings

    # add vi-like pager navigation
    bind -M insert \cj down-line
    bind -M insert \ck up-line
    bind -M insert \cl forward-char
    bind -M insert \ch backward-char
end
