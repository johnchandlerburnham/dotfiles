" File: Vim Configuration (.vimrc)
" Author: John C. Burnham (jcb@johnchandlerburnham.com)
" Date: 2018-5-25
"==============================================================================

"------------------------------------------------------------------------------
" Plugins (with vim-plug) and plugin configuration
"------------------------------------------------------------------------------

call plug#begin()

" Solarized Colorscheme
Plug 'altercation/vim-colors-solarized'

" A fancy status bar upgrade
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Useful Markdown plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

" Netrw (built-in file tree browser)
let g:netrw_banner=0          " Disable banner header
let g:netrw_winsize=20        " window is 20 columns wide
let g:netrw_liststyle=3       " tree style listing
let g:netrw_browse_split=4    " open files in previous window

" Vim-Markdown
let g:vim_markdown_math=1     " enable LaTeX and YAML syntax extensions
let g:vim_markdown_frontmatter= 1

"------------------------------------------------------------------------------
" Vim Options
"------------------------------------------------------------------------------

" Colorscheme
syntax enable                 " Syntax highlighting
colorscheme solarized         " delightful Solarized colors by Ethan Schoonover
set background=light          " in their light background variation

" Filetype options
filetype on                   " detect filetype for syntax highlighting
filetype plugin off           " but don't load filetype plugins
filetype indent off           " and don't override my indent behavior

" Turn tabs into 2 spaces
set expandtab                 " Always insert spaces instead of a Tab
set softtabstop=2             " Inserted Tabs are two columns wide
set tabstop=2                 " <Tab> characters display as two columns
set shiftwidth=2              " Indents are 2 spaces for e.g. shifting with '>'

" Invisible characters
set list                      " Show invisibles
set showbreak=↪               " Show breaks when long lines wrap
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

  " Note: nbsp is a non-breaking space character (Unicode has a bunch of these,
  " which display exactly like spaces, but are not spaces), trail is trailing
  " whitespace, extends/precedes show when lines go off screen, tab is <Tab>.

" Line and Column UI
set number                    " Show line numbers
set numberwidth=3             " Line number column is 3 characters wide
set ruler                     " Show line/ column numbers in lower right
set cursorline                " Highlight cursors current line
set colorcolumn=80            " Highlight column 80
set textwidth=80              " Lines are 80 characters long
set wrap                      " wrap lines that go off screen
set linebreak                 " try to break wrapped lines in between words
set autoindent                " preserve indent at level of previous line

" Status line
set showcmd                   " Show commands in lower right corner
set laststatus=2              " Always show status line

" Split UI
set splitbelow                " open new horizontal splits below current split
set splitright                " open new vertical splits below current split

" Backup and Undofiles
set swapfile                  " Even before saving, store all changes and edits
set undofile                  " Save undos so they persist between sessions
set backup                    " When overwriting a file, save previous version
set directory=~/.vim/swp//    " swap files in own directory
set undodir=~/.vim/undodir//  " undo files in own directory
set backupdir=~/.vim/backup// " and backup in own directory

  " Note: The '//' at the end of the above paths means that the full path
  " of the file will be used to build the swap/undo/backup files. This means
  " that e.g. '~/projectA/README.md' and '~/projectB/README.md' won't overwrite
  " each others backups by both writing to '~/.vim/backup/README.md'

" Search and completion options
set hlsearch                  " Persist highlights of all matches of last search
set incsearch                 " Show incremental matches when searching
set path+=**                  " When completing, search into sub-folders
set wildmenu                  " Show command line completion options as a menu
set complete-=i               " Don't search included files completions

" Misc. UI
set lazyredraw                " Only redraw when necessary for performance
set showmatch                 " Show matching brace when inserting closing brace
set nofoldenable              " Disable folding
set spelllang=en              " spellcheck using an English dictionary

"------------------------------------------------------------------------------
" Key mapping and remapping
"------------------------------------------------------------------------------

let mapleader = "\<SPACE>"    " Leader key is Space
                              " Navigate splits with leader+h/j/k/l
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>

