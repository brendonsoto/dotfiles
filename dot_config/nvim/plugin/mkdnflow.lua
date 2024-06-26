local mkdn_template = [[
---
createdAt: {{ date }}
tags:
- 
---
# {{ title }}



## Related

- Previous in track:
- Next in track:
]]

require('mkdnflow').setup({
  modules = {
    cmp = true,
    yaml = true,
  },
  perspective = {
    priority = 'current',
    fallback = 'first',
  },
  links = {
    conceal = true,
    transform_explicit = function (input)
      return (
        string.lower('./'..os.date('%Y_%m_%d_')..string.gsub(input, ' ', '_'))
      )
    end
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
    MkdnEnter = {{'i', 'n', 'v'}, '<CR>'},
    MkdnGoBack = {'n', '<C-p>'},
    MkdnGoForward = {'n', '<C-n>'},
    MkdnFoldSection = {'n', '<c-f>'},
    MkdnUnfoldSection = {'n', '<c-F>'},
    -- MkdnMoveSource<CR> -- this is interesting
  },
})
