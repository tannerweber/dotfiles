#!/usr/bin/env bash

# Tanner Weber
# July 29, 2025

# bash
ln -s ~/dot-files/.bash_profile		~/.bash_profile
ln -s ~/dot-files/.bashrc		~/.bashrc

# zsh
ln -s ~/dot-files/.zshrc		~/.zshrc
ln -s ~/dot-files/.zsh_profile		~/.zsh_profile

# tmux
ln -s ~/dot-files/.tmux.conf		~/.tmux.conf

# vim
ln -s ~/dot-files/.vimrc		~/.vimrc

# nvim, neovim, lazy
ln -s ~/dot-files/lua/config/autocmds.lua	~/.config/nvim/lua/config/autocmds.lua
ln -s ~/dot-files/lua/config/keymaps.lua	~/.config/nvim/lua/config/keymaps.lua
ln -s ~/dot-files/lua/config/lazy.lua		~/.config/nvim/lua/config/lazy.lua
ln -s ~/dot-files/lua/config/options.lua	~/.config/nvim/lua/config/options.lua
ln -s ~/dot-files/lua/plugins/disabled.lua	~/.config/nvim/lua/plugins/disabled.lua

echo "Done linking"
