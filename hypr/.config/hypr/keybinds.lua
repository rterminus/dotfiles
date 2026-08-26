local mainMod = "SUPER"

-- applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + CONTROL + Return", hl.dsp.exec_cmd("kitty", { float = true, size = { 800, 500 } }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi", { float = true, size = { 1280, 720 } }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("rofi -show drun -config ~/.config/rofi/config.rasi"))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd("kitty -e btop"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))

-- power menu
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/rofi/powermenu.sh"))

-- window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Z", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- focus movement
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- window movement
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- resizing
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- workspaces
for i = 1, 9 do
	local ws = tostring(i)
	hl.bind(mainMod .. " + " .. ws, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. ws, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. ws, function()
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
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && ~/dotfiles/bin/volume-notify.sh"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/dotfiles/bin/volume-notify.sh"),
	{ locked = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl set 5%+ && ~/dotfiles/bin/brightness-notify.sh"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl set 5%- && ~/dotfiles/bin/brightness-notify.sh"),
	{ locked = true, repeating = true }
)

-- screenshot
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/dotfiles/bin/screenshot.sh sf"))

-- reload hyprland configuration
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl reload && pkill waybar; waybar &"))

-- hyprsunset
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("hyprsunset -t 4500"))
hl.bind(mainMod .. " + F7", hl.dsp.exec_cmd("hyprsunset -t 3500"))
hl.bind(mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd("pkill hyprsunset"))

-- move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- keybind navigator
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.exec_cmd("~/dotfiles/bin/keybinds.sh"))

-- toggle waybar visibility
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill waybar || waybar"))

-- control center
hl.bind(
	mainMod .. " + CONTROL + W",
	hl.dsp.exec_cmd("kitty --class floating_shell -e ~/dotfiles/bin/control_center.sh")
)

-- color picker
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("~/dotfiles/bin/color_picker.sh"))
