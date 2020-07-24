" File: Vim Configuration (.vimrc)
" Author: John C. Burnham (jcb@johnchandlerburnham.com)
" Date: 2019-01-26
"==============================================================================

"------------------------------------------------------------------------------
" Plugins (with vim-plug) and plugin configuration
"------------------------------------------------------------------------------

" Plugin declarations
" -------------------

call plug#begin()

" Solarized Colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'

" A fancy status bar upgrade
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

" Useful Markdown plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'

" Language Specific plugins
Plug 'idris-hackers/idris-vim'
Plug 'derekelkins/agda-vim'
Plug 'raichoo/purescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'lnl7/vim-nix'
Plug 'cespare/vim-toml'

Plug 'neoclide/coc.nvim', {'branch': 'release'}



" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

set shell=/bin/sh

" Plugin configuration
" --------------------

" airline
let g:airline_powerline_fonts = 1
let g:airline_exclued_preview = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
"let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#languageclient#enabled = 1
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#warning_symbol = 'Warning:'


" Netrw (built-in file tree browser) settings (legacy)
let g:netrw_banner=0          " Disable banner header
let g:netrw_winsize=20        " window is 20 columns wide
let g:netrw_liststyle=3       " tree style listing
let g:netrw_browse_split=4    " open files in previous window

" NERDTree
let NERDTreeMinimalUI = 1     " remove extraneous UI clutter
let NERDTreeAutoDeleteBuffer=1
"let NERDTreeQuitOnOpen = 1

" Vim-Markdown
let g:vim_markdown_math=1     " enable LaTeX and YAML syntax extensions
let g:vim_markdown_frontmatter= 1
let g:table_mode_corner='|'
let g:vim_markdown_fenced_languages = ['haskell=haskell']
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_autowrite = 1

" Rust
                              " Don't override my preferred indent settings
let g:rust_recommended_style=0
                              " default rustfmt.toml
let g:rustfmt_options='--config-path ~/.config/rustfmt/rustfmt.toml'

au FileType rust setlocal nosmartindent
au FileType rust nnoremap <silent> <leader>w :RustFmt<CR>



" CoC
set updatetime=300
set shortmess+=c

autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <leader>R   <Plug>(coc-rename)<CR>
nnoremap <leader>T   <Plug>(coc-type-definition)
nnoremap <leader>R  <Plug>(coc-references)
nnoremap <leader>D  <Plug>(coc-diagnostic-info)
nnoremap <leader>P  <Plug>(coc-diagnostic-prev)
nnoremap <leader>N  <Plug>(coc-diagnostic-next)


"------------------------------------------------------------------------------
" Vim Options
"------------------------------------------------------------------------------

" Colorscheme
syntax enable                 " Syntax highlighting
set termguicolors
"colorscheme solarized         " delightful Solarized colors by Ethan Schoonover
colorscheme NeoSolarized       " truecolor Solarized
set background=dark            " in their dark background variation

" base03  = "#002b36", cterm = 8
" base02  = "#073642", cterm = 0
" base01  = "#586e75", cterm = 10
" base00  = "#657b83", cterm = 11
" base0   = "#839496", cterm = 12
" base1   = "#93a1a1", cterm = 14
" base2   = "#eee8d5", cterm = 7
" base3   = "#fdf6e3", cterm = 15
" yellow  = "#b58900", cterm = 3
" orange  = "#cb4b16", cterm = 9
" red     = "#dc322f", cterm = 1
" magenta = "#d33682", cterm = 5
" violet  = "#6c71c4", cterm = 13
" blue    = "#268bd2", cterm = 4
" cyan    = "#2aa198", cterm = 6
" green   = "#859899", cterm = 2

" Filetype options
filetype on                   " detect filetype for syntax hiing
filetype plugin on            " load filetype plugins
filetype indent off           " but don't override my indent behavior

" Turn tabs into 2 spaces
set expandtab                 " Always insert spaces instead of a Tab
set softtabstop=2             " Inserted Tabs are two columns wide
set tabstop=2                 " <Tab> characters display as two columns
set shiftwidth=2              " Indents are 2 spaces for e.g. shifting with '>'

