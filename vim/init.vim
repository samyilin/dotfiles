"======================================================================
"
" init.vim - initialize config
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 18:26:34
" Translated to English to avoid potential utf-8 errors
"======================================================================

" prevent repetitive vim profile multiple time(s)
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

" Get this file's file directory
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" define a function to load scripts. 'so' is alias for 'source'
command! -nargs=1 LoadScript exec 'so '.s:home.'/'.'<args>'

" add vim-init directory to runtimepath
exec 'set rtp+='.s:home

" add directory ~/.vim into runtimepath (sometimes vim won't help you
" add them）
set rtp+=~/.vim


"----------------------------------------------------------------------
" Loading modules
"----------------------------------------------------------------------

" load basic config
LoadScript init/init-basic.vim

" load extended config
LoadScript init/init-config.vim

" set tabsize
LoadScript init/init-tabsize.vim

" set plugins
LoadScript init/init-plugins.vim

" set styles
LoadScript init/init-style.vim

" set keymaps
LoadScript init/init-keymaps.vim
