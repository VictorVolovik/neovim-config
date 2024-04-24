return {
  "nvimtools/none-ls.nvim",
dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
  config = function()
    local null_ls = require("null-ls")
    local eslint = require("none-ls.diagnostics.eslint")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        eslint
      },
    })
  end
}
