hl.curve("snappy", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.curve("liquid", { type = "bezier", points = { { 0.22, 1.12 }, { 0.36, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "snappy" })
hl.animation({ leaf = "windows", enabled = true, speed = 1.2, bezier = "liquid", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.8, bezier = "snappy", style = "popin 92%" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "snappy" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.6, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 1, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "snappy" })
