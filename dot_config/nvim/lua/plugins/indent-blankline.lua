local opt = vim.opt
local cmd = vim.cmd

-- Using the example from the README to have rainbow lines and treesitter suport
opt.list = true
opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
