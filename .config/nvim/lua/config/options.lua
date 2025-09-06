-- Path ~/.config/nvim/lua/config/options.lua
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false

vim.g.clipboard = 'tmux'

vim.opt.relativenumber = true

vim.g.autoformat = false

vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"

-- Completion
vim.opt.completeopt = "fuzzy,menu,menuone,noinsert,noselect,popup,preview"
