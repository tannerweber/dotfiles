" .vimrc

let g:netrw_banner=0
let g:netrw_liststyle=3
set confirm
set colorcolumn=81
" set noshowmode
set shell='fish'
set mouse=a
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set cursorline
set guicursor="n-v-c:block-blinkwait1000-blinkon1000-blinkoff1,i-ci-ve:ver25-Cursor,r-cr-o:hor20"
set completeopt="fuzzy,menu,menuone,noinsert,noselect,popup,preview"
set termguicolors
set scrolloff=10
set ignorecase
set smartcase
set signcolumn="yes"
set list
set listchars="tab¬:trail:.nbsp:‚ê£"
set splitright
set splitbelow
set updatetime=250
set timeoutlen=300

set laststatus=2
set wrap
set cursorline
set showmatch
set hlsearch
set statusline=%F\ [%l/%L]\ [%p%%]\ %c	
set wildmenu
set wildmode=list:longest
set smartindent
set incsearch
set autowrite
colorscheme default
set background=dark
syntax match PointerOperator /[*&]/
highlight PointerOperator ctermfg=Yellow guifg=Orange
