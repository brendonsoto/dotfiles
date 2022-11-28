local vks = require('user/utils').vks

require('fm-nvim').setup {
  ui = {
    -- Border around floating window
    border = "double", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

    -- Percentage (0.8 = 80%)
    height = 1,
    width = 1,
  },
  broot_conf = '$HOME/.config/broot/conf.hjson',
}

vks('n', '<leader>bf', ':Broot<cr>', { desc = 'Browse files (using Broot)' })
vks('n', '<leader>lf', ':Lf %:p:h<cr>', { desc = 'File browser (using lf)' })
