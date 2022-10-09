require('gitsigns').setup {
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <abbrev_sha>',
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 250,
    ignore_whitespace = true,
  },
  on_attach = function(_)
    require('which-key').register({
      [']h'] = { '<cmd>Gitsigns next_hunk<cr>', 'Git next hunk' },
      ['[h'] = { '<cmd>Gitsigns prev_hunk<cr>', 'Git next hunk' },
      ['gtb'] = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Git Toggle blame' },
      ['gsh'] = { '<cmd>Gitsigns stage_hunk<cr>', 'Git stage hunk' },
      ['guh'] = { '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo Git stage hunk' },
    })
  end
}
