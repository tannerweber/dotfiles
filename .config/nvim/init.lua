-- Tanner Weber
-- ~/.config/nvim/init.lua
-- github.com/folke/lazy.nvim
-- lazy.folke.io/installation
-- Single File Setup

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "	-- Space leader
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false

vim.keymap.set("i", "jj", "<ESC>", { silent = true })

vim.g.clipboard = 'tmux'
vim.g.autoformat = false
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.mouse = 'nvi'
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.cursorline = true
vim.o.guicursor = "n-v-c-sm:block-blinkwait1000-blinkon1000-blinkoff1,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
vim.opt.completeopt = "fuzzy,menu,menuone,noinsert,noselect,popup,preview"
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.signcolumn =  "yes:1"
vim.opt.list = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "Saghen/blink.cmp",
      dependencies = { 'rafamadriz/friendly-snippets' },
    },
    {
      "akinsho/bufferline.nvim",
      lazy = true,
    },
    --------------------------------------------- Harpoon ---------------------
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
	local harpoon = require("harpoon")
        harpoon:setup() -- Required
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Harpoon add' })
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon list' })
        vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
      end
    },
    --------------------------------------------- Git Signs -------------------
    {
      "lewis6991/gitsigns.nvim",
    },
    --------------------------------------------- LSP -------------------------
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
	ensure_installed = {
	  "lua_ls",
	},
      },
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
	{
	  'saghen/blink.cmp',
	  dependences = { 'rafamadriz/friendly-snippets' },
	  version = '1.6',
	  opts = {
	    keymap = { preset = 'default' },
	    fuzzy = { implementation = "lua" },
	    sources = {
	      default = { "lazydev", "lsp", "path", "snippets", "buffer", },
	      providers = {
		lazydev = {
		  name = "LazyDev",
                  module = "lazydev.integrations.blink",
                  -- make lazydev completions top priority (see `:h blink.cmp`)
                  score_offset = 100,
		},
	      },
	    },
	  },
	},
	{
	  "folke/lazydev.nvim",
	  ft = "lua",
	},
      },
      diagnostics = {
	underline = true,
	virtual_text = {
	  spacing = 4,
	  source = "if_many",
	  prefix = "●",
	},
	severity_sort = true,
      },
      config = function()
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP definition" })
      end
    },
    --------------------------------------------- Lua Line --------------------
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      --event = "VeryLazy",
      lazy = false,
      options = {
	theme = 'ayu_mirage'
      },
      config = function()
	require('lualine').setup({
	  sections = {
	  lualine_a = {'mode'},
	  lualine_b = {'branch','diff','diagnostics'},
	  lualine_c = {
	    {'filename', show_filename_only = false, path = 3},
          },
	  lualine_x = {'lsp_status','encoding','fileformat','filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'},
          },
	})
      end,
    },
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    --------------------------------------------- Snacks ----------------------
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.config
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
	    header = [[
	                                                                       
	          ████ ██████           █████      ██                    
	         ███████████             █████                            
	         █████████ ███████████████████ ███   ███████████  
	        █████████  ███    █████████████ █████ ██████████████  
	       █████████ ██████████ █████████ █████ █████ ████ █████  
	     ███████████ ███    ███ █████████ █████ █████ ████ █████ 
	    ██████  █████████████████████ ████ █████ █████ ████ ██████
	    ]],
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
        --{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      },
      --[[
        https://neovim.io/doc/user/lsp.html
        "grn" is mapped in Normal mode to vim.lsp.buf.rename()
        "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
        "grr" is mapped in Normal mode to vim.lsp.buf.references()
        "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
        "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
        "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
        CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
      ]]--
    },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
	vim.cmd([[colorscheme tokyonight-night]])
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      priority = 900,
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
    },
    {
      "folke/trouble.nvim",
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
    },
    {
      "folke/which-key.nvim",
      lazy = false,
      event = "VeryLazy",
      opts = {
	preset = "helix",
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

------------------------------------------------- Auto Commands ---------------
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
