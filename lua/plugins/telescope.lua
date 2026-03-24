return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>f", function()
				builtin.find_files({
					hidden = true, -- Show hidden files
					no_ignore = false, -- Respect .gitignore
					find_command = { "rg", "--files", "--hidden", "--follow", "--glob", "!.git" },
				})
			end, {})
			vim.keymap.set("n", "<leader>F", function()
				builtin.find_files({
					hidden = true, -- Show hidden files
					no_ignore = true, -- Show ignored files
					find_command = { "rg", "--files", "--hidden", "--no-ignore", "--follow", "--glob", "!.git" },
				})
			end, {})

			vim.keymap.set("n", "<leader>t", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>g", builtin.git_status, {})
			vim.keymap.set("n", "<leader>d", function()
				builtin.diagnostics({ bufnr = 0 })
			end, {})
			vim.keymap.set("n", "<leader>D", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>j", builtin.jumplist, {})
			vim.keymap.set("n", "<leader>'", builtin.resume, {})
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
