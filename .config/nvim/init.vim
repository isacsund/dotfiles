" =============================================================================
" # PLUGINS
" =============================================================================
call plug#begin()

" VIM enhancements
Plug 'morhetz/gruvbox'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

" Rust
let g:rustfmt_autosave = 1

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set relativenumber                          " Show line numbers relative to each other
set number                                  " Show the current lines number w/ relative numbers around it
set noswapfile                              " Don't create *.swp files
set showcmd                                 " Display an incomplete command in the lower right corner
set mouse=a                                 " Allow scrolling/visual mode with mouse; Cmd-R to disable in Terminal

" Decent wildmenu
set wildmenu
set wildmode=list:longest                   " Tab complete to longest common string, like bash

" Searching
set hlsearch      " Highlight searches
set ignorecase    " Ignore case
set smartcase     " Override 'ignorecase' option if the search contains upper case characters.

" Indentation
set shiftwidth=4  " Number of spaces to use in each autoindent step
set tabstop=4     " Two tab spaces
set softtabstop=4 " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab     " Spaces instead of tabs for better cross-editor compatibility

" Color column at 80 characters
set colorcolumn=80
set textwidth=80

" 24bit true color
set termguicolors

" Gruvbox specific
let g:gruvbox_contrast_dark='hard'

" Colorscheme
syntax enable
colorscheme gruvbox

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