" Invisible characters
set list                      " Show invisibles
set showbreak=↪\              " Show breaks when long lines wrap
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨

  " Note: nbsp is a non-breaking space character (Unicode has a bunch of these,
  " which display exactly like spaces, but are not spaces), trail is trailing
  " whitespace, extends/precedes show when lines go off screen, tab is <Tab>.

" Line and Column UI
set number                    " Show line numbers
set numberwidth=3             " Line number column is 3 characters wide
set ruler                     " Show line/ column numbers in lower right
set cursorline                " Highlight cursors current line
set guicursor=sm-v:hor30,n:hor30-nCursor,i-c:cCursor,i-c-ci-ve:ver25,r-cr-o:hor30
set colorcolumn=80            " Highlight column 80
set textwidth=80              " Lines are 80 characters long
set wrap                      " wrap lines that go off screen
set linebreak                 " try to break wrapped lines in between words
set autoindent                " preserve indent at level of previous line

set formatoptions+=tqn        " textwidth autowrap, gq comments & num lists
set formatoptions-=o          " don't insert comment leader after 'o' or 'O'

" Note: This doesn't work when we're in a file that has a filetype plugin that
" overrides my settings, so I have to force it in an ugly way with an autocmd.
" I don't want to force the text-width autowrap though.
autocmd FileType * set fo+=qn fo-=o

set encoding=utf-8            " self-explanatory, required for deoplete

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
" set backupdir=~/.vim/backup// " and backup in own directory

  " Note: The '//' at the end of the above paths means that the full path
  " of the file will be used to build the swap/undo/backup files. This means
  " that e.g. '~/projectA/README.md' and '~/projectB/README.md' won't overwrite
  " each others backups by both writing to '~/.vim/backup/README.md'

  " Further Note: Vim has a bug in the 'backupdir' setting, and the '//'
  " actually does nothing for backup files (but does work for swp and undo). The
  " bug was reported in 2015 (https://github.com/vim/vim/issues/179), and is
  " still unresolved. When dealing with software, we must always remember the
  " Berra-Savitch Praxis Theorems:
  "
  " Theorem I:   In theory, there is no difference between theory and practice.
  " Theorem II:  In practice, there is.
  " Theorem III: The Berra-Savitch Praxis Theorems constitute a theory.
  "
  " In practice, we can get around this bug with some funky awesomeness. Or
  " awfulness, depending on your taste for VimScript.

  " First, let's declare our backup directory as a global variable:

let g:backup_dir='~/.vim/backup'
let g:swap_dir='~/.vim/swp'
let g:undo_dir='~/.vim/undodir'

  " and let's check if the directory exists, and let's make it if it doesn't

if !filewritable(expand(g:backup_dir))
  silent execute expand('!mkdir ' . g:backup_dir)
endif

  " We'll do the same thing for our swap and undo directories too.
  " it doesn't have anything to do with this bug, but it's good to do just to
  " make sure those directories exist too

if !filewritable(expand(g:swap_dir))
  silent execute expand('!mkdir ' . g:swap_dir)
endif

if !filewritable(expand(g:undo_dir))
  silent execute expand('!mkdir ' . g:undo_dir)
endif

  " Okay, now all aboard the train to funkytown. Our general strategy is going
  " to be to make a separate directory for each file so that they don't nuke
  " each others backups.

  " We're going to make an expression that will take the current path of
  " our file (e.g. '/home/jcb/.vimrc' for this vimrc file) and turn it into
  " a string that can work as a file or directory name (e.g. '~home~jcb~.vimrc')

let g:file_dir = substitute(substitute(expand('%:p'),
  \ "/", "~", "g"), ' ', '\\ ', 'g')

  " Just to explain what this does a little bit:
  " 1. expand('%:p') returns the full path of the file e.g. '/home/jcb/.vimrc'
  " 2. one substitute turns all the '/' characters into '~'
  "    (the backslash is a linebreak)
  " 3. the other substitute turns any spaces into escaped spaces
  "    (so 'foo bar' would become 'foo\ bar')

  " I don't know if this does a perfect job of sanitizing the filepath
  " (it almost certainly causes collisions if there were already '~' characters
  " in the path beforehand), but it seems decent.

  " Next, we'll join the above filename to our backup directory to make a path

