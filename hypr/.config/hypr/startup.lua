hl.on("hyprland.start", function()
	-- core daemons
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target"
	)
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

	-- display and hardware
	hl.exec_cmd("hyprctl setcursor NotwaitaBlack 24")
	hl.exec_cmd("brightnessctl set 10%")
	-- Nota: Removi o xrandr daqui pois o Wayland não usa xrandr e o script bash já vai gerir o monitor principal.

	-- wallpaper daemon
	hl.exec_cmd("awww-daemon")

	-- ui and services
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
	hl.exec_cmd("mako")

	-- applets
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("blueman-applet")

	-- clipboard
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- custom scripts
	hl.exec_cmd("~/dotfiles/bin/battery-notify.sh")
	hl.exec_cmd("~/dotfiles/bin/sunset.sh")

	-- monitors & wallpapers
	hl.exec_cmd("~/dotfiles/bin/monitor_manager.sh")
end)
