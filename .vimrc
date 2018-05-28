" File: Vim Configuration (.vimrc) " Author: John C. Burnham (jcb@johnchandlerburnham.com)
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
let g:vim_markdown_math = 1
  " Enable the LaTeX math syntax extension

let g:vim_markdown_frontmatter = 1
  " Enable YAML frontmater syntax extension


" Colorscheme
colorscheme solarized         " amazing Solarized colors by Ethan Schoonover
set background=light          " in their light background variation
syntax enable                 " Syntax highlighting

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
  " whitespace, extends/precedes showe when lines go offscreen, tab is <Tab>.

" Line and Column UI
set number                    " Show line numbers
set numberwidth=3             " Line number column is 3 characters wide
set ruler                     " Show line/ column numbers in lower right
set cursorline                " Highlight cursors current line
set colorcolumn=80            " Highlight column 80
set textwidth=80              " Lines are 80 characters long
set wrap                      " wrap lines that go offscreen
set linebreak                 " try to break wrapped lines in between words

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

" Search options
set hlsearch                  " Persist highlights of all matches of last search
set incsearch                 " Show incremental matches when searching

" Misc. UI
set wildmenu                  " Show command line completion options as a menu
set lazyredraw                " Only redraw when necessary for performance
set showmatch                 " Show matching brace when inserting closing brace
set showcmd                   " Show commands in lower right corner
set nofoldenable              " Disable folding
set complete-=i               " Don't search included files completions
set laststatus=2              " Always show status line
set spelllang=en              " spellcheck using an English dictionary

" Key Remapping
let mapleader = "\<SPACE>"    " Leader key is Space

" Filetype options
filetype on
filetype plugin off
filetype indent off
