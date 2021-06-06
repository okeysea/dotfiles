" Define prefix dictionary
let g:which_key_map = {}

" Hide status line
autocmd! FileType which_key
autocmd FileType which_key set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:mapleader = "\<space>"
let g:maplocalleader = ','

nnoremap <silent> <leader>      :<c-u>WhichKey '<space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>

let g:which_key_map['i'] = {
                  \ 'name': '+incremental-search',
                  \ 'f'   : {
                        \ 'name': '+fzf-files',
                        \ 'f': ['Files',           'fzf-files'              ],
                        \ 'g': ['GFiles',          'fzf-git-ls-files'       ],
                        \ 's': ['GFiles?',         'fzf-git-status-files'   ],
                        \},
                  \ 'b'   : ['Buffers',            'fzf-open-buffers'],
                  \ 'l'   : {
                        \ 'name': '+fzf-lines',
                        \ 'l': ['Lines',           'fzf-loaded-buffer-lines' ],
                        \ 'b': ['BLines',          'fzf-current-buffer-lines'],
                        \},
                  \}

let g:which_key_map['l'] = {
                  \ 'name': '+lsp',
                  \ 'a'   : [':CocList diagnostics', 'coclist-diagnostics' ],
                  \ 'e'   : [':CocList extensions',  'coclist-extensions'  ],
                  \ 'c'   : [':CocList commands',    'coclist-commands'    ],
                  \ 'o'   : [':CocList outline',     'coclist-outline'     ],
                  \ 's'   : [':CocList -I symbols',  'coclist-symbols'     ],
                  \
                  \ 'j'   : [':CocNext',             'cocnext'             ],
                  \ 'k'   : [':CocPrev',             'cocprev'             ],
                  \ 'p'   : [':CocListResume',       'coclist-resume'      ],
                  \}

call which_key#register('<Space>', "g:which_key_map")
