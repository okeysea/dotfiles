set runtimepath+=~/dotfiles/NeoVim/

source ~/dotfiles/NeoVim/init.vim

if filereadable(expand('~/dotfiles/NeoVim/init.vim'))
  echom 'Load init'
  " source ~/dotfiles/NeoVim/init.vim
else
  echom 'Can not load init'
endif
