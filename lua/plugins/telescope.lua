return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<C-p>", function()
				builtin.find_files({
					hidden = true, -- Show hidden files
					no_ignore = false, -- Respect .gitignore
					find_command = { "rg", "--files", "--hidden", "--follow", "--glob", "!.git" },
				})
			end, {})

			vim.keymap.set("n", "<C-t>", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
