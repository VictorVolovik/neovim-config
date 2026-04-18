return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
			})
			local ls = require("luasnip")
			ls.filetype_extend("typescript", { "javascript" })
			ls.filetype_extend("javascriptreact", { "javascript", "react" })
			ls.filetype_extend("typescriptreact", { "typescript", "javascript", "react" })
			ls.filetype_extend("astro", { "typescript", "javascript" })
		end,
	},
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"ray-x/cmp-sql",
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saghen/blink.compat",
			"ray-x/cmp-sql",
		},
		event = "InsertEnter",
		opts = {
			snippets = { preset = "luasnip" },

			appearance = {
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { inherit_defaults = true, "sql" },
				},
				providers = {
					sql = {
						name = "sql",
						module = "blink.compat.source",
					},
				},
			},

			completion = {
				menu = {
					border = "solid",
					draw = {
						columns = {
							{ "label", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "solid" },
				},
				list = {
					selection = { preselect = true, auto_insert = false },
				},
			},

			signature = {
				enabled = true,
				window = { border = "solid" },
			},

			keymap = {
				preset = "super-tab",
				["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Up>"] = { "scroll_documentation_up", "fallback" },
				["<Down>"] = { "scroll_documentation_down", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
