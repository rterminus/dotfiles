hl.window_rule({ match = { class = "pavucontrol" }, float = true })
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ match = { class = "Rofi" }, float = true, center = true })
hl.window_rule({ match = { class = "floating_shell" }, float = true, size = { 800, 600 }, center = true })
hl.window_rule({ match = { class = "Yazi-Picker" }, float = true, size = { 1000, 600 }, center = true })
hl.window_rule({
	match = { class = "org\\.speedcrunch\\.speedcrunch" },
	float = true,
	size = { 700, 500 },
	center = true,
})
hl.window_rule({ match = { class = "kitty" }, opacity = "1.0 override 0.6 override 1.0 override" })
hl.window_rule({
	match = { class = "StarRail\\.exe" },
	suppress_event = "fullscreen",
	float = true,
	size = { 1920, 1080 },
	center = true,
})

hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true, ignore_alpha = 0 })
hl.layer_rule({ match = { namespace = "dunst" }, blur = true, ignore_alpha = 0 })
