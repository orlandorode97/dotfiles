local wezterm = require("wezterm")

local theme_colors = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato"]

local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["kubectl"] = wezterm.nerdfonts.fa_cubes,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["make"] = wezterm.nerdfonts.dev_gnu,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["go"] = wezterm.nerdfonts.seti_go,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["git"] = wezterm.nerdfonts.dev_git,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = "",
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["gitui"] = wezterm.nerdfonts.dev_git,
	["lazygit"] = wezterm.nerdfonts.dev_git,
	["lf"] = wezterm.nerdfonts.mdi_file_tree,
	["cloud_sql_proxy"] = wezterm.nerdfonts.dev_google_cloud_platform,
	["ssh"] = wezterm.nerdfonts.dev_google_cloud_platform,
}

local function get_process(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return tab.active_pane.foreground_process_name
	end

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if string.find(process_name, "kubectl") then
		process_name = "kubectl"
	elseif string.find(process_name, "nvim") then
		process_name = "nvim"
	end

	return process_icons[process_name] or string.format("[%s]", process_name)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				has_unseen_output = true
				break
			end
		end
	end

	-- Gruvbox Dark Medium colors
	local gruvbox_colors = {
		-- Background colors
		bg0 = "#282828",   -- dark0
		bg1 = "#3c3836",   -- dark1
		bg2 = "#504945",   -- dark2
		bg3 = "#665c54",   -- dark3
		bg4 = "#7c6f64",   -- dark4
		-- Foreground colors
		fg0 = "#fbf1c7",  -- light0
		fg1 = "#ebdbb2",  -- light1
		fg2 = "#d5c4a1",  -- light2
		fg3 = "#bdae93",  -- light3
		fg4 = "#a89984",  -- light4
		-- Accent colors
		blue = "#458588",
		aqua = "#689d6a",
		green = "#98971a",
		yellow = "#d79921",
		orange = "#d65d0e",
		red = "#cc241d",
		purple = "#b16286",
		gray = "#928374",
	}

	-- Active tab: Blue background with light text
	-- Inactive tab: bg1 background with fg4 text
	-- Hover: bg2 background with fg1 text
	local edge_background = gruvbox_colors.bg0
	local background = gruvbox_colors.bg1
	local foreground = gruvbox_colors.fg4

	if tab.is_active then
		background = gruvbox_colors.blue
		foreground = gruvbox_colors.fg1
		edge_background = gruvbox_colors.blue
	elseif hover then
		background = gruvbox_colors.bg2
		foreground = gruvbox_colors.fg1
	end

	local edge_foreground = background

	local title = string.format(" %s %s ", tab.tab_index + 1, get_process(tab))

	if has_unseen_output then
		return {
			{ Background = { Color = edge_foreground } },
			{ Foreground = { Color = edge_background } },
			{ Background = { Color = background } },
			{ Foreground = { Color = gruvbox_colors.yellow } },
			{ Text = title },
			{ Background = { Color = edge_background } },
			{ Foreground = { Color = edge_foreground } },
		}
	end

	return {
		{ Background = { Color = edge_foreground } },
		{ Foreground = { Color = edge_background } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
	}
end)

wezterm.on("update-right-status", function(window, pane)
	local cells = {}

	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		cwd_uri = cwd_uri.path:sub(8)
		local slash = cwd_uri:find("/")
		local cwd = ""
		local hostname = ""
		if slash then
			hostname = cwd_uri:sub(1, slash - 1)
			-- Remove the domain name portion of the hostname
			local dot = hostname:find("[.]")
			if dot then
				hostname = hostname:sub(1, dot - 1)
			end
			-- and extract the cwd from the uri
			cwd = cwd_uri:sub(slash)

			table.insert(cells, cwd)
			table.insert(cells, hostname)
		end
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
	end

	local colors = {}
	-- local colors = theme_colors.ansi

	-- Foreground color for the text across the fade
	local text_fg = theme_colors.cursor_fg

	-- The elements to be formatted
	local elements = {}
	-- How many cells have been formatted
	local num_cells = 0

	-- Translate a cell into elements
	local function push(text, is_last)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
			table.insert(elements, {})
		end
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)
