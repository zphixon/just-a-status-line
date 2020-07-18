" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: plugin/just-a-status-line.vim
" Author: zphixon
" Email: zphixon@gmail.com
" License: MIT License
" ==================================================

fu StatusLine() abort
    return luaeval('require("just-a-status-line").active_line()')
endf

fu InactiveLine() abort
    return luaeval('require("just-a-status-line").inactive_line()')
endf

fu JaslFixModeString(mode) abort
    let m = a:mode
    if a:mode == 'no'
        let m = 'nocv'
    elseif a:mode == ''
        let m = 'ctrlv'
    elseif a:mode == ''
        let m = 'ctrls'
    elseif a:mode == 'r?'
        let m = 'rqm'
    elseif a:mode == '!'
        let m = 'bang'
    end

    return m
endf

autocmd BufEnter,WinEnter * setl stl=%!StatusLine()
autocmd BufLeave,WinLeave * setl stl=%!InactiveLine()

" TODO
let g:gc = gruvbox_material#get_configuration()
let g:gp = gruvbox_material#get_palette(g:gc.background, g:gc.palette)
exe 'hi JaslNormal guifg=' . g:gp.blue[0] . ' guibg=#3a3735'
exe 'hi JaslVisual guifg=' . g:gp.green[0] . ' guibg=#3a3735'
exe 'hi JaslInsert guifg=' . g:gp.purple[0] . ' guibg=#3a3735'
exe 'hi JaslReplace guifg=' . g:gp.red[0] . ' guibg=#3a3735'
exe 'hi JaslCommand guifg=' . g:gp.yellow[0] . ' guibg=#3a3735'
exe 'hi JaslTerminal guifg=' . g:gp.aqua[0] . ' guibg=#3a3735'
hi link JaslNormalOpPending        JaslNormal
hi link JaslNormalOpPendingChar    JaslNormal
hi link JaslNormalOpPendingLine    JaslNormal
hi link JaslNormalOpPendingBlock   JaslNormal
hi link JaslNormalCtrlO            JaslNormal
hi link JaslNormalReplaceCtrlO     JaslNormal
hi link JaslNormalVirtualCtrlO     JaslNormal
hi link JaslVisualLine             JaslVisual
hi link JaslVisualBlock            JaslVisual
hi link JaslVisualSelect           JaslVisual
hi link JaslVisualSelectLine       JaslVisual
hi link JaslVisualSelectBlock      JaslVisual
hi link JaslInsertInsertCompletion JaslInsert
hi link JaslInsertCtrlX            JaslInsert
hi link JaslReplaceCompletion      JaslReplace
hi link JaslReplaceVirtual         JaslReplace
hi link JaslReplaceCtrlX           JaslReplace
hi link JaslCommandEx              JaslCommand
hi link JaslCommandExNormal        JaslCommand
