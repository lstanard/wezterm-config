-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Plugins
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
local pain_control = wezterm.plugin.require("https://github.com/sei40kr/wez-pain-control")

-- Config
local config = wezterm.config_builder()

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Keys
config.keys = {
	{
		key = 'K',
		mods = 'CTRL|SHIFT',
		action = act.ClearScrollback 'ScrollbackAndViewport',
	}
}

-- UI config
config.color_scheme = 'catppuccin-frappe' -- also trying out catppuccin-mocha for a change
config.enable_tab_bar = true
config.initial_cols = 180
config.initial_rows = 60
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"
config.window_padding = {
	left = '12px',
	right = '12px',
	top = '18px',
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