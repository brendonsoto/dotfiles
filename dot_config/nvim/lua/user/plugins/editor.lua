-- Editor here is for plugins that provide more of an IDE-like experience
-- Got the naming from LazyVim
return {
  -- Editorconfig integration
  { 'gpanders/editorconfig.nvim' },

  -- File Explorer
  {
    'is0n/fm-nvim',
    opts = {
      ui = {
        -- Border around floating window
        border = "double", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

        -- Percentage (0.8 = 80%)
        height = 1,
        width = 1,
      }
    },
    keys = {
      {
        '<leader>fm',
        ':Xplr %:p:h<cr>',
        'n',
        desc = 'File Manager',
      },
    },
    -- config = function()
    --   require('user.plugins.fm')
    -- end,
  },

  -- Git
  -- { 'tpope/vim-fugitive' },
  -- {
  --   'lewis6991/gitsigns.nvim',
  --   init = function()
  --     local vks = vim.keymap.set
  --     vks('n', ']h', '<cmd>Gitsigns next_hunk<cr>', { desc = 'Git next hunk' })
  --     vks('n', '[h', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'Git next hunk' })
  --     vks('n', 'gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { desc = 'Toggle line blame' })
  --   end,
  --   config = true,
  -- },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },

  -- I don't really use this and always forget
  -- Harpoon. Ahab go brrr
  -- {
  --   'ThePrimeagen/harpoon',
  --   dependencies = { 'nvim-telescope/telescope.nvim' },
  --   config = function()
  --     local vks = require('user/utils').vks
  --     local mark = require('harpoon.mark')
  --     local ui = require('harpoon.ui')
  --
  --     vks('n', '<leader>mf', mark.add_file, { desc = 'Harpoon - mark file' })
  --     vks('n', '<leader>ms', ui.toggle_quick_menu, { desc = 'Harpoon - toggle ui (Marks Show)' })
  --
  --     -- Using hjkl as my way to remember 1,2,3,4
  --     vks('n', '<C-h>', function() ui.nav_file(1) end, { desc = 'Harpoon - go to file 1' })
  --     vks('n', '<C-j>', function() ui.nav_file(2) end, { desc = 'Harpoon - go to file 2' })
  --     vks('n', '<C-k>', function() ui.nav_file(3) end, { desc = 'Harpoon - go to file 3' })
  --     vks('n', '<C-l>', function() ui.nav_file(4) end, { desc = 'Harpoon - go to file 4' })
  --
  --     -- Telescope integration
  --     require('telescope').load_extension('harpoon')
  --     vks('n', '<leader>th', ':Telescope harpoon marks<CR>', { desc = 'Telescope Harpoon Marks' })
  --   end,
  -- },

  -- Highlighting other uses of the word under cursor
  { 'RRethy/vim-illuminate' },

  -- Named tabs!!
  { 'gcmt/taboo.vim' },

  -- Telescope!!
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local previewers = require('telescope.previewers')
      local builtin = require('telescope.builtin')
      local vks = vim.keymap.set

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
        defaults = {
          buffer_previewer_maker = new_maker,
          path_display = { 'truncate' },
        },
        extensions = {
          heading = {
            treesitter = true,
          },
        },
        pickers = {
          find_files = {
            find_command = {
              'rg', '--ignore', '--hidden', '--files', '-g', '!.git/*'
            },
            follow = true
          }
        },
      }

      -- Command for easy making markdown link
      -- local make_markdown_link = function()
      --   require('telescope.builtin').find_files {
      --     prompt_title = "Link file",
      --     attach_mappings = function(prompt_bufnr, _)
      --       actions.select_default:replace(function()
      --         actions.close(prompt_bufnr)
      --         local selection = action_state.get_selected_entry()
      --         local filename = selection[1]
      --         local file_without_dashes = string.gsub(filename, "-", " ")
      --         local ext_indx = string.find(filename, "%.")
      --         local file_without_ext = string.sub(file_without_dashes, 0, ext_indx - 1)
      --         local md_link = string.format("[%s](./%s)", file_without_ext, filename)
      --         vim.api.nvim_put({ md_link }, "", false, true)
      --       end)
      --       return true
      --     end,
      --   }
      -- end

      -- Manage sessions
      local session_pick = function()
        local sessions_dir = vim.fn.stdpath("data") .. '/sessions/'
        vim.loop.fs_mkdir(sessions_dir, 493) -- 493 = 0755

        require('telescope.builtin').find_files {
          prompt_title = 'Sessions (Creates one if input doesn\'t exist)',
          cwd = sessions_dir,
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()

              -- If the selection isn't an existing file, create a new one
              if selection == nil then
                local new_file = action_state.get_current_line()
                local filepath = sessions_dir .. new_file

                -- Accomodate my laziness of not wanting to add the file extension
                if string.find(new_file, '.vim') == nil then
                  filepath = filepath .. '.vim'
                end

                vim.cmd.mksession(filepath)
                print('Made new session file: ' .. filepath)
              else
                local filename = selection[1]
                local filepath = sessions_dir .. filename
                vim.cmd.source(filepath) -- same as `:Source <session.vim>`
              end
            end)
            return true
          end
        }
      end

      -- Delete sessions
      local session_delete = function()
        local sessions_dir = vim.fn.stdpath("data") .. '/sessions/'

        require('telescope.builtin').find_files {
          prompt_title = 'Delete session',
          cwd = sessions_dir,
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()

              -- If the selection isn't an existing file, create a new one
              if selection ~= nil then
                local filename = selection[1]
                local filepath = sessions_dir .. filename
                vim.fn.delete(filepath) -- same as `:Source <session.vim>`
              end
            end)
            return true
          end
        }
      end


      -- Setup Telescope specific keybindings
      vks('n', '<leader>f<space>', builtin.builtin, { desc = 'Telescope Builtin' })
      vks('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffer' })
      vks('n', '<leader>fd', builtin.lsp_definitions, { desc = '(LSP) Definitions' })
      vks('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
      vks('n', '<leader>fh', builtin.help_tags, { desc = 'Help tag' })
      vks('n', '<leader>fi', builtin.lsp_implementations, { desc = '(LSP) Implementations' })
      vks('n', '<leader>fj', builtin.jumplist, { desc = 'Jumplist' })
      vks('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
      vks('n', '<leader>fo', function() builtin.oldfiles({ only_cwd = true }) end, { desc = 'Old files' })
      vks('n', '<leader>fr', builtin.lsp_references, { desc = '(LSP) Find References' })
      vks('n', '<leader>fsa', builtin.lsp_document_symbols, { desc = '(LSP) Document Symbols - All' })
      vks('n', '<leader>fsf', function() builtin.lsp_document_symbols({ symbols = 'function' }) end, { desc = '(LSP) Document Symbols - Functions' })
      vks('n', '<leader>ft', builtin.lsp_type_definitions, { desc = '(LSP) Type Definitions' })
      vks('n', '<leader>fx', builtin.diagnostics, { desc = '(LSP) Diagnostic list' })
      vks('n', '<leader>g', builtin.live_grep, { desc = 'Live grep' })
      vks('n', '<leader>sp', session_pick, { desc = 'Pick Session' })
      vks('n', '<leader>sd', session_delete, { desc = 'Delete Session' })
    end,
  },
  {
    'crispgm/telescope-heading.nvim',
    config = function()
      local vks = vim.keymap.set
      require('telescope').load_extension('heading')
      vks('n', '<leader>dh', ':Telescope heading<CR>', { desc = 'Doc header (Markdown)' })
    end,
  },

  -- Not sure I actually use this...
  -- Session managment
  -- {
  --   'rmagatti/auto-session',
  --   config = function()
  --     vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  --     require('auto-session').setup({
  --       auto_session_enabled = false,
  --       auto_save_enabled = false,
  --       auto_restore_enabled = false,
  --       auto_session_use_git_branch = true,
  --     })
  --     require('telescope').load_extension('session-lens')
  --   end,
  -- },

  -- Undo tree
  -- Uncomment when you plan on actually using it
  -- {
  --   'mbbill/undotree',
  --   config = function()
  --     vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
  --     vim.g.undotree_SetFocusWhenToggle = 1
  --   end
  -- }
}
