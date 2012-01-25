" Ack integration.
" Keep track of the root of the current git repo, if any.
" TODO(sissel): Probably should put this in a separate plugin
autocmd BufNewFile,BufRead * let b:gitroot=system("git rev-parse --show-toplevel")

" Run Ack on the current word starting at the root of this git repo
nnoremap <Leader>a :execute "LAck <cword> " . b:gitroot<CR>
nnoremap <Leader>A :execute "Ack <cword> " . b:gitroot<CR>
" Map 't' on the quickfix window to open the file:line selected
autocmd FileType qf nnoremap t :call QFOpenCurrentInNewTab()<CR>

function! QFOpenCurrentInNewTab() 
  " For some reason getqflist() and getloclist() don't seem to work
  " when Ack is being used. So we have to do this instead.
  let l:line = line(".") " Get the current line number
  let l:str = getline(l:line) " Get the current line string
  " split: filename|number|...
  let l:values = split(l:str, '|') " Split the line by '|'
  " open the file:line in a new tab at the given line number
  execute "tabe +" . l:values[1] . " " . l:values[0]
endfunction
