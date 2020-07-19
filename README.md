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

### examples

you can add your own user-defined bits to the status line. their output goes
directly to the status line, so you can do cool things like add your own
highlighting to them. here's a few examples:

#### show cursor column

```vim
let g:jasl_active = "require('jasl').active_line({\n"
\ . "  right = {\n"
\ . "    function()\n"
\ . "      return vim.fn.col('.')\n"
\ . "    end,\n"
\ . "  },\n"
\ . "})\n"
```

#### example [nvim-lsp](https://github.com/neovim/nvim-lsp) integration

this one would probably be better off in its own file.

```vim
let g:jasl_active = "require('jasl').active_line({\n"
\ . "  right = {\n"
\ . "    function()\n"
\ . "      if vim.tbl_isempty(vim.lsp.buf_get_clients()) then\n"
\ . "        return ''\n"
\ . "      else\n"
\ . "        local server_name = ''\n"
\ . "        -- sometimes the client list doesn't start at 1 :(\n"
\ . "        for k, v in pairs(vim.lsp.buf_get_clients()) do\n"
\ . "          server_name = v.name\n"
\ . "        end\n"
\ . "        if vim.lsp.buf.server_ready() then\n"
\ . "          return server_name\n"
\ . "        else\n"
\ . "          return 'loading ' .. server_name .. '...'\n"
\ . "        end\n"
\ . "      end\n"
\ . "    end,\n"
\ . "  }\n"
\ . "})\n"
```

#### example gruvbox mode colors

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
* test in vim8

