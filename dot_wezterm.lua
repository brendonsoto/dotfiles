-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = 'Tokyo Night Storm'

config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 16.0

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Launchers
  { key = 'L', mods = 'LEADER', action = act.ShowLauncher },
  { key = 't', mods = 'LEADER', action = act.ShowTabNavigator },

  -- Pane management
  {
    key = '|',
    -- The shift is needed in linux land...
    mods = 'LEADER|SHIFT',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- Pane movement
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },


  -- Workspaces
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'W',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },

  -- Move tabs programmatically
  { key = '{', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },

  -- KEY TABLE ACTIVATION
  -- Finding Workspaces/Tabs
  {
    key = 'f',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'find',
    },
  },

  -- Naming Workspaces/Tabs
  {
    key = 'n',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'naming',
    },
  },

  -- Pane readjustment
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  -- Screen
  {
    key = ']',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'screen',
      one_shot = false,
    },
  },
}

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 5 } },
    -- Canceling modes by pressing escape or ctrl-c
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'c', mods = 'CTRL', action = 'PopKeyTable' },
  },

  naming = {
    {
      key = 't',
      action = act.PromptInputLine {
        description = 'What do you want to call this TAB?',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
    {
      key = 'w',
      action = act.PromptInputLine {
        description = 'What do you want to call this WORKSPACE?',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(
              wezterm.mux.get_active_workspace(),
              line
            )
          end
        end),
      },
    },
  },

  find = {
    {
      key = 'w',
      action = act.ShowLauncherArgs {
        flags = 'FUZZY|WORKSPACES',
      },
    },
  },

  screen = {
    { key = 'j', action = act.ScrollByLine(1) },
    { key = 'k', action = act.ScrollByLine(-1) },
    { key = 'u', action = act.ScrollByPage(-1) },
    { key = 'd', action = act.ScrollByPage(1) },
    { key = 'G', action = act.ScrollToBottom },
    { key = 'g', action = act.ScrollToTop },
    -- Canceling modes by pressing escape or ctrl-c
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'c', mods = 'CTRL', action = 'PopKeyTable' },
    { key = ']', mods = 'CTRL', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
}

-- config.window_background_image = '$HOME/Pictures/wallpapers/prince_x_nic_cage.jpg'
config.window_background_opacity = 0.9
-- config.window_background_gradient = {
--   orientation = {
--     Radial = {
--       cx = 0.75,
--       cy = 0.75,
--       radius = 1.25,
--     },
--   },
--   colors = { 'blueviolet', 'indigo', 'black' }
--   -- preset = 'Magma'
-- }
-- config.background = {
--   {
--     source = {
--       File = '$HOME/Pictures/wallpapers/patrick_nigel.png',
--     }
--   }
-- }

config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.6,
}

-- FOR WORK SETUPs:
-- Use the below to automate making multiple windows with diff panes
-- wezterm.on('gui-startup', function(cmd)
--   local work_root = '/path/to/work/dir'
--
--   -- Create our base setup to work off of
--   local tab, pane, window = mux.spawn_window(cmd or {})
--
--   -- Maximize the window so split pane sizes are set correctly
--   window:gui_window():maximize()
--
--   -- Sleep since window resizing is async
--   -- https://github.com/wez/wezterm/issues/3671
--   wezterm.sleep_ms(1000)
--
--   -- Rename first tab to use for ad-hoc tool config purposes
--   tab:set_title('config')
--
--
--   -- logs
--   tab, pane, window = window:spawn_tab({
--     cwd = work_root,
--   })
--   tab:set_title('logs')
--
--   -- The goal is to have 2 rows & 2 cols, all the same size
--   local pane_a = pane
--   local pane_b = pane_a:split({ direction = 'Right' })
--   pane_a:split({ direction = 'Bottom' })
--   pane_b:split({ direction = 'Bottom' })
--
--
--   -- Create Work root + obsid tab
--   tab, pane, window = window:spawn_tab({
--     cwd = work_root,
--   })
--   local work_root_pane = pane
--
--   tab:set_title('work_root + obsid')
--
--   pane:split({
--     cwd = '/path/to/work/obsidian',
--     direction = 'Right',
--   })
--
--
--   -- Create a tab w/ panes
--   tab, pane, window = window:spawn_tab({
--     cwd = work_root .. '/project',
--   })
--
--   tab:set_title('Project A')
--
--   -- Create the tooling area with panes for Build/Lint/Test
--   local tooling_pane = pane:split({ direction = 'Bottom', size = 0.2 }) -- Bottom for all tools
--   tooling_pane:split({ direction = 'Left', size = 0.333 }) -- Left 1/3rd
--   tooling_pane:split({ direction = 'Left', size = 0.5 }) -- Split remaining 2/3rds into 1/2
--   -- tooling_pane now is the last third to be used for Testing
--
--   -- Create Tab with just bottom row for tooling
--   tab, pane, window = window:spawn_tab({
--     cwd = work_root .. '/other/project',
--   })
--   tab:set_title('Project B')
--   pane:split({ direction = 'Bottom', size = 0.2 })
--
--
--   -- Set the focus back to the tab with the monorepo root
--   work_root_pane:activate()
-- end)


-- and finally, return the configuration to wezterm
return config
