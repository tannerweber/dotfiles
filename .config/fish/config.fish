if status is-interactive
    # PATH
    fish_add_path $HOME/.local/bin/
    fish_add_path $HOME/.npm-global/bin/
    fish_add_path /usr/local/go/bin/
    fish_add_path $HOME/.local/nvim-linux-x86_64/bin/
    fish_add_path $HOME/.local/lua-language-server-3.15.0-linux-x64/bin/
    fish_add_path $HOME/.local/clangd_21.1.0/bin/

	# Environment Variables
	set -x EDITOR "nvim"
    set -x LS_COLORS "di=1;33:*.o=0;34:*.txt=01;31"

    # Abbreviations
    abbr --add la "eza -al --icons"
	abbr --add gs git status
	abbr --add gd git diff
	abbr --add gl git log
	abbr --add gc git commit -m

    # fzf
    fzf --fish | source

    # Vim bindings
    fish_hybrid_key_bindings
    #fish_default_keybindings
    set fish_cursor_default block
    set fish_cursor_visual block
    set fish_cursor_insert line
    set fish_cursor_external line

    # bat
    set -x MANPAGER "bat -plman"

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
	if test -n "(which zoxide)"
    	zoxide init fish | source
		abbr --add cd "z"
	end

    # starship.rs
	starship init fish | source
end

function fish_greeting
    echo Using (fish -v) as $USER on $hostname
end
