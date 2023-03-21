return {
  -- tokyonight
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        style = "night",
      }
    end,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
