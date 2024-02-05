return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/knowledge-notes/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/knowledge-notes/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      workspaces = {
        {
          name = "knowledge-notes",
          path = "~/Documents/knowledge-notes",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_notes_location = 'current_dir',
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      disable_frontmatter = false,
      -- -- Optional, alternatively you can customize the frontmatter data.
      -- note_frontmatter_func = function(note)
      --   -- This is equivalent to the default frontmatter function.
      --   local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      --   -- `note.metadata` contains any manually added fields in the frontmatter.
      --   -- So here we just make sure those fields are kept in the frontmatter.
      --   if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      --     for k, v in pairs(note.metadata) do
      --       out[k] = v
      --     end
      --   end
      --   return out
      -- end,
      templates = {
        subdir = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({"open", url})  -- Mac OS
        vim.fn.jobstart({ "xdg-open", url }) -- linux
      end,
    }
  },

  -- Markdown
  {
    'preservim/vim-markdown',
    ft = 'markdown',
    config = function()
      local vks = require('user/utils').vks
      local g = vim.g

      g.vim_markdown_folding_disabled = 1        -- no auto-folds plz
      g.vim_markdown_no_default_key_mappings = 1 -- figured to set myself
      g.vim_markdown_conceal = 2
      g.vim_markdown_follow_anchor = 1           -- go-to link
      -- This is commented out for Obsidian support
      -- g.vim_markdown_frontmatter = 1 -- YAML frontmatter
      g.vim_markdown_strikethrough = 1        -- ~~strikethrough~~
      g.vim_markdown_auto_insert_bullets = 0  -- no auto-insert bullet points
      g.vim_markdown_new_list_item_indent = 0 -- no auto-indenting for lists

      -- Command for easy making markdown link
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      -- FIXME: `cd` into dir if path isn't path of files
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
              local file_without_ext = string.sub(file_without_dashes, 0, ext_indx - 1)
              local md_link = string.format("[%s](./%s)", file_without_ext, filename)
              vim.api.nvim_put({ md_link }, "", false, true)
            end)
            return true
          end,
        }
      end

      local curr_buf = vim.api.nvim_get_current_buf()
      vks('n', '<CR>', '<Plug>Markdown_EditUrlUnderCursor', { desc = 'Edit link under cursor', buffer = curr_buf })
      vks('n', ']]', '<Plug>Markdown_MoveToNextHeader', { desc = 'Go to next header', buffer = curr_buf })
      vks('n', '[[', '<Plug>Markdown_MoveToPreviousHeader', { desc = 'Go to previous header', buffer = curr_buf })

      vks('n', '<leader>t', ':Toc<CR>', { desc = 'Table of Contents', buffer = curr_buf })
      vks('n', '<leader>it', ':InsertToc<CR>', { desc = 'Insert Table of Contents', buffer = curr_buf })
      vks('n', '<leader>ml', make_markdown_link, { desc = 'Make Markdown Link', buffer = curr_buf })
    end,
  },
}
