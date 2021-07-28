function! CollectFolds() abort
  let scanline = 1
  let prevline = -1
  let folds = []
  let foldlevel = 0
  let cursor_pos = getpos('.')
  call cursor(1, 0)

  " Locate every fold, store information that lets us close and move to a fold
  while scanline != prevline
    let foldlevel = foldlevel(scanline)
    if (foldlevel > 0)
      let closed = foldclosed(scanline)
      if (closed == -1)
        normal! zc
      endif
      let foldtext = foldtextresult(scanline)
      call add(folds, [scanline, foldlevel, closed, foldtext])
      normal! zozj
    endif
    let prevline = scanline
    let scanline = line('.')
  endwhile

  " Move through and close all the folds we opened
  for fl in reverse(copy(folds))
    let [scanline, foldlevel, closed, line] = fl
    if (closed >= 0)
      call cursor(scanline, 0)
      normal! zc
    endif

  endfor

  " Move cursor back where we started
  call cursor(cursor_pos[1], cursor_pos[2])

  echo folds
endfunction

function! FzfFoldsSink(word) abort
  " exe 'normal! "_ciw'.a:word
endfunction

function! FzfFolds() abort
  let folds = CollectFolds()
  call fzf#run({'source': folds, 'sink': function('FzfFoldsSink')})
endfunction


command! Folds call CollectFolds()
" command! Folds call FzfFolds()

  " call map(folds, {_, val -> val[0] . ':' . val[1] . ':' . val[2] . ':' . val[3]})
