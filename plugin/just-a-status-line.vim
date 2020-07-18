" ==================================================
" URL: https://github.com/zphixon/just-a-status-line
" Filename: plugin/just-a-status-line.vim
" Author: zphixon
" Email: zphixon@gmail.com
" License: MIT License
" ==================================================

let g:jasl_status_line = 'require("just-a-status-line").active_line()'
let g:jasl_status_line_inactive = 'require("just-a-status-line").inactive_line()'

fu! JaslStatusLine() abort
    return luaeval(g:jasl_status_line)
endf

fu! JaslInactiveLine() abort
    return luaeval(g:jasl_status_line_inactive)
endf

autocmd BufEnter,WinEnter * setl stl=%!JaslStatusLine()
autocmd BufLeave,WinLeave * setl stl=%!JaslInactiveLine()

" TODO
let s:gc = gruvbox_material#get_configuration()
let s:gp = gruvbox_material#get_palette(s:gc.background, s:gc.palette)
exe 'hi JaslNormal guifg=' . s:gp.blue[0] . ' guibg=#3a3735'
exe 'hi JaslVisual guifg=' . s:gp.green[0] . ' guibg=#3a3735'
exe 'hi JaslInsert guifg=' . s:gp.purple[0] . ' guibg=#3a3735'
exe 'hi JaslReplace guifg=' . s:gp.red[0] . ' guibg=#3a3735'
exe 'hi JaslCommand guifg=' . s:gp.yellow[0] . ' guibg=#3a3735'
exe 'hi JaslTerminal guifg=' . s:gp.aqua[0] . ' guibg=#3a3735'
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
