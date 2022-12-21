"======================================================================
"
" init-tabsize.vim - Most people have preference for tabsize, change
" them here.
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 22:05:44
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" 默认缩进模式（可以后期覆盖）
" default tab (can be overwritten later on using autocmd
"----------------------------------------------------------------------


" shift width
set shiftwidth=4

" tabstop
set tabstop=4

" noexpandtab
set noet

" if you set expandtab later on, then how many characters does 1 tab
" become after expanding them?
set softtabstop=4


augroup PythonTab
  au!
  " If you NEED to use tab in python files, then un-comment the below
  " line, otherwise vim will automatically set to space indent for
  " python
  "au FileType python setlocal shiftwidth=4 tabstop=4 noexpandtab
augroup END
