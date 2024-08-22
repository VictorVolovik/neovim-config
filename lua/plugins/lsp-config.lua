return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "tsserver",
          "emmet_language_server",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
      })

      -- Border
      local _border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
      })
      vim.diagnostic.config({
        float = { border = _border },
      })

      -- Diagnostics
      vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

      -- Defitions, declarations and types
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gsh", vim.lsp.buf.signature_help, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

      -- Workspace
      vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, {})
      vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, {})
      vim.keymap.set("n", "<Leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, {})

      -- Code actions & refactoring
      vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<Leader>ff", function()
        vim.lsp.buf.format({ async = true })
      end, {})
    end,
  },
}
