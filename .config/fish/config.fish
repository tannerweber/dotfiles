if status is-interactive
    # PATH
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.local/nvim-linux-x86_64/bin/
    fish_add_path /usr/local/go/bin/

    # ALIASES
    alias gs "git status"
    alias gd "git diff"
    alias gl "git log"

    # fzf
    fzf --fish | source
    alias f "fzf --style full --reverse"

    # ls
    set -x LS_COLORS "di=1;33:*.o=0;34:*.txt=01;31"
    alias la "eza -al --icons"

    # Vim bindings
    fish_hybrid_key_bindings
    #fish_default_keybindings
    set fish_cursor_default block
    set fish_cursor_visual block
    set fish_cursor_insert line
    set fish_cursor_external line

    # bat
    set -x MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

    # yazi
    function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
    end

    # zoxide
    zoxide init fish | source

    # starship.rs
    starship init fish | source
end

function fish_greeting
    echo Using (fish -v) as $USER on $hostname
end
