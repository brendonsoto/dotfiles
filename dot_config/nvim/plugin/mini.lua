require('mini.bracketed').setup({
  treesitter = { suffix = 'a', options = {} },
  indent = { suffix = '' },
})
local vks = vim.keymap.set
vks('n', '[i', '<Cmd>lua MiniBracketed.indent("backward", { change_type = "less" })<CR>',
  { desc = 'Go to the previous indent level' })
vks('n', '[I', '<Cmd>lua MiniBracketed.indent("backward", { change_type = "more" })<CR>',
  { desc = 'Go to the previous indent level' })
vks('n', ']i', '<Cmd>lua MiniBracketed.indent("forward", { change_type = "less" })<CR>',
  { desc = 'Go to the previous indent level' })
vks('n', ']I', '<Cmd>lua MiniBracketed.indent("forward", { change_type = "more" })<CR>',
  { desc = 'Go to the previous indent level' })

require('mini.comment').setup({
  options = {
    custom_commentstring = function()
      return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
    end,
  },
})
require('mini.indentscope').setup({
  draw = {
    delay = 50,
    animation = require('mini.indentscope').gen_animation.quadratic({
      easing = 'in',
      duration = 10,
      unit = 'step',
    })
  },
})
require('mini.pairs').setup()
local starter = require('mini.starter')
starter.setup({
  header = function ()
    return require('user.dashboard-art').get_art()
  end,
  items = {
    starter.sections.telescope(),
  }
})
require('mini.surround').setup({
  mappings = {
    add = 'sa',
    delete = 'sd',
    find = 'sf',
    find_left = 'sF',
    highlight = '', -- was interfering w/ split horiz + i don't use
    replace = 'sr',
    update_n_lines = '', -- i'm fine w/ default search range of 20 lines

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  }
})
