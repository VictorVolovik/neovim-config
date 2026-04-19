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
			local task = require("nvim-treesitter").install(todo)
			task:await(function(err)
				if err then
					return
				end
				vim.schedule(function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(buf) then
							pcall(vim.treesitter.start, buf)
						end
					end
				end)
			end)
		end

		vim.treesitter.language.register("javascript", "javascriptreact")
		vim.treesitter.language.register("tsx", "typescriptreact")

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf = args.buf
				local ft = vim.bo[buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft
				local cfg = require("nvim-treesitter.config")
				if vim.tbl_contains(cfg.get_installed(), lang) then
					pcall(vim.treesitter.start, buf)
					return
				end
				local registry = require("treesitter-registry")
				local function maybe_install()
					if not registry.loaded or not registry.loaded[lang] then
						return
					end
					local task = require("nvim-treesitter").install({ lang })
					task:await(function(err)
						if err then
							return
						end
						vim.schedule(function()
							pcall(vim.treesitter.start, buf)
						end)
					end)
				end
				if registry.loaded then
					maybe_install()
				else
					registry.load(maybe_install)
				end
			end,
		})
	end,
}
