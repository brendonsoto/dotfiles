return {
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { 'windwp/nvim-ts-autotag' },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    -- event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return {
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
        },
        ensure_installed = {
          "c",
          "css",
          "dockerfile",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "norg",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "scss",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
        },
        highlight = {
          enable = true,
          custom_captures = { NOTE = "Special" },
          -- additional_vim_regex_highlighting = { "typescriptreact" }
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        incremental_selection = { enable = true },
        indent = { enable = true },
        textobjects = { enable = true }
      }
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
