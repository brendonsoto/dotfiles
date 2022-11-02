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
require('which-key').register({
  f = {
    ["<space>"] = {'<cmd>Telescope builtin<cr>', 'Telescope Builtin'},
    b = {'<cmd>Telescope buffers<cr>', 'Find Buffer'},
    d = {'<cmd>Telescope definitions<cr>', '(LSP) Definitions'},
    f = {'<cmd>Telescope find_files<cr>', 'Files'},
    h = {'<cmd>Telescope help_tags<cr>', 'Help tag'},
    i = {'<cmd>Telescope lsp_implementations<cr>', '(LSP) Implementations'},
    j = {'<cmd>Telescope jumplist<cr>', 'Jumplist'},
    l = {make_markdown_link, 'Make Markdown Link'},
    o = {'<cmd>Telescope oldfiles<cr>', 'Old files'},
    r = {'<cmd>Telescope lsp_references<cr>', '(LSP) Find References'},
    s = {'<cmd>Telescope lsp_document_symbols<cr>', '(LSP) Document Symbols'},
    t = {'<cmd>Telescope lsp_type_definitions<cr>', '(LSP) Type Definitions'},
    x = {'<cmd>Telescope diagnostics<cr>', '(LSP) Diagnostic list'},
    -- p = { '<cmd>Telescope projects<cr>', 'Find projects' },
    -- ['ts'] = {'<cmd>Telescope treesitter<cr>', 'Telescope Treesitter?'}
  },
  g = {'<cmd>Telescope live_grep<cr>', 'Live grep'},
  s = {pick_session, 'Pick Session'},
}, { prefix = '<leader>'})
