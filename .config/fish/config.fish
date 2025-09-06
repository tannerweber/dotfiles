if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.local/nvim-linux-x86_64/bin/

    # Colors
    set -x LS_COLORS "di=1;33:*.o=0;34:*.txt=01;31"

    # Vim bindings
    fish_hybrid_key_bindings
    #fish_default_keybindings
    set fish_cursor_default block
    set fish_cursor_visual block
    set fish_cursor_insert line
    set fish_cursor_external line

    # starship.rs
    starship init fish | source
end

function fish_greeting
    set_color ffffff
    echo Using (fish -v) as $USER on $hostname
end
