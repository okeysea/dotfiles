set runtimepath+=C:\Users\a\dotfiles\NeoVim\
if filereadable(expand('C:\Users\a\dotfiles\NeoVim\init.vim'))
  echom 'Load init'
  source C:\Users\a\dotfiles\NeoVim\init.vim
else
  echom 'Can not load init'
endif
