vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
vim.opt.undodir = { prefix .. "/nvim/.undo//" }
vim.opt.undofile = true
vim.o.autowriteall = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "▶", precedes = "◀" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.confirm = true

vim.opt.fillchars = {
	vert = " ",
	horiz = " ",
	horizup = " ",
	horizdown = " ",
	vertleft = " ",
	vertright = " ",
	verthoriz = " ",
	fold = " ",
}

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.viewoptions = { "folds", "cursor" }

function _G.minimal_foldtext()
	local start_line = vim.fn.getline(vim.v.foldstart)
	local lines_count = vim.v.foldend - vim.v.foldstart + 1
	local code_text = vim.trim(start_line)
	local suffix = "  󰁂 " .. lines_count .. " lines"

	return {
		{ "  ", "NonText" },
		{ code_text, "Normal" },
		{ " ...", "Comment" },
		{ suffix, "Comment" },
	}
end

vim.opt.foldtext = "v:lua.minimal_foldtext()"

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.g.terminal_color_0 = "color0"
vim.g.terminal_color_1 = "color1"
vim.g.terminal_color_2 = "color2"
vim.g.terminal_color_3 = "color3"
vim.g.terminal_color_4 = "color4"
vim.g.terminal_color_5 = "color5"
vim.g.terminal_color_6 = "color6"
vim.g.terminal_color_7 = "color7"
vim.g.terminal_color_8 = "color8"
vim.g.terminal_color_9 = "color9"
vim.g.terminal_color_10 = "color10"
vim.g.terminal_color_11 = "color11"
vim.g.terminal_color_12 = "color12"
vim.g.terminal_color_13 = "color13"
vim.g.terminal_color_14 = "color14"
vim.g.terminal_color_15 = "color15"
