local map = vim.keymap.set

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
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })
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
map("n", "<leader>A", "<cmd>A<CR>", { desc = "alternate between cpp/hpp" })

-- buffer management
map("n", "<leader>bd", function()
	require("snacks").bufdelete()
end, { desc = "[B]uffer [D]elete" })
map("n", "<leader>bo", function()
	require("snacks").bufdelete.other()
end, { desc = "[B]uffer Delete [O]thers" })
