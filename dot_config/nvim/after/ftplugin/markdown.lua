local set = vim.opt

-- set.comments={'b:*','b:-','b:+','n:>'}
-- set.formatlistpat='^\\s*[-*+]\\s'
set.formatoptions='tcr'
set.shiftwidth=4
set.spell=true
set.spelllang='en_us'
set.tabstop=4
set.textwidth=80

local vks = vim.keymap.set

local mk_new_md_file = function()
  local date = os.date('%Y_%m_%d')
  return string.format(':e %s_', date)
end

vks('n', '<leader>nf', mk_new_md_file, { desc = 'hey! Create a new dated markdown file', expr = true })
