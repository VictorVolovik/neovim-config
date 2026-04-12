return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	name = "kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = true,
			commentStyle = { italic = true },
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus",
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					-- Completion popup shares the same background as hover/diagnostic floats
					Pmenu = { fg = theme.ui.pmenu.fg, bg = theme.ui.float.bg },
					PmenuKind = { fg = theme.ui.fg_dim, bg = theme.ui.float.bg },
					PmenuExtra = { fg = theme.ui.special, bg = theme.ui.float.bg },
					-- Solid border blends into content bg across all floats
					FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.float.bg },
					BlinkCmpMenuBorder = { bg = theme.ui.float.bg },
				}
			end,
		})

		vim.cmd("colorscheme kanagawa")
	end,
}
