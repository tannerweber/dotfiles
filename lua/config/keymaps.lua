-- Path ~/.config/nvim/lua/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map('i', '<ENTER>', function()
  if vim.fn.pumvisible() == 0 then
    return '<ENTER>'
  else
    print("VISIBLEDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
    return '<C-e>'
  end
end, { expr = true, noremap = true })
