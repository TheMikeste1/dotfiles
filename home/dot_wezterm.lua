local wezterm = require("wezterm")
local act = wezterm.action

--- Creates a function that fixes the command arguments for exec domains.
--- @param command table The base command arguments.
--- @return function fix_func A function that takes a cmd table and appends its args to the base command.
local function create_simple_fix_func(command)
	return function(cmd)
		local args = {}
		for _, arg in ipairs(command) do
			table.insert(args, arg)
		end

		if cmd.args ~= nil then
			for _, arg in ipairs(cmd.args) do
				table.insert(args, arg)
			end
		end

		cmd.args = args
		return cmd
	end
end

--- Determines the command to use for a new pane based on the foreground process.
--- If the process is WSL, sets the working directory to the pane's cwd.
--- @param pane table The pane object.
--- @return table cmd Command table with cwd if WSL, else empty table.
local function determine_pane_command(pane)
	local fg = pane:get_foreground_process_name() or ""

	-- Determine if this is a WSL process
	if fg:match("\\[wW][sS][lL]") then
		local cwd_uri = pane:get_current_working_dir()
		if cwd_uri == nil then
			wezterm.log_error("Unable to get cwd for shell running in " .. fg)
			return {
				cwd = "/home",
			}
		end

		-- Expected form: file://<path>
		local cwd = tostring(cwd_uri)
		-- We just want the path portion
		local path = cwd:sub(8)
		return {
			cwd = path,
		}
	else
		-- Do nothing
		return {}
	end
end

--- Returns an action callback to split the current pane in the given direction.
--- Sets the working directory for WSL panes.
--- @param direction string The direction to split ('Down', 'Right', etc.).
--- @return function callback wezterm.action_callback for splitting the pane.
local function split(direction)
	return wezterm.action_callback(function(window, pane)
		local cmd = determine_pane_command(pane)
		window:perform_action(
			act.SplitPane({
				direction = direction,
				size = { Percent = 50 },
				command = cmd,
			}),
			pane
		)
	end)
end

local config = wezterm.config_builder()
config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50
config.use_fancy_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 10.0
config.window_padding = {
	left = 6,
	right = 6,
	top = 6,
	bottom = 6,
}
config.background = {
	{
		source = { File = "D:/OneDrive/ai-gen-black-hole.png" },
		opacity = 1.00,
		hsb = { brightness = 1.0, saturation = 1.0 },
		attachment = { Parallax = 0.0 },
		vertical_align = "Middle",
		horizontal_align = "Center",
	},
}
config.color_schemes = {
	["Darcula"] = {
		foreground = "#CCCCCC",
		background = "#2B2B2B",
		cursor_bg = "#FFFFFF",
		cursor_border = "#FFFFFF",
		cursor_fg = "#2B2B2B",
		selection_bg = "#214283",
		selection_fg = "black",
		ansi = {
			"#000000",
			"#F0524F",
			"#5C962C",
			"#A68A0D",
			"#3993D4",
			"#A771BF",
			"#00A3A3",
			"#808080",
		},
		brights = {
			"#595959",
			"#FF4050",
			"#4FC414",
			"#E5BF00",
			"#1FB0FF",
			"#ED7EED",
			"#00E5E5",
			"#FFFFFF",
		},
	},
	["Nord"] = {
		foreground = "#D8DEE9",
		background = "#2E3440",
		cursor_bg = "#81A1C1",
		cursor_border = "#81A1C1",
		cursor_fg = "#2E3440",
		selection_bg = "#434C5E",
		selection_fg = "black",
		ansi = {
			"#3B4252",
			"#BF616A",
			"#A3BE8C",
			"#EBCB8B",
			"#81A1C1",
			"#B48EAD",
			"#88C0D0",
			"#E5E9F0",
		},
		brights = {
			"#4C566A",
			"#BF616A",
			"#A3BE8C",
			"#EBCB8B",
			"#81A1C1",
			"#B48EAD",
			"#8FBCBB",
			"#ECEFF4",
		},
	},
}
config.color_scheme = "Nord"

local wsl_domains = wezterm.default_wsl_domains()
if #wsl_domains >= 1 then
	config.default_domain = wsl_domains[1].name
end

local launch_menu = {}
local exec_domains = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(
		exec_domains,
		wezterm.exec_domain("powershell", create_simple_fix_func({ "pwsh.exe", "-NoLogo" }), "PowerShell")
	)

	table.insert(
		exec_domains,
		wezterm.exec_domain(
			"git_bash",
			create_simple_fix_func({
				"C:/Program Files/Git/bin/bash.exe",
				"-i",
				"-l",
			}),
			"Git Bash"
		)
	)
end

config.launch_menu = launch_menu
config.exec_domains = exec_domains

-- tmux-style leader key
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }
-- Key bindings
config.keys = {
	{ key = '"', mods = "LEADER|SHIFT", action = split("Down") },
	{ key = "%", mods = "LEADER|SHIFT", action = split("Right") },
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnCommandInNewTab({
			domain = "CurrentPaneDomain",
			cwd = "~",
		}),
	},
	{ key = "F11", action = act.ToggleFullScreen },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "&", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },
}

return config
