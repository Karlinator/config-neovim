set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " make line numbers relative
set wildmode=longest,list   " get bash-like tab completions
set cc=120                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spell                   " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
set backupdir=~/.cache/vim  " Directory to store backup files.

call plug#begin()
 Plug 'Mofiqul/dracula.nvim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
 Plug 'nvim-tree/nvim-tree.lua'
 Plug 'lewis6991/gitsigns.nvim'
 Plug 'othree/html5.vim'
 Plug 'pangloss/vim-javascript'
 Plug 'evanleck/vim-svelte', {'branch': 'main'}
 Plug 'APZelos/blamer.nvim'
 Plug 'neovim/nvim-lspconfig'

call plug#end()

colorscheme dracula
:lua require('gitsigns').setup()
:lua require('init')

NvimTreeToggle

let g:blamer_enabled = 1
let g:blamer_delay = 400


