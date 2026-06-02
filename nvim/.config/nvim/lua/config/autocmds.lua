vim.api.nvim_create_augroup('misc', { clear = true })
local fold_group = vim.api.nvim_create_augroup('FoldPersistence', { clear = true })

vim.api.nvim_create_autocmd({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
  group = fold_group,
  pattern = '*.*',
  desc = 'saves folds and cursor position',
  command = 'silent! mkview',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = fold_group,
  pattern = '*.*',
  desc = 'restores folds and cursor position',
  command = 'silent! loadview',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeavePre', 'TextChanged', 'TextChangedP' }, {
  pattern = '*',
  callback = function() vim.cmd 'silent! write' end,
})

vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter' }, {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == '' or ft == 'toggleterm' then return end
    pcall(vim.treesitter.start, args.buf)
    vim.bo[args.buf].syntax = 'off'
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then client.server_capabilities.semanticTokensProvider = nil end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'SnacksDashboardOpened',
  callback = function() vim.opt_local.fillchars:append { eob = ' ' } end,
})
