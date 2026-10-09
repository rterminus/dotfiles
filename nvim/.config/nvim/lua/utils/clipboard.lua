local M = {}

function M.copy_file_range()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local file_path = vim.fn.expand("%:~:.")

  if file_path == "" then
    vim.notify("no file associated with buffer", vim.log.levels.WARN)
    return
  end

  local reference
  if start_line == end_line then
    reference = string.format("%s:%d", file_path, start_line)
  else
    reference = string.format("%s:%d-%d", file_path, start_line, end_line)
  end

  vim.fn.system("wl-copy", reference)
  vim.fn.setreg("+", reference)

  vim.notify("copied: " .. reference, vim.log.levels.INFO)
end

return M
