"======================================================================
"
" init-keymaps.vim - Keymap settings, change according to your
" preferences.
"
"   - Fast Motion
"   - tag changing
"   - window switching
"   - Terminal support
"   - compile and Run
"   - Symbol searcing
"
" Created by skywind on 2018/05/30
" Last Modified: 2018/05/30 17:59:31
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :


"----------------------------------------------------------------------
" Use EMACS keys in insert mode
"----------------------------------------------------------------------
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <c-_> <c-k>


"----------------------------------------------------------------------
" Use CTRL+HJKL to move cursor (Easy for occasional motion in insert
" mode)
" Using SecureCRT/xShell or other terminal needs to set: backspace sends
" delete
" See Blog (in English)：http://www.skywind.me/blog/archives/2021
"----------------------------------------------------------------------
noremap <C-h> <left>
noremap <C-j> <down>
noremap <C-k> <up>
noremap <C-l> <right>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>


"----------------------------------------------------------------------
" Quick motion in command mode
"----------------------------------------------------------------------
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-f> <c-d>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-_> <c-k>


"----------------------------------------------------------------------
" Leader+number to change tab
"----------------------------------------------------------------------
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>


"----------------------------------------------------------------------
" ALT+N to switch tab
"----------------------------------------------------------------------
noremap <silent><m-1> :tabn 1<cr>
noremap <silent><m-2> :tabn 2<cr>
noremap <silent><m-3> :tabn 3<cr>
noremap <silent><m-4> :tabn 4<cr>
noremap <silent><m-5> :tabn 5<cr>
noremap <silent><m-6> :tabn 6<cr>
noremap <silent><m-7> :tabn 7<cr>
noremap <silent><m-8> :tabn 8<cr>
noremap <silent><m-9> :tabn 9<cr>
noremap <silent><m-0> :tabn 10<cr>
inoremap <silent><m-1> <ESC>:tabn 1<cr>
inoremap <silent><m-2> <ESC>:tabn 2<cr>
inoremap <silent><m-3> <ESC>:tabn 3<cr>
inoremap <silent><m-4> <ESC>:tabn 4<cr>
inoremap <silent><m-5> <ESC>:tabn 5<cr>
inoremap <silent><m-6> <ESC>:tabn 6<cr>
inoremap <silent><m-7> <ESC>:tabn 7<cr>
inoremap <silent><m-8> <ESC>:tabn 8<cr>
inoremap <silent><m-9> <ESC>:tabn 9<cr>
inoremap <silent><m-0> <ESC>:tabn 10<cr>


" MacVim allows CMD+Number to quickly switch tabs
if has("gui_macvim")
	set macmeta
	noremap <silent><d-1> :tabn 1<cr>
	noremap <silent><d-2> :tabn 2<cr>
	noremap <silent><d-3> :tabn 3<cr>
	noremap <silent><d-4> :tabn 4<cr>
	noremap <silent><d-5> :tabn 5<cr>
	noremap <silent><d-6> :tabn 6<cr>
	noremap <silent><d-7> :tabn 7<cr>
	noremap <silent><d-8> :tabn 8<cr>
	noremap <silent><d-9> :tabn 9<cr>
	noremap <silent><d-0> :tabn 10<cr>
	inoremap <silent><d-1> <ESC>:tabn 1<cr>
	inoremap <silent><d-2> <ESC>:tabn 2<cr>
	inoremap <silent><d-3> <ESC>:tabn 3<cr>
	inoremap <silent><d-4> <ESC>:tabn 4<cr>
	inoremap <silent><d-5> <ESC>:tabn 5<cr>
	inoremap <silent><d-6> <ESC>:tabn 6<cr>
	inoremap <silent><d-7> <ESC>:tabn 7<cr>
	inoremap <silent><d-8> <ESC>:tabn 8<cr>
	inoremap <silent><d-9> <ESC>:tabn 9<cr>
	inoremap <silent><d-0> <ESC>:tabn 10<cr>
endif



