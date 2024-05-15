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
