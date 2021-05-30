" vim-plug (Plugin Manager) -----------------------------
if has("nvim")
  let s:plugin_path = stdpath('data') . "/plugged/"
else
  let s:plugin_path = "~/.vim/plugged/"
endif

call plug#begin(s:plugin_path)

Plug 'junegunn/vim-easy-align'

" filer -----------------------
Plug 'scrooloose/nerdtree'

if has('nvim')
  Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
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

" vim-iced---------------------
Plug 'ctrlpvim/ctrlp.vim'
" requires
Plug 'guns/vim-sexp',     {'for': 'clojure'}
Plug 'liquidz/vim-iced',  {'for': 'clojure'}
" -----------------------------

call plug#end()

" Automatically install/clean missing plugins on startup
function vimenter_auto_install_clean()
  let plugin_dirs = split(glob(g:plug_home . "/*/"), "\n")
  let plug_defs = []
  for v in values( g:plugs )
    call add( plug_defs, v.dir )
  endfor

  if len(filter(plugin_dirs, 'match(plug_defs, v:val) == -1'))
    PlugClean | q
  endif

  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    PlugInstall --sync | q
  endif
endfunction
autocmd VimEnter * vimenter_auto_install_clean()
