require('aerial').setup({
  default_bindings = false,
  on_attach = function()
    require('which-key').register({
      name = 'Aerial',
      a = {
        t = {'<cmd>AerialToggle!<cr>', 'Aerial Toggle'},
        n = {
          i = {'<cmd>AerialNext<cr>', 'Aerial Next inner func/method'},
          o = {'<cmd>AerialNextUp<cr>', 'Aerial Next outer func/method'},
        },
        p = {
          i = {'<cmd>AerialPrev<cr>', 'Aerial Prev inner func/method'},
          o = {'<cmd>AerialPrevUp<cr>', 'Aerial Prev outer func/method'},
        },
      }
    }, { prefix = '<leader>' })
  end
})

require('telescope').load_extension('aerial')
