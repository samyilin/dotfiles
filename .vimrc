"####################### Vi Compatible (~/.exrc) #######################

" automatically indent new lines
set autoindent

" automatically write files when changing when multiple files open
set autowrite

" deactivate line numbers
set nonumber

" turn col and row position on in bottom right
set ruler " see ruf for formatting

" show command and insert mode
set showmode

" set tabstop=2

"#######################################################################
"dein Scripts-----------------------------
if empty(glob('~/.cache/dein'))
  silent !curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/installer.sh
  silent !sh ~/installer.sh ~/.cache/dein
  call dein#install()
else
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
  call dein#begin('~/.cache/dein')
  call dein#add('tpope/vim-sensible')
  call dein#add('morhetz/gruvbox')
  call dein#add('tpope/vim-vinegar')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#end()
  " Required:
  filetype plugin indent on
  syntax enable
  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
endif
"End dein Scripts-------------------------

set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_hard'
if (has("termguicolors"))
  set termguicolors
endif


" disable visual bell (also disable in .inputrc)
set t_vb=

" set softtabstop=2

" mostly used with >> and <<
" set shiftwidth=2

set smartindent

set smarttab

if v:version >= 800
  " stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " better ascii friendly listchars
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

  " i hate automatic folding
  set foldmethod=manual
  set nofoldenable
endif

" mark trailing spaces as errors
match IncSearch '\s\+$'

" enough for line numbers + gutter within 80 standard
set textwidth=72
"set colorcolumn=73

" replace tabs with spaces automatically
set expandtab

" disable relative line numbers, remove no to sample it
set norelativenumber

" turn on default spell checking
"set spell

" disable spellcapcheck
set spc=

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

set icon


" highlight search hits
set hlsearch
set incsearch
set linebreak

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000
" wrap around when searching
set wrapscan

" stop complaints about switching buffer with changes
set hidden

" command history
set history=100

" faster scrolling
set ttyfast

" make Y consitent with D and C (yank til end)
map Y y$

" better command-line completion
set wildmenu

" enable omni-completion
set omnifunc=syntaxcomplete#Complete


"fix bork bash detection
if has("eval")  " vim-tiny detection
fun! s:DetectBash()
    if getline(1) == '#!/usr/bin/bash' || getline(1) == '#!/bin/bash'
        set ft=bash
        set shiftwidth=2
    endif
endfun
autocmd BufNewFile,BufRead * call s:DetectBash()
endif

" displays all the syntax rules for current position, useful
" when writing vimscript syntax plugins
if has("syntax")
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
endif

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" functions keys
map <F1> :set number!<CR> :set relativenumber!<CR>
nmap <F2> :call <SID>SynStack()<CR>
set pastetoggle=<F3>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>
map <F12> :set fdm=indent<CR>

nmap <leader>2 :set paste<CR>i


" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
