local wezterm = require("wezterm")
return {
	font = wezterm.font("Hack Nerd Font Mono"),
  bold = true,
	font_size = 16,
	color_scheme = "Monokai Remastered",
	check_for_updates = false,
	keys = {
		{
			key = "e",
			mods = "CMD",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "d",
			mods = "CMD",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
	},
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	colors = {
		tab_bar = {
			background = "#232634",
			-- The active tab is the one that has focus in the window
			active_tab = {
				-- The color of the background area for the tab
				bg_color = "#ca9ee6",
				-- The color of the text for the tab
				fg_color = "#282a39",

				-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
				-- label shown for this tab.
				-- The default is "Normal"
				intensity = "Bold",

				-- Specify whether you want "None", "Single" or "Double" underline for
				-- label shown for this tab.
				-- The default is "None"
				underline = "None",

				-- Specify whether you want the text to be italic (true) or not (false)
				-- for this tab.  The default is false.
				italic = false,

				-- Specify whether you want the text to be rendered with strikethrough (true)
				-- or not for this tab.  The default is false.
				strikethrough = false,
			},
			new_tab = {
				bg_color = "#232634",
				fg_color = "#c4ccec",
				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = "#282c3c",
				fg_color = "#c4ccec",

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab`.
			},
		},
	},
}
