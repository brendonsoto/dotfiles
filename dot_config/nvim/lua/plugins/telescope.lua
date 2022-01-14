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
