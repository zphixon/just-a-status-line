# just a status line

it's just a status line. what more do you want? (wip btw xd 🤪)

## gimme

using [vim-plug](https://github.com/junegunn/vim-plug) (or whatever I'm not your
dad)

```vim
Plug 'zphixon/just-a-status-line'
```

additional (optional) git integration with [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
and/or [fugitive](https://github.com/tpope/vim-fugitive).

![img](https://github.com/zphixon/just-a-status-line/blob/main/screenshot.png)

## doc

### defaults

```vim
let g:jasl_active = 'require("jasl").active_line()'
let g:jasl_inactive = 'require("jasl").inactive_line()'
let g:jasl_highlight = 'lua require("jasl").default_highlight()'
let g:jasl_separator = ' | '
```

### example gruvbox mode colors

```vim
fu MyHighlight() abort
    if exists('*gruvbox_material#get_configuration')
        let g:gc = gruvbox_material#get_configuration()
        let g:gp = gruvbox_material#get_palette(g:gc.background, g:gc.palette)
        exe 'hi JaslNormal   guifg=' . g:gp.blue[0]   . ' guibg=#3a3735'
        exe 'hi JaslVisual   guifg=' . g:gp.green[0]  . ' guibg=#3a3735'
        exe 'hi JaslInsert   guifg=' . g:gp.purple[0] . ' guibg=#3a3735'
        exe 'hi JaslReplace  guifg=' . g:gp.red[0]    . ' guibg=#3a3735'
        exe 'hi JaslCommand  guifg=' . g:gp.yellow[0] . ' guibg=#3a3735'
        exe 'hi JaslTerminal guifg=' . g:gp.aqua[0]   . ' guibg=#3a3735'
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
    else
        lua require('jasl').default_highlight()
    endif
endf

let g:jasl_highlight = 'call MyHighlight()'
```

## todo

* make colorscheme customization nicer
* ability to include user-defined bits
* cursor column probably
    * although this may fall under the above category
* test in vim8 and without gitgutter/fugitive

