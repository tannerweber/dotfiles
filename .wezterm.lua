-- Tanner Weber
-- .wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Windows Powershell 7
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
end

-- Appearance
config.max_fps = 255
config.color_scheme = 'Paul Millr (Gogh)'
config.window_background_opacity = 0.90
config.font_size = 12
config.font = wezterm.font 'Hack Nerd Font'
config.window_decorations = 'RESIZE'
config.use_fancy_tab_bar = true
config.enable_tab_bar = true

-- Keyboard Encoding
config.allow_win32_input_mode = false
config.enable_kitty_keyboard = true

--[[
-- Start in fullscreen
local mux = wezterm.mux
wezterm.on('gui-startup', function(window)
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window();
  gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)
--]]

-- Binds
local act = wezterm.action
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },

  -- Fix key encoding for ANSI sequences
  { key = 'a', mods = 'CTRL', action = act.SendString '\x01' },
  { key = 'b', mods = 'CTRL', action = act.SendString '\x02' },
  { key = 'c', mods = 'CTRL', action = act.SendString '\x03' },
  { key = 'd', mods = 'CTRL', action = act.SendString '\x04' },
  { key = 'e', mods = 'CTRL', action = act.SendString '\x05' },
  { key = 'f', mods = 'CTRL', action = act.SendString '\x06' },
  { key = 'g', mods = 'CTRL', action = act.SendString '\x07' },
  { key = 'h', mods = 'CTRL', action = act.SendString '\x08' },
  { key = 'i', mods = 'CTRL', action = act.SendString '\x09' },
  { key = 'j', mods = 'CTRL', action = act.SendString '\x0A' },
  { key = 'k', mods = 'CTRL', action = act.SendString '\x0B' },
  { key = 'l', mods = 'CTRL', action = act.SendString '\x0C' },
  { key = 'm', mods = 'CTRL', action = act.SendString '\x0D' },
  { key = 'n', mods = 'CTRL', action = act.SendString '\x0E' },
  { key = 'o', mods = 'CTRL', action = act.SendString '\x0F' },
  { key = 'p', mods = 'CTRL', action = act.SendString '\x10' },
  { key = 'q', mods = 'CTRL', action = act.SendString '\x11' },
  { key = 'r', mods = 'CTRL', action = act.SendString '\x12' },
  { key = 's', mods = 'CTRL', action = act.SendString '\x13' },
  { key = 't', mods = 'CTRL', action = act.SendString '\x14' },
  { key = 'u', mods = 'CTRL', action = act.SendString '\x15' },
  { key = 'v', mods = 'CTRL', action = act.SendString '\x16' },
  { key = 'w', mods = 'CTRL', action = act.SendString '\x17' },
  { key = 'x', mods = 'CTRL', action = act.SendString '\x18' },
  { key = 'y', mods = 'CTRL', action = act.SendString '\x19' },
  { key = 'z', mods = 'CTRL', action = act.SendString '\x1A' },
  { key = 'UpArrow', action = act.SendString '\x1b[A' },
  { key = 'DownArrow', action = act.SendString '\x1b[B' },
  { key = 'RightArrow', action = act.SendString '\x1b[C' },
  { key = 'LeftArrow', action = act.SendString '\x1b[D' },

  -- Navigation bindings
  { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = false }, },
  { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'c', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 's', mods = 'ALT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = 'd', mods = 'ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = 'h', mods = 'ALT', action = act{ActivatePaneDirection="Left"} },
  { key = 'j', mods = 'ALT', action = act{ActivatePaneDirection="Down"} },
  { key = 'k', mods = 'ALT', action = act{ActivatePaneDirection="Up"} },
  { key = 'l', mods = 'ALT', action = act{ActivatePaneDirection="Right"} },
  { key = '1', mods = 'ALT', action = act{ActivateTab=0} },
  { key = '2', mods = 'ALT', action = act{ActivateTab=1} },
  { key = '3', mods = 'ALT', action = act{ActivateTab=2} },
  { key = '4', mods = 'ALT', action = act{ActivateTab=3} },
  { key = '5', mods = 'ALT', action = act{ActivateTab=4} },
  { key = '6', mods = 'ALT', action = act{ActivateTab=5} },
  { key = '7', mods = 'ALT', action = act{ActivateTab=6} },
  { key = '8', mods = 'ALT', action = act{ActivateTab=7} },
  { key = '9', mods = 'ALT', action = act{ActivateTab=8} },

  -- Tmux like binds using a leader key
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = '1', mods = 'LEADER', action = act{ActivateTab=0} },
  { key = '2', mods = 'LEADER', action = act{ActivateTab=1} },
  { key = '3', mods = 'LEADER', action = act{ActivateTab=2} },
  { key = '4', mods = 'LEADER', action = act{ActivateTab=3} },
  { key = '5', mods = 'LEADER', action = act{ActivateTab=4} },
  { key = '6', mods = 'LEADER', action = act{ActivateTab=5} },
  { key = '7', mods = 'LEADER', action = act{ActivateTab=6} },
  { key = '8', mods = 'LEADER', action = act{ActivateTab=7} },
  { key = '9', mods = 'LEADER', action = act{ActivateTab=8} },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } },
  { key = 'h', mods = 'LEADER', action = act{ActivatePaneDirection="Left"} },
  { key = 'j', mods = 'LEADER', action = act{ActivatePaneDirection="Down"} },
  { key = 'k', mods = 'LEADER', action = act{ActivatePaneDirection="Up"} },
  { key = 'l', mods = 'LEADER', action = act{ActivatePaneDirection="Right"} },
}

-- Tab bar style
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Foreground = { Color = 'white' } },
        { Background = { Color = 'black' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
  end
)

-- Return the configuration to wezterm
return config
