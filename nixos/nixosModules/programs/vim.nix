{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    myModVim.enable = lib.mkEnableOption "enables vim modules";
  };

  config = lib.mkIf config.myModVim.enable {
    programs.vim = {
      enable = true;
      defaultEditor = true;
      package = (pkgs.vim-full.override { }).customize {
        name = "vim";
        # vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        #   start = [
        #     vim-nix
        #   ];
        #   opt = [ ];
        # };
        vimrcConfig.customRC = ''
          let g:netrw_banner=0
          let g:netrw_liststyle=3
          filetype plugin indent on
          syntax enable

          set confirm
          set colorcolumn=81
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
          set listchars=tab:»\ ,trail:.
          set splitright
          set splitbelow
          set updatetime=250
          set timeoutlen=300

          set laststatus=2
          set wrap
          set hlsearch
          set statusline=%F\ %m\ %=\ %y\ [%p\%%\ %l\:%c]
          set wildmenu
          set wildmode=list:longest
          colorscheme catppuccin
          set background=dark

          let &t_SI = "\e[6 q"
          let &t_EI = "\e[1 q"
          augroup myCmds
          au!
          autocmd VimEnter * silent !echo -ne "\e[1 q"
          augroup END
        '';
      };
    };
  };
}
