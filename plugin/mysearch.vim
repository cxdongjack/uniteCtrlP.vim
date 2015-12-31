":nmap <C-V> :w<CR>:so %<CR>:MySearchFinder<CR>
function! FindMyDirectory(path)
  let parent = unite#util#path2directory(a:path)
  let base = parent

  while 1
    echo parent
    let path = parent . '/.git'
    " only check .git as directory to avoid submodules
    if isdirectory(path)
      return parent
    endif
    let next = fnamemodify(parent, ':h')
    if next == parent
      return base
    endif
    let parent = next
  endwhile
endfunction

"test
"echo FindMyDirectory('~/a.html')

function! MySearchFinder()
    let buffername = unite#helper#get_buffer_directory(bufnr('%'))
    execute 'cd '.FindMyDirectory(buffername)
    execute 'Unite -start-insert buffer file_rec'
endfunction    
com! -nargs=0 MySearchFinder call MySearchFinder()

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <buffer> <C-c>   <Plug>(unite_exit)
endfunction

" Like ctrlp.vim settings.
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
\   'direction': 'botright',
\ })

" config example
" nnoremap <leader>u :<C-u>Unite<CR>
" nnoremap <C-p> :MySearchFinder<CR> 