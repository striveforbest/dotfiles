" All UTF-8 all the time
scriptencoding utf-8
set encoding=utf-8

" Initialize Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Bundles
Plugin 'wincent/command-t'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/taglist.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'wavded/vim-stylus'

" Enable filetype-specific indenting, syntax, and plugins
filetype plugin indent on
syntax on

" Vim 7.3 and newer can persist undo history across sessions
if v:version >= 703
    set undofile
    set undodir=~/.vim/tmp
endif

set directory=~/.vim/tmp "where to put swap files
set backupdir=~/.vim/backup "where to put backups
set viewdir=~/.vim/view
set autoread "re-read files when they're changed externally
set nobackup
set nowritebackup
set noswapfile

"set clipboard+=unnamed "yanks and pastes use the clipboard instead
set foldlevelstart=99 "no folds, please
set timeoutlen=250 "time to wait for a command (after leader, for example)
set hidden "change buffer without saving
set showmatch "show matching brackets
set matchtime=2 "how many tenths of a second to blink

" Modelines
set modeline
set modelines=5

" Tabs and spacing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab "expandtab for spaces, noexpandtab for tabs
set smarttab
set autoindent
set smartindent
set shiftround

" Language-specific settings
autocmd FileType,BufEnter,BufWinEnter python,javascript,coffee,css,less,scss set expandtab tabstop=4 shiftwidth=4 softtabstop=4 "textwidth=79 "PEP0008 compliance
autocmd FileType,BufEnter,BufWinEnter ruby,html,htmldjango,eruby set expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType,BufEnter,BufWinEnter django set ft=django.html
autocmd FileType,BufEnter,BufWinEnter eruby set ft=eruby.html
autocmd FileType,BufEnter,BufWinEnter css,less set ft=less.css
autocmd FileType,BufEnter,BufWinEnter scss set ft=scss.css
autocmd FileType,BufEnter,BufWinEnter jade set expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.json set ft=javascript

set ruler
set nowrap
set number
set laststatus=2
set report=0
"set showcmd
set listchars=tab:\▸\ ,trail:·,eol:¶

" Show current line in current window only
set cursorline
autocmd WinEnter,BufEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Automatically strip trailing whitespace.
autocmd BufWritePre * :%s/\s\+$//e

" Searching
set nohlsearch "don't highlight search results by default
set ignorecase
set smartcase
set incsearch "search-as-you-type
set gdefault "assume the /g flag on :s substitutions to replace all matches in a line
set wrapscan "searches wrap around the end of the file

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=.DS_Store,*.pyc,*.scssc,COMMIT_EDITMSG
set wildignore+=*/.git/*,*/node_modules/*
set wildignore+=*/tmp/*
set wildignore+=sass-cache/*,.sass-cache/*,*.scssc
set wildignore+=*/media/*,*/html/*,*/source/media/*,*.pyc
set infercase "ignore case on insert completion

" MacVIM shift+arrows to select behavior. Required in .vimrc instead of
" .gvimrc for some reason.
let macvim_hig_shift_movement=1

" Window management
set splitbelow "open new horizontal splits below the current
set splitright "open new veritcal splits to the right of the current

" Statusline
"set statusline=%<%f\ %h%m%r%w%q%[%{fugitive#statusline()}]\ %l,%c\ %P

" Enable the mouse in terminal Vim (if supported). In OS X iTerm provides
" this functionality.
set mouse=a


" GENERAL KEYBINDINGS

let mapleader=','

" Escape key alternatives
imap <S-CR> <Esc>
imap kj <Esc>

map <Leader>r :registers<CR>

" Toggles
map <Leader>i :set invlist<CR>:exe ":echo 'toggling invisibles'"<CR>
map <Leader>. :set number! nonumber?<CR>
map <Leader>s :set hlsearch! hlsearch?<CR>
map <Leader>w :set wrap! wrap?<CR>

" Tabs
nmap TN :wa<CR>:tabnext<CR>
nmap TP :wa<CR>:tabnext<CR>

" Buffers
nmap BN :wa<CR>:b
