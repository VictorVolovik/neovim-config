-- Treesitter-aware text objects + movement.
-- Uses the new `main`-branch API (standalone plugin, no nvim-treesitter setup table).
--
-- Move keymaps:
--   ]f/[f/ ]F/[F  = function (start / end)
--
-- Select text objects (work with y/d/c/v: e.g. yaf, dif, vac, 2yaf expands outward):
--   af/if  ac/ic  aa/ia  al/il  ai/ii  ab/ib
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	lazy = false,
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "V", -- linewise
					["@block.outer"] = "v", -- charwise
				},
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local function map_select(lhs, capture)
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(capture, "textobjects")
			end, { desc = capture })
		end

		-- Select text objects (works with y/d/c/v: e.g. yaf, dif, vac)
		map_select("af", "@function.outer")
		map_select("if", "@function.inner")
		map_select("ac", "@class.outer")
		map_select("ic", "@class.inner")
		map_select("aa", "@parameter.outer")
		map_select("ia", "@parameter.inner")
		map_select("al", "@loop.outer")
		map_select("il", "@loop.inner")
		map_select("ai", "@conditional.outer")
		map_select("ii", "@conditional.inner")
		map_select("ab", "@block.outer")
		map_select("ib", "@block.inner")

		local move = require("nvim-treesitter-textobjects.move")
		local function map_move(lhs, method, capture)
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move[method](capture, "textobjects")
			end, { desc = capture })
		end

		-- Function start/end
		map_move("]f", "goto_next_start", "@function.outer")
		map_move("[f", "goto_previous_start", "@function.outer")
		map_move("]F", "goto_next_end", "@function.outer")
		map_move("[F", "goto_previous_end", "@function.outer")
	end,
}
