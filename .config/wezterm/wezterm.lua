local wezterm = require("wezterm")

local keys = require("keys")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end
config.window_frame = {
	border_left_width = "0.15cell",
	border_right_width = "0.15cell",
	border_bottom_height = "0.10cell",
	border_top_height = "0.05cell",
	border_left_color = "#d7827e",
	border_right_color = "#d7827e",
	border_bottom_color = "#d7827e",
	border_top_color = "#d7827e",
}

config.colors = {
	split = "#d7827e",
	selection_bg = "#d7827e",
	selection_fg = "#0f0f0f",
}

config.window_decorations = "RESIZE"
config.font = wezterm.font("GeistMono Nerd Font")
config.font_size = 14
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.95
config.macos_window_background_blur = 90
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.color_scheme = "rose-pine"

config.max_fps = 120
config.enable_wayland = false
config.warn_about_missing_glyphs = false
config.show_update_window = false
config.check_for_updates = false
-- Color palette for the backgrounds of each cell
config.default_cursor_style = "SteadyUnderline"
config.line_height = 1
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keys

config.launch_menu = {
	{ args = { "top" } },
	{ args = { "nvim", "." } },
}
require("tabline")

return config
