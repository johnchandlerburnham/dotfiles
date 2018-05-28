" File: Vim Configuration (.vimrc)
" Author: John C. Burnham (jcb@johnchandlerburnham.com)
" Date: 2018-5-25
"------------------------------------------------------------------------------

" Plugins with vim-plug
call plug#begin()

" Solarized Colorscheme
Plug 'altercation/vim-colors-solarized'

" A Directory Tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" A fancy status bar upgrade
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Sytax checking
Plug 'scrooloose/syntastic'

" Line-by-line git insertion/deletion markers next to the line numbers
Plug 'airblade/vim-gitgutter'

" Visually display vim's undo/redo tree structure
Plug 'mbbill/undotree'

" Useful Markdown plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

" Plugin Configuration
let g:airline_solarized_bg='light'
let g:airline_powerine_fonts=1

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2


" Enable filetype dependent indentint (e.g. 4 spaces in Python)
filetype plugin indent on

" Leader key is Space
let mapleader = "\<SPACE>"

" Syntax highlighting
syntax enable

" Spellchecking
set spelllang=en        " using an English dictionary

" Colorscheme
colorscheme solarized   " Use the excellent Solarized colors by Ethan Schoonover
set background=light    " in their light background variation

" Turn tabs into 2 spaces
set expandtab           " Always insert spaces instead of a Tab
set softtabstop=2       " Inserted Tabs are two columns wide
set tabstop=2           " <Tab> characters display as two columns
set shiftwidth=2        " Indents are 2 spaces for e.g. shifting with '>' or '<'

" Line and Column UI
set number              " Show line numbers
set numberwidth=3       " Line number column is 3 characters wide
set ruler               " Show line/ column numbers in lower right
set cursorline          " Highlight cursors current line
set colorcolumn=80      " Highlight column 80

" Misc. UI
set wildmenu            " Show command line completion options as a menu
set lazyredraw          " Only redraw when necessary for performance
set showmatch           " Highlight matching brace when inserting closing brace
set showcmd             " Show commands in lower right corner
set nofoldenable        " Disable folding

" Search options
set incsearch           " Highlight partial matches when typing a search
set hlsearch            " Persistantly highlight all matches of previous search