"----------------------------------------------------------------------
" Cache: plugin Unimpaired defined [b, ]b to switch cache
"----------------------------------------------------------------------
noremap <silent> <leader>bn :bn<cr>
noremap <silent> <leader>bp :bp<cr>


"----------------------------------------------------------------------
" TAB：创建，关闭，上一个，下一个，左移，右移
" TAB: Create, Close, Next, Previous, Pnly, move left, move right
" You can also use built-in CTRL+PageUp, CTRL+PageDown to switch tabs
"----------------------------------------------------------------------

noremap <silent> <leader>tc :tabnew<cr>
noremap <silent> <leader>tq :tabclose<cr>
noremap <silent> <leader>tn :tabnext<cr>
noremap <silent> <leader>tp :tabprev<cr>
noremap <silent> <leader>to :tabonly<cr>


" switch tab to the left
function! Tab_MoveLeft()
	let l:tabnr = tabpagenr() - 2
	if l:tabnr >= 0
		exec 'tabmove '.l:tabnr
	endif
endfunc

" Switch tab to the right
function! Tab_MoveRight()
	let l:tabnr = tabpagenr() + 1
	if l:tabnr <= tabpagenr('$')
		exec 'tabmove '.l:tabnr
	endif
endfunc

noremap <silent><leader>tl :call Tab_MoveLeft()<cr>
noremap <silent><leader>tr :call Tab_MoveRight()<cr>
noremap <silent><m-left> :call Tab_MoveLeft()<cr>
noremap <silent><m-right> :call Tab_MoveRight()<cr>


"----------------------------------------------------------------------
" Enhanced ALT key movement
"----------------------------------------------------------------------

" ALT+h/l to quickly move left and right by word (normal mode + insert
" mode)
noremap <m-h> b
noremap <m-l> w
inoremap <m-h> <c-left>
inoremap <m-l> <c-right>

" ALT+j/k go to next/previous line (with respect to wrap)
noremap <m-j> gj
noremap <m-k> gk
inoremap <m-j> <c-\><c-o>gj
inoremap <m-k> <c-\><c-o>gk

" Same key for command mode
cnoremap <m-h> <c-left>
cnoremap <m-l> <c-right>

" ALT+y to delete till end of line
noremap <m-y> d$
inoremap <m-y> <c-\><c-o>d$


"----------------------------------------------------------------------
" Window switching: ALT+SHIFT+hjkl
" Traditional CTRL+hjkl window movement doesn't work in vim 8.1 terminal
" mode, because these are important key combos preserved in bash/zsh, so
" you don't want to "tnoremap" them.
"----------------------------------------------------------------------
noremap <m-H> <c-w>h
noremap <m-L> <c-w>l
noremap <m-J> <c-w>j
noremap <m-K> <c-w>k
inoremap <m-H> <esc><c-w>h
inoremap <m-L> <esc><c-w>l
inoremap <m-J> <esc><c-w>j
inoremap <m-K> <esc><c-w>k

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1')
  " Vim 8.1 supports termwinkey, no need to switch terminal to normal
  " mode
  " Set termwinkey as CTRL+-(GVIM), CTRL+? in some terminals
  " The following 4 key combos are in combo with termwinkey, need to be
  " changed if termwinkey changes
	set termwinkey=<c-_>
	tnoremap <m-H> <c-_>h
	tnoremap <m-L> <c-_>l
	tnoremap <m-J> <c-_>j
	tnoremap <m-K> <c-_>k
	tnoremap <m-q> <c-\><c-n>
elseif has('nvim')
  " Neovim do not have termwinkey support, must change back to normal
  " mode
	tnoremap <m-H> <c-\><c-n><c-w>h
	tnoremap <m-L> <c-\><c-n><c-w>l
	tnoremap <m-J> <c-\><c-n><c-w>j
	tnoremap <m-K> <c-\><c-n><c-w>k
	tnoremap <m-q> <c-\><c-n>
endif



"----------------------------------------------------------------------
" compile and run C/C++ projects
" see：http://www.skywind.me/blog/archives/2084
"----------------------------------------------------------------------

