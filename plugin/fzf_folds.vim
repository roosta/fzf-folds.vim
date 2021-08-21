" fzf_folds.vim - Fuzzy search for folds using fzf
" Maintainer:   Daniel Berg <mail@roosta.sh>
" Version:      0.1

if exists('g:loaded_fzf_folds')
  finish
endif
let g:loaded_fzf_folds = 1

if !exists('g:fzf_folds_open')
  let g:fzf_folds_open = 0
endif

command! Folds call fzf_folds#run()
