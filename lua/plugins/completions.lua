return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
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
				default = { "lsp", "snippets", "buffer" },
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
					selection = { preselect = false, auto_insert = false },
				},
			},

			signature = {
				enabled = true,
				window = { border = "solid" },
			},

			keymap = {
				preset = "default",
				["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Up>"] = { "scroll_documentation_up", "fallback" },
				["<Down>"] = { "scroll_documentation_down", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
