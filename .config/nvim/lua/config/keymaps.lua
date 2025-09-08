-- Path ~/.config/nvim/lua/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Enter doesn't select from completion menu
map('i', '<ENTER>', function()
  if vim.fn.pumvisible() == 0 then
    return '<ENTER>'
  else
    print("VISIBLEDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
    return '<C-e>'
  end
end, { expr = true, noremap = true })

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', function() builtin.find_files({ hidden = false }) end, { desc = 'Telescope find files' })
map('n', '<leader>fh', function() builtin.find_files({ hidden = true }) end, { desc = 'Telescope find hidden files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>ft', builtin.help_tags, { desc = 'Telescope help tags' })
