local wezterm = require("wezterm")
local Tab = require("tab")
local theme = require("theme")
local keys = require("keys")

Tab.setup()

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return {
	colors = theme.colors,
	keys = keys,
	color_scheme = "Catppuccin Frappe",
	scrollback_lines = 50000,
	font = wezterm.font("Lilex Nerd Font"),
	-- font = wezterm.font 'Ubuntu Nerd Font Propo',
	-- font = wezterm.font 'InconsolataGo Nerd Font Mono',
	font_size = 14.5,
	max_fps = 120,
	enable_wayland = false,
	warn_about_missing_glyphs = false,
	show_update_window = false,
	check_for_updates = false,
	line_height = 1.2,
	window_close_confirmation = "NeverPrompt",
	audible_bell = "Disabled",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	initial_cols = 110,
	initial_rows = 25,
	enable_scroll_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	macos_window_background_blur = 30,
	enable_tab_bar = true,
	tab_max_width = 50,
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	disable_default_key_bindings = false,
	front_end = "OpenGL",
	default_cursor_style = "BlinkingUnderline",
	hyperlink_rules = {
		{
			regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},
		{
			regex = [[\b[tT](\d+)\b]],
			format = "https://example.com/tasks/?t=$1",
		},
	},
}
