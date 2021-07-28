function! CollectFolds() abort
  let scanline = 1
  let prevline = -1
  let folds = []
  let foldlevel = 0
  let cursor_pos = getpos('.')
  call cursor(1, 0)

  while scanline != prevline
    let foldlevel = foldlevel(scanline)
    if (foldlevel > 0)
      let line = getline(scanline)
      let closed = foldclosed(scanline)
      call add(folds, [line, scanline, foldlevel, closed])
      normal! zozj
    endif
    let prevline = scanline
    let scanline = line('.')
  endwhile

  for fl in folds
    let [line, scanline, foldlevel, closed] = fl
    if (closed >= 0)
      call cursor(scanline, 0)
      normal! zc
    endif

  endfor

  call cursor(cursor_pos[1], cursor_pos[2])
  echo folds

endfunction

command! Folds call CollectFolds()
