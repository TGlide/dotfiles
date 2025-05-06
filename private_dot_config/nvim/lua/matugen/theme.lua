-- Matugen theme for Neovim
-- 
-- This module uses the colors from matugen.colors to create a complete 
-- Neovim colorscheme. To apply the theme, use:
--   :colorscheme matugen
--
-- To reload the theme after colors change, use:
--   :MatugenReload

local M = {}

-- Create a callable setup function that properly defines and loads the colorscheme
function M.setup()
  -- Check if the colors are available
  local ok, colors = pcall(require, "matugen.colors")
  if not ok then
    vim.notify("Failed to load matugen colors", vim.log.levels.ERROR)
    return
  end
  
  -- Clear existing highlights
  vim.cmd("highlight clear")
  if vim.g.syntax_on then
    vim.cmd("syntax reset")
  end
  
  -- Set the colorscheme name
  vim.g.colors_name = "matugen"
  vim.o.termguicolors = true 
  vim.o.background = "dark"
  
  -- UI elements
  vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "NormalNC", { fg = colors.fg_variant, bg = colors.bg_dim })
  vim.api.nvim_set_hl(0, "Cursor", { fg = colors.bg, bg = colors.primary })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_container_low })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.bg_container_low })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.fg_variant })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.primary, bold = true })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.outline })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.bg_container_high })
  vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.fg_variant, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.on_primary, bg = colors.primary })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = colors.bg_container_high })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.primary })
  vim.api.nvim_set_hl(0, "Search", { fg = colors.on_secondary_container, bg = colors.secondary_container })
  vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.on_tertiary_container, bg = colors.tertiary_container })
  vim.api.nvim_set_hl(0, "MatchParen", { fg = colors.tertiary, bold = true, underline = true })
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.primary_container })
  vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.bg_container_high })
  vim.api.nvim_set_hl(0, "Folded", { fg = colors.fg_variant, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.fg_variant, bg = colors.bg })
  vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.tertiary, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.secondary, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.error, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "DiffText", { fg = colors.primary, bg = colors.bg_container })
  vim.api.nvim_set_hl(0, "Directory", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.error })
  vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.tertiary }) -- Using tertiary as warning
  vim.api.nvim_set_hl(0, "ModeMsg", { fg = colors.fg, bold = true })
  vim.api.nvim_set_hl(0, "MoreMsg", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Question", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "NonText", { fg = colors.fg_variant })
  vim.api.nvim_set_hl(0, "SpecialKey", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Title", { fg = colors.primary, bold = true })
  vim.api.nvim_set_hl(0, "WildMenu", { fg = colors.on_primary, bg = colors.primary })
  
  -- Syntax highlighting
  vim.api.nvim_set_hl(0, "Comment", { fg = colors.fg_variant, italic = true })
  vim.api.nvim_set_hl(0, "Constant", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "String", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "Character", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "Number", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Boolean", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Float", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Identifier", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "Function", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Statement", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Conditional", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Repeat", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Label", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Operator", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Keyword", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "Exception", { fg = colors.error })
  vim.api.nvim_set_hl(0, "PreProc", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Include", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Define", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Macro", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "PreCondit", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Type", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "StorageClass", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "Structure", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "Typedef", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "Special", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Tag", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "SpecialComment", { fg = colors.fg_variant, italic = true })
  vim.api.nvim_set_hl(0, "Debug", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "Underlined", { fg = colors.primary, underline = true })
  vim.api.nvim_set_hl(0, "Ignore", { fg = colors.fg_variant })
  vim.api.nvim_set_hl(0, "Error", { fg = colors.error })
  vim.api.nvim_set_hl(0, "Todo", { fg = colors.bg, bg = colors.tertiary, bold = true })
  
  -- Diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.tertiary }) -- Using tertiary for warnings
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.secondary }) -- Using secondary for info
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = colors.tertiary })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = colors.secondary })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = colors.primary })
  
  -- Treesitter
  vim.api.nvim_set_hl(0, "@variable", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@function", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "@function.builtin", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "@keyword", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "@string", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "@number", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "@boolean", { fg = colors.tertiary })
  vim.api.nvim_set_hl(0, "@type", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "@property", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@field", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@parameter", { fg = colors.fg, italic = true })
  vim.api.nvim_set_hl(0, "@comment", { fg = colors.fg_variant, italic = true })
  vim.api.nvim_set_hl(0, "@operator", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.fg })
  vim.api.nvim_set_hl(0, "@tag", { fg = colors.primary })
  vim.api.nvim_set_hl(0, "@tag.attribute", { fg = colors.secondary })
  vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = colors.fg })
  
  -- LSP
  vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.bg_container_high })
  vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.bg_container_high })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.bg_container_high })
end

return M