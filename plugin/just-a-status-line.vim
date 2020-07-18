" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: plugin/just-a-status-line.vim
" Author: zphixon
" Email: zphixon@gmail.com
" License: MIT License
" ==================================================

if !exists("g:jasl_active")
    let g:jasl_active = 'require("just-a-status-line").active_line()'
endif

if !exists("g:jasl_inactive")
    let g:jasl_inactive = 'require("just-a-status-line").inactive_line()'
endif

if !exists("g:jasl_highlight")
    let g:jasl_highlight = 'lua require("just-a-status-line").default_highlight()'
endif

autocmd BufEnter,WinEnter * setl stl=%!jasl#active_line()
autocmd BufLeave,WinLeave * setl stl=%!jasl#inactive_line()
autocmd UIEnter,Colorscheme * call jasl#do_highlight()
