-- use global options
vim.o.background = "light" -- "light" or "dark" for dark mode
local colorscheme = "NeoSolarized"
-- this uses a protected call so it does not error out on the first call
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
