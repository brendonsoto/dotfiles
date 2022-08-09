local hop = require('hop')
local hopHint = require('hop.hint')
local wk = require('which-key')

hop.setup()

local keymappings = {
  name = "Hop",
  f = {
    function()
      hop.hint_char1({direction = hopHint.HintDirection.AFTER_CURSOR})
    end, 'Hop forward'
  },
  F = {
    function()
      hop.hint_char1({direction = hopHint.HintDirection.BEFORE_CURSOR})
    end, 'Hop Backwards'
  },
  j = {
    function()
      hop.hint_lines_skip_whitespace({
        direction = hopHint.HintDirection.AFTER_CURSOR
      })
    end, 'Hop down'
  },
  k = {
    function()
      hop.hint_lines_skip_whitespace({
        direction = hopHint.HintDirection.BEFORE_CURSOR
      })
    end, 'Hop up'
  }
}

wk.register(keymappings, { prefix = '<leader><leader>' })
wk.register(keymappings, { prefix = '<leader><leader>', mode = 'v' })
