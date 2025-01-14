return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "gwinn/none-ls-jsonlint.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local eslint = require("none-ls.diagnostics.eslint")
    local jsonlint = require("none-ls-jsonlint.diagnostics.jsonlint")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        eslint.with({
          condition = function(utils)
            return utils.root_has_file_matches("eslint")
          end,
        }),
        jsonlint,
        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
        null_ls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
      },
    })
  end,
}
