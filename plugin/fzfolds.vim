" fzfolds.vim - Fuzzy search for folds
" Maintainer:   Daniel Berg <mail@roosta.sh>
" Version:      0.1
if exists('g:loaded_fzfolds')
  finish
endif
let g:loaded_fzfolds = 1

command! Folds call fzfolds#run()
