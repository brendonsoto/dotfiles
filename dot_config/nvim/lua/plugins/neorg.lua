require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.integrations.telescope"] = {},
    ["core.integrations.nvim-cmp"] = {},
    ["core.keybinds"] = {},
    ["core.norg.completion"] = {config = {engine = "nvim-cmp"}},
    ["core.norg.concealer"] = {
      config = {
        icons = {
          heading = {
            enabled = true,

            level_1 = {enabled = true, icon = ""},

            level_2 = {enabled = true, icon = " "},

            level_3 = {enabled = true, icon = "  "},

            level_4 = {enabled = true, icon = "   "},

            level_5 = {enabled = true, icon = "    "},

            level_6 = {enabled = true, icon = "     "}
          },
          marker = {enabled = true, icon = ""},
        },
        conceals = {
          url = true,
          bold = true,
          italic = true,
          underline = true,
          strikethrough = true,
          verbatim = true,
          trailing = true,
          link = true
        }
      }
    },
    ["core.norg.dirman"] = {
      config = {
        -- TODO: Can I use an environment var for this too?
        workspaces = {
          work = "~/documents/neorg-work",
          notes = "~/documents/notes",
        },
        autodetect = true,
        autochdir = true
      }
    }
  },
}
