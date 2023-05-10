lua require("plugins/toggleterm").setup()

fu! ToggleFloatLazyGitToggleTerm()
  lua require("plugins/toggleterm")._lazygit_toggle()
endf

command! ToggleFloatLazyGit call ToggleFloatLazyGitToggleTerm()
