local wezterm = require("wezterm")
local is_dark = true

local function is_vi_process(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
	if is_vi_process(pane) then
		window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "ALT" }), pane)
	else
		window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditional_activate_pane(window, pane, "Down", "j")
end)

local custom_theme = {
	dark = {
		rosewater = "#F5E0DC",
		flamingo = "#F2CDCD",
		pink = "#F5C2E7",
		mauve = "#CBA6F7",
		red = "#F38BA8",
		maroon = "#EBA0AC",
		peach = "#FAB387",
		yellow = "#F9E2AF",
		green = "#A6E3A1",
		teal = "#94E2D5",
		sky = "#89DCEB",
		sapphire = "#74C7EC",
		blue = "#89B4FA",
		lavender = "#B4BEFE",
		text = "#CDD6F4",
		text0 = "#e0def4",
		subtext1 = "#BAC2DE",
		subtext0 = "#A6ADC8",
		overlay2 = "#9399B2",
		overlay1 = "#7F849C",
		overlay0 = "#6C7086",
		surface2 = "#585B70",
		surface1 = "#45475A",
		surface0 = "#313244",
		base = "#1E1E2E",
		mantle = "#181825",
		crust = "#11111B",
		background = "#1f1d2e",
		foreground_ = "#f4ede8",
	},
	light = {
		rosewater = "#dc8a78",
		flamingo = "#DD7878",
		pink = "#ea76cb",
		mauve = "#8839EF",
		red = "#D20F39",
		maroon = "#E64553",
		peach = "#FE640B",
		yellow = "#df8e1d",
		green = "#40A02B",
		teal = "#179299",
		sky = "#04A5E5",
		sapphire = "#209FB5",
		blue = "#1e66f5",
		lavender = "#7287FD",
		text = "#4C4F69",
		subtext1 = "#5C5F77",
		subtext0 = "#6C6F85",
		overlay2 = "#7C7F93",
		overlay1 = "#8C8FA1",
		overlay0 = "#9CA0B0",
		surface2 = "#ACB0BE",
		surface1 = "#BCC0CC",
		surface0 = "#CCD0DA",
		base = "#FFFFFF",
		mantle = "#E6E9EF",
		crust = "#DCE0E8",
	},
}

local colors = is_dark and custom_theme.dark or custom_theme.light

local function get_process(tab)
	local process_icons = {
		["docker"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["docker-compose"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["nvim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.custom_vim },
		},
		["vim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.dev_vim },
		},
		["node"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = wezterm.nerdfonts.mdi_hexagon },
		},
		["zsh"] = {
			{ Foreground = { Color = colors.teal } },
			{ Text = wezterm.nerdfonts.cod_terminal_bash },
		},
		["bash"] = {
			{ Foreground = { Color = colors.subtext0 } },
			{ Text = wezterm.nerdfonts.cod_terminal_bash },
		},
		["paru"] = {
			{ Foreground = { Color = colors.lavender } },
			{ Text = wezterm.nerdfonts.linux_archlinux },
		},
		["htop"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_chart_donut_variant },
		},
		["cargo"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["go"] = {
			{ Foreground = { Color = colors.sapphire } },
			{ Text = wezterm.nerdfonts.mdi_language_go },
		},
		["lazydocker"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.linux_docker },
		},
		["git"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["lazygit"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_git },
		},
		["lua"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.seti_lua },
		},
		["wget"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_arrow_down_box },
		},
		["curl"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = wezterm.nerdfonts.mdi_flattr },
		},
		["gh"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = wezterm.nerdfonts.dev_github_badge },
		},
		["kubectl"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = wezterm.nerdfonts.fa_cubes },
		},
		["make"] = {
			{ Foreground = { Color = colors.base } },
			{ Text = wezterm.nerdfonts.dev_gnu },
		},
		["lf"] = {
			{ Foreground = { Color = colors.red } },
			{ Text = wezterm.nerdfonts.mdi_file_tree },
		},
		["cloud_sql_proxy"] = {
			{ Foreground = { Color = colors.sapphire } },
			{ Text = wezterm.nerdfonts.dev_google_cloud_platform },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	return wezterm.format(
		process_icons[process_name]
		or { { Foreground = { Color = colors.sky } }, { Text = string.format("[%s]", process_name) } }
	)
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "  ~"
			or string.format("  %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab)
	return wezterm.format({
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format(" %s  ", tab.tab_index + 1) },
		"ResetAttributes",
		{ Text = get_process(tab) },
		{ Text = " " },
		{ Text = get_current_working_dir(tab) },
		{ Foreground = { Color = colors.base } },
		{ Text = "  ▕" },
	})
end)

