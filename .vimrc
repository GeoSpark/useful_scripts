" .vimrc based on Martin Brochhaus's presentation at PyCon APAC 2012
" see https://github.com/mbrochh/vim-as-a-python-ide

" Install plug-ins in .vim/bundle/<plug-in name>/ and Pathogen will take care
" of the rest.
" let g:pathogen_disabled = []
" call add(g:pathogen_disabled, 'python-mode')
" call add(g:pathogen_disabled, 'ctrlp.vim')
" call add(g:pathogen_disabled, 'vim-powerline')

call pathogen#infect()

" Rebind the <leader> key. This is a shortcut prefix that we can hang commands
" and macros on.
let mapleader=","

" Automatically reload .vimrc
autocmd! bufwritepost .vimrc source %

" More intuitive copy and paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
set clipboard=unnamed

" Mouse control - by clicking, it moves the cursor to that spot.
" On OSX press ALT and click
set mouse=a

" Make backspace behave normally
set bs=2

" Make it easier to switch between tabs.
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>
map <Leader>t <esc>:tabnew<CR>

" Remap some common typos.
command! WQ wq
command! Wq wq
command! Q q
command! W w

" Easily sort a block of text.
vnoremap <Leader>s :sort<CR>

" More easily indent and unindent a block of text.
vnoremap < <gv
vnoremap > >gv

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

set history=700
set undolevels=700

" Real programmers don't use tabs.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make searches case insensitive.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Settings for vim-powerline plug-in which adds useful items to the status bar.
set laststatus=2

" Settings for ctrlp plug-in which is used for quickly navigating through files.
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Settings for python-mode plug-in.
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable
