require("starship"):setup()

Status:children_remove(3, Status.RIGHT)

function Status:render()
	local left = self:children_render(self.LEFT)
	local right = self:children_render(self.RIGHT)
	return {
		ui.Line({ left, ui.Span("  │  "), right }),
	}
end