wezterm.on("update-right-status", function(window)
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = wezterm.strftime(" %A, %d %B %Y %I:%M %p ") },
	}))
end)

return {
	color_scheme = "Rosé Pine (base16)",
	--	check_for_updates = false,
	font = wezterm.font_with_fallback({
		--"Hack Nerd Font Mono",
		"FiraMono Nerd Font"
		--"OverpassMono Nerd Font"
	}),
	scrollback_lines = 50000,
	font_size = 14,
	max_fps = 120,
	enable_wayland = false,
	pane_focus_follows_mouse = false,
	warn_about_missing_glyphs = false,
	show_update_window = false,
	check_for_updates = false,
	line_height = 1.5,
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
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = is_dark and 0.85 or 0.95,
	},
	enable_scroll_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 1.0,
	tab_max_width = 50,
	hide_tab_bar_if_only_one_tab = true,
	disable_default_key_bindings = false,
	front_end = "OpenGL",
	default_cursor_style = "SteadyUnderline",
	colors = {
		scrollbar_thumb = colors.surface2,
		compose_cursor = colors.flamingo,
		ansi = {
			is_dark and colors.subtext1 or colors.surface1,
			colors.red,
			colors.green,
			colors.yellow,
			colors.blue,
			colors.pink,
			colors.teal,
			is_dark and colors.surface2 or colors.subtext1,
		},
		brights = {
			is_dark and colors.subtext0 or colors.surface2,
			colors.red,
			colors.green,
			colors.yellow,
			colors.blue,
			colors.pink,
			colors.teal,
			is_dark and colors.surface1 or colors.subtext0,
		},
		tab_bar = {
			background = colors.crust,
			active_tab = {
				bg_color = colors.surface0,
				fg_color = colors.subtext1,
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = colors.crust,
				fg_color = colors.surface2
			},
			inactive_tab_hover = {
				bg_color = colors.mantle,
				fg_color = colors.subtext0,
			},
			new_tab = {
				bg_color = colors.crust,
				fg_color = colors.subtext0,
			},
			new_tab_hover = {
				bg_color = colors.crust,
				fg_color = colors.subtext0,
			},
		},
	},
	keys = {
		{
			key = "e",
			mods = "CMD",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{ key = 'PageUp',   mods = 'SHIFT', action = wezterm.action.ScrollToTop },
		{ key = 'PageDown', mods = 'SHIFT', action = wezterm.action.ScrollToBottom },
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
	},
	hyperlink_rules = {
		-- Linkify things that look like URLs and the host has a TLD name.
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
			format = '$0',
		},

		-- linkify email addresses
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = 'mailto:$0',
		},

		-- file:// URI
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\bfile://\S*\b]],
			format = '$0',
		},

		-- Linkify things that look like URLs with numeric addresses as hosts.
		-- E.g. http://127.0.0.1:8000 for a local development server,
		-- or http://192.168.1.1 for the web interface of many routers.
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = '$0',
		},

		-- Make task numbers clickable
		-- The first matched regex group is captured in $1.
		{
			regex = [[\b[tT](\d+)\b]],
			format = 'https://example.com/tasks/?t=$1',
		},

		-- Make username/project paths clickable. This implies paths like the following are for GitHub.
		-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
		-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
		-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
		{
			regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
			format = 'https://www.github.com/$1/$3',
		},
	},
}
