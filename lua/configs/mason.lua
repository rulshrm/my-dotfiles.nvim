local M = {}

-- Daftar alat yang akan diinstal oleh Mason
M.ensure_installed = {
  -- LSPs
  "lua-language-server",          -- Lua LSP
  "html-lsp",                     -- HTML LSP
  "css-lsp",                      -- CSS LSP
  "typescript-language-server",    -- TypeScript/JavaScript LSP
  "json-lsp",                     -- JSON LSP
  "yaml-language-server",         -- YAML LSP
  "vim-language-server",          -- Vimscript LSP
  "rust-analyzer",                -- Rust LSP
  "gopls",                        -- Go LSP
  "nimlsp",                       -- Nim LSP

  -- Formatters & Linters
  "prettier",                     -- Prettier formatter
  "stylua",                      -- Lua formatter
  "eslint_d",                    -- JavaScript/TypeScript linter
  "shellcheck",                  -- Shell script linter
  "prettierd",                   -- prettierd 
}

M.setup = function()
  -- Debug log
  vim.notify("Setting up Mason...", vim.log.levels.INFO)

  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  -- Setup Mason
  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    max_concurrent_installers = 10,
  })

  -- Setup Mason LSPConfig
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "tsserver",  -- Changed from ts_ls to tsserver
      "html",
      "cssls",
      "jsonls",
      "yamlls",
    },
    automatic_installation = true,
  })

  -- Configure handlers for LSP servers
  mason_lspconfig.setup_handlers({
    -- Default handler
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = function(client, bufnr)
          -- Disable formatting untuk semua LSP
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- Notify when LSP attaches
          vim.notify(string.format("LSP %s attached", server_name), vim.log.levels.INFO)
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  })

  -- Install any missing tools
  local registry = require("mason-registry")
  for _, tool in ipairs(M.ensure_installed) do
    if not registry.is_installed(tool) then
      vim.notify(string.format("Installing %s...", tool), vim.log.levels.INFO)
      registry.get_package(tool):install()
    end
  end

  vim.notify("Mason setup completed!", vim.log.levels.INFO)
end

return M