-- vim:set sw=2 ts=2 sts=2 et:

local alt_if_str = function(str, alt)
  if str == '' then
    return ''
  else
    return alt
  end
end

local str_or_alt = function(str, alt)
  if str == '' then
    return alt
  else
    return str
  end
end

local maybe_sep = function(str, alt)
  local sep = vim.g.jasl_separator or ' | '
  if str == '' then
    return ''
  else
    return str .. sep
  end
end

local modes = {
  n      = { name = 'normal',    hl = 'JaslNormal'                 }, -- normal
  no     = { name = 'Normal',    hl = 'JaslNormalOpPending'        }, -- operator pending
  nov    = { name = 'Normal',    hl = 'JaslNormalOpPendingChar'    }, -- operator pending, forced charwise
  noV    = { name = 'normal',    hl = 'JaslNormalOpPendingLine'    }, -- operator pending, forced linewise
  niI    = { name = 'normal...', hl = 'JaslNormalCtrlO'            }, -- normal using i_CTRL-O in insert mode
  niR    = { name = 'normal...', hl = 'JaslNormalReplaceCtrlO'     }, -- normal using i_CTRL-O in replace mode
  niV    = { name = 'normal...', hl = 'JaslNormalVirtualCtrlO'     }, -- normal using i_CTRL-O in virtual replace mode
  v      = { name = 'visual',    hl = 'JaslVisual'                 }, -- visual
  V      = { name = 'Visual',    hl = 'JaslVisualLine'             }, -- line visual
  s      = { name = 'select',    hl = 'JaslVisualSelect'           }, -- select
  S      = { name = 'Select',    hl = 'JaslVisualSelectLine'       }, -- line select
  i      = { name = 'insert',    hl = 'JaslInsert'                 }, -- insert
  ic     = { name = 'insert...', hl = 'JaslInsertInsertCompletion' }, -- insert completion
  ix     = { name = 'insert...', hl = 'JaslInsertCtrlX'            }, -- insert completion using i_CTRL-X
  R      = { name = 'Replace',   hl = 'JaslReplace'                }, -- replace
  Rc     = { name = 'Replace',   hl = 'JaslReplaceCompletion'      }, -- replace completion
  Rv     = { name = 'gReplace',  hl = 'JaslReplaceVirtual'         }, -- virtual replace
  Rx     = { name = 'replace',   hl = 'JaslReplaceCtrlX'           }, -- replace completion using i_CTRL-X
  c      = { name = 'command',   hl = 'JaslCommand'                }, -- command
  cv     = { name = 'ex',        hl = 'JaslCommandEx'              }, -- ex mode
  ce     = { name = 'ex',        hl = 'JaslCommandExNormal'        }, -- normal ex mode
  r      = { name = 'prompt',    hl = 'JaslPrompt'                 }, -- hit-enter prompt
  rm     = { name = 'prompt',    hl = 'JaslPromptPager'            }, -- paging prompt
  t      = { name = 'terminal',  hl = 'JaslTerminal'               }, -- terminal mode
}

modes['no'] = { name = 'normal...', hl = 'JaslNormalOpPendingBlock' } -- operator pending, forced blockwise
modes['']   = { name = '^visual',   hl = 'JaslVisualBlock'          } -- block visual
modes['']   = { name = '^select',   hl = 'JaslVisualSelectBlock'    } -- block select
modes['r?']   = { name = 'prompt',    hl = 'JaslPromptConfirm'        } -- :confirm query
modes['!']    = { name = 'shell...',  hl = 'JaslShell'                } -- shell command executing

local current_mode_name = function(mode)
  local current_mode = modes[mode]

  -- highlight according to group and pad the name with 6 chars minimum
  return '%#' .. current_mode.hl .. '#%-6.(' .. current_mode.name .. '%)%#StatusLine#'
end

local git_status = function()
  if vim.fn.exists('*FugitiveGitDir') then
    local git = vim.fn.FugitiveGitDir()

    local gutter = ''
    if vim.fn.exists('*GitGutterGetHunkSummary') then
      local summary = vim.fn.GitGutterGetHunkSummary()
      local added, modified, removed = summary[1], summary[2], summary[3]
      gutter = string.format("+%d ~%d -%d", added, modified, removed)
    end
    local fugitive = vim.fn.FugitiveHead()

    local sep = vim.g.jasl_separator or ' | '
    local status = str_or_alt(fugitive, '(detached)') .. sep .. maybe_sep(gutter)

    return alt_if_str(git, status)
  end
end

local modified = function()
  if vim.bo.readonly then
    return '-'
  elseif vim.bo.modified then
    return '+'
  else
    return ''
  end
end

local spell = function()
  if vim.wo.spell then
    return 'spell'
  else
    return ''
  end
end

-- TODO: more left/right side stuff?
local active_line = function()
  local mode = current_mode_name(vim.fn.mode())
  local modified = maybe_sep(modified())
  local filename = '%f'
  local filetype = maybe_sep(vim.bo.filetype)
  local spell = maybe_sep(spell())
  local git = git_status()
  local percent = '%p%%'

  -- truncate *after* the filename. you probably want to see what mode you're in.
  return ' ' ..  mode ..
    (vim.g.jasl_separator or ' | ') ..
    filetype ..
    modified ..
    filename ..
    '%<%=' ..
    spell ..
    git ..
    percent ..
    ' '
end

local inactive_line = function()
  local tailname = '%t'
  return ' ' .. tailname
end

-- TODO
local highlighter = function(palette)
end

local M = {
  highlighter = highlighter,
  active_line = active_line,
  inactive_line = inactive_line,
  spell = spell,
}

return M
