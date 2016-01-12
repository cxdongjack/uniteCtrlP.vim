function! FindMyDirectory(path)
  let parent = unite#util#path2directory(a:path)
  let base = parent

  while 1
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

function! VimuxGoToRoot()
  call VimuxRunCommand("cd " . FindMyDirectory(bufname("%")))
  call _VimuxTmux("select-"._VimuxRunnerType()." -t ".g:VimuxRunnerIndex)
endfunction

" Run the current file with rspec
map <Leader>vg :call VimuxGoToRoot()<CR>

" Run the current file with rspec
map <Leader>vc :call VimuxRunCommand("cd " . FindMyDirectory(bufname("%")))<CR>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>
