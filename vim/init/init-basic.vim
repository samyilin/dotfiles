"======================================================================
"
" init-basic.vim - basic config，this config is compatible with vim tiny 
"
" A setting that hopefully everyone agrees with，no keymap, and personal
" config
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 16:53:18
" Translated to English
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :

"----------------------------------------------------------------------
" Basic settings 
"----------------------------------------------------------------------

" disable vi compatible mode
set nocompatible

" set backspace mode
" Same with tpope/vim-sensible
set bs=eol,start,indent

" automatically indent
set autoindent

" turn on C/C++ indent optimization
" set cindent

" Windows disable using ALT to manipulate menu（makes ALT usable in Vim）
set winaltkeys=no

" disable line wrapping. Line wrapping is more useful when editing documents
" though.
set nowrap

" turn on function key overtime detection (under terimnal, function keys are
" streams of characters that start with escape) For more, read
" https://unix.stackexchange.com/questions/608142/whats-the-effect-of-escape-time-in-tmux#:~:text=This%20is%20what%20the%20escape,slow%2C%20which%20is%20generally%20pointless.
" or
" https://github.com/skywind3000/vim-init/wiki/Setup-terminals-to-support-ALT-and-Backspace-correctly:
set ttimeout

" function key time out set to 50 milli-seconds. Practically usable on any
" terminal.
set ttimeoutlen=50

" show cursor position
set ruler


"----------------------------------------------------------------------
" search settings
"----------------------------------------------------------------------

" ignore case when searching
set ignorecase

" smart detect case，ignore case by default，unless word searched include
" capital letter
set smartcase

" highlight searched words
set hlsearch

" incrementally highlight search result upon typing
set incsearch


"----------------------------------------------------------------------
" encoding settings
"----------------------------------------------------------------------
if has('multi_byte')
	" inner working encoding
	set encoding=utf-8

	" file default encoding
	set fileencoding=utf-8

	" tries these encodings upon opening if default doesn't work
	set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif


"----------------------------------------------------------------------
" Allows Vim's default configs to set indents and so on based on file type 
"----------------------------------------------------------------------
if has('autocmd')
	filetype plugin indent on
endif


"----------------------------------------------------------------------
" syntax highlight settings
"----------------------------------------------------------------------
if has('syntax')  
	syntax enable 
	syntax on 
endif


"----------------------------------------------------------------------
" Other settings
"----------------------------------------------------------------------

" show matching brackets
set showmatch

" show matching brackets for 2 seconds
set matchtime=2

" displays last line
set display+=lastline

" allows using direction keys to sift through auto-completion
set wildmenu

" lazily redraw GUI to improve performance
" set lazyredraw
" if on a fast tty connection or local machine, use
set ttyfast

" error format
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" settings so that separators are visible
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" stop vim from silently messing with files that it shouldn't
set nofixendofline
" set tags：search upwards from directory until .tag file have been found 
" or current directory vim is in
" Need universal-ctags?
set tags=./.tags;,.tags

" if unicode char is longer than 255, don't wait for space to wrap lines
" Mostly to work with Chinese chars
set formatoptions+=m

" don't add a space when wrapping lines written in Chinese
set formatoptions+=B

" use unix line separator by default.
set ffs=unix,dos,mac


"----------------------------------------------------------------------
" folding settings
"----------------------------------------------------------------------
if has('folding')
	" allows folding. some people hate folding, in which case, use
        " set nofoldenable
	set foldenable

	" folding use indent by default.
	set fdm=indent

	" opens all folds by default
	set foldlevel=99
endif


"----------------------------------------------------------------------
" Ignores these extensions when searching files and auto-completing
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
