function! OkeyseaAvanteSetup()
 let g:okeysea_avante_setup_done = 1
 lua require('plugins/avante').setup()
endfunction

augroup avante.nvim
  autocmd!
  autocmd! User avante.nvim call OkeyseaAvanteSetup() 
augroup END

function! OkeyseaAvanteAsk()
  " Ensure setup is called if not already executed
  if !exists('g:okeysea_avante_setup_done')
    doautocmd User avante.nvim
  end

  AvanteAsk
endfunction
command! -nargs=0 OkeyseaAvanteAsk call OkeyseaAvanteAsk()
