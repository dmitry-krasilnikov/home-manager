local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.scrollback_lines = 10000
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 16
config.colors = require('lua/colorschemes/rose-pine-dawn').colors()

return config
