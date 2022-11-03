local g = vim.g

g.vim_markdown_folding_disabled = 1 -- no auto-folds plz
g.vim_markdown_no_default_key_mappings = 1 -- figured to set myself
g.vim_markdown_conceal = 2
g.vim_markdown_follow_anchor = 1 -- go-to link
g.vim_markdown_frontmatter = 1 -- YAML frontmatter
g.vim_markdown_strikethrough = 1 -- ~~strikethrough~~
g.vim_markdown_auto_insert_bullets = 0 -- no auto-insert bullet points
g.vim_markdown_new_list_item_indent = 0 -- no auto-indenting for lists

-- Command for easy making markdown link
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
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

local wk = require('which-key')
wk.register(
  {
    name = 'Markdown',
    ["<CR>"] = { "<Plug>Markdown_EditUrlUnderCursor", "Edit link under cursor" },
    ["]]"] = { "<Plug>Markdown_MoveToNextHeader", "Go to next header" },
    ["[["] = { "<Plug>Markdown_MoveToPreviousHeader", "Go to previous header" },
    ["<leader>"] = {
      t = { ":Toc<CR>", "Table of Contents" },
      ["it"] = { ":InsertToc<CR>", "Insert Table of Contents" },
      ["ml"] = {make_markdown_link, 'Make Markdown Link'},
    }
  }, {
    buffer = vim.api.nvim_get_current_buf()
  }
)
