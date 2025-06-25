local wezterm = require("wezterm")

local keys = require("keys")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end
-- config.window_frame = {
-- 	border_left_width = "0.30cell",
-- 	border_right_width = "0.30cell",
-- 	border_bottom_height = "0.25cell",
-- 	border_top_height = "0.20cell",
-- 	border_left_color = "#F1DFB6",
-- 	border_right_color = "#F1DFB6",
-- 	border_bottom_color = "#F1DFB6",
-- 	border_top_color = "#F1DFB6",
-- }

config.colors = {
	tab_bar = {
		background = "rgb(22, 24, 26 / 20%)",
	},

	split = "#F1DFB6",
	selection_bg = "#F1DFB6",
	selection_fg = "#0f0f0f",
}

config.window_decorations = "RESIZE"
config.font = wezterm.font("GeistMono Nerd Font", { weight = "Bold" })
config.font_size = 14
config.use_fancy_tab_bar = false
config.window_background_opacity = 0.85
config.tab_max_width = 22
config.macos_window_background_blur = 90
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true
config.color_scheme = "Tartan (terminal.sexy)"

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
config.scrollback_lines = 10000

config.launch_menu = {
	{ args = { "top" } },
	{ args = { "nvim", "." } },
}

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

require("tabline")

-- Custom any
wezterm.on("toggle-colorscheme", function(win, _)
	local overrides = win:get_config_overrides() or {}

	if overrides.colors and overrides.colors.background == "#16181a" then
		overrides.colors.background = "#eaeaea"
		overrides.colors.foreground = "#16181a"
	else
		overrides.colors = {
			background = "#16181a",
			foreground = "#eaeaea",
		}
	end

	win:set_config_overrides(overrides)
end)

return config
