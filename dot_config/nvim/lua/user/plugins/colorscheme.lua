return {
  -- tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'storm',
        transparent = true,
        -- styles = {
        --   markup = {
        --     italic = {
        --       markdown_inline = {
        --         italic = true
        --       }
        --     }
        --   }
        -- }
      })
      vim.cmd([[colorscheme tokyonight]])

      -- Enable italics in markdown files
      vim.api.nvim_set_hl(0, '@markup.italic.markdown_inline', { link = '@markup.emphasis' })
    end,
  },
}
