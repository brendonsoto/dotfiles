local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g
local set = vim.opt -- to set options

cmd([[
  filetype plugin indent on " Enable file detection and load any plugins for them
]])

g.mapleader = ' '
g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]] -- Hide hidden files by default

set.clipboard:append('unnamedplus') -- Use the clipboard register + in addition to the default
set.completeopt = {'menu', 'menuone', 'noselect'} -- NOTE: from nvim-cmp
set.expandtab = true
set.hidden = true
set.history = 50
set.ignorecase = true
set.inccommand = "split" -- Show substitutions as you go
set.joinspaces = false -- Joining lines w/ punctuations adds only one space
set.linebreak = true
set.list = true
set.modeline = false
set.mouse = "a"
set.foldenable = false
set.number = true
set.path = "$PWD/**"
set.relativenumber = true
-- set.scrolloff = 4
set.shiftround = true
set.shiftwidth = 2
set.showmatch = true
set.smartcase = true
set.smartindent = true
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 2
set.termguicolors = true
set.timeoutlen = 500
set.undofile = true
set.undolevels = 100
set.undoreload = 1000

local disabled_built_ins = {
    -- "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
    "gzip", "zip",
    "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin",
    "2html_plugin", "logipat", "rrhelper", "spellfile_plugin"
}

for _, plugin in pairs(disabled_built_ins) do g["loaded_" .. plugin] = 1 end

set.background = "dark"

cmd([[highlight Comment cterm=italic]])
cmd([[highlight Normal guibg=none]])
