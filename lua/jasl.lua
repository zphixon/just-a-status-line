-- vim:set sw=2 ts=2 sts=2 et:

local maybe_sep = function(str)
  if str == '' then
    return ''
  else
    return str .. vim.g.jasl_separator
  end
end

-- TODO: probably ignore all the random stuff no one cares about
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
  local branch = ''
  local gutter = ''

  if vim.fn.exists('*FugitiveHead') == 1 and vim.fn.FugitiveGitDir() ~= '' then
    if vim.fn.FugitiveHead() ~= '' then
      branch = vim.fn.FugitiveHead()
    else
      branch = '(detached)'
    end
  end

  if vim.fn.exists('*GitGutterGetHunkSummary') == 1 then
    local summary = vim.fn.GitGutterGetHunkSummary()
    local added, modified, removed = summary[1], summary[2], summary[3]
    if added ~= 0 or modified ~= 0 or removed ~= 0 then
      gutter = string.format("+%d ~%d -%d", added, modified, removed)
    end
  end

  return maybe_sep(branch) .. maybe_sep(gutter)
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
  local modified = '%{jasl#modified()}'
  local filename = '%f'
  local filetype = maybe_sep(vim.bo.filetype)
  local spell = maybe_sep(spell())
  local git = git_status()
  local percent = '%p%%'

  return ' ' ..  mode ..
    vim.g.jasl_separator ..
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
  local modified = '%{jasl#modified()}'
  local filename = '%f'
  return ' '.. modified .. filename
end

local clear_highlight = function()
  if vim.fn.has('nvim') then
    for k, mode in pairs(modes) do
      vim.cmd('hi clear ' .. mode.hl)
    end
  else
    for k, mode in pairs(modes) do
      vim.command('hi clear ' .. mode.hl)
    end
  end
end

local default_highlight = function()
  if vim.fn.has('nvim') then
    for k, mode in pairs(modes) do
      vim.cmd('hi link ' .. mode.hl .. ' StatusLine')
    end
  else
    for k, mode in pairs(modes) do
      vim.command('hi link ' .. mode.hl .. ' StatusLine')
    end
  end
end

local M = {
  clear_highlight = clear_highlight,
  default_highlight = default_highlight,
  active_line = active_line,
  inactive_line = inactive_line,
}

return M
