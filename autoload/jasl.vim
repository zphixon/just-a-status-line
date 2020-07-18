" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: autoload/jasl.vim
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
    call luaeval('require("jasl").clear_highlight()')
endf

fu! jasl#modified() abort
    " we have access to g:actual_curbuf and g:actual_curwin
    if &readonly
        return '-' . g:jasl_separator
    elseif &modified
        return '+' . g:jasl_separator
    else
        return ''
    end
endf
