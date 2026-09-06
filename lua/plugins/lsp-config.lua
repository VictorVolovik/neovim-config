return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()

			-- Ensure non-LSP tools are installed
			local ensure_installed = { "sqlfluff", "stylua", "prettier" }
			local registry = require("mason-registry")
			registry.refresh(function(success)
				if not success then
					vim.notify("mason-registry refresh failed", vim.log.levels.WARN)
				end
				for _, name in ipairs(ensure_installed) do
					local ok, pkg = pcall(registry.get_package, name)
					if ok and not pkg:is_installed() then
						pkg:install()
					end
				end
			end)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- mason-lspconfig auto-enables every installed server (automatic_enable
			-- defaults to true): it applies its per-server shims via vim.lsp.config,
			-- then calls vim.lsp.enable — no manual vim.lsp.enable needed here
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"rust_analyzer",
					"eslint",
					"emmet_language_server",
					"jsonls",
					"tailwindcss",
					"cssls",
					"html",
					"astro",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Prettier / StyLua (via none-ls) own formatting for these filetypes
			local null_ls_ft = {
				javascript = true,
				javascriptreact = true,
				typescript = true,
				typescriptreact = true,
				css = true,
				astro = true,
				markdown = true,
				lua = true,
			}

			local function format_filter(client)
				if null_ls_ft[vim.bo.filetype] then
					return client.name == "null-ls"
				end
				return true
			end

			-- Global defaults for all servers
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Per-server overrides
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						staticcheck = true,
					},
				},
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						check = { command = "clippy" },
						procMacro = { enable = true },
					},
				},
			})

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = {
							{
								fileMatch = { "package.json" },
								url = "https://json.schemastore.org/package.json",
							},
							{
								fileMatch = { "tsconfig.json", "tsconfig.*.json" },
								url = "https://json.schemastore.org/tsconfig.json",
							},
						},
					},
				},
			})

			-- Emmet's JSX profile rewrites class -> className and for -> htmlFor, which is
			-- right for React but wrong for Solid. Pick the profile per project root.
			local function uses_solid(root)
				if not root then
					return false
				end
				local f = io.open(root .. "/package.json", "r")
				if not f then
					return false
				end
				local ok, pkg = pcall(vim.json.decode, f:read("*a"))
				f:close()
				if not ok or type(pkg) ~= "table" then
					return false
				end
				for _, field in ipairs({ "dependencies", "devDependencies" }) do
					if type(pkg[field]) == "table" and pkg[field]["solid-js"] then
						return true
					end
				end
				return false
			end

			vim.lsp.config("emmet_language_server", {
				root_markers = { "package.json", ".git" },
				before_init = function(params, config)
					params.initializationOptions = vim.tbl_deep_extend(
						"force",
						params.initializationOptions or {},
						{ showAbbreviationSuggestions = true }
					)
					if uses_solid(config.root_dir) then
						params.initializationOptions.syntaxProfiles = {
							jsx = {
								["markup.attributes"] = { class = "class", ["class*"] = "class", ["for"] = "for" },
								["markup.valuePrefix"] = { ["class*"] = "styles" },
							},
						}
					end
				end,
			})

			-- Format on save for TS, Go and Rust
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = {
					"*.go",
					"*.rs",
					"*.js",
					"*.jsx",
					"*.ts",
					"*.tsx",
					"*.astro",
					"*.css",
					"*.md",
					"*.lua",
				},
				callback = function()
					vim.lsp.buf.format({
						async = false,
						filter = format_filter,
					})
				end,
			})

			-- Border for all floating windows
			vim.o.winborder = "solid"

			-- Diagnostics
			vim.diagnostic.config({
				severity_sort = true,
				float = { source = true },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					},
				},
			})
			vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)

			-- Inlay hints (global toggle)
			vim.keymap.set("n", "<Leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "Toggle inlay hints" })

			-- LSP keybindings via LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }

					-- Goto
					vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
					vim.keymap.set("n", "gD", "<cmd>Telescope lsp_definitions jump_type=never<CR>", opts)
					vim.keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)
					vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

					-- Info
					vim.keymap.set("n", "gsh", vim.lsp.buf.signature_help, opts)

					-- Actions
					vim.keymap.set({ "n", "v" }, "<Leader>a", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({
							async = true,
							filter = format_filter,
						})
					end, opts)

					-- Symbols (via Telescope)
					vim.keymap.set("n", "<Leader>s", "<cmd>Telescope lsp_document_symbols<CR>", opts)
					vim.keymap.set("n", "<Leader>S", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
				end,
			})
		end,
	},
}
