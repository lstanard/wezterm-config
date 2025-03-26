-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Plugins
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
local pain_control = wezterm.plugin.require("https://github.com/sei40kr/wez-pain-control")

-- Set up config
local config = wezterm.config_builder()

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
-- Custom 3-pane layout
wezterm.on('spawn-three-pane-layout', function(window, _)
  local tab = window:mux_window():spawn_tab {}  -- Open a new tab
  -- Create the left panel (1)
  local left = tab:active_pane()
  -- Create the right side panel (2) by splitting from left
  local top_right = left:split { direction = 'Right', size = 0.33 }
  -- Create the bottom-right panel (3) by splitting top-right
  local bottom_right = top_right:split { direction = 'Bottom', size = 0.5 }
end)

-- Customize tab title
wezterm.on("format-tab-title", function(tab)
  local pane = tab.active_pane
  local process_name = wezterm.basename(pane.foreground_process_name) -- e.g., 'nvim'
  local cwd_uri = pane.current_working_dir

  -- Extract the last folder name from the CWD
  local cwd = ""
  if cwd_uri then
    local cwd_path = cwd_uri:match("file://[^/]*/(.*)") -- Extract path after file://
    if cwd_path then
      cwd = cwd_path:match(".*/(.*)") or cwd_path -- Get the last folder
    end
  end

  -- Truncate the folder name if too long
  if #cwd > 10 then
    cwd = cwd:sub(1, 8) .. "…"
  end

  -- Format: "1 -> ni (repo-name)"
  return string.format("%d → %s (%s)", tab.tab_index + 1, process_name, cwd)
end)

-- Keys
config.keys = {
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent('spawn-three-pane-layout'),
  },
}

config.send_composed_key_when_left_alt_is_pressed = true

-- UI config
config.color_scheme = 'catppuccin-mocha'
config.enable_tab_bar = true
config.font_size = 13
config.initial_cols = 180
config.initial_rows = 60
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"
config.window_padding = {
  left = '12px',
  right = '12px',
  top = '14px',
  bottom = '12px',
}

-- Apply plugin config
bar.apply_to_config(config, {
  position = "bottom",
  max_width = 32,
  padding = {
    left = 1,
    right = 1,
  },
  separator = {
    space = 1,
    left_icon = wezterm.nerdfonts.fa_long_arrow_right,
    right_icon = wezterm.nerdfonts.fa_long_arrow_left,
    field_icon = wezterm.nerdfonts.indent_line,
  },
  modules = {
    tabs = {
      active_tab_fg = 4,
      inactive_tab_fg = 6,
    },
    workspace = {
      enabled = false,
      icon = wezterm.nerdfonts.cod_window,
      color = 8,
    },
    leader = {
      enabled = true,
      icon = wezterm.nerdfonts.oct_rocket,
      color = 2,
    },
    pane = {
      enabled = true,
      icon = wezterm.nerdfonts.cod_multiple_windows,
      color = 7,
    },
    username = {
      enabled = true,
      icon = wezterm.nerdfonts.fa_user,
      color = 6,
    },
    hostname = {
      enabled = false,
      icon = wezterm.nerdfonts.cod_server,
      color = 8,
    },
    clock = {
      enabled = true,
      icon = wezterm.nerdfonts.md_calendar_clock,
      color = 5,
    },
    cwd = {
      enabled = true,
      icon = wezterm.nerdfonts.oct_file_directory,
      color = 7,
    },
    spotify = {
      enabled = false,
      icon = wezterm.nerdfonts.fa_spotify,
      color = 3,
      max_width = 64,
      throttle = 15,
    },
  },
})
pain_control.apply_to_config(config, {})

return config
