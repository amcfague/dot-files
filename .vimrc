" Disable plugins
let g:pathogen_disabled = ['pyflakes-vim', 'pep8', 'pythonhelper', 'python']
call pathogen#infect()

" Debian can be a pain sometimes; reload the ft modules first
filetype plugin indent on

set backup backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Reload VIM from source
" nmap <Leader>s :source $MYVIMRC
" nmap <Leader>v :e $MYVIMRC

" Dark backgrounds work great with solarized
set background=dark
colorscheme solarized

" set nocompatible

" Colors to 256
set t_Co=256

" Setup space-based tabs
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set shiftwidth=4

" Also retab if necessary
retab

" Enable ruler
set ruler
set laststatus=2
set number
"
" Set the width to wrap at 80
set textwidth=79

" Key for show python documentation
let g:pymode_doc_key = 'K'

" Run linter on the fly
let g:pymode_lint_onfly = 0
"let g:pymode_lint_message = 0
let g:pymode_folding = 0
