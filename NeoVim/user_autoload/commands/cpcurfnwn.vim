fu! CopyCurrentFileNameWithCurrentLineNumber()
  let @+ = expand("%") . ':' . (line('.') + 1)
endf

command! Cpcurfnwcn call CopyCurrentFileNameWithCurrentLineNumber()
