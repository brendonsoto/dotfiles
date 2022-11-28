local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')
local builtin = require('telescope.builtin')
local vks = vim.keymap.set

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

-- Manage sessions
local pick_session = function()
  local sessions_dir = '$HOME/.config/nvim/sessions'

  require('telescope.builtin').find_files {
    prompt_title = 'Sessions (Creates one if input doesn\'t exist)',
    cwd = sessions_dir,
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        -- If the selection isn't an existin file, create a new one
        if selection == nil then
          local new_file = action_state.get_current_line()
          local filepath = sessions_dir .. '/' .. new_file

          -- Accomodate my laziness of not wanting to add the file extension
          if string.find(new_file, '.vim') == nil then
            filepath = filepath .. '.vim'
          end

          vim.cmd.mksession(filepath)
          print('Made new session file: ' .. filepath)
        else
          local filename = selection[1]
          local filepath = sessions_dir .. '/' .. filename
          vim.cmd.source(filepath) -- same as `:Source <session.vim>`
        end
      end)
      return true
    end
  }
end


-- Setup Telescope specific keybindings
vks('n', '<leader>f<space>', builtin.builtin, { desc = 'Telescope Builtin' })
vks('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffer' })
vks('n', '<leader>fd', builtin.lsp_definitions, { desc = '(LSP) Definitions' })
vks('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
vks('n', '<leader>fh', builtin.help_tags, { desc = 'Help tag' })
vks('n', '<leader>fi', builtin.lsp_implementations, { desc = '(LSP) Implementations' })
vks('n', '<leader>fj', builtin.jumplist, { desc = 'Jumplist' })
vks('n', '<leader>fo', function() builtin.oldfiles({ only_cwd = true }) end, { desc = 'Old files' })
vks('n', '<leader>fr', builtin.lsp_references, { desc = '(LSP) Find References' })
vks('n', '<leader>fs', builtin.lsp_document_symbols, { desc = '(LSP) Document Symbols' })
vks('n', '<leader>ft', builtin.lsp_type_definitions, { desc = '(LSP) Type Definitions' })
vks('n', '<leader>fx', builtin.diagnostics, { desc = '(LSP) Diagnostic list' })
vks('n', '<leader>g', builtin.live_grep, { desc = 'Live grep' })
vks('n', '<leader>s', pick_session, { desc = 'Pick Session' })
