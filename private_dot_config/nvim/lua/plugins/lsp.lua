return {
	-- Mason for installing LSP servers
	{ "mason-org/mason.nvim", opts = {} },
	"WhoIsSethDaniel/mason-tool-installer.nvim",

	-- Useful status updates for LSP.
	{ "j-hui/fidget.nvim", opts = {} },

	-- Allows extra capabilities provided by blink.cmp
	{
		"saghen/blink.cmp",
		config = function(_, opts)
			require("blink.cmp").setup(opts)
			-- Add blink.cmp capabilities to the default LSP client capabilities
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})
		end,
	},

	-- LSP Configuration (using native vim.lsp.config for Neovim 0.11+)
	{
		"neovim/nvim-lspconfig",
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("<leader>lr", ":LspRestart<CR>", "Restart LSP")

					map("K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, "Show documentation for symbol under cursor")

					-- Rename the variable under your cursor.
					map("<leader>rn", function()
						vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
							callback = function()
								local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
								vim.api.nvim_feedkeys(key, "c", false)
								vim.api.nvim_feedkeys("0", "n", false)
								return true
							end,
						})
						vim.lsp.buf.rename()
					end, "[R]e[n]ame")

					-- Execute a code action
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Goto Declaration (e.g., in C this would take you to the header)
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Fuzzy find all the symbols in your current document.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

					-- Jump to the type of the word under your cursor.
					map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					map("<leader>vd", function()
						vim.diagnostic.open_float()
					end, "[V]iew [D]iagnostics")

					map("[d", function()
						vim.diagnostic.goto_prev()
					end, "Prev Diagnostic")
					map("]d", function()
						vim.diagnostic.goto_next()
					end, "Next Diagnostic")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- Highlight references of the word under cursor
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
						local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Toggle inlay hints keymap
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end

					-- Svelte-specific: notify on TS/JS file changes
					-- https://github.com/sveltejs/language-tools/issues/2008#issuecomment-2351976230
					if client and client.name == "svelte" then
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							group = vim.api.nvim_create_augroup("svelte-on-did-change-ts-or-js-file", { clear = true }),
							callback = function(args)
								client:notify("$/onDidChangeTsOrJsFile", {
									uri = args.match,
								})
							end,
						})
					end
				end,
			})

			-- Extra keymaps
			vim.keymap.set("n", "<leader>oi", function()
				vim.lsp.buf.code_action({
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
					apply = true,
				})
			end, { desc = "Organize Imports" })

			-- Diagnostic Config
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			-- Install tools via mason-tool-installer
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"lua-language-server",
					"eslint-lsp",
					"tailwindcss-language-server",
				},
			})

			-- Enable LSP servers (configs are in nvim/lsp/*.lua)
			vim.lsp.enable({
				"lua_ls",
				"eslint",
				"gdscript",
				"vtsls",
				"svelte",
				"tailwindcss",
			})
		end,
	},
}
