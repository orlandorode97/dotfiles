local wezterm = require("wezterm")

wezterm.GLOBAL.is_dark = wezterm.gui.get_appearance():find("Dark")

local Theme = {}

local themes = {
	github = {
		light = {
			rosewater = "#da1e28",
			flamingo = "#da1e28",
			red = "#da1e28",
			maroon = "#da1e28",
			pink = "#d02670",
			mauve = "#8a3ffc",
			peach = "#d44a1c",
			yellow = "#ab8600",
			green = "#007d79",
			teal = "#1192e8",
			sky = "#1192e8",
			sapphire = "#1192e8",
			blue = "#0f62fe",
			lavender = "#0f62fe",
			text = "#000000",
			subtext1 = "#404040",
			subtext0 = "#595959",
			overlay2 = "#737373",
			overlay1 = "#8c8c8c",
			overlay0 = "#a6a6a6",
			surface2 = "#bfbfbf",
			surface1 = "#d1d1d1",
			surface0 = "#e6e6e6",
			base = "#FFFFFF",
			mantle = "#f2f2f2",
			crust = "#ebebeb",
		},
		dark = {
			rosewater = "#ff8389",
			flamingo = "#ff8389",
			red = "#ff8389",
			maroon = "#ff8389",
			pink = "#ff7eb6",
			mauve = "#be95ff",
			peach = "#d44a1c",
			yellow = "#FFFF00",
			green = "#08bdba",
			teal = "#33b1ff",
			sky = "#33b1ff",
			sapphire = "#33b1ff",
			blue = "#78a9ff",
			lavender = "#78a9ff",
			text = "#ffffff",
			subtext1 = "#f4f4f4",
			subtext0 = "#e0e0e0",
			overlay2 = "#616161",
			overlay1 = "#4f4f4f",
			overlay0 = "#474747",
			surface2 = "#383838",
			surface1 = "#2e2e2e",
			surface0 = "#1f1f1f",
			base = "#161616",
			mantle = "#0d0d0d",
			crust = "#000000",
		},
	},
	catppuccinmocha = {
		dark = {
			rosewater = "#f5e0dc",
			flamingo = "#f2cdcd",
			pink = "#f5c2e7",
			mauve = "#cba6f7",
			red = "#f38ba8",
			maroon = "#eba0ac",
			peach = "#fab387",
			yellow = "#f9e2af",
			green = "#a6e3a1",
			teal = "#94e2d5",
			sky = "#89dceb",
			sapphire = "#74c7ec",
			blue = "#89b4fa",
			lavender = "#b4befe",
			text = "#cdd6f4",
			subtext1 = "#bac2de",
			subtext0 = "#a6adc8",
			overlay2 = "#9399b2",
			overlay1 = "#7f849c",
			overlay0 = "#6c7086",
			surface2 = "#585b70",
			surface1 = "#45475a",
			surface0 = "#313244",
			base = "#1e1e2e",
			mantle = "#181825",
			crust = "#11111b",
		}
	}
}

local THEME_NAME = "catppuccinmocha"

local palettes = themes[THEME_NAME]

Theme.palette = palettes.dark

Theme.colors = {
	compose_cursor = Theme.palette.flamingo,
	tab_bar = {
		background = Theme.palette.crust,
		active_tab = {
			bg_color = Theme.palette.surface2,
			fg_color = Theme.palette.text,
			intensity = "Bold",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = Theme.palette.surface0,
			fg_color = Theme.palette.subtext1,
		},
		inactive_tab_hover = {
			bg_color = Theme.palette.mantle,
			fg_color = Theme.palette.subtext0,
		},
		new_tab = {
			bg_color = Theme.palette.crust,
			fg_color = Theme.palette.subtext0,
		},
		new_tab_hover = {
			bg_color = Theme.palette.crust,
			fg_color = Theme.palette.subtext0,
		},
	},
}

return Theme
