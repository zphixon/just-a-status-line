" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: plugin/just-a-status-line.vim
" Author: zphixon
" Email: zphixon@gmail.com
" License: MIT License
" ==================================================

" TODO: probably make these vim expressions like g:jasl_highlight
if !exists("g:jasl_active")
    let g:jasl_active = 'require("jasl").active_line()'
endif

if !exists("g:jasl_inactive")
    let g:jasl_inactive = 'require("jasl").inactive_line()'
endif

if !exists("g:jasl_highlight")
    let g:jasl_highlight = 'lua require("jasl").default_highlight()'
endif

if !exists("g:jasl_separator")
    let g:jasl_separator = ' | '
endif

augroup Jasl
    au!
    autocmd BufEnter,WinEnter * setl stl=%!jasl#active_line()
    autocmd BufLeave,WinLeave * setl stl=%!jasl#inactive_line()
    autocmd UIEnter,Colorscheme * call jasl#do_highlight()
augroup END
