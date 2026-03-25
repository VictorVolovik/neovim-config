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

			vim.keymap.set("n", "<leader>p", function()
				builtin.oldfiles({ cwd_only = true })
			end, {})
			vim.keymap.set("n", "<leader>P", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>g", builtin.git_status, {})
			vim.keymap.set("n", "<leader>d", function()
				builtin.diagnostics({ bufnr = 0 })
			end, {})
			vim.keymap.set("n", "<leader>D", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>j", builtin.jumplist, {})
			vim.keymap.set("n", "<leader>m", function()
				local cwd = vim.fn.getcwd() .. "/"
				local make_entry = require("telescope.make_entry")
				local default_maker = make_entry.gen_from_marks({})
				builtin.marks({
					mark_type = "global",
					entry_maker = function(item)
						if item.filename and not vim.startswith(item.filename, cwd) then
							return nil
						end
						return default_maker(item)
					end,
				})
			end, {})
			vim.keymap.set("n", "<leader>M", builtin.marks, {})
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
