return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "L3MON4D3/LuaSnip" },
		event = "InsertEnter",
		opts = {
			snippets = { preset = "luasnip" },

			appearance = {
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "snippets", "buffer" },
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
