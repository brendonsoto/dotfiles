local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

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

-- Command for easy making markdown link
local make_markdown_link = function()
  require('telescope.builtin').find_files {
    prompt_title = "Link file",
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local filename = selection[1]
        local file_without_dashes = string.gsub(filename, "-", " ")
        local ext_indx = string.find(filename, "%.")
        local file_without_ext = string.sub(file_without_dashes, 0, ext_indx-1)
        local md_link = string.format("[%s](./%s)", file_without_ext, filename)
        vim.api.nvim_put({ md_link }, "", false, true)
      end)
      return true
    end,
  }
end

telescope.load_extension('repo')


-- Setup Telescope specific keybindings
require('which-key').register({
  f = {
    ["<space>"] = {'<cmd>Telescope builtin<cr>', 'Telescope Builtin'},
    f = {'<cmd>Telescope find_files<cr>', 'Find files'},
    g = {'<cmd>Telescope live_grep<cr>', 'Live grep'},
    b = {'<cmd>Telescope buffers<cr>', 'Find Buffer'},
    h = {'<cmd>Telescope help_tags<cr>', 'Find help tag'},
    l = {make_markdown_link, 'Make Markdown Link'}
    -- p = { '<cmd>Telescope projects<cr>', 'Find projects' },
    -- ['ts'] = {'<cmd>Telescope treesitter<cr>', 'Telescope Treesitter?'}
  },
}, { prefix = '<leader>'})
