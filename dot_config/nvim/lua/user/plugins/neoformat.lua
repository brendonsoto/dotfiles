local g = vim.g

-- Enable alignment
g.neoformat_basic_format_align = 1

-- Enable tab to spaces conversion
g.neoformat_basic_format_retab = 2

-- Enable trimmming of trailing whitespace
g.neoformat_basic_format_trim = 1

-- Have Neoformat only msg when there is an error
g.neoformat_only_msg_on_error = 1

-- Try checking node_modules/.bin
-- NOTE: only applies to formatters with try_node_exe set to 1
g.neoformat_try_node_exe = 1

-- Format on save
vim.cmd([[
  augroup fmt
    autocmd!
    autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx,*.html undojoin | Neoformat
  augroup END
]])
