-- Tanner Weber
-- ~/.config/nvim/init.lua
-- github.com/folke/lazy.nvim
-- lazy.folke.io/installation
-- Single File Setup

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' ' -- Space leader
vim.g.maplocalleader = '\\'
vim.g.clipboard = 'tmux'
vim.g.autoformat = false
vim.g.netrw_banner = 0

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.relativenumber = true
vim.o.colorcolumn = '81'
vim.o.cursorline = true
vim.o.guicursor =
  'n-v-c-sm:block-blinkwait1000-blinkon1000-blinkoff1,i-ci-ve:ver25-Cursor,r-cr-o:hor20'
vim.o.completeopt = 'fuzzy,menu,menuone,noinsert,noselect,popup,preview'
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.ignorecase = true
vim.o.signcolumn = 'yes:1'
vim.o.list = true
vim.o.winborder = 'rounded'

vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('20Lexplore')
end, { desc = 'Lexplore' })

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    {
      'nvim-mini/mini.pairs',
      version = '*',
      config = function()
        require('mini.pairs').setup()
      end,
    },
    --------------------------------------------- Harpoon ---------------------
    {
      'ThePrimeagen/harpoon',
      branch = 'harpoon2',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
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
            harpoon:list():select(i)
          end, { desc = '󱡅 Harpoon to ' .. i })
          vim.keymap.set({ 'n', 'v' }, leader, function()
            harpoon:list():select(i)
          end, { desc = '󱡅 Harpoon to ' .. i })
        end
      end,
    },
    --------------------------------------------- Git Signs -------------------
    {
      'lewis6991/gitsigns.nvim',
    },
    --------------------------------------------- LSP -------------------------
    {
      'neovim/nvim-lspconfig',
      lazy = false,
      dependencies = {
        {
          'saghen/blink.cmp',
          dependences = {
            'rafamadriz/friendly-snippets',
          },
          version = '1.6',
          opts = {
            keymap = {
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
          },
        },
      },
      config = function()
        vim.lsp.enable({
          'lua_ls',
          'stylua',
          'clangd',
          'pyright',
          'rust_analyzer',
          'fish_lsp',
          'bashls',
        })
        vim.lsp.config('lua_ls', {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        })
      end,
    },
    --------------------------------------------- Lua Line --------------------
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      --event = "VeryLazy",
      lazy = false,
      options = {
        theme = 'ayu_mirage',
      },
      config = function()
        require('lualine').setup({
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
      end,
    },
    --------------------------------------------- Snacks ----------------------
    {
      'folke/snacks.nvim',
      priority = 1000,
      lazy = false,
      opts = {
        animate = { duration = 10, fps = 144 },
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true, timeout = 10000 },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        zen = { enabled = false },
      },
      keys = {
        {
          '<leader>fa',
          function()
            Snacks.picker.smart()
          end,
          desc = 'Find All Files',
        },
        {
          '<leader>fb',
          function()
            Snacks.picker.buffers()
          end,
          desc = 'Buffers',
        },
        {
          '<leader>ff',
          function()
            local cwd = vim.fn.getcwd()
            Snacks.picker.files({ cwd = cwd })
          end,
          desc = 'Find Project Files',
        },
        {
          '<leader>fg',
          function()
            Snacks.picker.grep()
          end,
          desc = 'Grep',
        },
        {
          'gd',
          function()
            Snacks.picker.lsp_definitions()
          end,
          desc = 'Goto Definition',
        },
        {
          'gD',
          function()
            Snacks.picker.lsp_declarations()
          end,
          desc = 'Goto Declaration',
        },
        {
          'gI',
          function()
            Snacks.picker.lsp_implementations()
          end,
          desc = 'Goto Implementation',
        },
        {
          'gy',
          function()
            Snacks.picker.lsp_type_definitions()
          end,
          desc = 'Goto T[y]pe Definition',
        },
        {
          '<leader>fd',
          function()
            Snacks.picker.diagnostics()
          end,
          desc = 'Diagnostics',
        },
        {
          '<leader>fD',
          function()
            Snacks.picker.diagnostics_buffer()
          end,
          desc = 'Buffer Diagnostics',
        },
        {
          '<leader>fh',
          function()
            Snacks.picker.help()
          end,
          desc = 'Help Pages',
        },
      },
    },
    {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      opts = {
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
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
    },
    {
      'folke/trouble.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {},
      cmd = 'Trouble',
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
    },
    {
      'folke/which-key.nvim',
      lazy = false,
      event = 'VeryLazy',
      opts = {
        preset = 'helix',
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'tokyonight' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

------------------------------------------------- Colorscheme -----------------
vim.cmd.colorscheme('tokyonight-night')

------------------------------------------------- Auto Commands ---------------
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.keymap.set(
      'n',
      '<leader>cf',
      vim.lsp.buf.format,
      { desc = 'Format code with LSP' }
    )
  end,
})
