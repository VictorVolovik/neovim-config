return {
	"neovim-treesitter/nvim-treesitter",
	dependencies = { "neovim-treesitter/treesitter-parser-registry" },
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local plugin_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
		vim.opt.runtimepath:prepend(plugin_runtime)

		local ensure = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"typescript",
			"tsx",
			"go",
			"rust",
			"html",
			"css",
			"json",
			"sql",
		}

		local installed = require("nvim-treesitter.config").get_installed()
		local todo = vim.iter(ensure)
			:filter(function(p)
				return not vim.tbl_contains(installed, p)
			end)
			:totable()
		if #todo > 0 then
			require("nvim-treesitter").install(todo)
		end

		vim.treesitter.language.register("javascript", "javascriptreact")
		vim.treesitter.language.register("tsx", "typescriptreact")

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
