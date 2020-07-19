# just a status line

It's just a status line. What more do you want? (wip btw xd 🤪)

## Todo

* Make colorscheme customization nicer
* Test in Vim8

## Gimme

Using [vim-plug](https://github.com/junegunn/vim-plug) (or whatever I'm not your
dad)

```vim
Plug 'zphixon/just-a-status-line'
```

Additional (optional) git integration with [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
and/or [fugitive](https://github.com/tpope/vim-fugitive).

![img](https://github.com/zphixon/just-a-status-line/blob/main/screenshot.png)

## Doc

The functions defined in `autoload/jasl.vim` should not be touched by an
end-user. The plugin instead defines a Lua API including:

* `clear_highlight`: fully clears the highlight groups of the status line
* `default_highlight`: sets the highlight groups of status line items to `StatusLine`
* `active_line`: returns the status line format string for the active window
* `inactive_line`: returns the status line format string for an inactive window

`active_line` and `inactive_line` both optionally take one argument that is a
table of functions to execute when calculating the status line for the active
and inactive windows.

The table may have two optional properties `left` and `right`, which are lists of
functions. The functions in the `left` property are appended in sequence to the
left side of the status line after the filename, and the functions in the `right`
property are prepended in sequence to the right side of the status line before
the git status and percent through the file.

The plugin also defines some highlight groups for syntax highlighting purposes.

| highlight group name           | mode                                          |
|--------------------------------|-----------------------------------------------|
| `JaslNormal`                   | normal                                        |
| `JaslNormalOpPending`          | operator pending                              |
| `JaslNormalOpPendingChar`      | operator pending, forced charwise             |
| `JaslNormalOpPendingLine`      | operator pending, forced linewise             |
| `JaslNormalCtrlO`              | normal using i_CTRL-O in insert mode          |
| `JaslNormalReplaceCtrlO`       | normal using i_CTRL-O in replace mode         |
| `JaslNormalVirtualCtrlO`       | normal using i_CTRL-O in virtual replace mode |
| `JaslVisual`                   | visual                                        |
| `JaslVisualLine`               | line visual                                   |
| `JaslVisualSelect`             | select                                        |
| `JaslVisualSelectLine`         | line select                                   |
| `JaslInsert`                   | insert                                        |
| `JaslInsertInsertCompletion`   | insert completion                             |
| `JaslInsertCtrlX`              | insert completion using i_CTRL-X              |
| `JaslReplace`                  | replace                                       |
| `JaslReplaceCompletion`        | replace completion                            |
| `JaslReplaceVirtual`           | virtual replace                               |
| `JaslReplaceCtrlX`             | replace completion using i_CTRL-X             |
| `JaslCommand`                  | command                                       |
| `JaslCommandEx`                | ex mode                                       |
| `JaslCommandExNormal`          | normal ex mode                                |
| `JaslPrompt`                   | hit-enter prompt                              |
| `JaslPromptPager`              | paging prompt                                 |
| `JaslTerminal`                 | terminal mode                                 |

### Defaults

```vim
" Lua expression that evaluates to the active window's status line
let g:jasl_active = 'require("jasl").active_line()'

" Lua expression that evaluates to the inactive window's status line
let g:jasl_inactive = 'require("jasl").inactive_line()'

" VimL expression that executes status line highlighting
let g:jasl_highlight = 'lua require("jasl").default_highlight()'

" Separator between status line items
let g:jasl_separator = ' | '
```

### Examples

You can add your own user-defined items to the status line. Since their output
goes directly to the editor's status line setting, you also have access to the
formatting options listed in `:h stl`.

#### Show cursor column

```vim
let g:jasl_active = "require('jasl').active_line({\n"
\ . "  right = {\n"
\ . "    function()\n"
\ . "      return vim.fn.col('.')\n"
\ . "    end,\n"
\ . "  },\n"
\ . "})\n"
```

#### Example [nvim-lsp](https://github.com/neovim/nvim-lsp) integration

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

#### Example [gruvbox-material](https://github.com/sainnhe/gruvbox-material) mode colors

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