let g:file_dir_path = g:backup_dir . '/' . g:file_dir

  " We'll make a directory at the path if it doesn't exist already
if !filewritable(expand(g:file_dir_path))
  silent execute expand('!mkdir ' . g:file_dir_path)
endif

  " And we'll set our backupdir option to that path
execute expand('set backupdir=' . g:file_dir_path)

  " This fixes the bug, but for giggles, let's add incremental backups so
  " that we save all versions of our files. I hate hate hate losing data.
  "
  " This line appends the current time to name of the backup file:

autocmd BufWritePre * let &backupext = '~' . strftime("%F_%T") . '~'

  " By the way, while researching this fix I read a bunch of people say that
  " incremental backups are old-fashioned and that using version control like
  " git is better. They couldn't be more wrong and I have a truly marvelous
  " argument for this that this comment is simply too narrow to contain.

  " But you can read the long form version here in Chapter 2 of this excellent
  " series on Houyhnhnm Computing by Fare Rideau:
  " https://ngnghm.github.io/blog/2015/08/03/chapter-2-save-our-souls/

" Search and completion options
set hlsearch                  " Persist his of all matches of last search
set incsearch                 " Show incremental matches when searching
set path+=**                  " When completing, search into sub-folders
set wildmenu                  " Show command line completion options as a menu
set complete-=i               " Don't search included files completions

" Highlights

if &bg == 'light'
  hi SignColumn ctermbg=7 guibg=#eee8d5
  hi Pmenu gui=bold guibg=#eee8d5
  hi PmenuSel gui=bold guifg=#cb4b16 guibg=#eee8d5
  hi PmenuSbar guibg=#93a1a1
  hi PmenuThumb cterm=reverse ctermfg=12 ctermbg=8 gui=reverse guifg=#839496 guibg=#002b36
  hi clear Visual
  hi Visual guibg=#eee8d5
  hi cCursor guibg=#586e75
  hi nCursor guibg=#586e75
  hi clear CursorLine    " this gives a nice effect in the line no. column
  hi CursorLine guibg=#eee8d5
  hi CursorLineNr gui=bold guibg=#fdf6e3 guifg=#cb4b16
  hi Search    cterm=italic ctermfg=Magenta gui=italic guifg=#d33682
  hi IncSearch cterm=italic ctermfg=Magenta gui=italic guifg=#d33682 guibg=#eee8d5
else
  hi SignColumn ctermbg=0 guibg= #073642
  hi Pmenu gui=bold guifg=#93a1a1 guibg=#073642
  hi PmenuSel gui=bold guifg=#cb4b16 guibg=#073642
  hi PmenuSbar guibg=#cb4b16 guifg=#cb4b16
  hi PmenuThumb ctermfg=12 ctermbg=8 gui=reverse guifg=#839496 guibg=#002b36
  hi clear Visual
  hi Visual guibg=#073642
  hi cCursor guibg=#93a1a1
  hi nCursor guibg=#93a1a1
  hi clear CursorLine    " this gives a nice effect in the line no. column
  hi CursorLine guibg=#073642
  hi CursorLineNr gui=bold guibg=#002b36 guifg=#cb4b16
  hi Search    cterm=italic ctermfg=Magenta gui=italic guifg=#d33682
  hi IncSearch cterm=italic ctermfg=Magenta gui=italic guifg=#d33682 guibg=#073642
endif

" hi CoqChecked ctermbg=7
" hi CoqSent   cterm=underline ctermbg=7

hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=#b58900
hi link ALEWarning Warning
hi link ALEInfo SpellCap

hi Error cterm=bold ctermfg=Red  guifg=#dc322f gui=bold

hi CocHintSign     ctermfg=6  guifg=#2aa198
hi CocErrorSign    ctermfg=8  guifg=#dc322f
hi CocInfoSign     ctermfg=3  guifg=#b58900
hi CocWarningSign  ctermfg=9  guifg=#cb4b16
hi CocSelectedText ctermfg=12 guifg=#839496 ctermbg=0 guibg=#073642

