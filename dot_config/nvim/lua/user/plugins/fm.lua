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

require('which-key').register({
  ['fm'] = {':Broot<cr>', 'File browser (using Broot)'},
  ['lf'] = {':Lf %:p:h<cr>', 'File browser (using lf)'},
  b = { ':Broot<cr>', 'Broot' }
}, { prefix = '<leader>'})
