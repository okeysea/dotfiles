" vim-plug (Plugin Manager) -----------------------------
call plug#begin('~/.vim/plugged/')

Plug 'junegunn/vim-easy-align'

" filer -----------------------
Plug 'scrooloose/nerdtree'
" -----------------------------

" vim-airline -----------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" -----------------------------

" vim-lsp, vim-lsp-settings ---
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" -----------------------------

" Color schemes ---------------
Plug 'joshdick/onedark.vim'
" -----------------------------

Plug 'nathanaelkane/vim-indent-guides'

" Syntax ----------------------
" Language pack
Plug 'sheerun/vim-polyglot'

" slim
Plug 'slim-template/vim-slim'

" TypeScript, tsx
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" -----------------------------

" Language Server -------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" -----------------------------

call plug#end()
