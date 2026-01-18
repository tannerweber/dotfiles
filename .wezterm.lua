-- Tanner Weber
-- .wezterm.lua

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Colors
local col_mantle = '#181825' -- Set for solid background
--local col_mantle = 'rgba(0, 0, 0, 0.90)' -- Set for transparent background
local col_crust = '#11111b'

-- Domains
config.ssh_domains = {
  {
    name = 'babbage',
    remote_address = 'babbage.cs.pdx.edu',
    username = 'tannerw',
  },
  {
    name = 'ada',
    remote_address = 'linux.cs.pdx.edu',
    username = 'tannerw',
  },
}
config.unix_domains = {
  {
    name = 'my_unix_domain',
  },
}
--config.default_gui_startup_args = { 'connect', 'my_unix_domain' }

-- Windows Settings
local function windows_settings(config)
  --config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
  config.default_prog = { 'C:\\Program Files\\nu\\bin\\nu.exe' }
  config.window_decorations = 'TITLE | RESIZE'
  --config.win32_system_backdrop = 'Tabbed'
end

-- Appearance
config.max_fps = 255
config.color_scheme = 'Paul Millr (Gogh)'
config.window_background_opacity = 1.0
config.font_size = 12
config.font = wezterm.font 'Hack Nerd Font'
config.window_decorations = 'NONE'
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.tab_max_width = 24
config.scrollback_lines = 5000
config.enable_scroll_bar = false
config.colors = {
  tab_bar = {
    background = col_mantle,
    new_tab = {
      bg_color = col_mantle,
      fg_color = 'white',
    },
    new_tab_hover = {
      bg_color = col_mantle,
      fg_color = 'white',
      intensity = 'Bold',
    },
  },
}
config.window_background_gradient = {
  colors = { '#000010', '#0a0020', '#220011' },
  orientation = {
    Radial = {
      cx = 0.0,
      cy = 0.0,
      radius = 1.0,
    },
  },
}

-- Keyboard Encoding
config.allow_win32_input_mode = false
config.enable_kitty_keyboard = true

