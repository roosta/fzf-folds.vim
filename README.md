fzfolds.vim
===========

Vim plugin that lets you fuzzy search for folds in a given file.

I don't know about you, but I love stuff like ctags, and I also love fzf. I
love searching through my ctags using fzf. I also love folds, and use them
liberally, especially fold markers, and I often section off parts of a file
using markers, like a lot of markers. But sometimes I need to find a specific
fold, that might be deeply nested. Thats where fzfolds come in, it lets you
fuzzy match for folds, and will put you at the starting point of the fold
selected.

## Requirements

- [fzf](https://github.com/junegunn/fzf)
- [fzf.vim](https://github.com/junegunn/fzf.vim)

## Installation

TBD

## Usage

fzfolds exposes a command `:Fzfolds`, use this command to start fzfolds in
currently opened file. It can be useful to bind this command to something:

```vim
nnoremap <leader>jf :Fzfolds<CR>
```
