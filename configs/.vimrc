" Debian can be a pain sometimes; reload the ft modules first
filetype off
filetype plugin indent on

" Disable plugins
"let g:pathogen_disabled = []
"let g:syntastic_disabled_filetypes = ['python']

" Load pathogen here
call pathogen#runtime_append_all_bundles() 

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
