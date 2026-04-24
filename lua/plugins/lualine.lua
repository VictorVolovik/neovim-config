return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "kanagawa",
				section_separators = { left = "\xee\x82\xb4", right = "\xee\x82\xb6" },
				component_separators = { left = "│", right = "│" },
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
						shorting_target = 80,
					},
				},
			},
		})
	end,
}
