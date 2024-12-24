"####################### Vi Compatible (~/.exrc) #######################
" As suggested, these bits can be used within .exrc for editing using
" vi. I don't use vi extensively, but these bits are helpful if you do
" need them.
if has("eval")                               " vim-tiny lacks 'eval'
  let skip_defaults_vim = 1
endif

" automatically indent new lines
set autoindent

" replace tabs with spaces automatically
set expandtab


" automatically write files when changing when multiple files open
set autowrite


" turn col and row position on in bottom right
set ruler " see ruf for formatting

" show command and insert mode
set showmode

" inhibits errors when running Alacritty on Windows
set t_u7=

"#######################################################################
"vim-plug Scripts-----------------------------
if !has('nvim')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    execute '!git clone https://github.com/junegunn/vim-plug' data_dir.'/autoload/'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    autocmd VimEnter * PlugUpdate | source $MYVIMRC
  endif
  call plug#begin()
  " The default plugin directory will be as follows:
  "   - Vim (Linux/macOS): '~/.vim/plugged'
  "   - Vim (Windows): '~/vimfiles/plugged'
  "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
  " You can specify a custom plugin directory by passing it as the argument
  "   - e.g. `call plug#begin('~/.vim/plugged')`
  "   - Avoid using standard Vim directory names like 'plugin'
  Plug 'junegunn/vim-plug'
  " Tim Pope's sensible default. A lot of code can be avoided by using
  " this. Battle-tested, good default.
  Plug 'tpope/vim-sensible'
  " Tim Pope's plugin to quickly comment and uncomment based on file
  " type. Wonderous piece of work. press gcc to comment, or [x]gcc to
  " comment x number of lines. use gcgc to uncomment.
  Plug 'tpope/vim-commentary'
  " Tim Pope's plugin to enhance netrw experience. Good enough as a
  " starter kit to file explorer within Vim.
  Plug 'tpope/vim-vinegar'
  " Tim Pope's git wrapper. Excellent if you don't want to leave Vim to
  " do git maintenance.
  Plug 'tpope/vim-fugitive'
  " Gruvbox material is silghtly better maintained than the original
  " version.
  Plug 'sainnhe/gruvbox-material'
  " Better tagline at bottom. A bit too heavy for my taste, but what the
  " heck.
  Plug 'vim-airline/vim-airline'
  " Tim Pope's plugin to automatically set tab size.
  Plug 'tpope/vim-sleuth'
  " Tim Pope's plugin to edit 'surrounds'
  Plug 'tpope/vim-surround'
  " Tim Pope's plugin for command ga to work with Unicode
  Plug 'tpope/vim-characterize'
  " Tim Pope's plugin for supporting tmux
  Plug 'tpope/vim-tbone'
  Plug 'goerz/jupytext.vim'
  Plug 'makerj/vim-pdf'
  " Initialize plugin system
  " - Automatically executes `filetype plugin indent on` and `syntax enable`.
  call plug#end()

  autocmd VimEnter * PlugUpdate | source $MYVIMRC | :q
  "End vim-plug Scripts-------------------------
endif
"#######################################################################
if !has("nvim")
  " Theme Setting(s)
  " Turn on truecolor support
  if (has("termguicolors"))
    set termguicolors
  endif
  set background=dark
  " gruvbox comes with its own airline, so it doesn't make sense to use
  " airline's themes.
  let g:airline_theme='gruvbox_material'

  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_foreground = "original"
  autocmd vimenter * ++nested colorscheme gruvbox-material
endif
"#######################################################################
" General Settings
" disable visual bell (also disable in .inputrc)
if !has('nvim')
  set vb t_vb=
endif

set smartindent
set smarttab

set shiftwidth=2 tabstop=2 softtabstop=2

if v:version >= 800
  " stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " better ascii friendly listchars
  " set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
  set listchars=trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

  set foldmethod=manual
  set nofoldenable
endif

" mark trailing spaces as errors
" match IncSearch '\s\+$'

" enough for line numbers + gutter within 80 standard
set textwidth=72



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

set formatoptions-=t

" faster scrolling. If you are ont SSHing into a slow remote connection,
" this will be good. 
if !has('nvim')
  set ttyfast
endif

" better command-line completion
if !has('nvim')
  set wildmenu
endif
" enable omni-completion
set omnifunc=syntaxcomplete#Complete

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
if !has('nvim')
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" functions keys
" F0 toggles showing line number
nmap <F1> :set number!<CR>:set relativenumber!<CR>
" " F2 shows syntax of item in vim
" nmap <F2> :call <SID>SynStack()<CR>
" " F2 to Toggle paste mode. Useful for pasting into vim
" set pastetoggle=<F3>
" " F4 to see spaces as "*"
" map <F4> :set list!<CR>
" " F5 to show current line at which our cursor is
map <F5> :set cursorline!<CR>
" F7 to toggle spellchecking
" map <F6> :set spell!<CR>
" map <F12> :set fdm=indent<CR>

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Create the `tags` file (may need to install ctags first)
if executable('ctags')
  command! MakeTags !ctags -R .
endif
if !empty(expand(glob("~/work.vim")))
  source ~/work.vim
endif
" python setting
if !has("nvim")
  autocmd FileType python if executable('black')| setlocal equalprg=black\ -q\ -| endif
endif
