local wezterm = require 'wezterm'
local config = wezterm.config_builder()



-- This is where you actually apply your config choices.

-- Powershell 7!
config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }

config.max_fps = 255

config.initial_cols = 120
config.initial_rows = 28

config.font_size = 12
config.font = wezterm.font 'Hack Nerd Font'
config.color_scheme = 'Paul Millr'

config.window_background_opacity = 0.8

-- Start in fullscreen
local mux = wezterm.mux
wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)



-- Finally, return the configuration to wezterm:
return config
