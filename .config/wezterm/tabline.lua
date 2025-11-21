local wezterm = require("wezterm")

----------------------------------------------------------------
-- PROCESS ICONS (unchanged)
----------------------------------------------------------------
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

	local process = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	if string.find(process, "kubectl") then
		process = "kubectl"
	elseif string.find(process, "nvim") then
		process = "nvim"
	end

	return process_icons[process] or ("[" .. process .. "]")
end

----------------------------------------------------------------
-- FORMAT TAB (Hyper.js rounded pill style)
----------------------------------------------------------------

local LEFT_ROUND = ""
local RIGHT_ROUND = ""

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local process = get_process(tab)
	local unseen = false

	if not tab.is_active then
		for _, p in ipairs(tab.panes) do
			if p.has_unseen_output then
				unseen = true
				break
			end
		end
	end

	-- Hyper-like palette
	local colors = {
		active_bg = "#1a1b26",
		active_fg = "#ffffff",
		inactive_bg = "#2d2f38",
		inactive_fg = "#a0a0a0",
		hover_bg = "#383a45",
		hover_fg = "#e5e5e5",
		alert_fg = "#d79921", -- unseen output
	}

	local bg = colors.inactive_bg
	local fg = colors.inactive_fg

	if tab.is_active then
		bg = colors.active_bg
		fg = colors.alert_fg
	elseif hover then
		bg = colors.hover_bg
		fg = colors.hover_fg
	end

	if unseen then
		fg = colors.active_fg
	end

	local title = string.format("  %s %s  ", tab.tab_index + 1, process)

	return {
		-- Left rounded edge
		{ Foreground = { Color = bg } },
		{ Background = { Color = "none" } },
		{ Text = LEFT_ROUND },

		-- Center title
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = title },

		-- Right rounded edge
		{ Foreground = { Color = bg } },
		{ Background = { Color = "none" } },
		{ Text = RIGHT_ROUND },
	}
end)
