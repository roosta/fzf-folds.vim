" fzf_folds.vim - Fuzzy search for folds using fzf
" Maintainer:   Daniel Berg <mail@roosta.sh>
" Version:      0.1

function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction

function! s:collect_folds() abort
  let scanline = 1
  let prevline = -1
  let folds = []
  let foldlevel = 0
  let cursor_pos = getpos('.')
  call cursor(1, 0)

  " Locate every fold, store information that lets us close and move to a fold
  while scanline != prevline
    if (foldlevel(scanline) > 0)
      let closed = foldclosed(scanline)
      if (closed == -1)
        normal! zc
      endif
      let foldtext = foldtextresult(scanline)
      call add(folds, [scanline, closed, foldtext])
      normal! zo
    endif
    keepjumps normal! zj
    let prevline = scanline
    let scanline = line('.')
  endwhile

  if empty(folds)
    " Move cursor back where we started
    call cursor(cursor_pos[1], cursor_pos[2])
    throw 'No folds found'
  endif

  " Move through and close all the folds we opened
  for fl in reverse(copy(folds))
    let [scanline, closed, line] = fl
    if (closed >= 0)
      call cursor(scanline, 0)
      normal! zc
    endif
  endfor

  call cursor(cursor_pos[1], cursor_pos[2])
  call map(folds, 'v:val[0] . ":" . v:val[2]')
  return folds
endfunction

function! s:sink(fold) abort
  normal! m'
  let [linum; rest] = split(a:fold, ':')
  call cursor(linum, 0)
  if g:fzf_folds_open == 1
    normal! zv
  endif
endfunction

function! fzf_folds#run() abort
  try
    let folds = s:collect_folds()
  catch
    return s:warn(v:exception)
  endtry

  call fzf#run({
        \ 'source': folds,
        \ 'sink': function('s:sink'),
        \ 'options': ['--delimiter', ':', '--with-nth', '2..'],
        \ 'window': { 'width': 0.9, 'height': 0.7 },
        \ })
endfunction
