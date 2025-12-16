-- Tanner Weber
-- ~/.config/nvim/init.lua

vim.pack.add({
  { src = 'https://github.com/folke/tokyonight.nvim.git', name = 'tokyonight' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons.git' },
  { src = 'https://github.com/nvim-lua/plenary.nvim.git' },
  {
	src = 'https://github.com/ThePrimeagen/harpoon.git',
	version = 'harpoon2',
	name = 'harpoon',
  },
  { src = 'https://github.com/lewis6991/gitsigns.nvim.git' },
  { src = 'https://github.com/folke/lazydev.nvim.git' },
  { src = 'https://github.com/folke/trouble.nvim.git' },
  { src = 'https://github.com/folke/which-key.nvim.git' },
  { src = 'https://github.com/folke/snacks.nvim.git' },
  { src = 'https://github.com/neovim/nvim-lspconfig.git' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter.git' },
  { src = 'https://github.com/Saghen/blink.cmp.git', version = 'v1.6.0' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim.git' },
  { src = 'https://github.com/nvim-mini/mini.pairs.git' },
})

vim.g.mapleader = ' ' -- Space leader
vim.g.maplocalleader = '\\'

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false

vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('20Lexplore')
end, { desc = 'Lexplore' })

vim.g.clipboard = 'tmux'
vim.g.autoformat = false
vim.g.netrw_banner = 0
vim.o.relativenumber = true
vim.o.colorcolumn = '81'
vim.o.mouse = 'nvi'
vim.o.autoindent = true
vim.o.number = true
vim.o.cursorline = true
vim.o.guicursor = 'n-v-c-sm:block-blinkwait1000-blinkon1000-blinkoff1,i-ci-ve:ver25-Cursor,r-cr-o:hor20'
vim.o.completeopt = 'fuzzy,menu,menuone,noinsert,noselect,popup,preview'
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.ignorecase = true
vim.o.signcolumn = 'yes:1'
vim.o.list = true
vim.o.winborder = 'rounded'

--------------------------------------------- Mini Pairs -----------------------
require('mini.pairs').setup()
--------------------------------------------- Harpoon --------------------------
local harpoon = require('harpoon')
harpoon:setup() -- Required

vim.keymap.set('n', '<C-a>', function()
  harpoon:list():add()
end, { desc = 'Harpoon add' })
vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end, { desc = 'Harpoon add' })

vim.keymap.set('n', '<C-h>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon list' })
vim.keymap.set('n', '<leader>h', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon list' })

for i = 1, 9 do
  local ctrl = string.format('<C-%d>', i)
  local leader = string.format('<leader>%d', i)
  vim.keymap.set({ 'n', 'i', 'v' }, ctrl, function()
    harpoon.list():select(i)
  end, { desc = '󱡅 Harpoon to ' .. i })
  vim.keymap.set({ 'n', 'v' }, leader, function()
    harpoon.list():select(i)
  end, { desc = '󱡅 Harpoon to ' .. i })
end
--------------------------------------------- Git Signs ------------------------
require('gitsigns').setup()
--------------------------------------------- LSP ------------------------------
require('lazydev').setup({
  ft = 'lua', -- only load on lua files
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
})
require('blink.cmp').setup({
  'saghen/blink.cmp',
  dependences = {
    'rafamadriz/friendly-snippets',
    'folke/lazydev.nvim',
  },
  version = '1.6',
  opts = {
    keymap = {
      preset = 'default',
      ['<C-l>'] = { 'accept' },
    },
    fuzzy = {
      implementation = 'lua',
      sorts = {
        'score',
        'sort_text',
        'label',
      },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  },
})
vim.lsp.enable({
  'lua_ls',
  'stylua',
  'clangd',
  'pyright',
  'rust_analyzer',
  'fish_lsp',
  'bashls',
})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP definition' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format code with LSP' })
--------------------------------------------- Lua Line -------------------------
require('lualine').setup({
  options = {
    theme = 'ayu_mirage',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      { 'filename', show_filename_only = false, path = 3 },
    },
    lualine_x = { 'lsp_status', 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})
--------------------------------------------- Snacks ---------------------------
require('snacks').setup({
    animate = { duration = 10, fps = 144 },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    picker = { enabled = true },
    notifier = { enabled = true, timeout = 10000 },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = false },
})
vim.keymap.set('n', '<leader>ff', function()
    Snacks.picker.smart()
end, { desc = 'Smart Find Files' })
vim.keymap.set('n', '<leader>fg', function()
  Snacks.picker.grep()
end, { desc = 'Grep' })
vim.keymap.set('n', 'gd', function()
  Snacks.picker.lsp_definitions()
end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function()
  Snacks.picker.lsp_declarations()
end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gI', function()
  Snacks.picker.lsp_implementations()
end, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'gy', function()
    Snacks.picker.lsp_type_definitions()
end, { desc = 'Goto T[y]pe Definition' })

--------------------------------------------- Colorscheme ----------------------
require('tokyonight').setup({
  transparent = true,
  styles = {
    sidebars = 'transparent',
    floats = 'transparent',
  },
})
vim.cmd.colorscheme('tokyonight-night')
--------------------------------------------- Treesitter -----------------------
require('nvim-treesitter').setup({
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      'bash',
      'c',
      'fish',
      'lua',
      'luadoc',
      'luap',
      'nu',
      'python',
      'rust',
      'toml',
      'yaml',
      'xml',
      'vim',
      'vimdoc',
    },
  },
})
--------------------------------------------- Trouble --------------------------
require('trouble').setup({
  cmd = "Trouble",
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
})
--------------------------------------------- Which Key ------------------------
require('which-key').setup({
  preset = 'helix',
})
------------------------------------------------- Auto Commands ----------------
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})
