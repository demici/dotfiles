set nocompatible              " be iMproved, required
set backspace=2
filetype off                  " required

" override leader mapping
let mapleader = ","

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'flazz/vim-colorschemes'                   " For xoria
Plugin 'jpalardy/vim-slime'
Plugin 'paradigm/TextObjectify'
Plugin 'whatyouhide/vim-gotham'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
Bundle 'plasticboy/vim-markdown'
Bundle 'mikewest/vimroom'
Bundle 'derekwyatt/vim-scala'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'EasyMotion'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'rking/ag.vim'
Bundle 'ConradIrwin/vim-bracketed-paste'
Bundle 'christoomey/vim-tmux-navigator'

Bundle 'mrtazz/simplenote.vim'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'ryanss/vim-hackernews'
Plugin 'mattn/webapi-vim'
Plugin 'urthbound/hound.vim'
Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plugin 'wincent/ferret'
Plugin 'mhinz/vim-startify'
"Plugin 'bling/vim-bufferline'
Plugin 'vim-scripts/YankRing.vim'
call vundle#end()            " required

filetype plugin indent on    " required

syntax on

set hidden

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu

" Let's make it easy to edit this file (mnemonic for the key sequence is
" 'e'dit 'v'imrc)
nmap <silent> ,ev :e $MYVIMRC<cr>

" And to source this file as well (mnemonic for the key sequence is
" 's'ource 'v'imrc)
nmap <silent> ,sv :so $MYVIMRC<cr

" Show line numbers (relative to cursor position)
set relativenumber
set number

" Allow mouse scrolling
set mouse=a

" Undo file
set undofile

" Cntl+P vim fuzzy file opener plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

" yank/delete will automatically be stored in the system clipboard. Try weening
" off of this...
" set clipboard=unnamed

" Stop reaching
inoremap jj <ESC>

" expand tabs
set smartindent
" set wrap
set nowrap
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set background=dark
" colorscheme solarized
colorscheme xoria256
"colorscheme twilight256

" search options
set incsearch
set showmatch
set hlsearch

"  Set swap/backup/undo file locations
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Disable initial folding in vim-markdown
let g:vim_markdown_folding_disabled=1
" let g:vim_markdown_initial_foldlevel=4

au BufRead,BufNewFile *.md set filetype=markdown

" Override vimroom width setting
let g:vimroom_width = 120

" Show status bar even when not working in multiple windows
set laststatus=2

" CtrlP stuff
nmap <Leader>t :CtrlP<CR>
nmap <Leader>T :CtrlPClearCache<CR>:CtrlP<CR>j

" Faster buffer switching
nnoremap <Leader>b :CtrlPBuffer<CR>

" Show NERDTree file viewer
nmap <leader>d :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40                  " Increase window size

let g:airline_powerline_fonts = 1           " Must have powerline installed

" fast save
nmap <leader>w :w!<cr>

" remove search highlights
nnoremap <leader><space> :noh<cr>

noremap <leader>l :Align
nnoremap <leader>a :Ag<space>"

" vim-slime settings
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" Vim Slime Describe table leader key: Place cursor on a table name and execute to describe a table in Vertica
" Note: assumes you have vim-slime configured
nnoremap <Leader>dt "ayiW:SlimeSend1 \d <C-r>a<cr>

" Generate SQL DML Statement for the table under the cursor
nnoremap <Leader>dml "ayiW:SlimeSend1 select export_objects('', '<C-r>a');<cr>

" Select Star: Grab 25 records from the table under the cursor
nnoremap <Leader>ss "ayiW:SlimeSend1 select * from <C-r>a limit 25;<cr>


if exists('$SSH_CLIENT') || exists('$SSH_TTY')
    " For ssh connections: copy to local clipboard: http://seancoates.com/blogs/remote-pbcopy
    " Assuming you have ^ set up correctly, this gets local clipboard working
    nnoremap <Leader>c :silent w !pbcopy<CR>
    vnoremap <leader>c :w !pbcopy<CR><CR>
else
    nnoremap <Leader>c :silent let @+=@"<CR>
    vnoremap <leader>c "+y
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Stip trailing whitespace from files on save
autocmd FileType c,cpp,python,ruby,java,sql,php,javascript,scala autocmd BufWritePre <buffer> :%s/\s\+$//e

" Use 'gq' to auto wrap markdown text
set textwidth=80
au BufRead,BufNewFile *.md setlocal textwidth=80

" Strip trailing whitespace from files on save
autocmd FileType c,scala,cpp,python,ruby,java,sql,php,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

" SQL specific workflow
" ----------------------------------------------------------------------
" Vim Slime Describe table leader key: Place cursor on a table name and execute to describe a table in Vertica
nnoremap <Leader>dt "ayiW:SlimeSend1 \d <C-r>a<cr>

" Generate SQL DML Statement for the table under the cursor
nnoremap <Leader>dml "ayiW:SlimeSend1 select export_objects('', '<C-r>a');<cr>

" select star: Grab 25 records from the table under the cursor
nnoremap <Leader>ss "ayiW:SlimeSend1 select * from <C-r>a limit 25;<cr>

" Python specific workflow (IPython specific)
" ----------------------------------------------------------------------
" Run current script file in IPython REPL using the %run command
" nnoremap <Leader>r :SlimeSend1 %run <C-r>%<CR>        " just passes filename
nnoremap <Leader>r :let @9=expand('%:p')<CR>:SlimeSend1 %run "<C-r>9"<CR>

" :echo expand('%:p')
" :let @a=expand('%:p)<CR>

" Cursorline style

set cursorline
highlight CursorLine cterm=bold

" the creator's config:
" https://github.com/mhinz/dotfiles/blob/7e1989e902e5d9d25af5e15c2064f47a33e9d86b/vim/vimrc#L612-L642
let g:startify_session_persistence = 1
let g:startify_custom_header = [
    \ '___________ __                  ________          __          ',
    \ '\_   _____//  |_  _________.__. \______ \ _____ _/  |______   ',
    \ ' |    __)_\   __\/  ___<   |  |  |    |  \\__  \\   __\__  \  ',
    \ ' |        \|  |  \___ \ \___  |  |    `   \/ __ \|  |  / __ \_',
    \ '/_______  /|__| /____  >/ ____| /_______  (____  /__| (____  /',
    \ '        \/           \/ \/              \/     \/          \/ ',
    \ '',
    \ ]

" yankring configuration
silent execute '!mkdir -p $HOME/.vim/tmp/yankring'
let g:yankring_history_dir = '$HOME/.vim/tmp/yankring'
