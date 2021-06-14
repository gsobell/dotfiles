syntax on
autocmd BufEnter * colorscheme default
autocmd BufEnter *.md colorscheme nord
autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/
autocmd filetype markdown syn match math '\\$[^$].\{-}\$'
autocmd BufEnter *.py colorscheme Tomorrow-Night
set mouse=a
set noerrorbells
set belloff=all
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
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
au BufRead /tmp/mutt-* set tw=72
setlocal nospell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
