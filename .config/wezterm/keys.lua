local wezterm = require("wezterm")

return {
	{
		key = "e",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollToTop },
	{ key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollToBottom },
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
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
	{ key = "y", mods = "CMD", action = wezterm.action.EmitEvent("toggle-colorscheme") },
}
