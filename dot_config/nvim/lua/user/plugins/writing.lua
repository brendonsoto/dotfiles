local mkdn_template = [[
---
createdAt: {{ date }}
tags:
- 
---
]]

return {
  -- Goyo -- focus-ish zone
  {
    -- This is mostly for writing for centering the writing area
    'junegunn/goyo.vim',
  },
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
  },
  {
    'jakewvincent/mkdnflow.nvim',
    config = function()
      require('mkdnflow').setup({
        modules = {
          cmp = true,
          yaml = true,
        },
        links = {
          conceal = true,
        },
        new_file_template = {
          use_template = true,
          template = mkdn_template,
          placeholders = {
            before = {
              date = function()
                return os.date("%Y-%m-%dT%H:%MZ")
              end
            },
          },
        },
        mappings = {
          MkdnGoBack = {'n', '<C-p>'},
          MkdnGoForward = {'n', '<C-n>'},
          MkdnFoldSection = {'n', '<c-f>'},
          MkdnUnfoldSection = {'n', '<c-F>'},
        },
      })
    end
  }
}
