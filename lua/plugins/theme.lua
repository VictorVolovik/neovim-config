return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  name = "kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
    })

    vim.cmd("colorscheme kanagawa")
  end,
}
