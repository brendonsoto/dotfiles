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
  {
    key = 'L',
    mods = 'LEADER',
    action = act.ShowLauncher,
  },
  {
    key = 't',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },

  -- Pane management
  {
    key = '\\',
    mods = 'LEADER',
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
  {
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },

  -- Pane movement
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },

  -- Pane readjustment
  {
    key = 'R',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

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

}

config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 5 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  }
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
