-- Tanner Weber
-- ~/.config/nvim/init.lua
-- github.com/folke/lazy.nvim
-- lazy.folke.io/installation
-- Single File Setup

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.inccommand = 'split'

local function mf(keys, func, desc)
  vim.keymap.set('n', keys, function()
    func()
  end, { desc = desc })
end

local function ml(keys, command, desc)
  vim.keymap.set('n', '<leader>' .. keys, command, { desc = desc })
end

local function mlf(keys, func, desc)
  vim.keymap.set('n', '<leader>' .. keys, function()
    func()
  end, { desc = desc })
end

vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })
vim.keymap.set('i', 'kk', '<ESC>', { silent = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
ml('e', ':20Lexplore<cr>', 'Lexplore')
mlf('q', vim.diagnostic.setloclist, 'Quickfix list')
mlf('df', vim.diagnostic.open_float, 'Open floating diagnostics')
mlf('cf', vim.lsp.buf.format, 'Format code with LSP')

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

---------------------------------------- Clipboard -----------------------------
-- if vim.uv.os_uname().sysname == 'Linux' then
if true then
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
end

vim.keymap.set({ 'n', 'v' }, 'y', '""y')
vim.keymap.set({ 'n', 'v' }, 'p', '""p')
vim.keymap.set({ 'n', 'v' }, 'd', '""d')
ml('y', '"+y', 'Yank to + register')
ml('p', '"+p', 'Paste from + register')
ml('d', '"+d', 'Delete to + register')
---------------------------------------- Lazy ----------------------------------
require('lazy').setup({
  spec = {
    {
      'nvim-mini/mini.pairs',
      config = function()
        require('mini.pairs').setup()
      end,
    },
    {
      'nvim-mini/mini.ai',
      config = function()
        require('mini.ai').setup()
      end,
    },
    ---------------------------------------- Database --------------------------
    {
      'kristijanhusak/vim-dadbod-ui',
      dependencies = {
        { 'tpope/vim-dadbod' },
        {
          'kristijanhusak/vim-dadbod-completion',
          ft = { 'sql', 'mysql', 'plsql' },
        },
      },
      cmd = {
        'DBUI',
      },
      init = function()
        vim.g.db_ui_use_nerd_fonts = 1
      end,
    },
    ---------------------------------------- Harpoon ---------------------------
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
    ---------------------------------------- Git Signs -------------------------
    {
      'lewis6991/gitsigns.nvim',
      lazy = false,
      config = function()
        local gitsigns = require('gitsigns')
        vim.keymap.set('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'git stage hunk' })
        vim.keymap.set('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'git reset hunk' })
        mlf('hs', gitsigns.stage_hunk, 'git stage hunk')
        mlf('hr', gitsigns.reset_hunk, 'git reset hunk')
        mlf('hS', gitsigns.stage_buffer, 'git Stage buffer')
        mlf('hu', gitsigns.stage_hunk, 'git undo stage hunk')
        mlf('hR', gitsigns.reset_buffer, 'git Reset buffer')
        mlf('hp', gitsigns.preview_hunk, 'git preview hunk')
        mlf('hb', gitsigns.blame_line, 'git blame line')
        mlf('hd', gitsigns.diffthis, 'git diff against index')
        ml('hD', ":lua require('gitsigns').diffthis('@')<cr>", 'Diff commit')
        mlf('gb', gitsigns.toggle_current_line_blame, 'git show blame line')
        mlf('gD', gitsigns.preview_hunk_inline, 'git show Deleted')
      end,
    },
    ---------------------------------------- LSP -------------------------------
    {
      'neovim/nvim-lspconfig',
      lazy = false,
      dependencies = {
        {
          'saghen/blink.cmp',
          dependences = {
            'rafamadriz/friendly-snippets',
          },
          version = '1.8',
          opts = {
            keymap = {
              ['<C-l>'] = { 'accept' },
            },
            sources = {
              per_filetype = {
                sql = { 'snippets', 'dadbod', 'buffer' },
              },
              providers = {
                dadbod = {
                  name = 'Dadbod',
                  module = 'vim_dadbod_completion.blink',
                },
              },
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
          'nixd',
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
    ---------------------------------------- Snacks ----------------------------
    {
      'folke/snacks.nvim',
      opts = {
        animate = { duration = 10, fps = 144 },
        bigfile = { enabled = true },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true, timeout = 10000 },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      },
      init = function()
        require('snacks')
        mlf('fa', Snacks.picker.smart, 'Find All Files')
        mlf('fb', Snacks.picker.buffers, 'Buffers')
        mlf('ff', Snacks.picker.files, 'Find Project Files')
        mlf('fg', Snacks.picker.grep, 'Grep')
        mlf('fd', Snacks.picker.diagnostics, 'Diagnostics')
        mlf('fD', Snacks.picker.diagnostics_buffer, 'Buffer Diagnostics')
        mlf('fh', Snacks.picker.help, 'Help Pages')
        mf('gd', Snacks.picker.lsp_definitions, 'Goto Definition')
        mf('gD', Snacks.picker.lsp_declarations, 'Goto Declaration')
        mf('gI', Snacks.picker.lsp_implementations, 'Goto Implementation')
        mf('gy', Snacks.picker.lsp_type_definitions, 'Goto T[y]pe Definition')
      end,
    },
    ---------------------------------------- Tokyonight ------------------------
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
      init = function()
        vim.cmd.colorscheme('tokyonight-night')
      end,
    },
    ---------------------------------------- Treesitter ------------------------
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
          'typst',
          'yaml',
          'xml',
          'vim',
          'vimdoc',
        },
      },
      -- config = function()
      --   vim.api.nvim_create_autocmd('FileType', {
      --     pattern = { 'bash', 'c', 'fish', 'kdl', 'lua', 'python', 'rust' },
      --     callback = function()
      --       vim.treesitter.start()
      --     end,
      --   })
      -- end,
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      lazy = false,
    },
    {
      'HiPhish/rainbow-delimiters.nvim',
      lazy = false,
      submodules = false,
    },
    ---------------------------------------- Trouble ---------------------------
    {
      'folke/trouble.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {},
      cmd = 'Trouble',
      init = function()
        ml('xx', ':Trouble diagnostics toggle<cr>', 'Diagnostics (Trouble)')
        ml('xX', ':Trouble diagnostics toggle filter.buf=0<cr>', 'Buf Diagnost')
        ml('xL', ':Trouble loclist toggle<cr>', 'Location List (Trouble)')
        ml('xQ', ':Trouble qflist toggle<cr>', 'Quickfix List (Trouble)')
        ml('cs', ':Trouble symbols toggle focus=false<cr>', 'Symbols (Trouble)')
        ml('cl', ':Trouble lsp toggle focus=false win.position=right<cr>', 'LS')
      end,
    },
    ---------------------------------------- Which Key -------------------------
    {
      'folke/which-key.nvim',
      lazy = false,
      event = 'VeryLazy',
      opts = {
        preset = 'helix',
      },
    },
  },
  install = { colorscheme = { 'tokyonight' } },
  checker = { enabled = true },
})

---------------------------------------- Auto Commands -------------------------
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})
---------------------------------------- Status Line ---------------------------
function CustomStatusLine()
  -- Tokyonight colors
  local colors = {
    black = '#000000',
    blue = '#7aa2f7',
    blue7 = '#394b70',
    orange = '#ff9e64',
    purple = '#9d7cd8',
    teal = '#1abc9c',
    yellow = '#e0af68',
    git_add = '#449dab',
    git_change = '#6183bb',
    git_delete = '#914c54',
  }

  vim.api.nvim_set_hl(0, 'MyModeNormal', {
    fg = colors.black,
    bg = colors.blue,
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'MyModeInsert', {
    fg = colors.black,
    bg = colors.orange,
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'MyModeVisual', {
    fg = colors.black,
    bg = colors.purple,
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'MyModeCommmand', {
    fg = colors.black,
    bg = colors.yellow,
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'MyModeOther', {
    fg = colors.black,
    bg = colors.teal,
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'MyGitAdded', { fg = colors.git_add })
  vim.api.nvim_set_hl(0, 'MyGitChanged', { fg = colors.git_change })
  vim.api.nvim_set_hl(0, 'MyGitRemoved', { fg = colors.git_delete })
  vim.api.nvim_set_hl(0, 'MyFileInfo', { fg = '#dddddd', bg = colors.blue7 })

  local function set_hl(group, text)
    return string.format('%%#%s#%s%%*', group, text)
  end

  local function get_formatted_mode()
    local m = {
      ['n'] = '%#MyModeNormal# NORMAL %*',
      ['i'] = '%#MyModeInsert# INSERT %*',
      ['v'] = '%#MyModeVisual# VISUAL %*',
      ['V'] = '%#MyModeVisual# V-LINE %*',
      ['\22'] = '%#MyModeVisual# V-BlOCK %*',
      ['c'] = '%#MyModeCommmand# COMMAND %*',
      ['s'] = '%#MyModeOther# S-CHAR %*',
      ['S'] = '%#MyModeOther# S-LINE %*',
      ['R'] = '%#MyModeOther# REPLACE %*',
      ['r'] = '%#MyModeOther# HIT-ENTER %*',
    }
    return m[vim.fn.mode()]
  end

  local function get_git_head()
    if not vim.b.gitsigns_head then
      return ''
    else
      return vim.b.gitsigns_head
    end
  end

  local function get_git_text(type, symbol)
    local g = vim.b.gitsigns_status_dict

    if not g or not symbol or not type or not g[type] then
      return ''
    end

    local text = ''
    if g[type] ~= 0 then
      text = symbol .. g[type] .. ' '
    end

    return text
  end

  local function get_formatted_git()
    return table.concat({
      '  ',
      get_git_head(),
      ' ',
      set_hl('MyGitAdded', get_git_text('added', '+')),
      set_hl('MyGitChanged', get_git_text('changed', '~')),
      set_hl('MyGitRemoved', get_git_text('removed', '-')),
      '',
    })
  end

  local function get_diag_text(type)
    local text = ''
    local count = vim.diagnostic.count(0)
    if count[vim.diagnostic.severity[type]] ~= nil then
      text = vim.diagnostic.config().signs.text[vim.diagnostic.severity[type]]
        .. count[vim.diagnostic.severity[type]]
        .. ' '
    end
    return text
  end

  local function get_formatted_diagnostics()
    return table.concat({
      ' ',
      set_hl('DiagnosticError', get_diag_text('ERROR')),
      set_hl('DiagnosticWarn', get_diag_text('WARN')),
      set_hl('DiagnosticInfo', get_diag_text('INFO')),
      set_hl('DiagnosticHint', get_diag_text('HINT')),
      ' ',
    })
  end

  local function get_formatted_lsp()
    local clients = vim.lsp.get_clients({
      bufnr = vim.api.nvim_get_current_buf(),
    })
    local client_names = ''
    for _, client in ipairs(clients) do
      client_names = client_names .. ' ' .. client.name
    end
    return table.concat({
      client_names,
      ' ',
    })
  end

  local function get_formatted_file_info()
    return table.concat({
      '%#MyFileInfo# ',
      vim.bo.filetype,
      ' ',
      vim.bo.fileformat,
      ' ',
      vim.opt.fileencoding:get(),
      ' %*',
    })
  end

  return table.concat({
    get_formatted_mode(),
    get_formatted_git(),
    get_formatted_diagnostics(),
    vim.fn.expand('%:p:~'), -- File name and path
    ' %m', -- File modified symbol
    '%=', -- Separate left and right side
    get_formatted_lsp(),
    get_formatted_file_info(),
    set_hl('MyModeNormal', ' %P %l:%c '),
  })
end

vim.api.nvim_create_autocmd({
  'WinEnter',
  'BufEnter',
  'BufWritePost',
  'SessionLoadPost',
  'FileChangedShellPost',
  'VimResized',
  'Filetype',
  'CursorMoved',
  'CursorMovedI',
  'ModeChanged',
}, {
  desc = 'CustomStatusline',
  callback = function()
    vim.opt_local.statusline = '%!v:lua.CustomStatusLine()'
  end,
})

--------------------------------------- Filetype Fix ---------------------------
vim.api.nvim_create_autocmd({
  'BufNewFile',
  'BufRead',
}, {
  desc = 'SetTPPFileType',
  pattern = '*.tpp',
  callback = function()
    vim.bo.filetype = 'cpp'
  end,
})
