colorscheme evening

syntax match PointerOperator /[*&]/
highlight PointerOperator ctermfg=Yellow guifg=Orange

set number		"shows line numbers
"set relativenumber
"set laststatus=2
"set wrap				"Enables line wrapping
set cursorline
"set showcmd
"set showmode
"set showmatch			"Highlights matching parentheses
"set hlsearch
"set colorcolumn=80		Highlights long lines
set statusline=%F\ [%l/%L]\ [%p%%]\ %c	" Display line and column numbers in the status line

"set wildmenu
"set wildmode=list:longest

"set smartindent
"set tabstop=4
"set shiftwidth=2
"set expandtab=false

"set incsearch      "Incremental search
"set autowrite      "Automatically save before commands like :next and :make
"set mouse=a       "Enable mouse usage (all modes)

"set hidden     		Hide buffers when they are abandoned
"set ignorecase     	Do case insensitive matching
"set smartcase      	Do smart case matching
"set background=dark	Lightens up text
