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
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.autoformat = false
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.o.confirm = true
vim.o.colorcolumn = '81'
vim.o.showmode = false
vim.o.shell = 'fish'
vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.guicursor =
  'n-v-c-sm:block-blinkwait1000-blinkon1000-blinkoff1,i-ci-ve:ver25-Cursor,r-cr-o:hor20'
vim.o.completeopt = 'fuzzy,menu,menuone,noinsert,noselect,popup,preview'
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '.', nbsp = '␣' }
vim.o.winborder = 'rounded'

vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('20Lexplore')
end, { desc = 'Lexplore' })

-- Clipboard
vim.o.clipboard = 'unnamedplus'

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = vim.fn.getreg('+'),
    ['*'] = vim.fn.getreg('*'),
  },
}

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
        vim.keymap.set('n', '<leader>H', function()
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
      config = function()
        local gitsigns = require('gitsigns')
        vim.keymap.set('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'git [s]tage hunk' })
        vim.keymap.set('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'git [r]eset hunk' })
        vim.keymap.set(
          'n',
          '<leader>hs',
          gitsigns.stage_hunk,
          { desc = 'git [s]tage hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hr',
          gitsigns.reset_hunk,
          { desc = 'git [r]eset hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hS',
          gitsigns.stage_buffer,
          { desc = 'git [S]tage buffer' }
        )
        vim.keymap.set(
          'n',
          '<leader>hu',
          gitsigns.stage_hunk,
          { desc = 'git [u]ndo stage hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hR',
          gitsigns.reset_buffer,
          { desc = 'git [R]eset buffer' }
        )
        vim.keymap.set(
          'n',
          '<leader>hp',
          gitsigns.preview_hunk,
          { desc = 'git [p]review hunk' }
        )
        vim.keymap.set(
          'n',
          '<leader>hb',
          gitsigns.blame_line,
          { desc = 'git [b]lame line' }
        )
        vim.keymap.set(
          'n',
          '<leader>hd',
          gitsigns.diffthis,
          { desc = 'git [d]iff against index' }
        )
        vim.keymap.set('n', '<leader>hD', function()
          gitsigns.diffthis('@')
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        vim.keymap.set(
          'n',
          '<leader>tb',
          gitsigns.toggle_current_line_blame,
          { desc = '[T]oggle git show [b]lame line' }
        )
        vim.keymap.set(
          'n',
          '<leader>tD',
          gitsigns.preview_hunk_inline,
          { desc = '[T]oggle git show [D]eleted' }
        )
      end,
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
          'pylsp',
          'rust_analyzer',
          'fish_lsp',
          'bashls',
          'clojure_lsp',
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
        vim.diagnostic.config({
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = ' ',
              [vim.diagnostic.severity.WARN] = ' ',
              [vim.diagnostic.severity.HINT] = ' ',
              [vim.diagnostic.severity.INFO] = ' ',
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
    --------------------------------------------- Tokyonight -------------------
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
    --------------------------------------------- Treesitter -------------------
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
          'kdl',
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
      'nvim-treesitter/nvim-treesitter-context',
      lazy = false,
    },
    {
      'HiPhish/rainbow-delimiters.nvim',
      submodules = false,
    },
    --------------------------------------------- Trouble ----------------------
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
      '<leader>q',
      vim.diagnostic.setloclist,
      { desc = 'Quickfix list' }
    )
    vim.keymap.set(
      'n',
      '<leader>df',
      vim.diagnostic.open_float,
      { desc = 'Open floating diagnostics' }
    )
    vim.keymap.set(
      'n',
      '<leader>cf',
      vim.lsp.buf.format,
      { desc = 'Format code with LSP' }
    )
    vim.keymap.set('n', '<leader>dl', function()
      local new_config = not vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({ virtual_lines = new_config })
    end, { desc = 'Toggle virtual lines' })
    vim.keymap.set('n', '<leader>dt', function()
      if vim.diagnostic.config().virtual_text ~= false then
        vim.diagnostic.config({ virtual_text = false })
      else
        vim.diagnostic.config({
          virtual_text = {
            spacing = 4,
            source = 'if_many',
            prefix = '●',
          },
        })
      end
    end, { desc = 'Toggle virtual text' })
  end,
})
