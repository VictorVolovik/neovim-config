return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- Show hidden files
					hide_dotfiles = false, -- Include dotfiles (hidden files)
				},
			},
		})

		vim.keymap.set("n", "\\", ":Neotree filesystem toggle left<CR>")
		vim.keymap.set("n", "<C-b>", ":Neotree buffers toggle left<CR>")
	end,
}
