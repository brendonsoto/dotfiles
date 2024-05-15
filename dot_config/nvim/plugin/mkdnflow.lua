local mkdn_template = [[
---
createdAt: {{ date }}
tags:
- 
---
]]

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
