local wezterm = require("wezterm")
local keys = require("keys")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.window_decorations = "RESIZE"
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 14.5
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 50

config.max_fps = 120
config.enable_wayland = false
config.warn_about_missing_glyphs = false
config.show_update_window = false
config.check_for_updates = false
config.default_cursor_style = "SteadyUnderline"
config.line_height = 1.1
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

local function windowicons()
	local CLOSE_CROSS = ("  %s  "):format(wezterm.nerdfonts.md_close)
	local MAXIMISE_BOX = (" %s "):format(wezterm.nerdfonts.md_window_maximize)
	local HIDE_DASH = (" %s "):format(wezterm.nerdfonts.md_window_minimize)
	local PLUS = (" %s "):format(wezterm.nerdfonts.md_plus)

	---@param icon string
	---@param hover_idx number | nil
	local function window_icons(icon, hover_idx)
		if hover_idx ~= nil then
			return wezterm.format({
				{ Background = { Color = wezterm.color.get_default_colors().brights[hover_idx] } },
				{ Text = icon },
			})
		else
			return wezterm.format({ { Text = icon } })
		end
	end

	return {
		new_tab = window_icons(PLUS),
		new_tab_hover = window_icons(PLUS),
		window_close = window_icons(CLOSE_CROSS),
		window_maximize_hover = window_icons(MAXIMISE_BOX, 5),
		window_hide = window_icons(HIDE_DASH),
		window_hide_hover = window_icons(HIDE_DASH),
	}
end

config.tab_bar_style = windowicons()
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keys

config.launch_menu = {
	{ args = { "top" } },
	{ args = { "nvim", "." } },
}
-- require("statusbar.right")
require("tabline")

-- and finally, return the configuration to wezterm
return config
