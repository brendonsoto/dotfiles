return {
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    opts = {
      indent = {
        char = "|",
        tab_char = ">",
      },
      exclude = {
        filetypes = {
          -- Defaults
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
          -- Others
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
        },
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function ()
      vim.notify = require('notify')
      -- Set a background for Notify based on TokyoNight Storm
      vim.cmd([[highlight NotifyBackground guibg=#1f2335]])

      -- Utility functions shared between progress reports for LSP and DAP

      local client_notifs = {}

      local function get_notif_data(client_id, token)
        if not client_notifs[client_id] then
          client_notifs[client_id] = {}
        end

        if not client_notifs[client_id][token] then
          client_notifs[client_id][token] = {}
        end

        return client_notifs[client_id][token]
      end


      local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

      local function update_spinner(client_id, token)
        local notif_data = get_notif_data(client_id, token)

        if notif_data.spinner then
          local new_spinner = (notif_data.spinner + 1) % #spinner_frames
          notif_data.spinner = new_spinner

          notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification,
          })

          vim.defer_fn(function()
            update_spinner(client_id, token)
          end, 100)
        end
      end

      local function format_title(title, client_name)
        return client_name .. (#title > 0 and ": " .. title or "")
      end

      local function format_message(message, percentage)
        return (percentage and percentage .. "%\t" or "") .. (message or "")
      end

      -- table from lsp severity to vim severity.
      local severity = {
        "error",
        "warn",
        "info",
        "info", -- map both hint and info to info?
      }
      vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
        vim.notify(method.message, severity[params.type])
      end
    end
  }
}
