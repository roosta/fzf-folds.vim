fzf :heart: folds
===============

Vim plugin that lets you fuzzy search for folds in a file.

## Demo

![demo](https://raw.githubusercontent.com/roosta/assets/master/fzf-folds.vim/demo.gif)

## Rationale

I don't know about you, but I love stuff like ctags, and I also love fzf. I
love searching through my ctags using fzf. I also love folds, and use them
liberally, especially fold markers, and I often section off parts of a file
using markers, like a lot of markers. But sometimes I need to find a specific
fold, that might be deeply nested. That's where fzf-folds come in, it lets you
fuzzy match for folds, and will put you at the starting point of the fold
selected.

## Requirements

fzf.vim is required for this plugin to work. If you aren't familiar with fzf
it's a commandline fuzzy finder, it lets you fuzzy search whatever you want
and it's great. Go check it out!

- https://github.com/junegunn/fzf
- https://github.com/junegunn/fzf.vim


## Installation

Use your favorite [plugin](https://github.com/tpope/vim-pathogen), [manager](https://github.com/VundleVim/Vundle.vim), [vim-plug](https://github.com/junegunn/vim-plug) for example:

```vim
Plug 'roosta/fzf-folds.vim'
```

## Usage instructions

fzf-folds introduce a command `:Folds`,

`:Folds`

Open a fzf popup and search for folds in file. On accept fzf-folds will move
you to that folds line number and open just enough folds to show the fold you
selected (`zv`).

It can be useful to bind this command to something:
```vim
nnoremap <leader>jf :Folds<CR>
```

## Reference

- [foldlist](https://www.vim.org/scripts/script.php?script_id=500)

## License

[MIT](https://github.com/roosta/fzf-folds.vim/blob/main/LICENSE)
