local mainMod = "SUPER"

-- applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty")) -- open terminal
hl.bind(mainMod .. " + CONTROL + Return", hl.dsp.exec_cmd("kitty", { float = true, size = { 800, 500 } })) -- open floating terminal
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi", { float = true, size = { 1280, 720 } })) -- open file manager
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun -config ~/.config/rofi/config.rasi")) -- open application launcher
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("kitty -e btop", { float = true, size = { 1050, 750 } })) -- open system monitor
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser")) -- open web browser

-- power menu
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/rofi/powermenu.sh")) -- open power menu

-- window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- close window
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" })) -- toggle fullscreen
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" })) -- toggle floating
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo()) -- toggle pseudo-tiling
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit")) -- toggle split
hl.bind(mainMod .. " + Z", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) -- toggle maximized

-- special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic")) -- toggle special workspace
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- move to special workspace

-- focus movement
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" })) -- focus left
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" })) -- focus right
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" })) -- focus up
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" })) -- focus down

-- window movement
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" })) -- move window left
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" })) -- move window right
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" })) -- move window up
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" })) -- move window down

-- resizing
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true }) -- resize left
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true }) -- resize right
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true }) -- resize up
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true }) -- resize down

-- workspaces
for i = 1, 9 do
	local ws = tostring(i)
	hl.bind(mainMod .. " + " .. ws, hl.dsp.focus({ workspace = i })) -- go to workspace [1-9]
	hl.bind(mainMod .. " + SHIFT + " .. ws, hl.dsp.window.move({ workspace = i })) -- move window to workspace [1-9]
	hl.bind(mainMod .. " + ALT + " .. ws, function() -- move all windows to workspace [1-9]
		local active = hl.get_active_workspace()
		if not active then
			return
		end
		for _, win in ipairs(active:get_windows()) do
			hl.dispatch(hl.dsp.window.move({ workspace = ws, window = win }))
		end
	end)
end

-- multimedia
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && ~/dotfiles/bin/volume-notify.sh"),
	{ locked = true, repeating = true }
) -- volume up
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/dotfiles/bin/volume-notify.sh"),
	{ locked = true, repeating = true }
) -- volume down
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/dotfiles/bin/volume-notify.sh"),
	{ locked = true }
) -- toggle mute
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl set 5%+ && ~/dotfiles/bin/brightness-notify.sh"),
	{ locked = true, repeating = true }
) -- brightness up
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl set 5%- && ~/dotfiles/bin/brightness-notify.sh"),
	{ locked = true, repeating = true }
) -- brightness down

-- utils
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/dotfiles/bin/screenshot.sh sf")) -- screenshot
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.exec_cmd("~/dotfiles/bin/keybinds.sh")) -- show keybinds
hl.bind(
	mainMod .. " + CONTROL + W",
	hl.dsp.exec_cmd("kitty --class floating_shell -e ~/dotfiles/bin/control_center.sh")
) -- open control center
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("~/dotfiles/bin/color_picker.sh")) -- color picker

-- environment controls
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl reload && pkill waybar; waybar &")) -- reload hyprland and waybar
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill waybar || waybar")) -- toggle waybar
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("hyprsunset -t 4500")) -- blue light filter (weak)
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("hyprsunset -t 3500")) -- blue light filter (strong)
hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd("pkill hyprsunset")) -- disable blue light filter

-- mouse integration
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- drag window
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- resize window
