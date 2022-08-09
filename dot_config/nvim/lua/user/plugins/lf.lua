local map = vim.api.nvim_set_keymap

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
        -- nnn_cmd    = "nnn",
        -- xplr_cmd   = "xplr",
        -- vifm_cmd   = "vifm",
        -- ranger_cmd = "ranger"
    },
}


local is_wk_present, wk = pcall(require, "which-key")
if (is_wk_present == false) then
    print("which-key not found")
    return
end

wk.register({
  ['fm'] = {':Lf %:p:h<cr>', 'File browser (using lf)'},
}, { prefix = '<leader>'})