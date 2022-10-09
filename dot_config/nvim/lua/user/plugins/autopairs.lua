-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

require("nvim-autopairs").setup({
    -- Use treesitter to check for pairs
    check_ts = true,

    -- if there's a closing pair char on the line, don't add a pair
    enable_check_bracket_line = false,

    -- This is to not add a pair when there's text after the cursor
    ignored_next_char = "[%w%.]",
})
