return {
  -- LSP stuff
  {
    'j-hui/fidget.nvim',
    config = function() require('fidget').setup({}) end
  },
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
    opts = {
      ensure_installed = servers,
      automatic_installation = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      return {
        eslint = {
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
        },

        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                }
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {enable = false}
            }
          }
        }
      }
    end,
    config = function()
      local vks = require('user.utils').vks
      local buf = vim.lsp.buf
      local servers = {
        'eslint',
        'html',
        'lua_ls',
        'tsserver',
      }

      -- Setup LSP configs
      for _, server in pairs(servers) do
        local opts = {
          on_attach = function(client, bufnr)
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
          end,

          -- NOTE: Using this instead of cmp for now because cmp's capabilites don't work
          -- M.capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        require("lspconfig")[server].setup(opts)
      end

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
    'glepnir/lspsaga.nvim',
    event = 'BufRead',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = function()
      return {
        outline = {
          auto_close = true,
          auto_preview = true,
          show_detail = true,
          keys = {
            jump = '<CR>',
            expand_collapse = 'u',
            quit = 'q',
          },
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
      vks('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { desc = 'LSP finder', silent = true })

      -- Code action
      vks({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code action', silent = true })

      -- Rename
      vks('n', 'gr', '<cmd>Lspsaga rename<CR>', { desc = 'LSP rename', silent = true })

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
      vks('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
      vks('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })

      -- Only jump to error
      vks('n', '[E', function()
        require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end, { silent = true })
      vks('n', ']E', function()
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
