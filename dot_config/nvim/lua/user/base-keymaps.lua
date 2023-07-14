-- These keymaps are not related to a plugin
local vks = vim.keymap.set

-- # Normal mode leader stuff
-- ## Movement
vks('n', '<leader>l', '<C-w>l', { desc = 'Move right' })
vks('n', '<leader>k', '<C-w>k', { desc = 'Move up' })
vks('n', '<leader>j', '<C-w>j', { desc = 'Move down' })
vks('n', '<leader>h', '<C-w>h', { desc = 'Move left' })

-- ## File stuff
vks('n', '<leader>e', ':e ', { desc = 'Open a file' })
vks('n', '<leader>w', ':w<cr>', { desc = 'Save!' })
vks('n', '<leader>q', ':q<cr>', { desc = 'Quit!' })
vks('n', '<leader>Q', ':qa<cr>', { desc = 'Quit all!' })

-- ## Clipboard
vks('n', '<leader>y', 'y "+y', { desc = 'Yank from clipboard' })
vks('n', '<leader>P', 'p "+p', { desc = 'Paste from clipboard (deletes buffer)' })

-- ## Paste but replace contents of the delete buffer
-- Kudos Primeagen
vks('n', '<leader>p', '"_dP', { desc = 'Paste w/o worrying about delete buffer' })

-- ## Misc
vks('n', '<leader>/', ':nohl<cr>', { desc = 'Undo highlighting' })


-- # Normal mode stuff
-- ## Splits
vks('n', 'sh', ':split<cr>', { desc= 'Split current pane horizontally' })
vks('n', 'sv', ':vs<cr>', { desc= 'Split current pane vertically' })
vks('n', 'st', ':tab split<cr>', { desc= 'Open current pane into tab' })

-- ## Inspired by T-Pope's Unimpaired
vks('n', '[b', ':bprev<cr>', { desc = 'Previous buffer' })
vks('n', '[t', ':tabp<cr>', { desc = 'Previous tab' })
vks('n', ']b', ':bnext<cr>', { desc = 'Next buffer' })
vks('n', ']t', ':tabn<cr>', { desc = 'Next tab' })

-- ## Tab navigation
vks('n', ']t', ':tabn<cr>', { desc = 'Tab Next' })
vks('n', '[t', ':tabp<cr>', { desc = 'Tab Prev' })


-- # Insert mode stuff
vks('i', '<c-e>', '<c-[>', { desc = 'Exit insert mode' })
vks('i', '<c-c>', '<c-[>', { desc = 'Exit insert mode' })


-- # Visual mode stuff
vks('v', '//', 'y/<c-r>"<cr>', { desc = 'Search for visual selection' })


-- # From Primagen
-- ## Keep the cursor in the center when scrolling and searching
vks('n', '<C-d>', '<C-d>zz')
vks('n', '<C-u>', '<C-u>zz')
vks('n', 'n', 'nzzzv')
vks('n', 'N', 'Nzzzv')

-- ## Quick formatting
vks('n', '<leader>f', function()
  vim.lsp.buf.format()
end, { desc = 'LSP format buffer' })
