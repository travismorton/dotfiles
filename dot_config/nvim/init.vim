" ,--.   ,--.                    ,--.                       
" |   `.'   |,--. ,--. ,--.  ,--.`--',--,--,--.,--.--. ,---.
" |  |'.'|  | \  '  /   \  `'  / ,--.|        ||  .--'| .--'
" |  |   |  |  \   '     \    /  |  ||  |  |  ||  |   \ `--.
" `--'   `--'.-'  /       `--'   `--'`--`--`--'`--'    `---'
"           `---'                                          
"
"       Quick Tips:
"
" :PlugInstall  - install plugins
" :PlugUpdate   - install or update plugins
" :PlugClean    - remove unlisted plugins
" :PlugUpgrade  - upgrade vim-plug itself
" :PlugStatus   - check status of plugins
" :PlugDiff     - examine changes from the previous update and the pending
"       changes
" :PlugSnapshot - generate script for restoring the current snapshot of the
"       plugins
"
"  To comment code: select text -> gc (using vim-commentary)
"
"
set nocompatible              " be iMproved, required
filetype off                  " required

" Configure python to be used (not using system here). Python plugins like
" deoplete and others need this
let g:python3_host_prog='/home/travis/.local/share/nvim/venv/bin/python'

" Using vim-plug for plugin management https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Theming
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
" Plug 'guns/xterm-color-table.vim'

" Tools
Plug 'scrooloose/nerdtree'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

" Autocompletion, linting, LSP, etc.
" LSP requirements outside of neovim:
"
" python-language-server
"       rope
"       pyflakes
"       yapf (optional for formatting)
"
" ccls
"       just install via yay (AUR)
"       DON'T FORGET TO MAKE compile_commands.json
"       -> cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
"

Plug '/usr/bin/fzf' " Managed by pacman
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/echodoc'
Plug 'ipod825/vim-tabdrop'

call plug#end()

" Tabs and syntax
syntax on
set showcmd " shows when <leader> (\) is pressed and goes away
" set tabwidth to 4 spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" ... except if it's cpp
autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2 expandtab
" ... or if it's yaml
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
" ... or if it's json
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 expandtab
" ... of if it's a makefile
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

set nu
set hlsearch
set backspace=2
set updatetime=100

" LSP (LanguageClient-neovim) config for autocompletion, linting, goto
" reference, goto definition, etc

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/bin/pyls'],
    \ 'cpp': ['/usr/bin/ccls'],
    \ 'c': ['/usr/bin/ccls'],
    \ 'erlang': ['/usr/bin/erlang_ls', "--transport", "stdio"],
    \ 'cmake': ['/usr/bin/cmake-language-server'],
    \ 'go': ['/usr/bin/gopls'],
    \ 'java': ['/usr/bin/jdtls', '-data', getcwd()],
    \ 'rust': ['/usr/bin/rls'],
    \ }

" LSP shortcuts go here.
" Starting with this config, might change up the mappings or add something
" like vim-tabdrop for goto reference to open a new buffer or something...
function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,python,rust call SetLSPShortcuts()
augroup END

" Autocompletion and others
let g:deoplete#enable_at_startup = 1
" Use smartcase.
call deoplete#custom#option('smart_case', v:true)
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'
set completeopt-=preview " let echodoc handle the function signatures


" QoL stuff
set laststatus=2
set shell=/usr/bin/fish
nmap ; :

" Coloring and looks
let g:airline_exclude_preview=1
let g:airline_theme='solarized'

colorscheme gruvbox
" set background=dark
set background=light

" Statusline formatting and warnings
set statusline+=%#warningmsg#
set statusline+=%*

" gitgutter config
let g:gitgutter_async = 1
let g:gitgutter_eager = 1

" NERDTree config
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeRespectWildIgnore=1

" paths to ignore in nerdtree
set wildignore+=*.pyc,*.o,*.lo

set title

" system + mouse copy/paste buffer bindings
set mouse=a
"map <C-c> "*y<CR>
"map <C-v> "*p<CR>

" Double click on a word to go to definition
nnoremap <silent> <2-LeftMouse> :call LanguageClient#textDocument_definition()<CR>

" Experimentation: using vim-tabdrop to open definition in a different tab
nnoremap <C-]> :call Gotodef()<CR>
nmap <C-t> :TabdropPopTag<Cr>

function! Gotodef()
    TabdropPushTag
    call LanguageClient_textDocument_definition({'gotoCmd': 'Tabdrop'})
endfunction

" Experimentation: LanguageClient-neovim doesn't erase gutter x after it's
" been fixed
set signcolumn=yes

" Debugging: Log LanguageClient output
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile =  expand('/tmp/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('/tmp/LanguageServer.log')
