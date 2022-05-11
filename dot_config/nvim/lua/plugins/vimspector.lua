local fn = vim.fn

local is_wk_present, wk = pcall(require, 'which-key')
if (is_wk_present == false) then
    print('which-key not found')
    return
end

wk.register({
  name = 'Debug',
  r = { function() fn['vimspector#Restart']() end, 'Restart debugger' },
  x = { function() fn['vimspector#Reset']() end, 'Exit debugger' },
  c = { function() fn['vimspector#Continue']() end, 'Continue debugging' },
  t = { function() fn['vimspector#ToggleBreakpoint']() end, 'Toggle breakpoint' },
  j = { function() fn['vimspector#StepInto']() end, 'Step into' },
  k = { function() fn['vimspector#StepOut']() end, 'Step out' },
  l = { function() fn['vimspector#StepOver']() end, 'Step over' },
}, { prefix = '<leader>d' })
