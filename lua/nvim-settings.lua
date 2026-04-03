-- Defaults
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
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
	local ts = vim.treesitter
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1 -- 0-indexed

	local ok, parser = pcall(ts.get_parser, bufnr)
	if not ok or not parser then
		return
	end

	local tree = parser:parse()[1]
	if not tree then
		return
	end

	local root = tree:root()
	local comments = {}

	-- Collect all comment nodes
	for node in root:iter_children() do
		local function collect_comments(n)
			if n:type():match("comment") then
				table.insert(comments, n)
			end
			for child in n:iter_children() do
				collect_comments(child)
			end
		end
		collect_comments(node)
	end

	if #comments == 0 then
		return
	end

	-- Find next/prev comment with wrapping
	if direction == "next" then
		for _, node in ipairs(comments) do
			local start_row = node:start()
			if start_row > row then
				vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
				return
			end
		end
		-- Wrap to first comment
		local start_row = comments[1]:start()
		vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
	else
		for i = #comments, 1, -1 do
			local start_row = comments[i]:start()
			if start_row < row then
				vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
				return
			end
		end
		-- Wrap to last comment
		local start_row = comments[#comments]:start()
		vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
	end
end

vim.keymap.set("n", "]c", function()
	jump_to_comment("next")
end, { desc = "Next comment" })

vim.keymap.set("n", "[c", function()
	jump_to_comment("prev")
end, { desc = "Previous comment" })
