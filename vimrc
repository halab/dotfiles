
" Root for most key bindings
let mapleader = ","

" Vundle setup
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" Colorscheme plugins
Bundle 'altercation/vim-colors-solarized.git'
"Bundle 'vim-scripts/molokai.git'
"Bundle 'vim-scripts/desert256.vim.git'
"Bundle 'tpope/vim-vividchalk.git'
"Bundle 'vim-scripts/Wombat.git'
"Bundle 'vim-scripts/wombat256.vim.git'

" Other plugins
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'vim-scripts/Gundo.git'
Bundle 'kogakure/vim-sparkup'
Bundle 'vim-scripts/SuperTab-continued..git'
Bundle 'vim-scripts/ReplaceWithRegister.git'
Bundle 'vim-scripts/cocoa.vim'
Bundle 'vim-scripts/Conque-Shell.git'
Bundle 'robbles/vim-easymotion.git'
Bundle 'vim-scripts/vim-indent-object.git'
Bundle 'vim-scripts/OOP-javascript-indentation.git'
Bundle 'vim-scripts/Jinja'
Bundle 'vim-scripts/less.vim.git'
Bundle 'vim-scripts/Lucius.git'
Bundle 'vim-scripts/Markdown.git'
Bundle 'vim-scripts/narrow--Kramer.git'
Bundle 'vim-scripts/Processing.git'
Bundle 'vim-scripts/pyflakes.vim.git'
Bundle 'vim-scripts/TaskList.vim.git'
Bundle 'godlygeek/tabular.git'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'duff/vim-scratch.git'
Bundle 'tpope/vim-repeat.git'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-abolish.git'
Bundle 'tpope/vim-endwise.git'
Bundle 'tpope/vim-fugitive.git'

" Edit .vimrc in a new tab
map <Leader>V :tabe $MYVIMRC<CR>

" Eye candy
if has('gui_running')
    "colorscheme molokai
    "colorscheme wombat
    "colorscheme lucius
    colorscheme fruity
    set background=dark

    " Customize startup size. Doesn't play nice with sessions
    "set lines=50
    "set columns=90

    "set guifont=Inconsolata:h14
    set guifont=Droid\ Sans\ Mono:h14
    set selectmode=mouse,key

    " Scrollbars are for the weak-willed, use Ctrl-g instead
    set guioptions=egmt
else
    set background=dark
    colorscheme solarized
endif

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>

" [Shift]-Tab cycles tabs
map <Tab> :tabn<CR>
map <S-Tab> :tabp<CR>
map <D-Right> :tabn<CR>
map <D-Left> :tabp<CR>

" Option/Alt-Left/Right cycles buffers
au VimEnter * map <A-Right> :bn<CR> | map <A-Left> :bp<CR>

" Ctrl-Space is omni-completion
inoremap <Nul> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>

" Toggle line wrap
map <Leader>W :set wrap!<CR>

" Toggle paste mode
map <Leader>pp :set paste!<CR>

" Toggle highlight search
map <Leader>h :set hls!<CR>

" Toggle whitespace symbols
nmap <leader>l :set list!<CR>

" Toggle relative line numbers
nmap <leader>r :set relativenumber!<CR>

" Easier way of starting substitute
map <Leader>s :s/
map <Leader>S :%s/

" Tame the quickfix window (open/close using ,q)
nmap <silent> <leader>q :QFix<CR>
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" Who needs Shift, anyway?
nnoremap ; :

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Run scripts with Cmd-R
map <D-r> :!./%<CR>

" Run python programs with leader-P
map <Leader>p :!/usr/bin/python %<CR>

" Tag list
map <Leader>T :Tlist<CR>
let Tlist_Close_On_Select=1
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=1

" NERDtree
map <Leader>f :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" Gundo
map <Leader>g :GundoToggle<CR>
let g:gundo_help=0

" ConqueTerm
let g:ConqueTerm_ToggleKey = '<F8>'
let g:ConqueTerm_Color = 1
let g:ConqueTerm_TERM = 'xterm-256'
let g:ConqueTerm_Syntax = 'bash'
let g:ConqueTerm_CloseOnEnd = 1

" Tasks
let g:tlWindowPosition = 1
map <Leader>X <Plug>TaskList

" New scratch buffer for notes
map <Leader>n :Sscratch<CR>
map <Leader>N :Scratch<CR>

" EasyMotion
let g:EasyMotion_do_mapping=1
let g:EasyMotion_mapping_f = '`f'
let g:EasyMotion_mapping_F = '`F'
let g:EasyMotion_mapping_t = '`t'
let g:EasyMotion_mapping_T = '`T'
let g:EasyMotion_mapping_w = '`w'
let g:EasyMotion_mapping_b = '`b'
let g:EasyMotion_mapping_e = '`e'
let g:EasyMotion_mapping_ge = '`ge'
let g:EasyMotion_mapping_j = '`j'
let g:EasyMotion_mapping_k = '`k'

