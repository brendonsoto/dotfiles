require('nvim-treesitter.configs').setup({
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
    "python",
    "query",
    "regex",
    "ruby",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
  },
  sync_install = false,
  auto_install = false,
  ignore_install = {},
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
  indent = {
    enable = true,
    disable = {
      'markdown', -- for lists
    }
  },
  textobjects = { enable = true }
})
