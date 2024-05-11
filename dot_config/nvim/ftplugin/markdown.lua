local setlocal = vim.opt_local
local vks = vim.keymap.set

local mk_new_md_file = function()
  local date = os.date('%Y_%m_%d')
  return string.format(':e %s_', date)
end

setlocal.shiftwidth=4
setlocal.tabstop=4
setlocal.textwidth=80
setlocal.spell=true
setlocal.spelllang='en_us'

vks('n', '<leader>nf', mk_new_md_file, { desc = 'hey! Create a new dated markdown file', expr = true })
