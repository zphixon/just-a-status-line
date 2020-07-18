" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: plugin/just-a-status-line.vim
" Author: zphixon
" Email: zphixon@gmail.com
" License: MIT License
" ==================================================

let g:jasl_status_line = 'require("just-a-status-line").active_line()'
let g:jasl_status_line_inactive = 'require("just-a-status-line").inactive_line()'
let g:jasl_highlight = 'require("just-a-status-line").highlight()'
let g:jasl_clear_highlight = 'require("just-a-status-line").clear_highlight()'

fu! JaslStatusLine() abort
    return luaeval(g:jasl_status_line)
endf

fu! JaslInactiveLine() abort
    return luaeval(g:jasl_status_line_inactive)
endf

fu! JaslHighlight() abort
    call luaeval(g:jasl_highlight)
endf

fu! JaslClearHighlight() abort
    call luaeval(g:jasl_highlight)
endf

autocmd BufEnter,WinEnter * setl stl=%!JaslStatusLine()
autocmd BufLeave,WinLeave * setl stl=%!JaslInactiveLine()
autocmd UIEnter,Colorscheme * call JaslHighlight()
