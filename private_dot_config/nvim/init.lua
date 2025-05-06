-- Load main configuration
require("thomasgen")

-- Load matugen colorscheme
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		-- First try to set the colorscheme directly
-- 		local ok = pcall(vim.cmd, "colorscheme matugen")
--
-- 		-- If that didn't work, try loading the module first
-- 		if not ok then
-- 			pcall(function()
-- 				require("matugen") -- This loads and registers the theme
-- 				vim.cmd("colorscheme matugen")
-- 			end)
-- 		end
-- 	end,
-- 	once = true,
-- })
