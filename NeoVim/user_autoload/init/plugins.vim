" vim-plug (Plugin Manager) -----------------------------
call plug#begin('~/.vim/plugged/')

Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/nerdtree'

" vim-airline -----------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" -----------------------------

" vim-lsp, vim-lsp-settings ---
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" -----------------------------

" Color schemes ---------------
Plug 'joshdick/onedark.vim'
" -----------------------------

Plug 'nathanaelkane/vim-indent-guides'

call plug#end()