hi CocListBgBlue    ctermfg=8  guifg=#002b36 ctermbg=4  guibg=#268bd2
hi CocListBgCyan    ctermfg=8  guifg=#002b36 ctermbg=6  guibg=#2aa198
hi CocListBgGreen   ctermfg=8  guifg=#002b36 ctermbg=2  guibg=#859899
hi CocListBgMagenta ctermfg=8  guifg=#002b36 ctermbg=5  guibg=#d33682
hi CocListBgOrange  ctermfg=8  guifg=#002b36 ctermbg=9  guibg=#cb4b16
hi CocListBgRed     ctermfg=8  guifg=#002b36 ctermbg=1  guibg=#dc322f
hi CocListBgWhite   ctermfg=11 guifg=#657b83 ctermbg=15 guibg=#fdf6e3
hi CocListBgYellow  ctermbg=8  guifg=#002b36 ctermbg=3  guibg=#b58900

" Misc. UI
"set lazyredraw                " Only redraw when necessary for performance
set showmatch                 " Show matching brace when inserting closing brace
set nofoldenable              " Disable folding
set spelllang=en              " spellcheck using an English dictionary
set shortmess+=aI             " Shorten messages, don't show the intro message
set ttimeoutlen=10            " reduce delay when escaping from insert mode
set nrformats-=octal          " e.g increment 07 to 08 with <C-A>, not 10
set nocompatible              " turn off vi compatiblity
set backspace=2               " allow backspacing over indent,eol, start
set signcolumn=yes            " always show the sign column

"------------------------------------------------------------------------------
" Key mapping and remapping
"------------------------------------------------------------------------------

let mapleader = "\<SPACE>"    " Leader key is Space
                              " Navigate panes with leader+h/j/k/l
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
                              " Move panes with leader+H/J/K/L
nnoremap <leader>H :wincmd H<CR>
nnoremap <leader>J :wincmd J<CR>
nnoremap <leader>K :wincmd K<CR>
nnoremap <leader>L :wincmd L<CR>

nnoremap <leader>n :noh<CR>   " Clear search his in Normal mode
nnoremap <leader>= <C-W>=     " Equalize splits

if has('nvim')                " terminal settings, make nvim behave like vim
  nnoremap <leader>' :10new \| :term<CR>i
  tnoremap <C-d> <C-\><C-N>:q<CR>
  tnoremap <ESC> <C-\><C-N>
  au TermOpen * setlocal nonumber norelativenumber scl=no
else
  nnoremap <leader>' :term<CR>
endif

inoremap <M-{> {<CR>}<Esc>[{a<CR><TAB>
inoremap <M-l> λ
inoremap <M-a> ∀
inoremap <M-m> μ

" Coq
"nnoremap <leader>ml :CoqStart<CR>
"nnoremap <leader>mx :CoqQuit<CR>
"nnoremap <leader>mm :CoqNext<CR>
"nnoremap <leader>m. :CoqToCursor<CR>
"nnoremap <leader>mM :CoqRewind<CR>
"nnoremap <leader>m: :CoqQuery
"nnoremap <leader>m? :CoqSet


nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>F :NERDTreeFocus<CR>
nnoremap <silent> <leader>v :NERDTreeFind<CR>


" ----------------------------------------------------------------------------
" autocommands
" ----------------------------------------------------------------------------

"autocmd VimResized * :redraw! " fix resizing/redraw issues

" autocmd FileType * call LC_maps()  " activate LanguageClient mapping

" control deoplete for each filetype
" autocmd InsertEnter *.hs call deoplete#enable()
" autocmd InsertEnter *.lhs call deoplete#enable()
" autocmd InsertEnter *.vim call deoplete#enable()
" autocmd InsertEnter *.vimrc call deoplete#enable()
" autocmd InsertEnter *.md call deoplete#disable()

" NERDTee
" open NERDTree automatically if no files specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" and on opening a directory
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif"
"" and close if the only window left open is a NERDTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