-- Start in fullscreen
--[[
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

  -- Domain bindings
  { key = 'a', mods = 'ALT', action = act.ShowLauncherArgs { flags = 'DOMAINS' } },
  { key = 'd', mods = 'ALT', action = act.DetachDomain 'CurrentPaneDomain' },
  { key = 's', mods = 'ALT', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },
  {
    key = 'r',
    mods = 'ALT',
    action = act.PromptInputLine {
      description = 'Rename Workspace',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },

  -- Navigation bindings
  { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = false }, },
  { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'c', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'f', mods = 'ALT', action = act.TogglePaneZoomState },
  { key = '%', mods = 'ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '"', mods = 'ALT|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = 'p', mods = 'ALT', action = act.ActivateCommandPalette },
  { key = 'f', mods = 'ALT', action = act.Search 'CurrentSelectionOrEmptyString' },

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
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
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
  { key = '`', mods = 'SHIFT', action = act.SendString '~' },
  { key = '1', mods = 'SHIFT', action = act.SendString '!' },
  { key = '2', mods = 'SHIFT', action = act.SendString '@' },
  { key = '3', mods = 'SHIFT', action = act.SendString '#' },
  { key = '4', mods = 'SHIFT', action = act.SendString '$' },
  { key = '5', mods = 'SHIFT', action = act.SendString '%' },
  { key = '6', mods = 'SHIFT', action = act.SendString '^' },
  { key = '7', mods = 'SHIFT', action = act.SendString '&' },
  { key = '8', mods = 'SHIFT', action = act.SendString '*' },
  { key = '9', mods = 'SHIFT', action = act.SendString '(' },
  { key = '0', mods = 'SHIFT', action = act.SendString ')' },
  { key = '-', mods = 'SHIFT', action = act.SendString '_' },
  { key = '=', mods = 'SHIFT', action = act.SendString '+' },
  { key = '[', mods = 'SHIFT', action = act.SendString '{' },
  { key = ']', mods = 'SHIFT', action = act.SendString '}' },
  { key = '\\', mods = 'SHIFT', action = act.SendString '|' },
  { key = ';', mods = 'SHIFT', action = act.SendString ':' },
  { key = "'", mods = 'SHIFT', action = act.SendString '"' },
  { key = ',', mods = 'SHIFT', action = act.SendString '<' },
  { key = '.', mods = 'SHIFT', action = act.SendString '>' },
  { key = '/', mods = 'SHIFT', action = act.SendString '?' },
}

-- Tab bar style
local function remove_exe(text)
  if text:sub(-4) == '.exe' then
    text = wezterm.truncate_right(text, #text - 4)
  end

  return text
end

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    title = tab_info.tab_title
  else
    -- Otherwise, use the title from the active pane in that tab
    title = tab_info.active_pane.title
  end

  return remove_exe(title)
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = wezterm.truncate_right(tab_title(tab), max_width - 7)
    if tab.is_active then
      return {
        { Foreground = { Color = '#303446' } },
        { Background = { Color = col_mantle } },
        { Text = ' ' },
        { Foreground = { Color = '#00ff00' } },
        { Background = { Color = '#303446' } },
        { Text = ' ' .. title .. ' ' },
        { Foreground = { Color = 'white' } },
        { Background = { Color = '#8caaee' } },
        { Text = ' ' .. tab.tab_index + 1 },
        { Foreground = { Color = '#8caaee' } },
        { Background = { Color = col_mantle } },
        { Text = '' },
      }
    else
      return {
        { Foreground = { Color = '#444444' } },
        { Background = { Color = col_mantle } },
        { Text = ' ' },
        { Foreground = { Color = '#white' } },
        { Background = { Color = '#444444' } },
        { Text = ' ' .. title .. ' ' },
        { Foreground = { Color = 'black' } },
        { Background = { Color = '#f2d5cf' } },
        { Text = ' ' .. tab.tab_index + 1 },
        { Foreground = { Color = '#f2d5cf' } },
        { Background = { Color = col_mantle } },
        { Text = '' },
      }
    end
    return title
  end
)

wezterm.on('update-status', function(window, pane)
  local workspace = window:active_workspace()
  window:set_left_status(wezterm.format {
    -- Workspace Name
    { Foreground = { Color = '#fab387' } },
    { Background = { Color = col_mantle } },
    { Text = ' ' },
    { Foreground = { Color = 'black' } },
    { Background = { Color = '#fab387' } },
    { Text = ' ' },
    { Foreground = { Color = 'white' } },
    { Background = { Color = col_crust } },
    { Text = ' ' .. workspace .. ' ' },
    { Foreground = { Color = col_crust } },
    { Background = { Color = col_mantle } },
    { Text = ' ' },
  })
end)

local function basename(path)
  path = path:gsub('/+$', '')
  local name = path:match("([^/]+)$")
  name = name .. '/'
  return name or ''
end

local function get_cwd(pane)
  local cwd_uri = pane:get_current_working_dir()
  local cwd = 'undefined'
  if cwd_uri then
      cwd = cwd_uri.file_path
  end
  cwd = basename(cwd)
  return cwd
end

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%I:%M %p - %a %b %-d'
  local domain= pane:get_domain_name()
  local cwd = get_cwd(pane)
  window:set_right_status(wezterm.format {
    -- Current Working Directory
    { Foreground = { Color = '#f9e2af' } },
    { Background = { Color = col_mantle } },
    { Text = '' },
    { Foreground = { Color = 'black' } },
    { Background = { Color = '#f9e2af' } },
    { Text = ' ' },
    { Foreground = { Color = 'white' } },
    { Background = { Color = col_crust } },
    { Text = ' ' .. cwd .. ' ' },
    { Foreground = { Color = col_crust } },
    { Background = { Color = col_mantle } },
    { Text = ' ' },
    -- Time
    { Foreground = { Color = '#a6e3a1' } },
    { Background = { Color = col_mantle } },
    { Text = '' },
    { Foreground = { Color = 'black' } },
    { Background = { Color = '#a6e3a1' } },
    { Text = '󰃰 ' },
    { Foreground = { Color = 'white' } },
    { Background = { Color = col_crust } },
    { Text = ' ' .. date .. ' ' },
    { Foreground = { Color = col_crust } },
    { Background = { Color = col_mantle } },
    { Text = ' ' },
    -- Domain
    { Foreground = { Color = '#b4befe' } },
    { Background = { Color = col_mantle } },
    { Text = '' },
    { Foreground = { Color = 'black' } },
    { Background = { Color = '#b4befe' } },
    { Text = '󰇗 ' },
    { Foreground = { Color = 'white' } },
    { Background = { Color = col_crust } },
    { Text = ' ' .. domain .. ' ' },
    { Foreground = { Color = col_crust } },
    { Background = { Color = col_mantle } },
    { Text = ' ' },
  })
end)

-- Apply operating specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  windows_settings(config)
end

-- Return the configuration to wezterm
return config
