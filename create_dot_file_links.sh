#!/usr/bin/env bash

# Tanner Weber
# September 3, 2025

FILE="~/.dotfiles" # Where the cloned git repo is

# fish
ln -s ~/.dotfiles/fish/config.fish	~/.config/fish/config.fish
ln -s ~/.dotfiles/fish/fish_variables	~/.config/fish/fish_variables

# bash
ln -s ~/.dotfiles/.bash_profile		~/.bash_profile
ln -s ~/.dotfiles/.bashrc		~/.bashrc

# zsh
ln -s ~/.dotfiles/.zshrc		~/.zshrc
ln -s ~/.dotfiles/.zsh_profile		~/.zsh_profile

# starship
ln -s ~/.dotfiles/starship.toml		~/.config/starship.toml

# tmux
ln -s ~/.dotfiles/.tmux.conf		~/.tmux.conf

# vim
ln -s ~/.dotfiles/.vimrc		~/.vimrc

# nvim, neovim, lazy
ln -s ~/.dotfiles/lua/config/autocmds.lua	~/.config/nvim/lua/config/autocmds.lua
ln -s ~/.dotfiles/lua/config/keymaps.lua	~/.config/nvim/lua/config/keymaps.lua
ln -s ~/.dotfiles/lua/config/lazy.lua		~/.config/nvim/lua/config/lazy.lua
ln -s ~/.dotfiles/lua/config/options.lua	~/.config/nvim/lua/config/options.lua
ln -s ~/.dotfiles/lua/plugins/disabled.lua	~/.config/nvim/lua/plugins/disabled.lua

echo "Done linking"