" Automatically open quickfix window, height 6
let g:asyncrun_open = 6

" Bell when job finish
let g:asyncrun_bell = 1

" Update cmake
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" F5 to run/execute file
nnoremap <silent> <F5> :call ExecuteFile()<cr>

" F6 to test project
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

" F7 to make/compile
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

" F8 to make and run project
" Under windows, supports using F8 to open new cmd window and execute
if has('win32') || has('win64')
  nnoremap <silent> <F8> :AsyncRun -cwd=<root> -mode=4 make run <cr>
else
  nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
endif
" F9 compile C/C++ file
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" F10 to toggle quickfix
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"----------------------------------------------------------------------
" F5 to execute current file: use filetype to know how to run, and
" output to quickfix
"----------------------------------------------------------------------
function! ExecuteFile()
  let cmd = ''
  if index(['c', 'cpp', 'rs', 'go'], &ft) >= 0
    " native language, getting rid of file extensions to run as
    " executable. Writing full path because -cwd=? will change runtime
    " path, so writing full runtime path plus double quote to avoid
    " space in path
    let cmd = '"$(VIM_FILEDIR)/$(VIM_FILENOEXT)"'
  elseif &ft == 'python'
    " Close python buffer to see live feed
    let $PYTHONUNBUFFERED=1 
    let cmd = 'python "$(VIM_FILEPATH)"'
  elseif &ft == 'javascript'
    let cmd = 'node "$(VIM_FILEPATH)"'
  elseif &ft == 'perl'
    let cmd = 'perl "$(VIM_FILEPATH)"'
  elseif &ft == 'ruby'
    let cmd = 'ruby "$(VIM_FILEPATH)"'
  elseif &ft == 'php'
    let cmd = 'php "$(VIM_FILEPATH)"'
  elseif &ft == 'lua'
    let cmd = 'lua "$(VIM_FILEPATH)"'
  elseif &ft == 'zsh'
    let cmd = 'zsh "$(VIM_FILEPATH)"'
  elseif &ft == 'ps1'
    let cmd = 'powershell -file "$(VIM_FILEPATH)"'
  elseif &ft == 'vbs'
    let cmd = 'cscript -nologo "$(VIM_FILEPATH)"'
  elseif &ft == 'sh'
    let cmd = 'bash "$(VIM_FILEPATH)"'
  else
    return
  endif
  " Windows 下打开新的窗口 (-mode=4) 运行程序，其他系统在 quickfix 运行
  " -raw: 输出内容直接显示到 quickfix window 不匹配 errorformat
  " -save=2: 保存所有改动过的文件
  " -cwd=$(VIM_FILEDIR): 运行初始化目录为文件所在目录
  if has('win32') || has('win64')
    exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=4 '. cmd
  else
    exec 'AsyncRun -cwd=$(VIM_FILEDIR) -raw -save=2 -mode=0 '. cmd
  endif
endfunc



"----------------------------------------------------------------------
" F2 to search for word under cursor in project root, default to
" C/C++/Py/Js files, add file extensions as you see fit
" Support rg/grep/findstr, you can add other types
" Not grep under current dir, but grep under project root
"----------------------------------------------------------------------
if executable('rg')
  noremap <silent><F2> :AsyncRun! -cwd=<root> rg -n --no-heading 
        \ --color never -g *.h -g *.c* -g *.py -g *.js -g *.vim 
        \ <C-R><C-W> "<root>" <cr>
elseif has('win32') || has('win64')
  noremap <silent><F2> :AsyncRun! -cwd=<root> findstr /n /s /C:"<C-R><C-W>" 
        \ "\%CD\%\*.h" "\%CD\%\*.c*" "\%CD\%\*.py" "\%CD\%\*.js"
        \ "\%CD\%\*.vim"
        \ <cr>
else
  noremap <silent><F2> :AsyncRun! -cwd=<root> grep -n -s -R <C-R><C-W> 
        \ --include='*.h' --include='*.c*' --include='*.py' 
        \ --include='*.js' --include='*.vim'
        \ '<root>' <cr>
endif


