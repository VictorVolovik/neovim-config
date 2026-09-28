return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local render_markdown = require("render-markdown")
		render_markdown.setup({
			latex = { enabled = false },
		})

		vim.keymap.set("n", "<leader>tm", render_markdown.buf_toggle)
		vim.keymap.set("n", "<leader>tp", render_markdown.preview)
	end,
}
