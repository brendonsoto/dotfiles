return {
  -- tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- require('tokyonight').setup({
      --   -- I like transparency, but only when I can have my editor in one window
      --   -- and switching windows is immediate, no animation or delay. The
      --   -- animation makes me a bit nauseaous and I haven't made the time to
      --   -- look into reducing motion on MacOS & Linux.
      --   -- transparent = true,
      --   -- styles = {
      --   --   markup = {
      --   --     italic = {
      --   --       markdown_inline = {
      --   --         italic = true
      --   --       }
      --   --     }
      --   --   }
      --   -- }
      -- })
      vim.cmd([[colorscheme tokyonight-night]])

      -- Enable italics in markdown files
      vim.api.nvim_set_hl(0, '@markup.italic.markdown_inline', { link = '@markup.emphasis' })
    end,
  },
}