" Map ,F to toggle indent folding
map <leader>F :set foldenable!<CR>

" Make command-line mimic bash-style shortcuts
cmap <C-a> <C-b>

" Crontab hijinks (prevents error when using "crontab -e")
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
set backupskip=/tmp/*,/private/tmp/*

" How to keep your sanity when editing long text sentences in Vim
map j gj
map k gk


"""""""""""""  Python Code """"""""""""""""""""
if has('python')
python << EOF
import sys, os, vim
try:
    import ropevim
except:
    pass

# Setup Django for model completion
os.environ['DJANGO_SETTINGS_MODULE'] = 'settings'

# Evaluate Python code under cursor
def EvaluateCurrentRange(): 
    eval(compile('\n'.join(vim.current.range),'','exec'),globals()) 

EOF
map <C-h> :py EvaluateCurrentRange()<CR>
endif
"""""""""""""  /Python Code  """""""""""""""""""

" snipMate snippets
let g:snips_author = "Rob O'Dwyer"

" Really handy if you often end up doing :W by accident
command! -nargs=* W write <args>
command! -nargs=0 Q quit

" Autocommands and filetype detection
"au BufReadPost *.project bd | Project <afile>:p
au BufReadPost *.less set ft=less
au BufReadPost buildfile set ft=ruby
au BufNewFile,BufRead *.pde	setf arduino
au BufNewFile,BufRead *.wsgi setf python
au BufNewFile,BufRead *.info setf ini

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType rst set textwidth=80
autocmd FileType txt set textwidth=80
autocmd FileType markdown set textwidth=80
autocmd Filetype java setlocal omnifunc=javacomplete#Complete 
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" :make for Python (pyflakes is easier though)
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\" 
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 

" This function detects whether this is a Django/Liquid template, or a plain HTML file, and sets filetype accordingly
fun! s:DetectHTMLVariant()
    let n = 1
    while n < 50 && n < line("$")
        " check for django
        if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
            set ft=htmldjango.html
            return
        endif
        let n = n + 1
    endwhile
    " go with html
    set ft=html
endfun
autocmd BufRead *.html,*.htm call s:DetectHTMLVariant()

" Project plugin
let g:proj_window_width=32

" HTML formatting ( get rid of shitty underlining )
hi! link htmlLink Normal

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Simplify saving and loading sessions
command! Pause mks! session.vim
command! Resume so session.vim

" Load indentation rules and plugins according to the detected filetype.
filetype plugin indent on

if exists('&autochdir')
    " Pretty much essential, saves a lot of `cd`ing
    set autochdir
endif
if exists('&colorcolumn')
    " Great for keeping code wrapped neatly
    set colorcolumn=80
endif
if exists('&cursorcolumn') && has('gui_running')
    " set cursorcolumn
endif

" Prompt for reload after external change
set noautoread

" This allows block selection to span outside of lines
set virtualedit=block
set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set smartcase " Do smart case matching
"set incsearch " Incremental search
"set autowrite " Automatically save before commands like :next and :make
set hidden " Hide buffers when they are abandoned
set mouse=a " Enable mouse usage (all modes)
syntax on
set textwidth=0
set visualbell

" These options interact together in some mysterious way to give four tab spacing
set softtabstop=4
set expandtab
set shiftwidth=4
set tabstop=4

set smartindent
set nocindent
set autoindent
set nobackup
set showcmd
set noswapfile
"set hlsearch
"set incsearch
set viminfo+=h
set nocp
set switchbuf=useopen,usetab

" Folding - Do it by one indent level, but off by default
set foldmethod=indent
set nofoldenable
set foldnestmax=1

" Wrapping sucks. I don't like it at all.
set nowrap

" Way better than Vim's crazy default backspace setting
set bs=indent,eol,start
set laststatus=2
set history=500
set completeopt=menu,menuone
set fillchars=vert:.,fold:~
set listchars=tab:▸\ ,trail:·,eol:¬

" Split windows open above and to the right
set splitright
set nosplitbelow

" No backups for temp files
set backupskip=/tmp/*,/private/tmp/*" 

" Make - and _ part of a word for text objects, start/end of word
set iskeyword+=-
set iskeyword+=_

" Scrolling options - keep 4 lines around cursor
set scrolloff=4

" :Loremipsum plugin is more effective, but doing this is just hilarious
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

" Convert TeX to PDF with <⌘ -C> and <Leader>t
autocmd FileType tex nmap <D-C> :!texi2pdf -b -o $(basename % .tex).pdf % 1>/dev/null && open $(basename % .tex).pdf<CR><CR>
autocmd FileType tex nmap <Leader>t :!texi2pdf -b -o $(basename % .tex).pdf %<CR>

" Count number of words in a TeX document
autocmd FileType tex nmap <Leader>wc :w !detex \| wc -w<CR>

