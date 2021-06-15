syntax on
autocmd BufEnter * colorscheme default
autocmd BufEnter *.md colorscheme nord
autocmd BufEnter *.py colorscheme Tomorrow-Night
set mouse=a
set showmatch
set noerrorbells
set belloff=all
set smartindent
set nu
set wrap linebreak
set mouse=a
set undodir=~/.vim/undodir
set undofile
set incsearch
set wildmenu
set wildmode=list:longest,full
source $VIMRUNTIME/vimrc_example.vim
inoremap { {}<ESC>ha
inoremap ( ()<ESC>ha
inoremap [ []<ESC>ha
inoremap " ""<ESC>ha
inoremap { {}<ESC>ha
inoremap $ $$<ESC>ha
au BufRead /tmp/mutt-* set tw=72
setlocal nospell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

""Portable basic LaTeX highlighting, in lieu of a plugin 
function s:math()
  syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$" contains=Statement
   syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
  syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Constant
endfunction

autocmd BufNewFile,BufReadPre,BufRead *.md setfiletype markdown
autocmd FileType markdown :call <SID>math()
