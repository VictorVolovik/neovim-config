-- Defaults
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.g.mapleader = " "
vim.g.omni_sql_no_default_maps = 1

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Key mappings --

-- Clear search highlight
vim.keymap.set("n", "<Leader><space>", "<cmd>nohlsearch<CR>")

-- Move vertically by visual line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Easy window navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")

-- Switch to last active buffer (Helix-style ga)
vim.keymap.set("n", "ga", "<cmd>b#<CR>")

-- Moving between buffers
vim.keymap.set("n", "<PageUp>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<PageDown>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<Delete>", "<cmd>bdelete<CR>")

-- Moving between tabs
vim.keymap.set("n", "<Leader><PageUp>", "<cmd>tabp<CR>")
vim.keymap.set("n", "<Leader><PageDown>", "<cmd>tabn<CR>")

-- Fix nvim handling new line with * selector in css
vim.api.nvim_create_autocmd("FileType", {
	pattern = "css",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r" })
	end,
})

-- Comment navigation (Helix-style: ]c/[c)
local function jump_to_comment(direction)
	local bufnr = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1

	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok or not parser then
		return
	end

	local tree = parser:parse()[1]
	if not tree then
		return
	end

	local lang = parser:lang()
	local comments = {}

	-- Most grammars use (comment); Rust uses line_comment/block_comment
	local patterns = { "(comment) @c", "[(line_comment) (block_comment)] @c" }
	for _, pat in ipairs(patterns) do
		local q_ok, query = pcall(vim.treesitter.query.parse, lang, pat)
		if q_ok and query then
			for _, node in query:iter_captures(tree:root(), bufnr) do
				table.insert(comments, node)
			end
			if #comments > 0 then
				break
			end
		end
	end

	if #comments == 0 then
		return
	end

	if direction == "next" then
		for _, node in ipairs(comments) do
			local start_row = node:start()
			if start_row > row then
				vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
				return
			end
		end
		vim.api.nvim_win_set_cursor(0, { comments[1]:start() + 1, 0 })
	else
		for i = #comments, 1, -1 do
			local start_row = comments[i]:start()
			if start_row < row then
				vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
				return
			end
		end
		vim.api.nvim_win_set_cursor(0, { comments[#comments]:start() + 1, 0 })
	end
end

vim.keymap.set("n", "]c", function()
	jump_to_comment("next")
end, { desc = "Next comment" })

vim.keymap.set("n", "[c", function()
	jump_to_comment("prev")
end, { desc = "Previous comment" })
