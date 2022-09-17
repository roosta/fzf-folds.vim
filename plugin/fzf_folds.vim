" fzf_folds.vim - Fuzzy search for folds using fzf
" Maintainer:   Daniel Berg <mail@roosta.sh>
" Version:      0.1

if exists('g:loaded_fzf_folds')
  finish
endif
let g:loaded_fzf_folds = 1

command! Folds call fzf_folds#run()
