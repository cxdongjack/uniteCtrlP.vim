" Loading Guard {{{1
if exists('g:viper__tmux')
    finish
endif
let g:viper__tmux = 1

function! VimuxGoToRoot()
  call VimuxRunCommand("cd " . FindGitRoot(bufname("%")))
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
