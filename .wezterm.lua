-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Plugins
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
local pain_control = wezterm.plugin.require("https://github.com/sei40kr/wez-pain-control")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Keys
config.keys = {
	{
		key = 'K',
		mods = 'CTRL|SHIFT',
		action = act.ClearScrollback 'ScrollbackAndViewport',
	}
}

-- This is where you actually apply your config choices
config.window_padding = {
	left = '12px',
	right = '12px',
	top = '12px',
	bottom = '12px',
}
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.color_scheme = 'catppuccin-mocha'
config.font = wezterm.font_with_fallback {
  { family = 'JetBrains Mono', weight = 'Regular' },
  'Hack Nerd Font',
}
config.font_size = 13

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.window_decorations = "RESIZE"

-- Apply plugin config
bar.apply_to_config(config)
pain_control.apply_to_config(config, {})

-- and finally, return the configuration to wezterm
return config

