"======================================================================
"
" init-config.vim - config for normal mode，loaded after init-basic.vim
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 19:20:46
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" Give timeout to functional key timeout in tmux (microseconds)
"----------------------------------------------------------------------
if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif

"----------------------------------------------------------------------
" Allows ALT key to be used in terminal. http://www.skywind.me/blog/archives/2021
" Rember to set ttimeout (in init-basic.vim) and ttimeoutlen (above)
"----------------------------------------------------------------------
if has('nvim') == 0 && has('gui_running') == 0
	function! s:metacode(key)
		exec "set <M-".a:key.">=\e".a:key
	endfunc
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
endif

"----------------------------------------------------------------------
" Function key (F1, F2 etc) setting for terminal
"----------------------------------------------------------------------
function! s:key_escape(name, code)
	if has('nvim') == 0 && has('gui_running') == 0
		exec "set ".a:name."=\e".a:code
	endif
endfunc


"----------------------------------------------------------------------
" Function Key ANSI code fix for XTERM compatibility.
" :help xterm-function-keys explains this. 
" Also https://stackoverflow.com/questions/3519532/mapping-function-keys-in-vim
"----------------------------------------------------------------------
call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')

"----------------------------------------------------------------------
" Prevent background color abnormalities when using under tmux
" Refer: http://sunaku.github.io/vim-256color-bce.html
"----------------------------------------------------------------------
if &term =~ '256color' && $TMUX != ''
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif
"----------------------------------------------------------------------
" backup settings
"----------------------------------------------------------------------

" Allow backup
" set nobackup
set backup

" Backup when saving as an overwrite
" set nowritebackup
set writebackup

" Backup directory to manage in a singular place
set backupdir=~/.vim/tmp

" Backup file extension
set backupext=.bak

" Do not use swapfile
set noswapfile

" 禁用 undo文件
" do not use undo file
set noundofile

" 创建目录，并且忽略可能出现的警告
silent! call mkdir(expand('~/.vim/tmp'), "p", 0755)


"----------------------------------------------------------------------
" Settings tweaking
"----------------------------------------------------------------------
" Fix SecureCRT/xShell or other terminal garbage text problem, main
" reason is that some terminal control sequence are not supported, for
" example cursor shaping or other terminal command that change cursor
" shapings under xterm would cause some terminals that are not
" completely xterm-compatible to analyze incorrectly and display garbage
" text, for example the text "q".
" If you are sure that your terminal supports these or are
" xterm-compatible, and you would not run vim under terminals that are
" not completely xterm-compatible, feel free to commit it out

" 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
" 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
" 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
" 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
" if has('nvim')
" 	set guicursor=
" elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
" 	let g:termcap_guicursor = &guicursor
" 	let g:termcap_t_RS = &t_RS
" 	let g:termcap_t_SH = &t_SH
" 	set guicursor=
" 	set t_RS=
" 	set t_SH=
" endif

" Get cursor to where it was the last time when you open a file
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

" Define a DiffPrig command to see file change
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif



"----------------------------------------------------------------------
" File type tweaking
"----------------------------------------------------------------------
augroup InitFileTypesGroup

  " Get rid of historic autocmd that are the same group
	au!

  " C/C++ documents use // as comments
	au FileType c,cpp setlocal commentstring=//\ %s

  " Markdown should allow wrap, makes sense for text-only files
	au FileType markdown setlocal wrap

  " Tweaking for lisp
	au FileType lisp setlocal ts=8 sts=2 sw=2 et

  " Tweaking for scala
	au FileType scala setlocal sts=4 sw=4 noet

  " Tweaking for haskell
	au FileType haskell setlocal et

  " Tweaking for quickfix to hide row number
	au FileType qf setlocal nonumber

  " Force some file types to fix filetype
	au BufNewFile,BufRead *.as setlocal filetype=actionscript
	au BufNewFile,BufRead *.pro setlocal filetype=prolog
	au BufNewFile,BufRead *.es setlocal filetype=erlang
	au BufNewFile,BufRead *.asc setlocal filetype=asciidoc
	au BufNewFile,BufRead *.vl setlocal filetype=verilog

augroup END


