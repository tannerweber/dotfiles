#!/usr/bin/env bash

# Tanner Weber
# July 29, 2025

# bash
ln -s ~/.dotfiles/.bash_profile		~/.bash_profile
ln -s ~/.dotfiles/.bashrc		~/.bashrc

# zsh
ln -s ~/.dotfiles/.zshrc		~/.zshrc
ln -s ~/.dotfiles/.zsh_profile		~/.zsh_profile

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
