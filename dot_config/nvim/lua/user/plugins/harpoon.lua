local vks = require('user/utils').vks
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vks('n', '<leader>mf', mark.add_file, { desc = 'Harpoon - mark file' })
vks('n', '<leader>ms', ui.toggle_quick_menu, { desc = 'Harpoon - toggle ui (Marks Show)' })

-- Using hjkl as my way to remember 1,2,3,4
vks('n', '<C-h>', function() ui.nav_file(1) end, { desc = 'Harpoon - go to file 1' })
vks('n', '<C-j>', function() ui.nav_file(2) end, { desc = 'Harpoon - go to file 2' })
vks('n', '<C-k>', function() ui.nav_file(3) end, { desc = 'Harpoon - go to file 3' })
vks('n', '<C-l>', function() ui.nav_file(4) end, { desc = 'Harpoon - go to file 4' })

-- Telescope integration
require('telescope').load_extension('harpoon')
vks('n', '<leader>th', ':Telescope harpoon marks<CR>', { desc = 'Telescope Harpoon Marks' })
