local gitsigns = require('gitsigns')
gitsigns.setup {}

local is_wk_present, wk = pcall(require, "which-key")
if (is_wk_present == false) then
    print("which-key not found")
    return
end

-- There's just the name because I'm using the default mappings
-- Without this, hitting just <leader>h will show "+Left" on which-key
wk.register({
  name = 'gitsigns',
}, { prefix = '<leader>h' })
