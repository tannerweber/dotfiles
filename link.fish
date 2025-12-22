#!/usr/bin/env fish
# Tanner Weber

set src_repo '~/.dotfiles' # Where the cloned git repo is

function symlink -a src dest
	set overwrite 'n'
	ln -s $src $dest
	if test $status -ne 0
		echo 'File already exists at destination'
		echo 'Overwrite? (y/n)'
		read overwrite
		if test $overwrite = 'y'
			echo 'Overwriting'
			ln -sf $src $dest
			if test $status -eq 0
				echo 'Linked successfully'
			end
		else
			echo 'Not overwriting'
		end
	else
		echo 'Linked successfully'
	end
end

# fish
symlink $src_repo/.config/fish/config.fish	~/.config/fish/config.fish
symlink $src_repo/.config/fish/fish_variables	~/.config/fish/fish_variables

# bash
symlink $src_repo/.bash_profile		~/.bash_profile
symlink $src_repo/.bashrc			~/.bashrc

# zsh
symlink $src_repo/.zshrc			~/.zshrc
symlink $src_repo/.zsh_profile		~/.zsh_profile

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
