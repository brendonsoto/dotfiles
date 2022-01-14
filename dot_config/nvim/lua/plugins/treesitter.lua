local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = {"src/parser.c", "src/scanner.cc"},
        branch = "main"
    }
}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "c", "css", "dockerfile", "graphql", "haskell", "html", "javascript",
        "jsdoc", "json", "lua", "norg", "regex", "ruby", "scss", "tsx",
        "typescript", "vim", "vue"
    },
    highlight = {
        enable = true,
        custom_captures = {NOTE = "Special"},
        additional_vim_regex_highlighting = false
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    incremental_selection = {enable = true},
    textobjects = {enable = true}
}
