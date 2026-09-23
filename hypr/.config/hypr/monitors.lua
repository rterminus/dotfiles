-- displays
hl.monitor({
	output = "HDMI-A-1",
	mode = "3440x1440@100",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "-1920x0",
	scale = 1,
})

-- fallback
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})
