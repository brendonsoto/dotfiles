require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.integrations.telescope"] = {},
    ["core.integrations.nvim-cmp"] = {},
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
          marker = {enabled = true, icon = ""}
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
  -- logger = {
    --     -- Should print the output to neovim while running
    --     use_console = true,
    --
    --     -- Should highlighting be used in console (using echohl)
    --     highlights = true,
    --
    --     -- Should write to a file
    --     use_file = true,
    --
    --     -- Any messages above this level will be logged.
    --     level = "warn",
    --
    --     -- Level configuration
    --     modes = {
      --         {name = "trace", hl = "Comment"}, {name = "debug", hl = "Comment"},
      --         {name = "info", hl = "None"}, {name = "warn", hl = "WarningMsg"},
      --         {name = "error", hl = "ErrorMsg"}, {name = "fatal", hl = "ErrorMsg"}
      --     },
      --
      --     -- Can limit the number of decimals displayed for floats
      --     float_precision = 0.01
      -- },
      hook = function()
        -- Require the user callbacks module, which allows us to tap into the core of Neorg
        local neorg_callbacks = require('neorg.callbacks')

        -- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
        -- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
        -- needs to reevaluate all the bound keys is invoked
        neorg_callbacks.on_event("core.keybinds.events.enable_keybinds",
        function(_, keybinds)

          -- Map all the below keybinds only when the "norg" mode is active
          -- NOTE: Modified the defaults
          keybinds.map_event_to_mode("norg", {
            n = { -- Bind keys in normal mode

            -- Keys for managing TODO items and setting their states
            {"<leader>td", "core.norg.qol.todo_items.todo.task_done"},
            {"<leader>tu", "core.norg.qol.todo_items.todo.task_undone"},
            {"<leader>tp", "core.norg.qol.todo_items.todo.task_pending"},

            {"<CR>", "core.norg.esupports.goto_link"},

            {"<C-s>", "core.integrations.telescope.find_linkable"},

            {"<M-k>", "core.norg.manoeuvre.item_up"},
            {"<M-j>", "core.norg.manoeuvre.item_down"}
          },
          i = {{"<C-l>", "core.integrations.telescope.insert_link"}}
        }, {silent = true, noremap = true})

        -- Map the below keys only when traverse-heading mode is active
        keybinds.map_event_to_mode("traverse-heading", {
          n = {
            -- Rebind j and k to move between headings in traverse-heading mode
            {"j", "core.integrations.treesitter.next.heading"},
            {"k", "core.integrations.treesitter.previous.heading"}
          }
        }, {silent = true, noremap = true})

        -- Apply the below keys to all modes
        keybinds.map_to_mode("all", {
          n = {
            {"<leader>mn", ":Neorg set-mode norg<CR>"},
            {"<leader>mh", ":Neorg set-mode traverse-heading<CR>"}
          }
        }, {silent = true, noremap = true})

      end)
    end
  }
