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

            level_1 = {enabled = true, icon = "1"},

            level_2 = {enabled = true, icon = " 2"},

            level_3 = {enabled = true, icon = "  3"},

            level_4 = {enabled = true, icon = "   4"},

            level_5 = {enabled = true, icon = "    5"},

            level_6 = {enabled = true, icon = "     6"}
          },
          marker = {enabled = true, icon = ""},
          todo = {
            done = { enabled = true, icon = "X" },
            pending = { enabled = true, icon = "-" },
            undone = { enabled = true, icon = " " },
          }
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
          work = "~/neorg-work",
          zettle = "~/dotfiles/meine_zettlekasten",
          zettle2 = "~/dotfiles/zettle2",
          notes = "~/dotfiles/notes"
        },
        autodetect = true,
        autochdir = true
      }
    }
  },
}
