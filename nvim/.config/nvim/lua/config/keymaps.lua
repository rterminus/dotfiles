local map = vim.keymap.set

-- line insertion overrides
map("n", "o", "o<Esc>")
map("n", "O", "O<Esc>")

-- smart insert and append
vim.keymap.set("n", "i", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_cc'
	else
		return "i"
	end
end, { expr = true, desc = "smart insert" })

vim.keymap.set("n", "a", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_cc'
	else
		return "a"
	end
end, { expr = true, desc = "smart append" })

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", '"_dP')
map("n", "<leader>d", '"_d', { desc = "delete without yanking" })
map("v", "<leader>d", '"_d', { desc = "delete without yanking" })
map("n", "Q", "<nop>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>q", "<cmd>Trouble diagnostics toggle<CR>", { desc = "open diagnostic [q]uickfix list" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

map("n", "<left>", '<cmd>echo ""<CR>')
map("n", "<right>", '<cmd>echo ""<CR>')
map("n", "<up>", '<cmd>echo ""<CR>')
map("n", "<down>", '<cmd>echo ""<CR>')

-- pane movement
map("n", "<C-h>", "<C-w><C-h>", { desc = "move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "move focus to the upper window" })

-- buffer movement
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bprev<CR>")

-- buffer management
map("n", "<leader>bd", function()
	require("snacks").bufdelete()
end, { desc = "[b]uffer [d]elete" })
map("n", "<leader>bo", function()
	require("snacks").bufdelete.other()
end, { desc = "[b]uffer Delete [o]thers" })

-- vim.dadbod
vim.keymap.set("n", "<Leader>gdd", "<cmd>DBUIToggle<cr>", { desc = "toggle database ui" })
vim.keymap.set("n", "<Leader>gdf", "<cmd>DBUIFindBuffer<cr>", { desc = "find db buffer" })

-- telekasten
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten panel<CR>", { desc = "telekasten panel" })
vim.keymap.set("n", "<leader>zs", "<cmd>Telekasten find_notes<CR>", { desc = "search in notes" })
vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten search_notes<CR>", { desc = "find in notes" })
vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = "go to today" })
vim.keymap.set("n", "<leader>zo", "<cmd>Telekasten follow_link<CR>", { desc = "follow link" })
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", { desc = "new note" })
vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>", { desc = "show calendar" })
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { desc = "show backlinks" })
vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", { desc = "insert image link" })
vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten new_templated_note<CR>", { desc = "new templated note" })
vim.keymap.set("n", "<leader>zT", "<cmd>TodoTelescope cwd=~/second-brain<CR>", { desc = "to-do" })
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
