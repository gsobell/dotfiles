syntax on
set mouse=a
set noerrorbells
set belloff=all
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
set smartindent
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
inoremap ' ''<ESC>ha
inoremap " ""<ESC>ha
