-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

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
-- config.window_background_opacity = 0.02
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

-- and finally, return the configuration to wezterm
return config
