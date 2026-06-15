if status is-interactive
    # PATH
    fish_add_path $HOME/.local/bin/
    fish_add_path $HOME/.npm-global/bin/
    fish_add_path /usr/local/go/bin/
    fish_add_path $HOME/.local/nvim-linux-x86_64/bin/
    fish_add_path $HOME/.local/lua-language-server-3.15.0-linux-x64/bin/
    fish_add_path $HOME/.local/clangd_21.1.0/bin/
	fish_add_path $HOME/.opencode/bin

	# Environment Variables
	set -x EDITOR "nvim"
    set -x LS_COLORS "di=1;33:*.o=0;34:*.txt=01;31"

    source ~/.config/fish/abbrs.fish
    source ~/.config/fish/binds.fish
	source ~/.config/fish/my_completions.fish
    source ~/.config/fish/programs.fish
    source ~/.config/fish/greeting.fish
end
