local g = vim.g

g.vim_markdown_folding_disabled = 1 -- no auto-folds plz
g.vim_markdown_no_default_key_mappings = 1 -- figured to set myself
g.vim_markdown_conceal = 2
g.vim_markdown_follow_anchor = 1 -- go-to link
g.vim_markdown_frontmatter = 1 -- YAML frontmatter
g.vim_markdown_strikethrough = 1 -- ~~strikethrough~~
g.vim_markdown_auto_insert_bullets = 0 -- no auto-insert bullet points
g.vim_markdown_new_list_item_indent = 0 -- no auto-indenting for lists

function setupMarkdownKeybindings()
  local wk = require('which-key')
  wk.register(
    {
      name = 'Markdown',
      ["<CR>"] = { "<Plug>Markdown_EditUrlUnderCursor", "Edit link under cursor" },
      ["]]"] = { "<Plug>Markdown_MoveToNextHeader", "Go to next header" },
      ["[["] = { "<Plug>Markdown_MoveToPreviousHeader", "Go to previous header" },
      ["<leader>toc"] = { ":Toc<CR>", "Table of Contents" },
      ["<leader>itoc"] = { ":InsertToc<CR>", "Insert Table of Contents" },
    }, {
      buffer = vim.api.nvim_get_current_buf()
    }
  )
end
vim.cmd('autocmd FileType markdown lua setupMarkdownKeybindings()')
