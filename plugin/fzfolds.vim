if exists('g:loaded_fzfolds')
  finish
endif
let g:loaded_fzfolds = 1

function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
  return 0
endfunction

function! CollectFolds() abort
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
    normal! zj
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

  call map(folds, {_, val -> val[0] . ':' . val[2]})
  return folds
endfunction

function! FzFoldsSink(fold) abort
  let [linum; rest] = split(a:fold, ':')
  call cursor(linum, 0)
endfunction

function! FzFolds() abort
  try
    let folds = CollectFolds()
  catch
    return s:warn(v:exception)
  endtry

  call fzf#run({
        \ 'source': folds,
        \ 'sink': function('FzFoldsSink'),
        \ 'options': ['--delimiter', ':', '--with-nth', '2..'],
        \ 'window': { 'width': 0.9, 'height': 0.7 },
        \ })
endfunction


" command! Folds call CollectFolds()
command! FFolds call FzFolds()

