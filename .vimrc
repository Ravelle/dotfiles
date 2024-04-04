""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Installation
"
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
call plug#begin('~/.vim/plugged')

" Plug 'janko/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
" Plug 'mileszs/ack.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
" Plug 'wavded/vim-stylus'
Plug 'tomasiser/vim-code-dark'
"Plug 'mengelbrecht/lightline-bufferline'

call plug#end()
filetype plugin indent on

" colorscheme
set t_Co=256
set t_ut=
colorscheme codedark
call matchadd('ColorColumn', '\%81v', 100)
call matchadd('ColorColumn', '\s{4}', 100)
set cursorline
set cursorcolumn
"
" General config
"
       
:syntax on
:set number
:set relativenumber
:set tabstop=2 " 4
:set shiftwidth=2 " 4
:set expandtab
:set ruler
:set nolist
:set autoindent
:set smartindent
:set ignorecase

if executable('rg')
      " Use rg over grep
      set grepprg=rg\ --vimgrep
endif
"         myfather                  
" add recursion to the search path (find)
:set path+=**
" allow for tab selecting possible matches for find
:set wildmenu
"set splitbelow
"set splitright

" Display status bar regardless of windows
set laststatus=2


" Persist undos
set undodir=~/.vim/undodir
set undofile

set updatetime=100


" Cursor change
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

"
" Vim-Test config
"

"map <leader>tn :TestNearest<CR>
"map <leader>tt :TestFile<CR>
"map <leader>ts :TestSuite<CR>
"map <leader>tl :TestLast<CR>
"map <leader>tv :TestVisit<CR>


"
" Lightline Config
"

" Don't show --INSERT--
"set noshowmode

let g:lightline = {
      \ 'colorscheme': 'codedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component': {
      \   'filename': '%F',
      \}
      \ }
"let g:lightline = {}
"let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
"let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
"let g:lightline.component_type   = {'buffers': 'tabsel'}
"autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" Transparent background
hi Normal guibg=NONE ctermbg=NONE 
hi EndOfBuffer guibg=NONE ctermbg=NONE 

"
" CTRLP Config
"

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'


"
" NerdTree config
"

" Close vim if NERDTree is all that is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Auto open nerd tree + blank if you open a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let NERDTreeShowHidden=1

"nnoremap <leader>n :NERDTree %<CR>
"map <C-n> :NERDTreeToggle<CR>

call NERDTreeHighlightFile('py', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('Dockerfile', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('Makefile', 'Magenta', 'none', '#ff00ff', '#151515')
:hi Directory guibg=NONE ctermbg=NONE
:hi treeDir guifg=#96CBFE guibg=#00ff00
:hi link treeDir Keyword


:highlight ColorColumn cterm=NONE ctermbg=red
"whitespace config
:hi MaxIndenting ctermbg=233 ctermfg=237
:hi MaxTrailing ctermfg=red
:set listchars=tab:>·,trail:▯,extends:>,precedes:<
:set list

call matchadd('MaxIndenting', '^\t*\zs \+', 100)
call matchadd('MaxTrailing', '\s\+$', 100)

au BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif
:highlight IndentLevel1 ctermbg=236 ctermfg=NONE
:highlight IndentLevel2 ctermbg=237 ctermfg=NONE
:highlight IndentLevel3 ctermbg=238 ctermfg=NONE
:highlight IndentLevel4 ctermbg=239 ctermfg=NONE
:highlight IndentLevel5 ctermbg=240 ctermfg=NONE
"call matchadd('IndentLevel1', '\(^\s\{3}\)\@<=\s', 100)
"call matchadd('IndentLevel2', '\(^\s\{7}\)\@<=\s', 100)
"call matchadd('IndentLevel3', '\(^\s\{11}\)\@<=\s', 100)
"call matchadd('IndentLevel4', '\(^\s\{15}\)\@<=\s', 100)
"call matchadd('IndentLevel5', '\(^\s\{19}\)\@<=\s', 100)
"
" ALE setup
"


let g:ale_linters = {
 \ 'javascript': ['eslint'],
 \ 'typescript': ['eslint', 'tsserver'],
 \ 'typescriptreact': ['eslint', 'tsserver'],
 \ 'scss': ['stylelint'],
 \ 'cpp': ['cc']
 \ }
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint'],
 \ 'typescript': ['prettier', 'eslint'],
 \ 'typescript.tsx': ['prettier', 'eslint'],
 \ 'typescriptreact': ['prettier', 'eslint']
 \ }

"let g:ale_cpp_gcc_options = '-std=c++23 -Wall'
let g:ale_cpp_cc_options = '-std=c++23 -Wall'
let g:ale_cpp_cc_executable = 'gcc' " or 'clang'
"

let g:ale_sign_error = '❌'
let g:ale_sign_warning = ''
let g:ale_fix_on_save = 1
"let g:ale_typescript_prettier_use_local_config = 1
let g:ale_linters_explicit = 1
autocmd vimenter * NERDTree

