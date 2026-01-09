#!/usr/bin/env fish
# Tanner Weber

set src_repo $HOME'/.dotfiles' # Where the cloned git repo is

function symlink -a src dest
	set overwrite 'n'
	ln -s $src $dest
	if test $status -ne 0
		echo 'Overwrite destination? (y/n)'
		read overwrite
		if test $overwrite = 'y'
			echo 'Overwriting'
			ln -sf $src $dest
			if test $status -eq 0
				echo 'Linked successfully'
			end
		else
			set_color red
			echo 'Not overwriting'
			set_color normal
		end
	else
		set_color green
		echo -n 'Linked successfully: '
		echo $dest
		set_color normal
	end
end

# fish
symlink $src_repo/.config/fish/config.fish	~/.config/fish/config.fish
symlink $src_repo/.config/fish/my_completions.fish	~/.config/fish/my_completions.fish

# bash
symlink $src_repo/.bashrc			~/.bashrc

# zsh
symlink $src_repo/.zshrc			~/.zshrc

# starship
symlink $src_repo/.config/starship.toml		~/.config/starship.toml

# tmux
symlink $src_repo/.tmux.conf					~/.tmux.conf
symlink $src_repo/.local/bin/tmux-sessionizer	~/.local/bin/tmux-sessionizer

# vim
symlink $src_repo/.vimrc	~/.vimrc

# nvim, neovim, lazy
symlink $src_repo/.config/nvim/init.lua ~/.config/nvim/init.lua

echo 'Done linking'
