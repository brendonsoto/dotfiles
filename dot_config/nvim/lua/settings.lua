local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g
local o = vim.o
local set = vim.opt -- to set options

cmd([[
  filetype plugin indent on " Enable file detection and load any plugins for them
]])

g.mapleader = ' '

set.clipboard:append('unnamedplus') -- Use the clipboard register + in addition to the default
set.completeopt = {'menu', 'menuone', 'noselect'}
set.expandtab = true
set.hidden = true
set.history = 50
set.ignorecase = true
set.inccommand = "split"
set.joinspaces = false
set.lazyredraw = true
set.linebreak = true
set.list = true
set.modeline = false
set.mouse = "a"
-- set.number = true
set.path = "$PWD/**"
set.scrolloff = 4
set.shiftround = true
set.shiftwidth = 2
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
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip",
    "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin",
    "2html_plugin", "logipat", "rrhelper", "spellfile_plugin"
}

for _, plugin in pairs(disabled_built_ins) do g["loaded_" .. plugin] = 1 end

-- Set background depending on time of day
-- This is mostly to hint to me that it's time to go home / stop working
local current_hour = tonumber(os.date("%H", os.time()))
local starting_light_hour = 9
local starting_dark_hour = 12 + 5 -- to use 24 hours
local is_day_time = starting_light_hour <= current_hour and current_hour <
                        starting_dark_hour

if (is_day_time) then
    o.background = "light"
else
    o.background = "dark"
end
cmd([[highlight Comment cterm=italic]])
