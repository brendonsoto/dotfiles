local vks = require('user/utils').vks
local gitsigns = require('gitsigns')

gitsigns.setup {
  -- current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <abbrev_sha>',
  -- current_line_blame_opts = {
  --   virt_text = true,
  --   virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
  --   delay = 250,
  --   ignore_whitespace = true,
  -- },
  on_attach = function(_)
    vks('n', ']h', gitsigns.next_hunk, { desc = 'Git next hunk' })
    vks('n', '[h', gitsigns.prev_hunk, { desc = 'Git next hunk' })
    -- vks('n', 'gtb', gitsigns.toggle_current_line_blame, { desc = 'Git Toggle blame' })
  end
}
