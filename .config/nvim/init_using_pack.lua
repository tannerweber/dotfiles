-- Tanner Weber
-- ~/.config/nvim/init.lua

vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim.git", name = "tokyonight" },
  { src = "https://github.com/akinsho/bufferline.nvim.git" },
  { src = "https://github.com/ThePrimeagen/harpoon.git" },
  { src = "https://github.com/lewis6991/gitsigns.nvim.git" },
  { src = "https://github.com/nvim-lua/plenary.nvim.git" },
  { src = "https://github.com/folke/lazydev.nvim.git" },
  { src = "https://github.com/folke/trouble.nvim.git" },
  { src = "https://github.com/folke/which-key.nvim.git" },
  { src = "https://github.com/folke/snacks.nvim.git" },
  { src = "https://github.com/neovim/nvim-lspconfig.git" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/mason-org/mason.nvim.git" },
  { src = "https://github.com/neovim/nvim-lspconfig.git" },
  { src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
  { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
})

-------------------------------------------------------------------------------
vim.g.mapleader = " "	-- Space leader
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false

vim.cmd("colorscheme tokyonight-night")
vim.g.clipboard = 'tmux'
vim.opt.mouse = 'nvi'
vim.opt.number = true
vim.opt.wrap = true
vim.opt.relativenumber = true
vim.g.autoformat = false
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
vim.opt.completeopt = "fuzzy,menu,menuone,noinsert,noselect,popup,preview"
vim.opt.termguicolors = true
-------------------------------------------------------------------------------

require('plenary').setup {
}

require('bufferline').setup {
}

--require('harpoon').setup {
--}
local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Harpoon add' })
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon list' })
vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)


require('gitsigns').setup {
}

require('lazydev').setup {
  ft = "lua",
}

require('lualine').setup {
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  options = {
    theme = 'ayu_mirage'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch','diff','diagnostics'},
    lualine_c = {
      {'filename', show_filename_only = false, path = 3}
    },
    lualine_x = {'lsp_status','encoding','fileformat','filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
}

require('mason').setup {
}

require('snacks').setup {
  opts = {
    animate = { duration = 10, fps = 144, },
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
	keys = {
	  { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.smart()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "u", desc = "Help poor children in Uganda!", action = ":help iccf" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
	},
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true , timeout = 10000, },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = {
      win = {
	keys = {
	  --nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
          --nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
          --nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
          --nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
	},
      },
    },
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
  },
}
vim.keymap.set('n', "<leader>ff", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })

require('tokyonight').setup {
}

require('nvim-treesitter.configs').setup {
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "lua",
      "luadoc",
      "luap",
      "python",
      "toml",
      "yaml",
      "xml",
      "vim",
      "vimdoc",
    },
  },
}

require('trouble').setup {
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)", },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)", },
  },
}

require('which-key').setup {
  opts = {
    preset = "helix",
  },
}
