require('fm-nvim').setup {
    -- Border around floating window
    border = "rounded", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

    -- Percentage (0.8 = 80%)
    height = 0.8,
    width = 0.8,

    -- Command used to open files
    edit_cmd = "edit", -- opts: 'tabedit'; 'split'; 'pedit'; etc...

    -- Terminal commands used w/ file manager
    cmds = {
        lf_cmd = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
    },
}

require('which-key').register({
  ['fm'] = {':Broot<cr>', 'File browser (using Broot)'},
  ['lf'] = {':Lf %:p:h<cr>', 'File browser (using lf)'},
  b = { ':Broot<cr>', 'Broot' }
}, { prefix = '<leader>'})
