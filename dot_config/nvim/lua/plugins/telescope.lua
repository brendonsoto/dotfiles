local g = vim.g
local map = vim.api.nvim_set_keymap
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')

-- Taken from the Config recipes
local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

telescope.setup {
    defaults = {buffer_previewer_maker = new_maker},
    pickers = {
        find_files = {
            find_command = {
                'rg', '--ignore', '--hidden', '--files', '-g', '!.git/*'
            },
            follow = true
        }
    }
}

telescope.load_extension('repo')


-- Setup Telescope specific keybindings
local is_wk_present, wk = pcall(require, "which-key")
if (is_wk_present == false) then
    print("which-key not found")
    return
end

wk.register({
  f = {
    f = {'<cmd>Telescope find_files<cr>', 'Find files'},
    g = {'<cmd>Telescope live_grep<cr>', 'Live grep'},
    b = {'<cmd>Telescope buffers<cr>', 'Find Buffer'},
    h = {'<cmd>Telescope help_tags<cr>', 'Find help tag'},
    -- p = { '<cmd>Telescope projects<cr>', 'Find projects' },
    -- ['ts'] = {'<cmd>Telescope treesitter<cr>', 'Telescope Treesitter?'}
  },
}, { prefix = '<leader>'})
