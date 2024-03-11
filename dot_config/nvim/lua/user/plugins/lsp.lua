local servers = {
  'eslint',
  'html',
  'lua_ls',
  'marksman',
  'tsserver',
}

return {
  -- LSP stuff
  -- {
  --   'j-hui/fidget.nvim',
  --   config = function() require('fidget').setup({}) end
  -- },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = function ()
      local lspconfig = require('lspconfig')
      local vks = require('user.utils').vks
      local buf = vim.lsp.buf

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vks('n', 'gd', buf.definition, { desc = 'Go to definition' })
        vks('n', 'gD', buf.declaration, { desc = 'Go to declaration' })
        vks('n', 'gi', buf.implementation, { desc = 'Go to implementation' })
        -- vks('n', 'gr', buf.references, { desc = 'See references' })
        vks('n', 'gt', buf.type_definition, { desc = 'Go to type definition' })
        -- vks('n', 'K', buf.hover, { desc = 'Hover' })
        -- vks('n', '<leader>ca', buf.code_action, { desc = 'Code action' })
        vks('n', '<leader>fc', buf.formatting, { desc = 'format code' })
      end

      -- NOTE: Using this instead of cmp for now because cmp's capabilites don't work
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      return {
        ensure_installed = servers,
        automatic_installation = true,
        handlers = {
          -- The default handler
          -- Will be called for each installed server that doesn't have
          -- a dedicated handler.
          function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          -- Specific servers
          ["lua_ls"] = function ()
            lspconfig.lua_ls.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                  },
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'}
                  },
                  workspace = {
                    -- Prevent asking if I'm using libs every time
                    checkThirdParty = false,
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  -- Do not send telemetry data containing a randomized but unique identifier
                  telemetry = {enable = false}
                }
              }
            }
          end,

          ["eslint"] = function ()
            lspconfig.eslint.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                filetypes = {
                  "graphql",
                  "javascript",
                  "javascriptreact",
                  "javascript.jsx",
                  "typescript",
                  "typescriptreact",
                  "typescript.tsx",
                  "vue",
                }
              }
            }
          end,
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Extras
      -- Configure more helpful virtual text
      vim.diagnostic.config {
        virtual_text = false,
        float = {
          format = function(diagnostic)
            if diagnostic.source == 'eslint' then
              return string.format(
              '[%s]\n%s',
              diagnostic.user_data.lsp.code,
              -- shows the name of the rule
              diagnostic.message
              )
            end
            return string.format('%s [%s]', diagnostic.message, diagnostic.source)
          end,
          severity_sort = true,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          max_width = 80,
        },
      }
    end
  },
  { 'jose-elias-alvarez/null-ls.nvim' },
  {
    'nvimdev/lspsaga.nvim',
    -- event = 'BufRead',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = function()
      return {
        finder = {
          max_height = 0.8,
          left_width = 0.4,
          right_width = 0.4,
          keys = {
            toggle_or_open = '<CR>',
            quit = { 'q', '<ESC>' },
            vsplit = 'v',
            split = 's',
            tabe = 't',
          },
        },
        outline = {
          layout = 'float',
          -- commented out because its all the default but i'll forget
          -- keys = {
          --   toggle_or_jump = 'o',
          --   quit = 'q',
          --   jump = 'e',
          -- },
        },
      }
    end,
    config = function(_, opts)
      require('lspsaga').setup(opts)

      local vks = require('user.utils').vks
      -- Lsp finder find the symbol definition implement reference
      -- if there is no implement it will hide
      -- when you use action in finder like open vsplit then you can
      -- use <C-t> to jump back
      vks('n', 'gh', '<cmd>Lspsaga finder<CR>', { desc = 'LSP finder', silent = true })

      -- Code action
      vks({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code action', silent = true })

      -- Rename
      -- vks('n', 'gr', '<cmd>Lspsaga rename<CR>', { desc = 'LSP rename', silent = true })

      -- Peek Definition
      -- you can edit the definition file in this flaotwindow
      -- also support open/vsplit/etc operation check definition_action_keys
      -- support tagstack C-t jump back
      vks('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek definition', silent = true })

      -- Show line diagnostics
      vks('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })

      -- Show cursor diagnostic
      vks('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })

      -- Diagnsotic jump can use `<c-o>` to jump back
      vks('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
      vks('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

      -- Trying out incoming/outgoing calls
      vks('n', 'gci', '<cmd>Lspsaga incoming_calls<CR>', { silent = true })
      vks('n', 'gco', '<cmd>Lspsaga outgoing_calls<CR>', { silent = true })

      -- Only jump to error
      vks('n', '[e', function()
        require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })
      vks('n', ']e', function()
        require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })

      -- Outline
      vks('n', '<leader>o', '<cmd>Lspsaga outline<CR>', { desc = 'LSP Outline', silent = true })

      -- Hover Doc
      vks('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
    end,
  },

  {
    'simrat39/rust-tools.nvim',
    opts = function()
      local rt = require('rust-tools')
      return {
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set('n', '<c-space>', rt.hover_actions.hover_actions,
            { buffer = bufnr, desc = '[Rust Tools] Hover actions' })
            -- Code action groups
            vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group,
            { buffer = bufnr, desc = '[Rust Tools] Action groups' })
          end,

          settings = {
            ['rust-analyzer'] = {
              inlayHints = { locationLinks = false },
            },
          },
        },
      }
    end,
  },
}
