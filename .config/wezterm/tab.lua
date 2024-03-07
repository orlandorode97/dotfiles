local wezterm = require("wezterm")
local palette = require("theme").palette

local Tab = {}

local function get_random_color()
	local values = {}
	for _, value in pairs(palette) do
		table.insert(values, value)
	end
	return values[math.random(1, #values)]
end


local function get_process(tab)
	local process_icons = {
		["docker"] = {
			{ Foreground = { Color = palette.blue } },
			{ Text = " " .. wezterm.nerdfonts.linux_docker .. " " },
		},
		["docker-compose"] = {
			{ Foreground = { Color = palette.blue } },
			{ Text = " " .. wezterm.nerdfonts.linux_docker .. " " },
		},
		["nvim"] = {
			{ Foreground = { Color = palette.green } },
			{ Text = " " .. wezterm.nerdfonts.custom_vim .. " " },
		},
		["vim"] = {
			{ Foreground = { Color = palette.green } },
			{ Text = " " .. wezterm.nerdfonts.dev_vim .. " " },
		},
		["node"] = {
			{ Foreground = { Color = palette.green } },
			{ Text = " " .. wezterm.nerdfonts.mdi_hexagon .. " " },
		},
		["zsh"] = {
			{ Foreground = { Color = palette.base } },
			{ Background = { Color = palette.yellow } },
			{ Text = " " .. tab.tab_index + 1 .. " " },
		},
		["bash"] = {
			{ Foreground = { Color = palette.subtext1 } },
			{ Text = " " .. wezterm.nerdfonts.cod_terminal_bash .. " " },
		},
		["cargo"] = {
			{ Foreground = { Color = palette.peach } },
			{ Text = " " .. wezterm.nerdfonts.dev_rust .. " " },
		},
		["go"] = {
			{ Foreground = { Color = palette.sapphire } },
			{ Text = " " .. wezterm.nerdfonts.mdi_language_go .. " " },
		},
		["gitui"] = {
			{ Foreground = { Color = palette.maroon } },
			{ Text = " " .. wezterm.nerdfonts.dev_git .. " " },
		},
		["git"] = {
			{ Foreground = { Color = palette.peach } },
			{ Text = " " .. wezterm.nerdfonts.dev_git .. " " },
		},
		["lazygit"] = {
			{ Foreground = { Color = palette.mauve } },
			{ Text = " " .. wezterm.nerdfonts.dev_git .. " " },
		},
		["lua"] = {
			{ Foreground = { Color = palette.blue } },
			{ Text = " " .. wezterm.nerdfonts.seti_lua .. " " },
		},
		["wget"] = {
			{ Foreground = { Color = palette.yellow } },
			{ Text = " " .. wezterm.nerdfonts.mdi_arrow_down_box .. " " },
		},
		["curl"] = {
			{ Foreground = { Color = palette.yellow } },
			{ Text = "" },
		},
		["gh"] = {
			{ Foreground = { Color = palette.mauve } },
			{ Text = "" },
		},
		["flatpak"] = {
			{ Foreground = { Color = palette.blue } },
			{ Text = "󰏖" },
		},
		["kubectl"] = {
			{ Foreground = { Color = palette.blue } },
			{ Text = " " .. wezterm.nerdfonts.fa_cubes .. " " },
		},
		["make"] = {
			{ Foreground = { Color = palette.base } },
			{ Text = " " .. wezterm.nerdfonts.dev_gnu .. " " },
		},
		["lf"] = {
			{ Foreground = { Color = palette.red } },
			{ Text = " " .. wezterm.nerdfonts.mdi_file_tree .. " " },
		},
		["cloud_sql_proxy"] = {
			{ Foreground = { Color = palette.sapphire } },
			{ Text = " " .. wezterm.nerdfonts.dev_google_cloud_platform .. " " },
		},
		["ssh"] = {
			{ Foreground = { Color = palette.sapphire } },
			{ Text = " " .. wezterm.nerdfonts.dev_google_cloud_platform .. " " },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	if not process_name then
		process_name = "zsh"
	end

	local process_format = process_icons[process_name] or
			{ { Foreground = { Color = palette.blue } }, { Text = string.format("[%s] ", process_name) } }

	return wezterm.format(process_format)
end

local function get_current_working_folder_name(tab)
	local cwd_uri = tab.active_pane.current_working_dir

	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return cwd_uri == HOME_DIR and ""
			or string.format(" %s", string.gsub(cwd_uri, "(.*[/\\])(.*)", "%2"))
end

local function get_home(tab)
	local cwd_uri = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	return cwd_uri == HOME_DIR and "  ~" or ""
end

function Tab.setup()
	wezterm.on("format-tab-title", function(tab)
		return wezterm.format({
			{ Text = "" },
			{ Text = get_process(tab) },
			{ Text = " " },
			{ Foreground = { Color = palette.subtext1 } },
			{ Text = get_home(tab) },
			{ Text = get_current_working_folder_name(tab) },
			{ Text = "  " },
		})
	end)
end

return Tab
