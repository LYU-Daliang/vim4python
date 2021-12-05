" >>> Make Vim a Python IDE >>>
"  ref: https://realpython.com/vim-and-python-a-match-made-in-heaven
"  ref: https://dev.to/shahinsha/how-to-make-vim-a-python-ide-best-ide-for-python-23e1
"  install:
"   1) run `git clone https://github.com/gmarik/Vundle.vim.git \
"      ~/.vim/bundle/Vundle.vim`
"   2) run `pip3 install flake8`, add its path to $PATH
"   3) run `vi .vimrc`, and `:PluginInstall`
"   4) install ycm, ref: https://github.com/ycm-core/YouCompleteMe
"      a) `sudo apt install build-essential cmake vim-nox python3-dev`
"      b) `sudo apt install mono-complete`
"      c) `cd \path\to\ycm`, `python3 install.py`
"   5) (optionally) run `:PluginList` to check
"  changes:
"   1) fold/unfold with `zc` `zo`, not `za`
"   2) for multiline `au`, only one `set` can be used 
"   3) define highlight group `BadWhitespace`
"   4) change `py` to `py3`
" <<< Make Vim a Python IDE <<<


" required
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" add all your plugins here, then fire up vim and run `:PluginInstall`
" code folding
Plugin 'tmhedberg/SimpylFold'
" python indentation
Plugin 'vim-scripts/indentpython.vim'
" auto-complete
Plugin 'Valloric/YouCompleteMe'
" syntax checking/highlighting
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
" color schemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" file browsing
Plugin 'scrooloose/nerdtree'
" super searching
Plugin 'kien/ctrlp.vim'
" git integration
Plugin 'tpope/vim-fugitive'
" powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" tabnine and rainbow 
Plugin 'zxqfl/tabnine-vim'
Plugin 'frazrepo/vim-rainbow'

" all of your plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" split navigations (split with `:sp <filename>` or `:vs <filename>`
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" list buffers with `:ls`, switch to a buffer with `:b <buffer#>`

" enable folding
set foldmethod=indent
set foldlevel=99
" enable folding with the spacebar
" not `za` for SimpylFold, use `zc` and `zo`, close and open
nnoremap <space> zc
" see the docstrings for folded code
let g:SimpylFold_docstring_preview=1

" add the proper PEP 8 indentation
" https://groups.google.com/g/vim_use/c/X02NT61oLTs/m/E7yATcuDBQAJ
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" auto indentation for other filetypes
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

" flagging unnecessary whitespace
" define BadWhitespace highlight group first
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" utf-8 support
set encoding=utf-8

" ensure the auto-complete window goes away when you're done with it
let g:ycm_autoclose_preview_window_after_completion=1
" define a shortcut for goto definition (default <leader> key: \)
" sometimes may get `RuntimeError: Can't jump to definition.`
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" syntax checking and highlighting
let python_highlight_all=1
syntax on

" switch color scheme according to vim mode
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
" switch dark and light theme of solarized
call togglebg#map("<F5>")

" hide .pyc files from nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] 

" line numbering
set nu

" system clipboard
set clipboard=unnamed

" rainbow bracket settings
let g:rainbow_active=1
