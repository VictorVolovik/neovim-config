return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()

      -- Ensure non-LSP tools are installed
      local ensure_installed = { "sqlfluff", "stylua", "prettier", "staticcheck", "jsonlint" }
      local registry = require("mason-registry")
      for _, name in ipairs(ensure_installed) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "gopls",
          "rust_analyzer",
          "eslint",
          "emmet_language_server",
          "jsonls",
          "tailwindcss",
          "cssls",
          "html",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Global defaults for all servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Per-server overrides
      vim.lsp.config("ts_ls", {
        root_markers = { "package.json" },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
            procMacro = { enable = true },
          },
        },
      })

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
              },
              {
                fileMatch = { "tsconfig.json", "tsconfig.*.json" },
                url = "https://json.schemastore.org/tsconfig.json",
              },
            },
          },
        },
      })

      -- Enable all servers
      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "gopls",
        "rust_analyzer",
        "eslint",
        "emmet_language_server",
        "jsonls",
        "tailwindcss",
        "cssls",
        "html",
      })

      -- Format on save for Go and Rust
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go", "*.rs" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      -- Border for all floating windows
      vim.o.winborder = "solid"

      -- Diagnostics
      vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float)

      -- LSP keybindings via LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }

          -- Goto
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

          -- Info
          vim.keymap.set("n", "gsh", vim.lsp.buf.signature_help, opts)

          -- Actions
          vim.keymap.set({ "n", "v" }, "<Leader>a", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<Leader>ff", function()
            vim.lsp.buf.format({ async = true })
          end, opts)

          -- Symbols (via Telescope)
          vim.keymap.set("n", "<Leader>s", "<cmd>Telescope lsp_document_symbols<CR>", opts)
          vim.keymap.set("n", "<Leader>S", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
        end,
      })
    end,
  },
}
