"####################### Vi Compatible (~/.exrc) #######################
" As suggested, these bits can be used within .exrc for editing using
" vi. I don't use vi extensively, but these bits are helpful if you do
" need them.

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

" inhibits errors when running Alacritty on Windows
set t_u7=

"#######################################################################
"dein Scripts-----------------------------
"if the below dir is empty, download dein installer and install dein,
"then get rid of installer script.
"remove vi compatibility mode if we are running Vim. Mandatory for
"dein.
if &compatible
        set nocompatible               " Be iMproved
endif
" Let dein manage dein
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
call dein#begin('~/.cache/dein')
" Tim Pope's sensible default. A lot of code can be avoided by using
" this. Battle-tested, good default.
call dein#add('tpope/vim-sensible')
" Tim Pope's plugin to quickly comment and uncomment based on file
" type. Wonderous piece of work. press gcc to comment, or [x]gcc to
" comment x number of lines. use gcgc to uncomment.
call dein#add('tpope/vim-commentary')
" Tim Pope's plugin to enhance netrw experience. Good enough as a
" starter kit to file explorer within Vim.
call dein#add('tpope/vim-vinegar')
" Colorscheme. Try other ones too, but this one works well with me.
call dein#add('morhetz/gruvbox')
" Better tagline at bottom. A bit too heavy for my taste, but what the
" heck.
call dein#add('vim-airline/vim-airline')
" Make airline have gruvbox theme.
call dein#add('vim-airline/vim-airline-themes')
call dein#end()
" Required:
filetype plugin indent on
syntax enable
" If you want to install not installed plugins on startup.
if dein#check_install()
        call dein#install()
endif
"End dein Scripts-------------------------

" Theme Setting(s)
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
let g:airline_theme='base16_gruvbox_dark_hard'
if (has("termguicolors"))
        set termguicolors
endif


" disable visual bell (also disable in .inputrc)
set t_vb=

set smartindent
set smarttab

if v:version >= 800
        " stop vim from silently messing with files that it shouldn't
        set nofixendofline

        " better ascii friendly listchars
        set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

        set foldmethod=manual
        set nofoldenable
endif

" mark trailing spaces as errors
" match IncSearch '\s\+$'

" enough for line numbers + gutter within 80 standard
set textwidth=72

" replace tabs with spaces automatically
set expandtab

" disable line numbers. Line numbers are useful when you need them, not
" so much globally.
set norelativenumber
set nonumber

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

set ignorecase
set smartcase

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000
" wrap around when searching
set wrapscan

" stop complaints about switching buffer with changes. 
set hidden

" command history
set history=100

" faster scrolling. If you are ont SSHing into a slow remote connection,
" this will be good. 
set ttyfast

" better command-line completion
set wildmenu

" enable omni-completion
set omnifunc=syntaxcomplete#Complete


"fix bork bash detection
if has("eval")  " vim-tiny detection
        fun! s:DetectBash()
                if getline(1) == '#!/usr/bin/bash' || getline(1) == '#!/bin/bash' || getline(1) == '#!/bin/sh'
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
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" functions keys
nmap <F1> :set number!<CR>:set relativenumber!<CR>
nmap <F2> :call <SID>SynStack()<CR>
" set pastetoggle=<F3>
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

if filereadable("~/.vimrc.personal")
        set rtp^=~/.vimrc.personal
endif
if filereadable("~/.vimrc.work")
        set rtp^=~/.vimrc.work
endif
