local hop = require('hop')
local hopHint = require('hop.hint')

hop.setup()

local is_wk_present, wk = pcall(require, "which-key")
if (is_wk_present == false) then
    print("which-key not found")
    return
end

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
