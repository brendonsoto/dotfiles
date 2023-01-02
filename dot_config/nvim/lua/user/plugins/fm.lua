local vks = require('user/utils').vks

-- NOTE: Tried broot but was weird with custom config
-- The config required a property in the setup function whereas xplr does not
require('fm-nvim').setup {
  ui = {
    -- Border around floating window
    border = "double", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

    -- Percentage (0.8 = 80%)
    height = 1,
    width = 1,
  },
}

vks('n', '<leader>fm', ':Xplr %:p:h<cr>', { desc = 'File Manager' })
