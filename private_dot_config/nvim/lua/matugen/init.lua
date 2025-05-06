-- Main matugen module
local M = {}

-- Load and apply the matugen theme
function M.load()
  local ok, theme = pcall(require, "matugen.theme")
  if ok then
    theme.setup()
  else
    print("Failed to load matugen theme")
  end
end

-- Register the colorscheme with Neovim
vim.api.nvim_create_augroup("Matugen", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Matugen",
  pattern = "matugen",
  callback = function()
    M.load()
  end,
})

-- Create a command to reload the theme
vim.api.nvim_create_user_command("MatugenReload", function()
  vim.cmd("colorscheme matugen")
end, {})

-- Get the current colors
function M.get_colors()
  return require("matugen.colors")
end

-- Register the colorscheme
local function register_colorscheme()
  -- Set up the colorscheme autocommand
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    pattern = "matugen",
    callback = function()
      M.load()
    end
  })
  
  -- Register the colorscheme function
  vim.g.colors_name = 'matugen'
  M.load()
end

-- Initialize immediately
register_colorscheme()

return M