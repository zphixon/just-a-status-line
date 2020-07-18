" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: plugin/just-a-status-line.vim
" Author: zphixon
" Email: zphixon@gmail.com
" License: MIT License
" ==================================================

fu! jasl#active_line() abort
    return luaeval(g:jasl_active)
endf

fu! jasl#inactive_line() abort
    return luaeval(g:jasl_inactive)
endf

fu! jasl#do_highlight() abort
    exe g:jasl_highlight
endf

fu! jasl#clear_highlight() abort
    call luaeval('require("just-a-status-line").clear_highlight()')
endf
